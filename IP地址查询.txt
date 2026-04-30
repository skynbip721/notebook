/**
 * Cloudflare Worker - IP 查询工具
 * 多数据源对比展示 
 */


const API_SOURCES = [
    { name: "IP-API.com", url: "http://ip-api.com/json/{ip}?fields=status,message,country,regionName,city,district,isp,org,lat,lon,timezone,as,mobile,proxy,hosting,query&lang=zh-CN" },
    { name: "Mir6.com", url: "https://api.mir6.com/api/ip_json?ip={ip}" },
    { name: "IP.SB", url: "https://api.ip.sb/geoip/{ip}" },
];

/**
 * 国际化语言字典
 */
const i18nDict = {
    en: {
        title: "IP Inspector",
        subtitle: "Multi-source IP geolocation intelligence routing",
        placeholder: "Enter IP address (leave empty for yours)",
        inspect: "Inspect",
        queryResults: "Query Results",
        apiUsage: "API & CLI Usage",
        address: "Address",
        isp: "ISP",
        org: "Organization",
        coord: "Coordinates",
        active: "Active",
        unknownLoc: "Unknown Location",
        unknownIsp: "Unknown ISP",
        unknownOrg: "Unknown Org",
        errorMsg: "Query failed. The upstream APIs might be rate-limited or unreachable.",
        terminal: "Terminal",
        commentCurrent: "# Check your current IP directly",
        commentSpecific: "# Query specific IP",
        commentJson: "# Get JSON response",
        commentAll: "# Multi-source full text response",
        footerPowered: "Powered by Cloudflare Workers",
        // CLI Texts
        cliAllFailed: "All upstream query interfaces failed",
        cliUnknown: "Unknown",
        cliTimeout: "Query timeout or parse failed",
        cliAddress: "Addr",
        cliIsp: "ISP",
        cliSource2: "Src 2",
        cliSource3: "Src 3",
    },
    zh: {
        title: "IP Inspector", // 保留英文感品牌名
        subtitle: "多源 IP 归属地智能查询聚合",
        placeholder: "输入 IP 地址（留空查询本机）",
        inspect: "查询",
        queryResults: "查询结果",
        apiUsage: "API 与命令行调用",
        address: "物理地址",
        isp: "服务商",
        org: "归属组织",
        coord: "地理坐标",
        active: "成功",
        unknownLoc: "未知地址",
        unknownIsp: "未知服务商",
        unknownOrg: "未知组织",
        errorMsg: "查询失败。接口超时或所有上游 API 均无法连通。",
        terminal: "终端",
        commentCurrent: "# 查询本机 IP",
        commentSpecific: "# 查询指定 IP",
        commentJson: "# 请求 JSON 格式",
        commentAll: "# 多源完整文本展示",
        footerPowered: "由 Cloudflare Workers 强力驱动",
        // CLI Texts
        cliAllFailed: "所有查询接口均失败",
        cliUnknown: "未知",
        cliTimeout: "查询超时或解析失败",
        cliAddress: "地址",
        cliIsp: "运营商",
        cliSource2: "数据二",
        cliSource3: "数据三",
    }
};

/**
 * 根据请求头解析语言
 */
function getLanguage(request) {
    const acceptLang = request.headers.get("Accept-Language") || "";
    return acceptLang.toLowerCase().includes("zh") ? "zh" : "en";
}

/**
 * 带超时的 fetch
 */
async function fetchWithTimeout(url, timeoutMs = 8000) {
    const controller = new AbortController();
    const timeoutId = setTimeout(() => controller.abort(), timeoutMs);
    try {
        const response = await fetch(url, { signal: controller.signal });
        clearTimeout(timeoutId);
        return response;
    } catch (error) {
        clearTimeout(timeoutId);
        throw error;
    }
}

async function fetchSingleSource(ip, source) {
    try {
        const url = source.url.replace("{ip}", ip);
        const response = await fetchWithTimeout(url, 8000);
        if (!response.ok) return null;
        const data = await response.json();
        if (!data) return null;
        return data;
    } catch (error) { return null; }
}

function isValidResponse(data, source) {
    if (!data) return false;
    if (source.name === "IP-API.com") { return data.status !== "fail"; }
    if (source.name === "Mir6.com") { return !(data.code && data.code === 0); }
    if (source.name === "IP.SB") { return !!data.ip || !!data.country; }
    return true;
}

