## Annie——一个简洁强大的轻量级视频下载神器

![img](https://pic2.zhimg.com/80/v2-90076be5ca2a7c96ff55d81e375c2679_720w.webp)





**Annie**是一个基于go语言编写的**下载器**，先来解释一下这几个形容词。

**简洁**：程序无UI界面，通过命令行操作，且简单易懂。

**强大**：支持Windows、macOS、Linux系统，各大视频网站均可下载，且还能下载其他文件如音频，图片等。在项目网站列举的有：*[抖音](https://link.zhihu.com/?target=https%3A//www.douyin.com/)、[哔哩哔哩](https://link.zhihu.com/?target=https%3A//www.bilibili.com/)、[半次元](https://link.zhihu.com/?target=https%3A//bcy.net/)、[pixivision](https://link.zhihu.com/?target=https%3A//www.pixivision.net/)、[优酷](https://link.zhihu.com/?target=https%3A//www.youku.com/)、[YouTube](https://link.zhihu.com/?target=https%3A//www.youtube.com/)、[爱奇艺](https://link.zhihu.com/?target=https%3A//www.iqiyi.com/)、[芒果TV](https://link.zhihu.com/?target=https%3A//www.mgtv.com/)、[糖豆广场舞](https://link.zhihu.com/?target=http%3A//www.tangdou.com/)、[Tumblr](https://link.zhihu.com/?target=https%3A//www.tumblr.com/)、[Vimeo](https://link.zhihu.com/?target=https%3A//vimeo.com/)、[Facebook](https://link.zhihu.com/?target=https%3A//facebook.com/)、[斗鱼视频](https://link.zhihu.com/?target=https%3A//v.douyu.com/)、[微博](https://link.zhihu.com/?target=https%3A//weibo.com/)、[Instagram](https://link.zhihu.com/?target=https%3A//www.instagram.com/)、[Twitter](https://link.zhihu.com/?target=https%3A//twitter.com/)、[腾讯视频](https://link.zhihu.com/?target=https%3A//v.qq.com/)、[网易云音乐](https://link.zhihu.com/?target=https%3A//music.163.com/)、[音悦台](https://link.zhihu.com/?target=https%3A//yinyuetai.com/)、[极客时间](https://link.zhihu.com/?target=https%3A//time.geekbang.org/)、[Pornhub](https://link.zhihu.com/?target=https%3A//pornhub.com/)、[XVIDEOS](https://link.zhihu.com/?target=https%3A//xvideos.com/)、[聯合新聞網](https://link.zhihu.com/?target=https%3A//udn.com/)、[TikTok](https://link.zhihu.com/?target=https%3A//www.tiktok.com/)*

**轻量级**：软件本体不到3MB，加上用来合成视频的软件FFmpeg也不过70MB。

本文详细介绍Windows，其他系统请查看项目地址，已经很详细了。



## **安装**

### **Windows**

这里使用Windows预装的**PowerShell**进行操作，可以在程序搜索框搜索PowerShell，Win10也可右键开始按钮->Windows PowerShell。



![img](https://pic1.zhimg.com/80/v2-10425feb4f62826d0d1324b3acccd3c0_720w.webp)

**Windows PowerShell**



### **1. 环境配置**

**①Windows 7 SP1 + / Windows Server 2008+**
**②.NET Framework 4.5+**和**PowerShell 5+**，
一般的**Win10系统符合要求可直接跳过**。
**查看.NET Framework版本：**在PowerShell窗口中输入


**powershell**
$PSVersionTable.CLRVersion

或打开`控制面板->程序->启用或关闭 Windows 功能



![img](https://pic1.zhimg.com/80/v2-7a9973a5977b515f1fb8dc14eeb677d4_720w.webp)

**图中版本为4.8**



若版本过低，请点击下载[.NET Framework 4.5.2](https://link.zhihu.com/?target=https%3A//dotnet.microsoft.com/download/dotnet-framework/thank-you/net452-developer-pack-offline-installer)并安装。

**查看PowerShell版本：**在PowerShell窗口中输入




**powershell**
$PSVersionTable.PSVersion

**Major**为版本号。



![img](https://pic2.zhimg.com/80/v2-b2b0f9d4145b791c28728c2f2bb0f765_720w.webp)

**图中版本号为5**



若版本过低，则需下载。这里有微软官方说明[下载并安装 Windows PowerShell 5.1](https://link.zhihu.com/?target=https%3A//docs.microsoft.com/zh-cn/skypeforbusiness/set-up-your-computer-for-windows-powershell/download-and-install-windows-powershell-5-1)



### **2. 安装scoop**

在PowerShell窗口中输入


**powershell**
iex (new-object net.webclient).downloadstring('[https://get.scoop.sh](https://link.zhihu.com/?target=https%3A//get.scoop.sh)')

这是一个强大的命令行包管理工具，在我的另一篇中有介绍。如遇报错，请到这里查看：[scoop安装详解](https://link.zhihu.com/?target=http%3A//www.boyinthesun.cn/post/scoop/)

### **3. 安装annie**

在PowerShell窗口中输入


**powershell**
scoop install annie

该命令会为你安装FFmpeg（合并视频用）和Annie
同理，**如果下载过程中断，需要删除**`C:\Users<user>\scoop\app`内相应的文件夹。同样建议挂梯子。



![img](https://pic4.zhimg.com/80/v2-b5fe32a894aeff8b2a9bd88a8f43eae3_720w.webp)

**如图即为安装成功**



### **macOS**

在终端输入


**sh**
brew install ffmpeg brew install annie

由于博主手头没有macOS无法测试，欢迎留言讨论。

### **Linux**

首先根据自己的系统构架**选择安装包**：[传送门](https://link.zhihu.com/?target=https%3A//github.com/iawia002/annie/releases)
目前最新版是0.9.8，我的系统是64位Debian系统，那么执行命令：


**sh**
wget [https://github.com/iawia002/annie/releases/download/0.9.8/annie_0.9.8_Linux_64-bit.tar.gz](https://link.zhihu.com/?target=https%3A//github.com/iawia002/annie/releases/download/0.9.8/annie_0.9.8_Linux_64-bit.tar.gz) tar zxvf annie_*.tar.gz mv annie /usr/local/bin/ rm -rf annie_*.tar.gz

再安装FFmpeg


**sh**
wget [https://www.moerats.com/usr/down/ffmpeg/ffmpeg-git-](https://link.zhihu.com/?target=https%3A//www.moerats.com/usr/down/ffmpeg/ffmpeg-git-)$(getconf LONG_BIT)bit-static.tar.xz tar xvf ffmpeg-git-*-static.tar.xz mv ffmpeg-git-*/ffmpeg ffmpeg-git-*/ffprobe /usr/local/bin/ rm -rf ffmpeg-git-*

## **用法**


**txt**
annie [OPTIONS] URL [URL...] Options -i Information only -F string URLs file path -d Debug mode -j Print extracted data -v Show version Download: -f string Select specific stream to download -p Download playlist -n int The number of download thread (only works for multiple-parts video) (default 10) -c string Cookie -r string Use specified Referrer -cs int HTTP chunk size for downloading (in MB) (default 0) Network: -retry int How many times to retry when the download failed (default 10) Playlist: -start int Playlist video to start at (default 1) -end int Playlist video to end at -items string Playlist video items to download. Separated by commas like: 1,5,6,8-10 Filesystem: -o string Specify the output path -O string Specify the output file name Subtitle: -C Download captions Youku: -ccode string Youku ccode (default "0590") -ckey string Youku ckey (default "7B19C0AB12633B22E7FE81271162026020570708D6CC189E4924503C49D243A0DE6CD84A766832C2C99898FC5ED31F3709BB3CDD82C96492E721BDD381735026") -password string Youku password aria2: Note: If you use aria2 to download, you need to merge the multi-part videos yourself. -aria2 Use Aria2 RPC to download -aria2addr string Aria2 Address (default "localhost:6800") -aria2method string Aria2 Method (default "http") -aria2token string Aria2 RPC Token

### **基本用法**

**无选项**，直接下载视频，默认是最高清晰度，如:`annie https://www.iqiyi.com/v_19rrnqxz7k.html`



![img](https://pic1.zhimg.com/80/v2-5afbf2543d5bb02e84ac6f59f48781dc_720w.webp)





**-i选项**，仅显示信息但不下载，如`annie -i https://www.iqiyi.com/v_19rrnqxz7k.html`：



![img](https://pic3.zhimg.com/80/v2-70066392bc6cdd6ea35bafc3c346134e_720w.webp)





这时可以根据提示使用**-f选项**来选择清晰度，如我要下载896*376，则`annie -f 2 https://www.iqiyi.com/v_19rrnqxz7k.html`：



![img](https://pic1.zhimg.com/80/v2-f93d55dea12a7d0edfa1481aa607e788_720w.webp)





此时文件已经下载至程序运行目录，对于windows即位于`C:\Users<user>`，我的用户名为Sunboy，则可以找到我的视频：`C:\Users\Sunboy\战狼.f4v`

如果你想下载多个视频，那么**用空格隔开网址**。

也可以使用**-F选项**下载txt中的所有链接，如我把链接都放到了`D:\text.txt`，则执行`annie -F D:\text.txt -i`列举信息，`annie -F D:\text.txt -f 80`下载指定清晰度

**-o选项**，用于指定下载目录，如下载到D盘视频文件夹，即`annie -o D:\视频\ https://www.iqiyi.com/v_19rrnqxz7k.html`



### **播放列表**

目前播放列表只支持bilibili、youtube和糖豆广场舞，加上**参数-p**即可，如查看所有集：`annie -i -p https://www.bilibili.com/bangumi/play/ss20117?spm_id_from=333.851.b_62696c695f7265706f72745f74656c65706c6179.36`，再下载指定清晰度：`annie -f 80 -p https://www.bilibili.com/bangumi/play/ss20117?spm_id_from=333.851.b_62696c695f7265706f72745f74656c65706c6179.36`，也可以下载指定集：`annie -f 80 -p -start 1 -end 10 https://www.bilibili.com/bangumi/play/ss20117?spm_id_from=333.851.b_62696c695f7265706f72745f74656c65706c6179.36`

### **会员**

目前会员只支持bilibili和优酷，当然首先你得有个会员才能下载。我刚好有优酷会员，做个一演示。
首先在浏览器登陆会员，然后获取`cookies`的`P_pck_rm`参数，保存到cookies.txt，格式如：`P_pck_rm=woxiaxiede`。至于获取`cookies`，推荐使用`EditThisCookie`插件，我是用的是Chrome可以直接从插件商店获取（需翻墙）。安装完成后到设置更改导出格式为`Semicolon separated name=value paris`，复制到txt文件，仅需保留`P_pck_rm=woxiaxiede`。



![img](https://pic1.zhimg.com/80/v2-dbe2c2f8d78cd1aff5e05353d21ac6f4_720w.webp)





使用时添加**-c选项**：`annie -c D:\cookies -i https://for.example.com/`以查看信息。

这里我遇到一个报错



![img](https://pic2.zhimg.com/80/v2-f781f5c8a4138f299cc26676afdada95_720w.webp)





按照提示将`&`替换为`"&"`即可。



## **其他**

可以使用**-aira2**选项提升下载速度，当然需要首先安装aria2。
annie也可以下载普通文件，等同于wget命令。
其他用法详见[项目地址](https://link.zhihu.com/?target=https%3A//github.com/iawia002/annie)。

## **推荐**

除了Annie，github上还有不少类似的项目，安装和使用方法也类似，这里就不再赘述了，有兴趣的可以自己尝试。
[lulu](https://link.zhihu.com/?target=https%3A//github.com/iawia002/Lulu)来自相同的作者，但似乎支持更多网站，没有细研究。
[youtube-dl](https://link.zhihu.com/?target=https%3A//github.com/rg3/youtube-dl)
[ytdl](https://link.zhihu.com/?target=https%3A//github.com/rylio/ytdl)
[you-get](https://link.zhihu.com/?target=https%3A//github.com/soimort/you-get)

## **参考链接**

[https://www.moerats.com/archives/93](https://link.zhihu.com/?target=https%3A//www.moerats.com/archives/935/)