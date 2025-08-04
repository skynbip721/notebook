import platform
import os
import sys
import wmi
import socket
import requests
from datetime import datetime

def get_system_info():
    info = {}
    info['操作系统'] = platform.system()
    info['操作系统版本'] = platform.release()
    info['操作系统版本号'] = platform.version()
    info['架构'] = platform.machine()
    info['计算机名称'] = socket.gethostname()
    info['Python版本'] = sys.version
    return info

def get_bios_info():
    c = wmi.WMI()
    bios = c.Win32_BIOS()[0]
    info = {}
    info['制造商'] = bios.Manufacturer
    info['型号'] = bios.Name
    info['版本'] = bios.Version
    info['发布日期'] = bios.ReleaseDate
    return info

def get_cpu_info():
    c = wmi.WMI()
    cpu = c.Win32_Processor()[0]
    info = {}
    info['制造商'] = cpu.Manufacturer
    info['名称'] = cpu.Name
    info['核心数'] = cpu.NumberOfCores
    info['线程数'] = cpu.NumberOfLogicalProcessors
    info['最大时钟频率'] = f'{cpu.MaxClockSpeed} MHz'
    return info

def get_gpu_info():
    c = wmi.WMI()
    gpus = c.Win32_VideoController()
    info = []
    for gpu in gpus:
        gpu_info = {
            '名称': gpu.Name,
            '制造商': gpu.AdapterCompatibility,
            '显存': f'{int(gpu.AdapterRAM / (1024**3))} GB' if gpu.AdapterRAM else '未知',
            '分辨率': str(gpu.CurrentHorizontalResolution) + 'x' + str(gpu.CurrentVerticalResolution) if gpu.CurrentHorizontalResolution else '未知'
        }
        info.append(gpu_info)
    return info

def get_sound_card_info():
    c = wmi.WMI()
    sound_cards = c.Win32_SoundDevice()
    info = []
    for card in sound_cards:
        sound_info = {
            '名称': card.ProductName,
            '制造商': card.Manufacturer
        }
        info.append(sound_info)
    return info

def get_hard_drive_info():
    c = wmi.WMI()
    drives = c.Win32_LogicalDisk(DriveType=3)
    info = []
    for drive in drives:
        total_size = int(drive.Size) if drive.Size else 0
        free_space = int(drive.FreeSpace) if drive.FreeSpace else 0
        used_space = total_size - free_space
        drive_info = {
            '设备ID': drive.DeviceID,
            '文件系统': drive.FileSystem,
            '卷标': drive.VolumeName,
            '总大小': f'{total_size / (1024**3):.2f} GB' if total_size else '未知',
            '可用空间': f'{free_space / (1024**3):.2f} GB' if free_space else '未知',
            '已用空间': f'{used_space / (1024**3):.2f} GB' if used_space else '未知',
            '文件系统类型': drive.DriveType
        }
        info.append(drive_info)
    return info

def get_network_card_info():
    c = wmi.WMI()
    adapters = c.Win32_NetworkAdapterConfiguration(IPEnabled=True)
    info = []
    for adapter in adapters:
        ip_addresses = adapter.IPAddress if adapter.IPAddress else []
        mac_address = adapter.MACAddress if adapter.MACAddress else '未知'
        gateway = adapter.DefaultIPGateway[0] if adapter.DefaultIPGateway else '未知'
        dns_servers = ', '.join(adapter.DNSServerSearchOrder) if adapter.DNSServerSearchOrder else '未知'
        adapter_info = {
            '名称': adapter.Description,
            'MAC地址': mac_address,
            'IP地址': ', '.join(ip_addresses),
            '子网掩码': ', '.join(adapter.IPSubnet) if adapter.IPSubnet else '未知',
            '网关': gateway,
            'DNS服务器': dns_servers
        }
        info.append(adapter_info)
    return info

def get_monitor_info():
    c = wmi.WMI()
    monitors = c.Win32_DesktopMonitor()
    info = []
    for monitor in monitors:
        monitor_info = {
            '名称': monitor.Name,
            '制造商': getattr(monitor, 'Manufacturer', '未知'),
            '屏幕尺寸': f'{monitor.ScreenWidth}x{monitor.ScreenHeight} 像素'
        }
        info.append(monitor_info)
    return info

def get_input_device_info():
    c = wmi.WMI()
    keyboards = c.Win32_Keyboard()
    mice = c.Win32_PointingDevice()
    info = {
        '键盘': [],
        '鼠标': []
    }
    for keyboard in keyboards:
        info['键盘'].append({
            '名称': keyboard.Name,
            '制造商': getattr(keyboard, 'Manufacturer', '未知')
        })
    for mouse in mice:
        info['鼠标'].append({
            '名称': mouse.Name,
            '制造商': getattr(mouse, 'Manufacturer', '未知')
        })
    return info

def get_printer_info():
    c = wmi.WMI()
    printers = c.Win32_Printer()
    info = []
    for printer in printers:
        try:
            manufacturer = printer.Manufacturer
        except AttributeError:
            manufacturer = '未知'
        printer_info = {
            '名称': printer.Name,
            '制造商': manufacturer,
            '状态': printer.Status,
            '默认打印机': '是' if printer.Default else '否',
            '共享': '是' if printer.Shared else '否'
        }
        info.append(printer_info)
    return info

def get_public_ip_info():
    info = {}
    try:
        response = requests.get('https://ipinfo.io', timeout=5)
        data = response.json()
        info['公网IP'] = data.get('ip', '未知')
        info['国家'] = data.get('country', '未知')
        info['地区'] = data.get('region', '未知')
        info['城市'] = data.get('city', '未知')
        info['运营商'] = data.get('org', '未知')
    except Exception as e:
        info['错误'] = f'获取公网信息失败: {str(e)}'
        info['公网IP'] = '未知'
    return info

def main():
    # 创建信息收集字典
    system_info = {
        '收集时间': datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
        '系统信息': get_system_info(),
        'BIOS信息': get_bios_info(),
        'CPU信息': get_cpu_info(),
        'GPU信息': get_gpu_info(),
        '声卡信息': get_sound_card_info(),
        '硬盘信息': get_hard_drive_info(),
        '网卡信息': get_network_card_info(),
        '显示器信息': get_monitor_info(),
        '输入设备信息': get_input_device_info(),
        '打印机信息': get_printer_info(),
        '公网信息': get_public_ip_info()
    }

    # 格式化信息为文本
    output = '=== 系统信息收集报告 ===\n'
    output += f'收集时间: {system_info["收集时间"]}\n\n'

    for section, data in system_info.items():
        if section == '收集时间':
            continue
        output += f'--- {section} ---\n'
        if isinstance(data, dict):
            for key, value in data.items():
                output += f'{key}: {value}\n'
        elif isinstance(data, list):
            for i, item in enumerate(data, 1):
                output += f'设备 {i}:\n'
                if isinstance(item, dict):
                    for key, value in item.items():
                        output += f'  {key}: {value}\n'
                else:
                    output += f'  {item}\n'
        else:
            output += f'{data}\n'
        output += '\n'

    # 保存到桌面
    desktop_path = os.path.join(os.path.expanduser('~'), 'Desktop')
    file_path = os.path.join(desktop_path, '系统信息报告.txt')

    try:
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(output)
        print(f'系统信息已成功保存到: {file_path}')
    except Exception as e:
        print(f'保存文件失败: {str(e)}')

if __name__ == '__main__':
    main()