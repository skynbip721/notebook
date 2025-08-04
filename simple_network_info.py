import os
import sys
import requests
import subprocess
from pathlib import Path
import datetime

def get_desktop_path():
    """获取桌面路径"""
    return str(Path.home() / "Desktop")

def get_public_ip_info():
    """获取公网IP信息，包括IPv4、IPv6、国家、城市、运营商等"""
    public_info = []
    try:
        # 从ipinfo.io获取公网IP信息
        response = requests.get("https://ipinfo.io/json")
        if response.status_code == 200:
            data = response.json()
            public_info.append(f"公网IP (IPv4): {data.get('ip', 'N/A')}\n")
            public_info.append(f"主机名: {data.get('hostname', 'N/A')}\n")
            public_info.append(f"城市: {data.get('city', 'N/A')}\n")
            public_info.append(f"地区: {data.get('region', 'N/A')}\n")
            public_info.append(f"国家: {data.get('country', 'N/A')}\n")
            public_info.append(f"位置: {data.get('loc', 'N/A')}\n")
            public_info.append(f"运营商: {data.get('org', 'N/A')}\n")
            public_info.append(f"邮政编码: {data.get('postal', 'N/A')}\n")
            public_info.append(f"时区: {data.get('timezone', 'N/A')}\n")
        else:
            public_info.append(f"获取公网IP信息失败。状态码: {response.status_code}\n")
    except Exception as e:
        public_info.append(f"获取公网IP信息时出错: {str(e)}\n")
    
    # 尝试获取IPv6信息
    try:
        response = requests.get("https://api64.ipify.org?format=json")
        if response.status_code == 200:
            ipv6_data = response.json()
            public_info.append(f"公网IP (IPv6): {ipv6_data.get('ip', 'N/A')}\n")
        else:
            public_info.append("获取IPv6地址失败。\n")
    except Exception as e:
        public_info.append(f"获取IPv6信息时出错: {str(e)}\n")
    
    return public_info

def get_local_network_info():
    """获取局域网信息"""
    local_info = []
    try:
        # 使用ipconfig获取局域网信息
        result = subprocess.run("ipconfig /all", capture_output=True, text=True, shell=True)
        local_info.append("=== 局域网信息 ===\n")
        local_info.append(result.stdout)
    except Exception as e:
        local_info.append(f"获取局域网信息时出错: {str(e)}\n")
    return local_info

def get_wifi_info():
    """获取WiFi信息"""
    wifi_info = []
    try:
        # 使用netsh获取WiFi信息
        result = subprocess.run("netsh wlan show all", capture_output=True, text=True, shell=True)
        wifi_info.append("=== WiFi信息 ===\n")
        wifi_info.append(result.stdout)
    except Exception as e:
        wifi_info.append(f"获取WiFi信息时出错: {str(e)}\n")
    return wifi_info

def collect_network_information():
    """收集所有网络信息并生成报告"""
    report = []
    report.append("=" * 80 + "\n")
    report.append("网络信息报告\n")
    report.append(f"生成时间: {datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
    report.append("=" * 80 + "\n\n")
    
    # 公网信息
    report.append("=" * 40 + "\n")
    report.append("公网网络信息\n")
    report.append("=" * 40 + "\n")
    report.extend(get_public_ip_info())
    report.append("\n")
    
    # 局域网信息
    report.append("=" * 40 + "\n")
    report.append("局域网信息\n")
    report.append("=" * 40 + "\n")
    report.extend(get_local_network_info())
    report.append("\n")
    
    # WiFi信息
    report.append("=" * 40 + "\n")
    report.append("WiFi信息\n")
    report.append("=" * 40 + "\n")
    report.extend(get_wifi_info())
    report.append("\n")
    
    return "".join(report)

def main():
    try:
        print("开始收集网络信息...")
        report_content = collect_network_information()
        
        # 保存到桌面
        desktop_path = get_desktop_path()
        report_path = os.path.join(desktop_path, "网络信息报告.txt")
        
        with open(report_path, "w", encoding="utf-8") as f:
            f.write(report_content)
            
        print(f"报告已成功生成: {report_path}")
        
    except Exception as e:
        print(f"发生错误: {str(e)}")
        # 写入错误日志
        error_log_path = os.path.join(get_desktop_path(), "network_info_error.log")
        with open(error_log_path, "w", encoding="utf-8") as f:
            f.write(f"错误: {str(e)}\n")
        print(f"错误详情已保存到: {error_log_path}")
        sys.exit(1)

if __name__ == "__main__":
    main()