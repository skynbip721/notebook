### Linux服务器/VPS性能和带宽测试脚本汇总

下面我汇总了几个比较好用的测试脚本。

## Superspeed.sh

**一键测试服务器到国内的速度脚本Superspeed.sh ：**

```text
wget https://raw.githubusercontent.com/oooldking/script/master/superspeed.sh
chmod +x superspeed.sh
sudo ./superspeed.sh
```

![img](https://pic2.zhimg.com/80/v2-29016e70ce558e63ffbc9b0ac5a30391_720w.webp)

## SuperBench.sh

**一键检测VPS的CPU、内存、负载、IO读写、机房带宽和服务器类型等脚本SuperBench.sh：**

```text
wget -N --no-check-certificate https://raw.githubusercontent.com/oooldking/script/master/superbench.sh
sudo bash superbench.sh
#或者
curl -Lso- https://raw.githubusercontent.com/oooldking/script/master/superbench.sh | bash
```

![img](https://pic3.zhimg.com/80/v2-f9909d989af4be938656d734a79ee92e_720w.webp)

## Zench

**Zench可以看作是Bench.sh 和 SuperBench的结合版本，加入 Ping 以及 路由测试 功能，会生成测评报告，可以很方便地分享给其他朋友看自己的测评数据 ：**

```text
wget -N --no-check-certificate https://raw.githubusercontent.com/FunctionClub/ZBench/master/ZBench-CN.sh
sudo bash ZBench-CN.sh
#项目：https://github.com/FunctionClub/ZBench
```

![img](https://pic3.zhimg.com/80/v2-0a0fd4b9f4d6046d903702b81822f35a_720w.webp)

## speedtest-cli

**一键带宽检测工具：speedtest-cli**

**安装命令：**

```text
sudo apt-get update
apt-get install python-pip
sudo pip install speedtest-cli

#CentOS
yum update
yum -y install epel-release
yum install python-pip
pip install speedtest-cli
```

**使用方法：**

```text
speedtest-cli
#后面也可以接以下参数：
-h, --help show this help message and exit 
--share 分享你的网速，该命令会在speedtest网站上生成网速测试结果的图片。 
--simple Suppress verbose output, only show basic information 
--list 根据距离显示speedtest.net的测试服务器列表。 
--server=SERVER 指定列表中id的服务器来做测试。 
--mini=MINI URL of the Speedtest Mini server 
--source=SOURCE Source ip address to bind to 
--version Show the version number and exit
```

## unixbench

**VPS性能综合跑分工具unixbench：**
Unixbench的主要测试项目有：系统调用、读写、进程、图形化测试、2D、3D、管道、运算、C库等系统基准性能提供测试数据。最新版本`UnixBench5.1.3`，包含`system和graphic`测试，如果你需要测试graphic，则需要修改Makefile。
不要注释掉`GRAPHIC_TESTS = defined` ，同时需要系统提供`x11perf` 命令gl_glibs库。本文脚本注释了关于`graphic`的测试项（大多数VPS都是没有显卡或者是集显，所以图像性能无需测试），运行10-30分钟后（根据CPU内核数量，运算时间不等）得出分数，越高越好。

**UnixBench性能跑分受版本影响较大。**UnixBench目前有不同的版本，而网上不少的版本也是经过人工修改过的，可能测试的项目不同导致的结果也会不同。大家在测试时记得找一个参照对比。

```text
yum -y install wget screen      #for CentOS/Redhat
# apt-get -y install wget screen       #for Debian/Ubuntu
screen -S zeruns      #如果网路出现中断，可以执行命令`screen -R zeruns`重新连接测试窗口
wget --no-check-certificate https://github.com/teddysun/across/raw/master/unixbench.sh
#备用   wget --no-check-certificate https://github.com/freehao123/across/raw/master/unixbench.sh
chmod +x unixbench.sh
./unixbench.sh
```

各测试项目详细说明：

```text
# Dhrystone 2 using register variables
此项用于测试 string handling，因为没有浮点操作，所以深受软件和硬件设计（hardware and software design）、编译和链接（compiler and linker options）、代码优化（code optimazaton）、对内存的cache（cache memory）、等待状态（wait states）、整数数据类型（integer data types）的影响。
# Double-Precision Whetstone
这一项测试浮点数操作的速度和效率。这一测试包括几个模块，每个模块都包括一组用于科学计算的操作。覆盖面很广的一系列 c 函数：sin，cos，sqrt，exp，log 被用于整数和浮点数的数学运算、数组访问、条件分支（conditional branch）和程序调用。此测试同时测试了整数和浮点数算术运算。
# Execl Throughput
此测试考察每秒钟可以执行的 execl 系统调用的次数。 execl 系统调用是 exec 函数族的一员。它和其他一些与之相似的命令一样是 execve（） 函数的前端。
# File copy
测试从一个文件向另外一个文件传输数据的速率。每次测试使用不同大小的缓冲区。这一针对文件 read、write、copy 操作的测试统计规定时间（默认是 10s）内的文件 read、write、copy 操作次数。
# Pipe Throughput
管道（pipe）是进程间交流的最简单方式，这里的 Pipe throughtput 指的是一秒钟内一个进程可以向一个管道写 512 字节数据然后再读回的次数。需要注意的是，pipe throughtput 在实际编程中没有对应的真实存在。
# Pipe-based Context Switching
这个测试两个进程（每秒钟）通过一个管道交换一个不断增长的整数的次数。这一点很向现实编程中的一些应用，这个测试程序首先创建一个子进程，再和这个子进程进行双向的管道传输。
# Process Creation
测试每秒钟一个进程可以创建子进程然后收回子进程的次数（子进程一定立即退出）。process creation 的关注点是新进程进程控制块（process control block）的创建和内存分配，即一针见血地关注内存带宽。一般说来，这个测试被用于对操作系统进程创建这一系统调用的不同实现的比较。
# System Call Overhead
测试进入和离开操作系统内核的代价，即一次系统调用的代价。它利用一个反复地调用 getpid 函数的小程序达到此目的。
# Shell Scripts
测试一秒钟内一个进程可以并发地开始一个 shell 脚本的 n 个拷贝的次数，n 一般取值 1，2，4，8。（我在测试时取 1， 8）。这个脚本对一个数据文件进行一系列的变形操作（transformation）。
```

![img](https://pic3.zhimg.com/80/v2-4956dc2e0995fd299884e070b6f04076_720w.webp)

## Serverreview

**Serverreview-benchmark综合评测工具**

这是一个老外写的VPS主机综合评测工具，主要评测的项目有VPS主机磁盘IO、内存读写、CPU性能以及Benchmark性能，还有美国、欧洲、亚洲等不同节点的下载速度。主页：[https://github.com/sayem314/serverreview-benchmark](https://link.zhihu.com/?target=https%3A//blog.zeruns.tech/go/aHR0cHM6Ly9naXRodWIuY29tL3NheWVtMzE0L3NlcnZlcnJldmlldy1iZW5jaG1hcms%3D)

**脚本使用使用方法：**

```text
yum install curl -y
curl -LsO https://raw.githubusercontent.com/sayem314/serverreview-benchmark/master/bench.sh; chmod +x bench.sh && ./bench.sh -a share
```

![img](https://pic2.zhimg.com/80/v2-8712e031157a1cd22ca202dabecff0ed_720w.webp)

## mPing

**一键测试回程Ping值工具：mPing**

```text
wget https://raw.githubusercontent.com/helloxz/mping/master/mping.sh
bash mping.sh
```

参数说明：

```text
x% packet loss: 丢包率
min: 最低延迟
avg: 平均延迟
max: 最高延迟
mdev: 平均偏差
```

![img](https://pic1.zhimg.com/80/v2-5916a595f8f0d975c1c1a22113752ea4_720w.webp)

## LemonBench

LemonBench 工具(别名LBench、柠檬Bench)，是一款针对Linux服务器设计的服务器性能测试工具。通过综合测试，可以快速评估服务器的综合性能，为使用者提供服务器硬件配置信息。

```text
#LemonBench 国内版：
curl -fsL https://ilemonra.in/LemonBench | sudo bash -s fast
#LemonBench 国际版：
curl -fsL https://ilemonra.in/LemonBenchIntl | sudo bash -s fast
```

![img](https://pic1.zhimg.com/80/v2-c880ea5a4fa324b9a0a8fd4cda41b750_720w.webp)