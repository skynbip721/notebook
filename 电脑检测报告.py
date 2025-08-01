import os
import sys
import subprocess
import getpass
import datetime
from pathlib import Path
import win32evtlog
import win32evtlogutil
import win32con
import win32api
import win32crypt
import pythoncom
import win32security
import win32process


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
        try:
            token = win32security.OpenProcessToken(win32process.GetCurrentProcess(), win32security.TOKEN_QUERY)
            sid, _, _ = win32security.GetTokenInformation(token, win32security.TokenUser)
            user_info.append(f"User SID: {win32security.ConvertSidToStringSid(sid)}\n")
        except:
            user_info.append("User SID: N/A (requires admin privileges)\n")
            
    except Exception as e:
        user_info.append(f"Error getting user information: {str(e)}")
    return user_info

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
    
    # ipconfig
    report.append("=" * 40 + "\n")
    report.append("IPCONFIG /ALL\n")
    report.append("=" * 40 + "\n")
    report.append(run_command("ipconfig /all"))
    report.append("\n")
    
    # netsh wlan show all
    report.append("=" * 40 + "\n")
    report.append("NETSH WLAN SHOW ALL\n")
    report.append("=" * 40 + "\n")
    report.append(run_command("netsh wlan show all"))
    report.append("\n")
    
    # Wireless Profiles
    report.append("=" * 40 + "\n")
    report.append("WIRELESS PROFILES\n")
    report.append("=" * 40 + "\n")
    profiles_output = run_command("netsh wlan show profiles")
    report.append(profiles_output)
    
    # Extract profile names and get detailed info
    profile_names = []
    for line in profiles_output.split('\n'):
        if "All User Profile" in line:
            profile_name = line.split(":")[1].strip()
            profile_names.append(profile_name)
    
    for profile in profile_names:
        report.append("\n" + "=" * 20 + "\n")
        report.append(f"PROFILE: {profile}\n")
        report.append("=" * 20 + "\n")
        report.append(run_command(f'netsh wlan show profile name="{profile}" key=clear'))
    report.append("\n")
    
    # Network Devices
    report.append("=" * 40 + "\n")
    report.append("NETWORK DEVICES\n")
    report.append("=" * 40 + "\n")
    report.append(run_command("wmic nic get Name,Index,MACAddress,Manufacturer"))
    report.append("\n")
    
    # Certificates
    report.append("=" * 40 + "\n")
    report.append("CERTIFICATES\n")
    report.append("=" * 40 + "\n")
    report.extend(get_certificates())
    report.append("\n")
    
    # Event Logs
    event_logs_info = [
        ("System", "WLAN-AutoConfig", "WLAN EVENTS"),
        ("System", "Microsoft-Windows-NCSI", "NCSI EVENTS"),
        ("System", "Microsoft-Windows-NDIS", "NDIS EVENTS"),
        ("System", "Microsoft-Windows-EAPOL", "EAP EVENTS"),
        ("System", "Microsoft-Windows-WLAN-Config", "WCM EVENTS"),
        ("System", None, "KERNEL EVENTS"),
        ("System", None, "SYSTEM EVENTS")
    ]
    
    for log_type, source, title in event_logs_info:
        report.append("=" * 40 + "\n")
        report.append(title + "\n")
        report.append("=" * 40 + "\n")
        events = get_event_logs(log_type, source)
        if events:
            report.extend(events)
        else:
            report.append(f"No events found for {title}\n")
        report.append("\n")
    
    return "".join(report)

def main():
    """Main function"""
    try:
        # Collect all information
        report_content = collect_network_information()
        
        # Save to desktop
        desktop_path = get_desktop_path()
        report_path = os.path.join(desktop_path, "电脑检测报告.txt")
        
        with open(report_path, "w", encoding="utf-8") as f:
            f.write(report_content)
            
        print(f"Report generated successfully: {report_path}")
        
    except Exception as e:
        print(f"An error occurred: {str(e)}")
        sys.exit(1)

if __name__ == "__main__":
    main()
