import os
import sys
import subprocess
import getpass
import datetime
from pathlib import Path
import requests

# 尝试导入Windows特定模块，如果失败则跳过
try:
    import win32evtlog
    import win32evtlogutil
    import win32con
    import win32api
    import win32crypt
    import pythoncom
    import win32security
    import win32process
    WINDOWS_MODULES_AVAILABLE = True
except ImportError:
    print("Warning: Windows specific modules not available.")
    WINDOWS_MODULES_AVAILABLE = False


def get_desktop_path():
    """Get the path to the user's desktop"""
    return str(Path.home() / "Desktop")

def run_command(command):
    """Run a command and return its output"""
    try:
        result = subprocess.run(command, capture_output=True, text=True, check=True, shell=True)
        return result.stdout
    except subprocess.CalledProcessError as e:
        return f"Error running command: {e.stderr}"

def get_event_logs(log_type, event_source=None, max_events=100):
    """Get events from Windows Event Log"""
    logs = []
    if not WINDOWS_MODULES_AVAILABLE:
        logs.append("Windows modules not available, skipping event logs.\n")
        return logs
        
    try:
        hand = win32evtlog.OpenEventLog(None, log_type)
        flags = win32evtlog.EVENTLOG_BACKWARDS_READ | win32evtlog.EVENTLOG_SEQUENTIAL_READ
        total = win32evtlog.GetNumberOfEventLogRecords(hand)
        
        events = win32evtlog.ReadEventLog(hand, flags, 0)
        count = 0
        
        for event in events:
            if count >= max_events:
                break
                
            if event_source and event.SourceName != event_source:
                continue
                
            # Format event information
            event_time = datetime.datetime.fromtimestamp(win32evtlogutil.GetEventLogRecord(event, log_type)['TimeGenerated']).strftime('%Y-%m-%d %H:%M:%S')
            event_id = event.EventID & 0xFFFF  # Mask off the top bit
            event_type = {
                win32con.EVENTLOG_ERROR_TYPE: "Error",
                win32con.EVENTLOG_WARNING_TYPE: "Warning",
                win32con.EVENTLOG_INFORMATION_TYPE: "Information",
                win32con.EVENTLOG_AUDIT_SUCCESS: "Audit Success",
                win32con.EVENTLOG_AUDIT_FAILURE: "Audit Failure"
            }.get(event.EventType, "Unknown")
            
            logs.append(f"[{event_time}] {event_type} - {event.SourceName} (Event ID: {event_id})\n")
            count += 1
            
        win32evtlog.CloseEventLog(hand)
    except Exception as e:
        logs.append(f"Error reading {log_type} event log: {str(e)}")
        
    return logs

def get_certificates():
    """Get system and user certificates"""
    certificates = []
    
    if not WINDOWS_MODULES_AVAILABLE:
        certificates.append("Windows modules not available, skipping certificates.\n")
        return certificates
        
    # Initialize COM
    pythoncom.CoInitialize()
    
    # User certificates
    try:
        store = win32crypt.CertOpenSystemStore(None, "MY")
        if store:
            certificates.append("User Certificates:\n")
            cert_context = win32crypt.CertEnumCertificatesInStore(store, None)
            while cert_context:
                subject = win32crypt.CertGetNameString(cert_context, win32crypt.CERT_NAME_SIMPLE_DISPLAY_TYPE, 0, None)
                issuer = win32crypt.CertGetNameString(cert_context, win32crypt.CERT_NAME_SIMPLE_DISPLAY_TYPE, 0, cert_context.pCertInfo.Issuer)
                exp_date = win32crypt.FileTimeToSystemTime(cert_context.pCertInfo.NotAfter)
                exp_date_str = f"{exp_date.wYear}-{exp_date.wMonth:02d}-{exp_date.wDay:02d}"
                certificates.append(f"  - Subject: {subject}\n")
                certificates.append(f"    Issuer: {issuer}\n")
                certificates.append(f"    Expires: {exp_date_str}\n")
                cert_context = win32crypt.CertEnumCertificatesInStore(store, cert_context)
            win32crypt.CertCloseStore(store, 0)
    except Exception as e:
        certificates.append(f"Error reading user certificates: {str(e)}")
    
    # System certificates
    try:
        store = win32crypt.CertOpenSystemStore(None, "ROOT")
        if store:
            certificates.append("\nSystem Certificates:\n")
            cert_context = win32crypt.CertEnumCertificatesInStore(store, None)
            while cert_context:
                subject = win32crypt.CertGetNameString(cert_context, win32crypt.CERT_NAME_SIMPLE_DISPLAY_TYPE, 0, None)
                issuer = win32crypt.CertGetNameString(cert_context, win32crypt.CERT_NAME_SIMPLE_DISPLAY_TYPE, 0, cert_context.pCertInfo.Issuer)
                exp_date = win32crypt.FileTimeToSystemTime(cert_context.pCertInfo.NotAfter)
                exp_date_str = f"{exp_date.wYear}-{exp_date.wMonth:02d}-{exp_date.wDay:02d}"
                certificates.append(f"  - Subject: {subject}\n")
                certificates.append(f"    Issuer: {issuer}\n")
                certificates.append(f"    Expires: {exp_date_str}\n")
                cert_context = win32crypt.CertEnumCertificatesInStore(store, cert_context)
            win32crypt.CertCloseStore(store, 0)
    except Exception as e:
        certificates.append(f"Error reading system certificates: {str(e)}")
    
    pythoncom.CoUninitialize()
    return certificates

