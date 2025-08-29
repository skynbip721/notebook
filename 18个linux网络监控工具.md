# 18个linux网络监控工具

**导读**

本文介绍了一些可以用来监控网络使用情况的Linux命令行工具。这些工具可以监控通过网络接口传输的数据，并测量目前哪些数据所传输的速度。入站流量和出站流量分开来显示。

一些命令可以显示单个进程所使用的带宽。这样一来，用户很容易发现过度使用网络带宽的某个进程。

这些工具使用不同的机制来制作流量报告。nload等一些工具可以读取"proc/net/dev"文件，以获得流量统计信息；而一些工具使用pcap库来捕获所有数据包，然后计算总数据量，从而估计流量负载。下面是按功能划分的命令名称。

- 监控总体带宽使用――nload、bmon、slurm、bwm-ng、cbm、speedometer和netload
- 监控总体带宽使用（批量式输出）――vnstat、ifstat、dstat和collectl
- 每个套接字连接的带宽使用――iftop、iptraf、tcptrack、pktstat、netwatch和trafshow
- 每个进程的带宽使用――nethogs

**1、nload**

![img](https://pic2.zhimg.com/80/v2-327539d5cd6d768910b3521f7bbbf771_720w.webp)

nload是一个命令行工具，让用户可以分开来监控入站流量和出站流量。它还可以绘制图表以显示入站流量和出站流量，视图比例可以调整。用起来很简单，不支持许多选项。所以，如果你只需要快速查看总带宽使用情况，无需每个进程的详细情况，那么nload用起来很方便。



![img](https://pic4.zhimg.com/80/v2-96151f13425971f87683326d95616d1f_720w.webp)



安装nload：Fedora和Ubuntu在默认软件库里面就有nload。CentOS用户则需要从Epel软件库获得nload。



![img](https://pic3.zhimg.com/80/v2-09ee0bef80e95371286ada82f94f126e_720w.webp)

**2、iftop**

iftop可测量通过每一个套接字连接传输的数据；它采用的工作方式有别于nload。iftop使用pcap库来捕获进出网络适配器的数据包，然后汇总数据包大小和数量，搞清楚总的带宽使用情况。虽然iftop报告每个连接所使用的带宽，但它无法报告参与某个套按字连接的进程名称/编号（ID）。不过由于基于pcap库，iftop能够过滤流量，并报告由过滤器指定的所选定主机连接的带宽使用情况。



![img](https://pic2.zhimg.com/80/v2-f30c11ee29849fd2a454ced4c646dc41_720w.webp)

n选项可以防止iftop将IP地址解析成主机名，解析本身就会带来额外的网络流量。

![img](https://pic1.zhimg.com/80/v2-2a6a2da81e5ef0336cfefdea20ee3a34_720w.webp)

安装iftop：Ubuntu/Debian/Fedora用户可以从默认软件库获得它。CentOS用户可以从Epel获得它。



![img](https://pic1.zhimg.com/80/v2-3ea5ec7663041f34c31468715e4c7cc4_720w.webp)

**3、iptraf**

iptraf是一款交互式、色彩鲜艳的IP局域网监控工具。它可以显示每个连接以及主机之间传输的数据量。下面是屏幕截图。

![img](https://pic3.zhimg.com/80/v2-5cdccc00778ef9f6883733ff56852f1a_720w.webp)

![img](https://pic4.zhimg.com/80/v2-2d1eedfa56431dafaf82f19e995d8137_720w.webp)



安装iptraf：

![img](https://pic1.zhimg.com/80/v2-72fbc29d3c6f6809ee7b0a5c4485d86c_720w.webp)

**4、nethogs**

nethogs是一款小巧的"net top"工具，可以显示每个进程所使用的带宽，并对列表排序，将耗用带宽最多的进程排在最上面。万一出现带宽使用突然激增的情况，用户迅速打开nethogs，就可以找到导致带宽使用激增的进程。nethogs可以报告程序的进程编号（PID）、用户和路径。



![img](https://pic2.zhimg.com/80/v2-deaea2267dde1ccc15a05e99501d590d_720w.webp)

安装nethogs：Ubuntu、Debian和Fedora用户可以从默认软件库获得。CentOS用户则需要Epel。



![img](https://pic4.zhimg.com/80/v2-376d8ab0be30d52ac24a6675db05d383_720w.webp)

**5. bmon**

bmon（带宽监控器）是一款类似nload的工具，它可以显示系统上所有网络接口的流量负载。输出结果还含有图表和剖面，附有数据包层面的详细信息。

![img](https://pic3.zhimg.com/80/v2-40f1dc49730322182d81db6dc1fbbdfe_720w.webp)

安装bmon：Ubuntu、Debian和Fedora用户可以从默认软件库来安装。CentOS用户则需要安装repoforge，因为Epel里面没有bmon。



**6. slurm**

slurm是另一款网络负载监控器，可以显示设备的统计信息，还能显示ASCII图形。它支持三种不同类型的图形，使用c键、s键和l键即可激活每种图形。slurm功能简单，无法显示关于网络负载的任何更进一步的详细信息。

![img](https://pic2.zhimg.com/80/v2-a1e574f7ae86bcc8df85d27255ecb3bd_720w.webp)

安装slurm



![img](https://pic4.zhimg.com/80/v2-cd3fdbb1f59b463d2f8b99355983d04b_720w.webp)



**7. tcptrack**

tcptrack类似iftop，使用pcap库来捕获数据包，并计算各种统计信息，比如每个连接所使用的带宽。它还支持标准的pcap过滤器，这些过滤器可用来监控特定的连接。



![img](https://pic3.zhimg.com/80/v2-c9dd6c6239f57f068940e97cfe6e4212_720w.webp)

安装tcptrack：Ubuntu、Debian和Fedora在默认软件库里面就有它。CentOS用户则需要从RepoForge获得它，因为Epel里面没有它。



![img](https://pic4.zhimg.com/80/v2-e27db3b141005681ad60a116f6ba1c0f_720w.webp)



**8. vnstat**

vnstat与另外大多数工具有点不一样。它实际上运行后台服务/守护进程，始终不停地记录所传输数据的大小。之外，它可以用来制作显示网络使用历史情况的报告



![img](https://pic1.zhimg.com/80/v2-6379d1c2dc02dcdf1117191ea9d65fc0_720w.webp)

运行没有任何选项的vnstat，只会显示自守护进程运行以来所传输的数据总量。



![img](https://pic1.zhimg.com/80/v2-b0e9691edbe964dff39867e1bb489378_720w.webp)



想实时监控带宽使用情况，请使用"-l"选项（实时模式）。然后，它会显示入站数据和出站数据所使用的总带宽量，但非常精确地显示，没有关于主机连接或进程的任何内部详细信息。

![img](https://pic1.zhimg.com/80/v2-b357179187a2235c5d3405f22bd0412c_720w.webp)



vnstat更像是一款制作历史报告的工具，显示每天或过去一个月使用了多少带宽。它并不是严格意义上的实时监控网络的工具。vnstat支持许多选项，支持哪些选项方面的详细信息请参阅参考手册页。安装vnstat



![img](https://pic2.zhimg.com/80/v2-867d2a52be5ccd1556ff68b39d4398b1_720w.webp)

**9. bwm-ng**

bwm-ng（下一代带宽监控器）是另一款非常简单的实时网络负载监控工具，可以报告摘要信息，显示进出系统上所有可用网络接口的不同数据的传输速度。



![img](https://pic1.zhimg.com/80/v2-d99c0a24cf856c35d616c888589b1c80_720w.webp)



如果控制台足够大，bwm-ng还能使用curses2输出模式，为流量绘制条形图。安装bwm-ng：在CentOS上，可以从Epel来安装bwm-ng。



**10. cbm：Color Bandwidth Meter**

![img](https://pic2.zhimg.com/80/v2-8bc170149c273bebf590f05684a0c54d_720w.webp)

这是一款小巧简单的带宽监控工具，可以显示通过诸网络接口的流量大小。没有进一步的选项，仅仅实时显示和更新流量的统计信息。



![img](https://pic2.zhimg.com/80/v2-dc97a94c1a5820fe02fcabb587431739_720w.webp)

**11. speedometer**

这是另一款小巧而简单的工具，仅仅绘制外观漂亮的图形，显示通过某个接口传输的入站流量和出站流量。



![img](https://pic2.zhimg.com/80/v2-bb2ea0632c90e7b890c0524fb236aead_720w.webp)



安装speedometer



![img](https://pic3.zhimg.com/80/v2-3290835a8ab04f2e320143e9dbcefe3a_720w.webp)



**12. pktstat**

![img](https://pic2.zhimg.com/80/v2-c7850d7e81ceeb21d072db214245fa85_720w.webp)

pktstat可以实时显示所有活动连接，并显示哪些数据通过这些活动连接传输的速度。它还可以显示连接类型，比如TCP连接或UDP连接；如果涉及HTTP连接，还会显示关于HTTP请求的详细信息。

![img](https://pic2.zhimg.com/80/v2-346849d42a50d9f4b2af4e6cab1e338d_720w.webp)

**13. netwatch**

![img](https://pic1.zhimg.com/80/v2-f4341b63b0c0acb57657b44699ae420c_720w.webp)

netwatch是netdiag工具库的一部分，它也可以显示本地主机与其他远程主机之间的连接，并显示哪些数据在每个连接上所传输的速度。



**14. trafshow**

与netwatch和pktstat一样，trafshow也可以报告当前活动连接、它们使用的协议以及每条连接上的数据传输速度。它能使用pcap类型过滤器，对连接进行过滤。只监控TCP连接

![img](https://pic1.zhimg.com/80/v2-20b19c45691b84a41d030614401d56a0_720w.webp)

![img](https://pic2.zhimg.com/80/v2-831c48e9049ce363b9995b6364a4bc21_720w.webp)

**15. netload**

netload命令只显示关于当前流量负载的一份简短报告，并显示自程序启动以来所传输的总字节量。没有更多的功能特性。它是netdiag的一部分。



![img](https://pic1.zhimg.com/80/v2-092c9e9c6ec582acc799476a3569807c_720w.webp)



**16. ifstat**

ifstat能够以批处理式模式显示网络带宽。输出采用的一种格式便于用户使用其他程序或实用工具来记入日志和分析。

![img](https://pic1.zhimg.com/80/v2-282904652f926688129ef0898941facc_720w.webp)

安装ifstat：Ubuntu、Debian和Fedora用户在默认软件库里面就有它。CentOS用户则需要从Repoforge获得它，因为Epel里面没有它。



![img](https://pic3.zhimg.com/80/v2-e5af3eb02fd6320c7785f4e2c9e09936_720w.webp)



**17. dstat**

dstat是一款用途广泛的工具（用python语言编写），它可以监控系统的不同统计信息，并使用批处理模式来报告，或者将相关数据记入到CSV或类似的文件。这个例子显示了如何使用dstat来报告网络带宽。安装dstat

![img](https://pic3.zhimg.com/80/v2-c9815b45679db612985553672553a456_720w.webp)

**18. collectl**

collectl以一种类似dstat的格式报告系统的统计信息；与dstat一样，它也收集关于系统不同资源（如处理器、内存和网络等）的统计信息。这里给出的一个简单例子显示了如何使用collectl来报告网络使用/带宽。

![img](https://pic1.zhimg.com/80/v2-5e496683728d5d4a208b6f5b02490734_720w.webp)

结束语：上述几个使用方便的命令可以迅速检查Linux服务器上的网络带宽使用情况。不过，这些命令需要用户通过SSH登录到远程服务器。另外，基于Web的监控工具也可以用来实现同样的任务。ntop和darkstat是面向Linux系统的其中两个基本的基于Web的网络监控工具。除此之外还有企业级监控工具，比如nagios，它们提供了一批功能特性，不仅仅可以监控服务器，还能监控整个基础设施。