function normalizeIPInfo(raw, source, targetIp) {
    let result = {
        ip: raw.ip || raw.query || raw.ip_address || raw["0"] || targetIp || "",
        country: raw.country || raw.country_name || raw.countryCode || "",
        region: raw.regionName || raw.region || raw.region_name || raw.province || raw.province || "",
        city: raw.city || "",
        isp: raw.isp || raw.carrier || raw.org || raw.organization || "",
        org: raw.organization || raw.org || "",
        lat: raw.lat || raw.latitude || null,
        lon: raw.lon || raw.longitude || null,
        timezone: raw.timezone || raw.timezone?.id || "",
        source: source.name,
    };
    
    if (source.name === "Mir6.com") {
        if (raw.data) {
            const d = raw.data;
            result.ip = d.ip || result.ip;
            result.country = d.country || d.country_code || result.country;
            result.region = d.province || d.region || result.region;
            result.city = d.city || result.city;
            result.isp = d.carrier || d.operator || d.isp || result.isp;
            result.org = d.org || result.org;
            result.lat = d.lat || result.lat;
            result.lon = d.lon || result.lon;
        }
        result.ip = raw.ip || result.ip;
        result.country = raw.country || result.country;
        result.region = raw.province || result.region;
        result.city = raw.city || result.city;
        result.isp = raw.isp || raw.carrier || result.isp;
    }
    
    if (source.name === "IP.SB") {
        result.country = raw.country || result.country;
        result.region = raw.region || result.region;
        result.city = raw.city || result.city;
        result.isp = raw.isp || result.isp;
    }

    return result;
}

async function fetchAllSources(ip) {
    const results = {};
    const fetchPromises = API_SOURCES.map(async (source) => {
        const rawData = await fetchSingleSource(ip, source);
        if (rawData && isValidResponse(rawData, source)) {
            const info = normalizeIPInfo(rawData, source, ip);
            if (info && info.ip) return { name: source.name, data: info };
        }
        return null;
    });

    const responses = await Promise.all(fetchPromises);
    responses.forEach(res => { if (res) results[res.name] = res.data; });
    return results;
}

async function fetchFirstAvailable(ip) {
    try {
        const first = await Promise.any(API_SOURCES.map(async (source) => {
            const rawData = await fetchSingleSource(ip, source);
            if (rawData && isValidResponse(rawData, source)) {
                const info = normalizeIPInfo(rawData, source, ip);
                if (info && info.ip) return info;
            }
            throw new Error("Invalid");
        }));
        return first;
    } catch {
        return null;
    }
}

function isValidIP(ip) {
    if (!ip) return false;
    const ipv4Pattern = /^(\d{1,3}\.){3}\d{1,3}$/;
    if (ipv4Pattern.test(ip)) {
        const parts = ip.split(".");
        if (parts.every((part) => parseInt(part) <= 255)) return true;
    }
    if (ip.includes(":") && ip.split(":").length <= 8) return true;
    return false;
}

function getClientIP(request) {
    const url = new URL(request.url);
    const queryIP = url.searchParams.get("ip");
    if (queryIP && isValidIP(queryIP)) return queryIP;
    const headerIP = request.headers.get("X-Forwarded-For");
    if (headerIP && isValidIP(headerIP.split(",")[0].trim())) {
        return headerIP.split(",")[0].trim();
    }
    return request.headers.get("CF-Connecting-IP") || "127.0.0.1";
}

function parsePathIP(request) {
    const url = new URL(request.url);
    const pathParts = url.pathname.replace(/^\/+|\/+$/g, "").split("/");
    if (pathParts.length === 0) return null;
    if (pathParts[0] === "json" && pathParts[1] && isValidIP(pathParts[1])) return pathParts[1];
    if (isValidIP(pathParts[0])) return pathParts[0];
    return null;
}

/**
 * 命令行输出双语支持
 */
