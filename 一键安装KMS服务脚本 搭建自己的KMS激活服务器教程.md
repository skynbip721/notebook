#### 一键安装KMS服务脚本 搭建自己的KMS激活服务器教程

KMS，是 Key Management System 的缩写，也就是密钥管理系统。这里所说的 KMS，毋庸置疑就是用来激活 VOL 版本的 Windows 和 Office 的 KMS 啦。经常能在网上看到有人提供的 KMS 服务器地址，那么你有没有想过自己也来搞一个这样的服务呢？适用于三大 Linux 发行版的一键安装 KMS 服务的脚本。请勿使用美国服务器搭建KMS，因为这是违反DMCA的。建议使用国内服务器或者自家电脑。

![KMS](https://www.ypojie.com/wp-content/uploads/2018/05/kms.png)

**本脚本适用环境**

系统支持：CentOS 6+，Debian 7+，Ubuntu 12+
虚拟技术：任意
内存要求：≥128M
日期　　：2018 年 04 月 15 日

### 关于本脚本

1、本脚本适用于三大 Linux 发行版，其他版本则不支持。
2、KMS 服务安装完成后会加入开机自启动。
3、默认记录日志，其日志位于 /var/log/vlmcsd.log。

### 使用方法

使用root用户登录，运行以下命令：

**复制

```bsh
wget --no-check-certificate https://github.com/teddysun/across/raw/master/
kms.sh && chmod +x kms.sh && ./kms.sh
```

安装完成后，输入以下命令查看端口号 1688 的监听情况

**复制

```bsh
netstat -nxtlp | grep 1688
```

返回值类似于如下这样就表示 OK 了：

**复制

```bsh
tcp        0      0 0.0.0.0:1688                0.0.0.0:*                   LISTEN      3200/vlmcsd
tcp        0      0 :::1688                     :::*                        LISTEN      3200/vlmcsd
```

本脚本安装完成后，会将 KMS 服务加入开机自启动。

**使用命令：**
启动：/etc/init.d/kms start
停止：/etc/init.d/kms stop
重启：/etc/init.d/kms restart
状态：/etc/init.d/kms status

**卸载方法：**
使用 root 用户登录，运行以下命令：

**复制

```bsh
./kms.sh uninstall
```

### 如何使用 KMS 服务

KMS 服务，用于在线激活 VOL 版本的 Windows 和 Office。
激活的前提是你的系统是批量授权版本，即 VL 版，一般企业版都是 VL 版。而 VL 版本的镜像一般内置 GVLK key，用于 KMS 激活。
下面列表里面含有的产品的 VL 版本或者能使用 key 进入 KMS 通道的产品，都支持使用 KMS 激活。

Office 2016：[https://technet.microsoft.com/zh-cn/library/dn385360(v=office.16).aspx](https://www.ypojie.com/go/aHR0cHM6Ly90ZWNobmV0Lm1pY3Jvc29mdC5jb20vemgtY24vbGlicmFyeS9kbjM4NTM2MCh2PW9mZmljZS4xNikuYXNweA==)
Office 2013：[https://technet.microsoft.com/ZH-CN/library/dn385360.aspx](https://www.ypojie.com/go/aHR0cHM6Ly90ZWNobmV0Lm1pY3Jvc29mdC5jb20vWkgtQ04vbGlicmFyeS9kbjM4NTM2MC5hc3B4)
Office 2010：[https://technet.microsoft.com/ZH-CN/library/ee624355(v=office.14).aspx](https://www.ypojie.com/go/aHR0cHM6Ly90ZWNobmV0Lm1pY3Jvc29mdC5jb20vWkgtQ04vbGlicmFyeS9lZTYyNDM1NSh2PW9mZmljZS4xNCkuYXNweA==)
Windows：[https://docs.microsoft.com/zh-cn/windows-server/get-started/kmsclientkeys](https://www.ypojie.com/go/aHR0cHM6Ly9kb2NzLm1pY3Jvc29mdC5jb20vemgtY24vd2luZG93cy1zZXJ2ZXIvZ2V0LXN0YXJ0ZWQva21zY2xpZW50a2V5cw==)

使用管理员权限运行 cmd 查看系统版本，命令如下：

**复制

```bsh
wmic os get caption
```

使用管理员权限运行 cmd 安装从上面列表得到的 key，命令如下：

**复制

```bsh
slmgr /ipk xxxxx-xxxxx-xxxxx-xxxxx-xxxxx
```

使用管理员权限运行 cmd 将 KMS 服务器地址设置为你自己的 IP 或 域名，命令如下：

**复制

```bsh
slmgr /skms Your IP or Domain
```

**注意：**本脚本所做的工作就是此步骤。当你的 KMS 服务出于启动状态，那么此处就可以设置为你自己的 KMS 服务器地址。
使用管理员权限运行 cmd 手动激活系统，命令如下：

**复制

```bsh
slmgr /ato
```

关于 Office 的激活，要求必须是 VOL 版本，否则无法激活。
找到你的 Office 安装目录，32 位默认一般为 C:\Program Files (x86)\Microsoft Office\Office16
64 位默认一般为 C:\Program Files\Microsoft Office\Office16
Office16 是 Office 2016，Office15 就是 Office 2013，Office14 就是 Office 2010。
打开以上所说的目录，应该有个 OSPP.VBS 文件。
使用管理员权限运行 cmd 进入 Office 目录，命令如下：

**复制

```bsh
cd "C:\Program Files (x86)\Microsoft Office\Office16"
```

使用管理员权限运行 cmd 注册 KMS 服务器地址：

**复制

```bsh
cscript ospp.vbs /sethst:Your IP or Domain
```

使用管理员权限运行 cmd 手动激活 Office，命令如下：

**复制

```bsh
cscript ospp.vbs /act
```

**注意：** KMS 方式激活，其有效期只有 180 天。
每隔一段时间系统会自动向 KMS 服务器请求续期，请确保你自己的 KMS 服务正常运行。

### 常见错误的对策

如果遇到在执行过程报错，请按以下步骤检查：
1，你的 KMS 服务器是否挂了？
2，你的 KMS 服务是否正常开启？
3，你的系统或 Office 是否为批量 VL 版本？
4，你的系统或 Office 是否修改过 Key 或未安装 GVLK Key？
5，你是否以管理员权限运行 cmd？
6，你的网络连接是否正常？
7，你的本地 DNS 解析是否正常？
8，如果你排除了以上的对策，那请根据错误提示代码自行搜索原因。