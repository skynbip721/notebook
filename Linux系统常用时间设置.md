Linux系统常用时间设置
=============

一、查看系统时间

使用 date 命令即可查看当前的系统时间：
    date

二、手动设置时间

1、执行如下命令可以设置一个新的系统时间：
    date -s "20231118 06:30:50"

或者使用如下命令分开设置  
    sudo date +%Y%m%d -s "20230719"  //设置日期为2023年7月19日

第一行命令将日期设置为指定的日期，第二行命令将时间设置为指定的时间。请根据需要更改这些值。

2、设置完后还要执行如下命令将结果同步到硬件时钟：
    hwclock --systohc

三、自动同步时间

1、首先安装 ntpdate 命令：
    yum install -y ntpdate

2、与网络时间服务器同步：
    ntpdate ntp1.aliyun.com

其他常用的时间服务器：
    cn.pool.ntp.org

3、同步结果到硬件时钟，避免下次重启被还原
    hwclock --systohc



![图片](https://mmbiz.qpic.cn/mmbiz_jpg/cnxtibJc19sadRbpY8Re7ickUHnrpFtqbqbgJUzcLliaAf4gBwXEGAQYm3M5x8ku4Ips7kCUbjxOEKh5W9WSyvnpg/640?wx_fmt=jpeg&from=appmsg&tp=wxpic&wxfrom=5&wx_lazy=1&wx_co=1)

在Linux上查看和设置系统时间是一项基本的任务。接下来讲一下如何自动同步时间。

如果希望系统能够自动同步时间，可以使用网络时间协议（NTP）。  

在CentOS上可以使用yum安装，在Ubuntu上，可以使用apt-get安装，以下为ubuntu命令安装：
    sudo apt-get update

安装完成后，NTP客户端将自动从互联网上的时间服务器同步时间。您也可以手动启动NTP客户端来强制同步时间：
    sudo service ntp start

或者，为了让NTP客户端在系统启动时自动启动，您需要编辑/etc/default/ntp文件，并将start_ntp的行改为start_ntp=1。然后保存并关闭文件。最后，运行以下命令以使更改生效：
    sudo service ntp restart