function formatCLIResponse(ip, allSources, baseUrl, lang) {
    const t = i18nDict[lang];
    const s1 = allSources["IP-API.com"];
    const s2 = allSources["Mir6.com"];
    const s3 = allSources["IP.SB"];

    if (!s1 && !s2 && !s3) return `IP\t: ${ip}\n${t.cliAddress}\t: ${t.cliAllFailed}\n`;

    let output = `IP\t: ${ip}\n`;

    if (s1) {
        let address1 = [s1.country, s1.region, s1.city].filter(Boolean).join(" ");
        output += `${t.cliAddress}\t: ${address1} (${s1.source})\n`;
        output += `${t.cliIsp}\t: ${s1.isp || t.cliUnknown}\n`;
    } else {
        output += `${t.cliAddress}\t: ${t.cliTimeout} (IP-API.com)\n`;
    }

    output += `\n`;

    if (s2) {
        let address2 = [s2.country, s2.region, s2.city].filter(Boolean).join(" | ");
        output += `${t.cliSource2}\t: ${address2} | ${s2.isp || t.cliUnknown} (${s2.source})\n`;
    } else {
        output += `${t.cliSource2}\t: ${t.cliTimeout} (Mir6.com)\n`;
    }

    output += `\n`;

    if (s3) {
        let address3 = [s3.country, s3.region, s3.city].filter(Boolean).join(" ");
        output += `${t.cliSource3}\t: ${address3} | ${s3.isp || t.cliUnknown} (${s3.source})\n`;
    } else {
        output += `${t.cliSource3}\t: ${t.cliTimeout} (IP.SB)\n`;
    }

    output += `\nURL\t: ${baseUrl}/${ip}\n`;
    return output;
}

function formatCLIAllResponse(ip, allSources, lang) {
    const t = i18nDict[lang];
    const sources = Object.values(allSources);
    if (sources.length === 0) return `IP: ${ip}\n${t.cliAllFailed}\n`;
    let output = `IP: ${ip}\n\n`;
    sources.forEach((s) => {
        output += `[${s.source}]\n`;
        output += `  IP: ${s.ip}\n`;
        output += `  ${t.cliAddress}: ${[s.country, s.region, s.city].filter(Boolean).join(" ")}\n`;
        output += `  ${t.cliIsp}: ${s.isp}\n`;
        output += `  ${t.coord}: ${s.lat ? `${s.lat}, ${s.lon}` : t.cliUnknown}\n\n`;
    });
    return output;
}

/**
 * 格式化 HTML 页面 (中英双语自适应)
 */
