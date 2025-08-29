# Windows & Office 永久激活工具

## **背景**

## **HWID**

在 Win10 刚发布时，微软曾推出的一项计划：已激活的 Win7/Win8 的旧版用户可以免费升级到 Win10，而且同一台电脑即便重装系统，无需输入密钥，只要联网自动激活，也称为 HWID 激活。

数字激活软件就是通过软件模拟直接在 Win10 设备获取 HWID 发送给微软，伪装成旧版设备升级、走免费升级服务的通道从而实现系统的激活。

现在 Win11 都推出了，微软也并正式关闭了这个通道。但幸运的是如今又有开发者研究出了新方法，可重新永久激活，大家将其称为HWID 2。

## **Microsoft Activation Scripts**

MAS 具备 HWID/KMS38/在线 KMS 激活 Microsoft，这款批处理版 KMS 激活脚本最大特色是代码开源，小巧不误报。

这个神器叫 **[Microsoft Activation Scripts (MAS)](https://link.juejin.cn?target=https%3A%2F%2Flink.zhihu.com%2F%3Ftarget%3Dhttps%3A%2F%2Fgithub.com%2Fmassgravel%2FMicrosoft-Activation-Scripts)** ，是 github 上的一个开源项目。

具体的操作步骤

1. `Win + R`后输入`cmd`，回车，即打开 CMD 窗口
2. 粘贴这条命令后回车

```arduino
arduino
复制代码irm https://massgrave.dev/get | iex
```

![img](https://pic1.zhimg.com/80/v2-892cf0259c4f4bd33c019c0ba93ff0dc_720w.webp)

cmd窗口输入命令

###### 三种激活方式分别是 ：HWID 数字许可证永久激活、KMS38 激活至 2038年、在线 KMS 激活 180天，支持 Windows、Office所有版本激活。

![img](https://pic1.zhimg.com/80/v2-8a3564e3928450db51258741e7fac478_720w.webp)

可以下载收藏，把自己的系统永久激活，并且以后如果重装系统只要联网就可以自动激活。使用前记得暂时把杀毒软件退出一下。

## **MAS**

## **概述**

xxxxxxxxxx #删除配置的静态IPnmcli connection modify ens37 ipv4.addresses "" ipv4.gateway "" ipv4.dns ""#修改网卡为dhcp模式nmcli connection modify eth0 ipv4.method auto#重启网卡nmcli c down ens37 && nmcli c up ens37sh

![img](https://pic3.zhimg.com/80/v2-594cd65fe7849eafcad0a8de0d2f4e76_720w.webp)

## **核心功能**

### **Windows 激活**

### **概述**

MAS 的主要功能是帮助用户激活其 Windows 操作系统。无论使用的是 Windows 10、Windows 11 还是其他版本，MAS 都提供了可靠的激活选项。

### **永久激活**

Microsoft Activation Scripts 提供了永久激活 Windows 的 HWID（数字许可证）方法。
选择 HWID 激活时，电脑必须联网，因为它得连接微软服务器，否则会导致激活失败。

### **Office激活**

### **概述**

除了 Windows，MAS 还支持 Microsoft Office 套件的激活。这包括诸如 Word、Excel、PowerPoint等常用办公软件。

### **永久激活**

Microsoft Activation Scripts 提供了永久激活 Office 的 Ohook 方法。
Office的Ohook激活，电脑不联网也行，可以本地离线执行。

### **离线激活**

MAS 允许用户进行离线激活，这对于没有稳定互联网连接的用户非常有用。通过这一功能，可以在没有网络连接的情况下激活操作系统和 Office 套件。

### **多种激活方式**

MAS 提供了多种激活方式，包括 KMS（Key Management Service）、Digital License（数字许可证）和 HWID（硬件标识）激活。

### **定制选项**

MAS 允许用户根据其需求进行个性化配置。可以选择要激活的产品、激活方式以及其他参数，以确保完全符合您的要求。

### **自动激活续期**

MAS 还提供了自动续期功能，可以确保操作系统和 Office 套件保持激活状态，而无需手动干预。

## **MAS 的优势**

Microsoft Activation Scripts 在解决 Windows 激活问题方面具有多重优势：

1. 免费和开源：MAS 是一个完全免费且开源的项目，任何人都可以自由使用和修改。这意味着无需花费额外的资金来激活 Windows 操作系统。
2. 可靠性：MAS 经过广泛测试，被认为是一种非常可靠的激活解决方案。它能够解决常见的激活问题，确保系统在激活后正常运行。
3. 离线激活支持：MAS 的离线激活功能使其在没有稳定互联网连接的情况下仍然可用。这对于一些用户来说是一个关键的功能。
4. 自动续期：MAS 自动续期功能可确保激活状态持续有效，无需手动操作。
5. 多种激活方式：MAS 提供多种激活方式，允许用户根据自己的需求进行选择。

## **MAS 下载及使用**

## **下载**

Microsoft Activation Scripts ：下载地址：[https://github.com/massgravel/Microsoft-Activation-Scripts/releases](https://link.zhihu.com/?target=https%3A//github.com/massgravel/Microsoft-Activation-Scripts/releases)

## **使用**

Microsoft Activation Scripts 的使用非常简单，解压下载的文件，打开 MAS_AIO 文件：

![img](https://pic1.zhimg.com/80/v2-a55070582d220932121f74290705e9c4_720w.webp)

然后根据需要输入对应的数字即可：

![img](https://pic2.zhimg.com/80/v2-6dda5447cf45998a001cbb07d86eedb9_720w.webp)

激活完成如上图所示。