# 实用的DOS命令-wifi命令

**1、获取附近wifi信息：**netsh wlan show networks mode=bssid

C:\Users\ArchLinux>netsh wlan show networks mode=bssid



Interface name : WLAN

There are 1 networks currently visible.



SSID 1 : ASUS

Network type : Infrastructure

Authentication : WPA2-Personal

Encryption : CCMP

BSSID 1 : 4c:ed:fb:a3:b1:50

Signal : 85%

Radio type : 802.11n

Channel : 9

Basic rates (Mbps) : 1 2 5.5 11

Other rates (Mbps) : 6 9 12 18 24 36 48 54

**2、获取当前连接的wifi名称：**netsh WLAN show interfaces

C:\Users\ArchLinux>netsh WLAN show interfaces



There is 1 interface on the system:



Name : WLAN

Description : Intel(R) Wireless-AC 9462

GUID : daef7123-37d6-4bac-bfc0-24d583a13f82

Physical address : b4:69:21:bf:5c:c0

State : connected

SSID : ASUS

BSSID : 4c:ed:fb:a3:b1:50

Network type : Infrastructure

Radio type : 802.11n

Authentication : WPA2-Personal

Cipher : CCMP

Connection mode : Auto Connect

Channel : 9

Receive rate (Mbps) : 72.2

Transmit rate (Mbps) : 72.2

Signal : 86%

Profile : ASUS



Hosted network status : Not available



**3、查看已连接的wifi：**netsh wlan show profiles



C:\Users\ArchLinux>netsh wlan show profiles



Profiles on interface WLAN:



Group policy profiles (read only)

\---------------------------------

<None>



User profiles

\-------------

All User Profile : ASUS

All User Profile : ASUS_5G

All User Profile : 360WiFi-659EC1

All User Profile : SKY

All User Profile : archlinux

**4、查看mywifi的相关信息：**netsh wlan show profile name=mywifi key=clear

C:\Users\ArchLinux>netsh wlan show profile name=ASUS key=clear



Profile ASUS on interface WLAN:

=======================================================================



Applied: All User Profile



Profile information

\-------------------

Version : 1

Type : Wireless LAN

Name : ASUS

Control options :

Connection mode : Connect automatically

Network broadcast : Connect only if this network is broadcasting

AutoSwitch : Do not switch to other networks

MAC Randomization : Disabled



Connectivity settings

\---------------------

Number of SSIDs : 1

SSID name : "ASUS"

Network type : Infrastructure

Radio type : [ Any Radio Type ]

Vendor extension : Not present



Security settings

\-----------------

Authentication : WPA2-Personal

Cipher : CCMP

Authentication : WPA2-Personal

Cipher : GCMP

Security key : Present

Key Content : Woshinibaba



Cost settings

\-------------

Cost : Unrestricted

Congested : No

Approaching Data Limit : No

Over Data Limit : No

Roaming : No

Cost Source : Default