function formatHTMLResponse(ip, allSources, hostname, lang) {
    const t = i18nDict[lang];
    const sources = Object.values(allSources);
    
    let content = "";
    if (sources.length === 0) {
        content = `
            <div class="alert alert-error">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="8" x2="12" y2="12"></line><line x1="12" y1="16" x2="12.01" y2="16"></line></svg>
                <span>${t.errorMsg}</span>
            </div>`;
    } else {
        content = `<div class="sources-grid">`;
        sources.forEach((s) => {
            const address = [s.country, s.region, s.city].filter(Boolean).join(", ") || t.unknownLoc;
            const coordinates = s.lat ? `${s.lat}, ${s.lon}` : "N/A";
            const isp = s.isp || t.unknownIsp;
            const org = s.org || t.unknownOrg;
            
            content += `
                <div class="source-card">
                    <div class="card-header">
                        <div class="source-name">
                            <span class="dot"></span>
                            ${s.source}
                        </div>
                        <div class="source-badge">${t.active}</div>
                    </div>
                    <div class="source-body">
                        <div class="info-row">
                            <span class="info-label">${t.address}</span>
                            <span class="info-value">${address}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">${t.isp}</span>
                            <span class="info-value">${isp}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">${t.org}</span>
                            <span class="info-value">${org}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">${t.coord}</span>
                            <span class="info-value mono">${coordinates}</span>
                        </div>
                    </div>
                </div>
            `;
        });
        content += `</div>`;
    }

    return `<!DOCTYPE html>
<html lang="${lang}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${t.title} - ${ip}</title>
    <style>
        :root {
            --bg: #fafafa;
            --surface: #ffffff;
            --border: #eaeaea;
            --border-hover: #d3d3d3;
            --text-main: #111111;
            --text-muted: #666666;
            --text-light: #999999;
            --black: #000000;
            --radius-md: 8px;
            --radius-lg: 12px;
            /* 优化中文字体支持 PingFang SC 让 Safari/iOS 下显示更具高级纤细感 */
            --font-sans: "Inter", -apple-system, BlinkMacSystemFont, "PingFang SC", "Hiragino Sans GB", "Microsoft YaHei", sans-serif;
            --font-mono: "JetBrains Mono", "Menlo", "Monaco", "Courier New", monospace;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: var(--font-sans);
            background-color: var(--bg);
            color: var(--text-main);
            line-height: 1.5;
            -webkit-font-smoothing: antialiased;
            background-image: radial-gradient(#e5e5e5 1px, transparent 0);
            background-size: 20px 20px;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .layout {
            max-width: 800px;
            margin: 0 auto;
            padding: 60px 20px;
            width: 100%;
        }

        header {
            margin-bottom: 40px;
        }

        h1 {
            font-size: 24px;
            font-weight: 600;
            letter-spacing: -0.02em;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .target-ip {
            font-family: var(--font-mono);
            font-weight: 400;
            color: var(--text-muted);
            font-size: 20px;
            margin-top: 2px;
        }

        .subtitle {
            color: var(--text-muted);
            font-size: 14px;
        }

        /* Search Form */
        .search-box {
            display: flex;
            gap: 12px;
            margin-bottom: 40px;
        }

        input {
            flex: 1;
            padding: 12px 16px;
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            font-size: 14px;
            font-family: var(--font-mono);
            outline: none;
            transition: all 0.2s ease;
            box-shadow: 0 1px 2px rgba(0,0,0,0.02);
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(4px);
        }

        input:focus {
            border-color: var(--text-muted);
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            background: #fff;
        }

        input::placeholder {
            color: var(--text-light);
            font-family: var(--font-sans);
        }

        button {
            background-color: var(--black);
            color: white;
            border: none;
            padding: 0 24px;
            border-radius: var(--radius-md);
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: background 0.2s;
            white-space: nowrap;
        }

        button:hover {
            background-color: #333;
        }

        /* Data Cards */
        .section-title {
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: var(--text-light);
            font-weight: 600;
            margin-bottom: 16px;
        }

        .sources-grid {
            display: grid;
            gap: 20px;
            margin-bottom: 40px;
        }

        @media (min-width: 640px) {
            .sources-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            .sources-grid .source-card:first-child {
                grid-column: 1 / -1; /* First result spans full width */
            }
        }

        .source-card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            padding: 24px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.02);
            transition: border-color 0.2s;
        }

        .source-card:hover {
            border-color: var(--border-hover);
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 16px;
            border-bottom: 1px solid var(--border);
        }

        .source-name {
            font-weight: 600;
            font-size: 15px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .dot {
            width: 8px;
            height: 8px;
            background-color: #000;
            border-radius: 50%;
        }

        .source-badge {
            font-size: 11px;
            padding: 2px 8px;
            background: #f1f1f1;
            color: var(--text-muted);
            border-radius: 10px;
            font-family: var(--font-mono);
        }

        .info-row {
            display: flex;
            flex-direction: column;
            margin-bottom: 12px;
        }
        
        .info-row:last-child {
            margin-bottom: 0;
        }

        .info-label {
            font-size: 12px;
            color: var(--text-light);
            margin-bottom: 2px;
        }

        .info-value {
            font-size: 14px;
            color: var(--text-main);
        }

        .mono {
            font-family: var(--font-mono);
            font-size: 13px;
        }

        /* CLI usage */
        .cli-section {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            overflow: hidden;
        }
        
        .cli-header {
            padding: 12px 20px;
            border-bottom: 1px solid var(--border);
            font-size: 13px;
            font-weight: 500;
            color: var(--text-muted);
            display: flex;
            gap: 6px;
            align-items: center;
            background: #fafafa;
        }

        .window-dots {
            display: flex;
            gap: 6px;
            margin-right: 10px;
        }
        .window-dot { width: 10px; height: 10px; border-radius: 50%; background: var(--border); }

        .cli-body {
            padding: 20px;
            background: #000;
            color: #f1f1f1;
            font-family: var(--font-mono);
            font-size: 13px;
            line-height: 1.6;
            overflow-x: auto;
        }

        .cli-comment { color: #888; }
        .cli-command { color: #fff; margin-bottom: 12px; display: block; }
        .cli-command::before { content: "$ "; color: #666; }

        .alert-error {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 16px;
            background: #fff0f0;
            border: 1px solid #ffd6d6;
            color: #d10000;
            border-radius: var(--radius-md);
            font-size: 14px;
        }

        footer {
            margin-top: auto;
            text-align: center;
            padding: 40px 0;
            font-size: 12px;
            color: var(--text-light);
            font-family: var(--font-mono);
        }
    </style>
</head>
<body>
    <div class="layout">
        <header>
            <h1>${t.title} <span class="target-ip">${ip}</span></h1>
            <p class="subtitle">${t.subtitle}</p>
        </header>

        <form class="search-box" method="GET">
            <input type="text" name="ip" placeholder="${t.placeholder}" value="">
            <button type="submit">${t.inspect}</button>
        </form>

        <div class="section-title">${t.queryResults}</div>
        ${content}

        <div class="section-title">${t.apiUsage}</div>
        <div class="cli-section">
            <div class="cli-header">
                <div class="window-dots">
                    <div class="window-dot"></div><div class="window-dot"></div><div class="window-dot"></div>
                </div>
                ${t.terminal}
            </div>
            <div class="cli-body">
<span class="cli-comment">${t.commentCurrent}</span>
<span class="cli-command">curl ${hostname}</span>

<span class="cli-comment">${t.commentSpecific}</span>
<span class="cli-command">curl ${hostname}/${ip}</span>

<span class="cli-comment">${t.commentJson}</span>
<span class="cli-command">curl ${hostname}/json/${ip}</span>

<span class="cli-comment">${t.commentAll}</span>
<span class="cli-command">curl ${hostname}/all</span>
            </div>
        </div>
    </div>
    
    <footer>
        &copy; ${new Date().getFullYear()} Toolkit &middot; ${t.footerPowered}
    </footer>
</body>
</html>`;
}