def get_user_info():
    """Get user information"""
    user_info = []
    try:
        user_info.append(f"Username: {getpass.getuser()}\n")
        user_info.append(f"User Domain: {os.environ.get('USERDOMAIN', 'N/A')}\n")
        user_info.append(f"Computer Name: {os.environ.get('COMPUTERNAME', 'N/A')}\n")
        
        # Get more detailed user information
        if WINDOWS_MODULES_AVAILABLE:
            try:
                token = win32security.OpenProcessToken(win32process.GetCurrentProcess(), win32security.TOKEN_QUERY)
                sid, _, _ = win32security.GetTokenInformation(token, win32security.TokenUser)
                user_info.append(f"User SID: {win32security.ConvertSidToStringSid(sid)}\n")
            except:
                user_info.append("User SID: N/A (requires admin privileges)\n")
        else:
            user_info.append("User SID: N/A (Windows modules not available)\n")
            
    except Exception as e:
        user_info.append(f"Error getting user information: {str(e)}")
    return user_info

def get_public_ip_info():
    """Get public IP information including IPv4, IPv6, country, city, ISP, etc."""
    public_info = []
    try:
        # Get public IP information from ipinfo.io
        response = requests.get("https://ipinfo.io/json")
        if response.status_code == 200:
            data = response.json()
            public_info.append(f"Public IP (IPv4): {data.get('ip', 'N/A')}\n")
            public_info.append(f"Hostname: {data.get('hostname', 'N/A')}\n")
            public_info.append(f"City: {data.get('city', 'N/A')}\n")
            public_info.append(f"Region: {data.get('region', 'N/A')}\n")
            public_info.append(f"Country: {data.get('country', 'N/A')}\n")
            public_info.append(f"Location: {data.get('loc', 'N/A')}\n")
            public_info.append(f"ISP: {data.get('org', 'N/A')}\n")
            public_info.append(f"Postal: {data.get('postal', 'N/A')}\n")
            public_info.append(f"Timezone: {data.get('timezone', 'N/A')}\n")
        else:
            public_info.append(f"Failed to get public IP info. Status code: {response.status_code}\n")
    except Exception as e:
        public_info.append(f"Error getting public IP information: {str(e)}\n")
    
    # Try to get IPv6 information
    try:
        response = requests.get("https://api64.ipify.org?format=json")
        if response.status_code == 200:
            ipv6_data = response.json()
            public_info.append(f"Public IP (IPv6): {ipv6_data.get('ip', 'N/A')}\n")
        else:
            public_info.append("Failed to get IPv6 address.\n")
    except Exception as e:
        public_info.append(f"Error getting IPv6 information: {str(e)}\n")
    
    return public_info

def collect_network_information():
    """Collect all network information and generate report"""
    report = []
    report.append("=" * 80 + "\n")
    report.append(f"Network and System Information Report\n")
    report.append(f"Generated on: {datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
    report.append("=" * 80 + "\n\n")
    
    # User Information
    report.append("=" * 40 + "\n")
    report.append("USER INFORMATION\n")
    report.append("=" * 40 + "\n")
    report.extend(get_user_info())
    report.append("\n")
    
    # Public Network Information
    report.append("=" * 40 + "\n")
    report.append("PUBLIC NETWORK INFORMATION\n")
    report.append("=" * 40 + "\n")
    report.extend(get_public_ip_info())
    report.append("\n")
    
    # Local Network Information (ipconfig)
    report.append("=" * 40 + "\n")
    report.append("LOCAL NETWORK INFORMATION (IPCONFIG /ALL)\n")
    report.append("=" * 40 + "\n")
    try:
        ipconfig_output = run_command("ipconfig /all")
        report.append(ipconfig_output)
    except Exception as e:
        report.append(f"Error getting ipconfig information: {str(e)}\n")
    report.append("\n")
    
    # Wireless Information
    report.append("=" * 40 + "\n")
    report.append("WIRELESS INFORMATION\n")
    report.append("=" * 40 + "\n")
    try:
        wlan_output = run_command("netsh wlan show all")
        report.append(wlan_output)
    except Exception as e:
        report.append(f"Error getting wireless information: {str(e)}\n")
    report.append("\n")
    
    # Wireless Profiles (simplified to avoid complex parsing)
    report.append("=" * 40 + "\n")
    report.append("WIRELESS PROFILES\n")
    report.append("=" * 40 + "\n")
    try:
        profiles_output = run_command("netsh wlan show profiles")
        report.append(profiles_output)
    except Exception as e:
        report.append(f"Error getting wireless profiles: {str(e)}\n")
    report.append("\n")
    
    return "".join(report)

def main():
    """Main function"""
    # Set up error logging to file
    error_log_path = os.path.join(get_desktop_path(), "network_info_error.log")
    
    try:
        print("Starting network information collection...")
        # Collect all information
        report_content = collect_network_information()
        
        print("Information collected successfully.")
        # Save to desktop
        desktop_path = get_desktop_path()
        print(f"Desktop path: {desktop_path}")
        report_path = os.path.join(desktop_path, "网络信息报告.txt")
        
        with open(report_path, "w", encoding="utf-8") as f:
            f.write(report_content)
            
        print(f"Report generated successfully: {report_path}")
        
    except Exception as e:
        error_message = f"An error occurred: {str(e)}"
        print(error_message)
        
        # Write error to log file
        with open(error_log_path, "w", encoding="utf-8") as f:
            f.write(error_message + "\n\n")
            import traceback
            traceback.print_exc(file=f)
            
        print(f"Error details saved to: {error_log_path}")
        sys.exit(1)

if __name__ == "__main__":
    main()
