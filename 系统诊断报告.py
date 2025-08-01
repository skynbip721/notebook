import os
import platform
import subprocess
from datetime import datetime

def get_desktop_path():
    """获取桌面路径"""
    return os.path.expanduser("~/Desktop")

def get_system_info():
    """获取系统信息"""
    system_info = f"操作系统: {platform.system()} {platform.release()}\n"
    system_info += f"平台: {platform.platform()}\n"
    system_info += f"架构: {platform.machine()}\n"
    system_info += f"处理器: {platform.processor()}\n"
    return system_info

def get_hardware_info():
    """获取硬件信息"""
    hardware_info = ""
    if platform.system() == "Windows":
        hardware_info += "=== Windows 硬件信息 ===\n"
        hardware_info += subprocess.getoutput("wmic cpu get name")
        hardware_info += "\n"
        hardware_info += subprocess.getoutput("wmic memorychip get capacity")
        hardware_info += "\n"
        hardware_info += subprocess.getoutput("wmic diskdrive get model,size")
        hardware_info += "\n"
        hardware_info += subprocess.getoutput("wmic path win32_videocontroller get name")
    elif platform.system() == "Linux":
        hardware_info += "=== Linux 硬件信息 ===\n"
        hardware_info += subprocess.getoutput("lscpu")
        hardware_info += "\n"
        hardware_info += subprocess.getoutput("lsmem")
        hardware_info += "\n"
        hardware_info += subprocess.getoutput("lsblk")
        hardware_info += "\n"
        hardware_info += subprocess.getoutput("lspci | grep VGA")
    elif platform.system() == "Darwin":  # macOS
        hardware_info += "=== macOS 硬件信息 ===\n"
        hardware_info += subprocess.getoutput("sysctl -n machdep.cpu.brand_string")
        hardware_info += "\n"
        hardware_info += subprocess.getoutput("system_profiler SPHardwareDataType")
    return hardware_info

def get_network_info():
    """获取网络信息"""
    network_info = ""
    if platform.system() == "Windows":
        network_info += "=== Windows 网络信息 ===\n"
        network_info += subprocess.getoutput("ipconfig /all")
        network_info += "\n"
        network_info += subprocess.getoutput("netstat -ano")
    elif platform.system() == "Linux":
        network_info += "=== Linux 网络信息 ===\n"
        network_info += subprocess.getoutput("ifconfig -a")
        network_info += "\n"
        network_info += subprocess.getoutput("netstat -tuln")
    elif platform.system() == "Darwin":
        network_info += "=== macOS 网络信息 ===\n"
        network_info += subprocess.getoutput("ifconfig -a")
        network_info += "\n"
        network_info += subprocess.getoutput("netstat -tuln")
    return network_info

def get_security_info():
    """获取安全信息"""
    security_info = ""
    if platform.system() == "Windows":
        security_info += "=== Windows 安全信息 ===\n"
        security_info += subprocess.getoutput("tasklist | findstr /i \"msmpeng.exe avg avast norton mcafee\"")
    elif platform.system() == "Linux":
        security_info += "=== Linux 安全信息 ===\n"
        security_info += subprocess.getoutput("systemctl status firewalld")
        security_info += "\n"
        security_info += subprocess.getoutput("iptables -L")
    elif platform.system() == "Darwin":
        security_info += "=== macOS 安全信息 ===\n"
        security_info += subprocess.getoutput("sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate")
    return security_info

def save_to_file(content):
    """将信息保存到文件"""
    desktop_path = get_desktop_path()
    timestamp = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
    file_name = f"SystemReport_{timestamp}.txt"
    file_path = os.path.join(desktop_path, file_name)
    
    with open(file_path, "w") as f:
        f.write(content)
    
    print(f"诊断报告已保存到: {file_path}")
    return file_path

def main():
    """主函数"""
    content = "系统诊断报告\n"
    content += "===============================\n"
    content += f"日期和时间: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n"
    content += "===============================\n\n"
    
    content += "系统信息:\n"
    content += "----------------\n"
    content += get_system_info()
    content += "\n"
    
    content += "硬件信息:\n"
    content += "----------------\n"
    content += get_hardware_info()
    content += "\n"
    
    content += "网络信息:\n"
    content += "----------------\n"
    content += get_network_info()
    content += "\n"
    
    content += "安全信息:\n"
    content += "----------------\n"
    content += get_security_info()
    content += "\n"
    
    content += "===============================\n"
    content += "诊断报告结束\n"
    content += "===============================\n"
    
    save_to_file(content)

if __name__ == "__main__":
    main()