function formatJSONResponse(ip, info) {
    const response = {
        ip: ip,
        timestamp: new Date().toISOString(),
        source: info?.source || "unknown",
    };

    if (info) {
        response.location = {
            country: info.country,
            region: info.region,
            city: info.city,
            coordinates: info.lat ? { lat: parseFloat(info.lat), lon: parseFloat(info.lon) } : null,
        };
        response.network = {
            isp: info.isp,
            org: info.org,
        };
    }
    return JSON.stringify(response, null, 2);
}

async function handleRequest(request) {
    const url = new URL(request.url);
    const pathParts = url.pathname.replace(/^\/+|\/+$/g, "").split("/");
    const firstPath = pathParts[0] || "";
    // 判断是否在终端请求
    const isCLI = (request.headers.get("User-Agent") || "").includes("curl") || 
                 (request.headers.get("User-Agent") || "").includes("Wget");
    const hostname = url.hostname;
    const lang = getLanguage(request); // 获取语言

    let ip = parsePathIP(request);
    if (!ip) ip = getClientIP(request);

    if (firstPath === "health") {
        return new Response("OK", { status: 200, headers: { "Content-Type": "text/plain" } });
    }

    if (firstPath === "json") {
        const info = await fetchFirstAvailable(ip);
        return new Response(formatJSONResponse(ip, info), {
            headers: { "Content-Type": "application/json; charset=utf-8", "Access-Control-Allow-Origin": "*" },
        });
    }

    if (firstPath === "all") {
        const allSources = await fetchAllSources(ip);
        if (isCLI) {
            return new Response(formatCLIAllResponse(ip, allSources, lang), { headers: { "Content-Type": "text/plain; charset=utf-8" } });
        }
        return new Response(formatHTMLResponse(ip, allSources, hostname, lang), { headers: { "Content-Type": "text/html; charset=utf-8" } });
    }

    const allSources = await fetchAllSources(ip);
    if (isCLI) {
        return new Response(formatCLIResponse(ip, allSources, hostname, lang), { headers: { "Content-Type": "text/plain; charset=utf-8" } });
    }

    return new Response(formatHTMLResponse(ip, allSources, hostname, lang), { headers: { "Content-Type": "text/html; charset=utf-8" } });
}

addEventListener("fetch", (event) => {
    event.respondWith(handleRequest(event.request));
});