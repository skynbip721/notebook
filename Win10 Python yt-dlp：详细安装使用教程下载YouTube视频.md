# Win10 Python yt-dlp：详细安装使用教程下载YouTube视频

### 目录



[前言](https://www.iotword.com/9620.html)

[0.科学上网](https://www.iotword.com/9620.html)

[1.安装yt-dlp](https://www.iotword.com/9620.html)

[2.安装FFmpeg](https://www.iotword.com/9620.html)



[2.1 官网下载](https://www.iotword.com/9620.html)

[2.2 环境变量配置](https://www.iotword.com/9620.html)

[2.3 安装成果检查](https://www.iotword.com/9620.html)

[3. 上手下载](https://www.iotword.com/9620.html)



[3.1 基础格式](https://www.iotword.com/9620.html)

[3.2 脚本地址查询](https://www.iotword.com/9620.html)

[3.3 常用参数和用例展示](https://www.iotword.com/9620.html)



[3.3.1 陈列资源 -F, –list-formats](https://www.iotword.com/9620.html)

[3.3.2 格式选择 -f , –format](https://www.iotword.com/9620.html)

[3.3.3 字幕下载 –write-subs，–write-auto-subs](https://www.iotword.com/9620.html)

[3.3.4 批量下载 -a FILE](https://www.iotword.com/9620.html)

[3.3.5 片段提取 –download-sections](https://www.iotword.com/9620.html)

[3.3.6 格式化命名和存储 -o TEMPLATE](https://www.iotword.com/9620.html)

[3.3.7 更多](https://www.iotword.com/9620.html)

[3.4 其他平台使用](https://www.iotword.com/9620.html)



[3.4.1 b站](https://www.iotword.com/9620.html)

[4. 进阶技巧](https://www.iotword.com/9620.html)



[4.1 Aria2下载加速](https://www.iotword.com/9620.html)



[4.1.1 官网下载](https://www.iotword.com/9620.html)

[4.1.2 环境变量配置](https://www.iotword.com/9620.html)

[4.1.3 命令行调用格式](https://www.iotword.com/9620.html)

[4.1.4 在yt-dlp中调用Aria2](https://www.iotword.com/9620.html)

[4.2 Python程序调用](https://www.iotword.com/9620.html)

[5.报错解决](https://www.iotword.com/9620.html)



[5.1 无法连接](https://www.iotword.com/9620.html)

[6. 拓展阅读](https://www.iotword.com/9620.html)

------

## 前言

yt-dlp是一个命令行程序，可在youtube、twitch、bilbili、西瓜视频等一千多个网站下载视频资源[1](https://www.iotword.com/9620.html)。国内平台的解析工具已经存在很多，像you-get之类，我们主要用它来下载海外视频。
作为youtube-dl的增补版，yt-dlp有着比起前辈更快的速度，以及众多新特性。本文仅记录win10系统python环境下的跑通方法。在尝试前，先确保本地存在3.7+的python版本，推荐安装ffmpeg、ffprobe等依赖，以方便视频合并、转码等后续处理。
官方项目地址：https://github.com/yt-dlp/yt-dlp

本文仅作学习记录，如有错误欢迎提出，持续更新。

------

## 0.科学上网

下载youtube视频的前提是自由访问，默认读到本文的应该都已实现科学访问了~
没有的同学请先行寻找合适的加速器

## 1.安装yt-dlp

打开命令行输入：

```python
pip install yt-dlp
```

速度慢可以更换pip镜像源，或在[pypi](https://pypi.org/project/yt-dlp/)下载离线安装

## 2.安装FFmpeg

这里的FFmpeg指二进制文件，而非同名的python包，其中包含了ffmpeg、ffprobe、ffplay三大工具。

### 2.1 官网下载

访问网址：[https://www.gyan.dev/ffmpeg/builds](https://www.gyan.dev/ffmpeg/builds/)
全文搜索`CTRL+F`找到**ffmpeg-release-full.7z**这个安装包，点击下载
解压到本地目录中，打开**bin**文件夹，地址栏复制本地路径

### 2.2 环境变量配置

计算机右键【属性】-> 【高级系统设置】->【高级】-> 【环境变量】-> 【用户变量】
双击Path，新建一条，在变量值里粘贴复制的路径
![配置环境变量](https://i3.wp.com/img-blog.csdnimg.cn/36587c3e3a2b471b960e702bc3302b2d.png)

### 2.3 安装成果检查

`WIN+R` 输入cmd，命令行中测试一下，输入ffmpeg回车，出现下图类似结果安装成功
![安装成功截图](https://i3.wp.com/img-blog.csdnimg.cn/37ec52d855524850a14b683ce1187fc0.png)

## 3. 上手下载

### 3.1 基础格式

在想要保存的目录下打开命令行（地址栏输入cmd回车），按照如下格式书写命令：

```python
yt-dlp [OPTIONS] [--] URL [URL...]
```

yt-dlp必须在前，OPTIONS和URL填写不分先后

基础用法示例：

```python
# --proxy 使用指定的HTTP/HTTPS/SOCKS代理。 e.g. socks5://user:pass@127.0.0.1:1080/
# 127.0.0.1表示本机ip，1080表示当前使用的端口，请根据本机情况查询并更改，见3.2
# URL填写想下载的视频地址

# 下载单个视频
yt-dlp --proxy socks5://127.0.0.1:1080 https://www.youtube.com/watch?v=NtKJSHW68p4

# 下载播放列表的所有视频 
yt-dlp --proxy socks5://127.0.0.1:1080 https://www.youtube.com/playlist?list=PLqWr7dyJNgLJ79otw7N9CXQ_AU0Fm04aq
```

### 3.2 脚本地址查询

点右下角网络图标进入【网络和Internet设置】，选择【代理】
找到【使用设置脚本】，开启
检查命令中的ip和端口和【脚本地址】是否一致

### 3.3 常用参数和用例展示

根据使用需求，追加命令参数，体验yt-dlp的丰富玩法，具体见项目自述，也可在命令行输入`yt-dlp --help`查看说明

#### 3.3.1 陈列资源 -F, –list-formats

含义：列出所有文件的格式信息

用法：

```python
yt-dlp [--proxy ...] URL -F
yt-dlp [--proxy ...] URL --list-formats	
```

![img](https://i3.wp.com/img-blog.csdnimg.cn/058aa3270b3f4af29d650f2967196e13.png)
对图中的标题做一下阅读理解：

| ID   | EXT    | RESOLUTION      | FPS          | CH         | FILESIZE   | TBR                            | PROTO                                                        |
| :--- | :----- | :-------------- | :----------- | :--------- | :--------- | :----------------------------- | :----------------------------------------------------------- |
| 编码 | 扩展名 | 分辨率（宽x高） | 每秒画面帧数 | 音频通道数 | 文件字节数 | 音频和视频的平均比特率（KBit） | 下载协议 （http, https, rtsp, rtmp, rtmpe, mms, f4m, ism, http_dash_segments, m3u8, or m3u8_native） |

| VCODEC       | VBR                  | ACODEC       | ABR                  | ASR            | MORE INFO |
| :----------- | :------------------- | :----------- | :------------------- | :------------- | :-------- |
| 视频编码方案 | 平均视频码率（KBit） | 音频编码方案 | 平均音频码率（KBit） | 音频采样率(hz) | 补充说明  |

#### 3.3.2 格式选择 -f , –format

含义：格式选择器，根据要求下载指定格式的音视频资源

说明：未传参时，默认下载最佳质量的格式。按特定要求下载时，写明视频和音频的格式要求。支持单独下载纯视频/音频，合并下载用"+“连接，各自分开下载用”,“，从左到右选择第一个可用资源下载用”/"

示例：

```python
# 根据id，下载编号597的资源作为视频画面，599作为视频声音，把图像和音轨合并为MP4格式导出
yt-dlp -f 597+599 [--proxy ...] URL --merge-output-format mp4

# 下载编码为22的文件
yt-dlp -f webm [--proxy ...] URL

# 下载最佳质量的单个webm文件（目前支持3gp, aac, flv, m4a, mp3, mp4, ogg, wav, webm格式）
yt-dlp -f webm [--proxy ...] URL

# 分开下载视频和音频，格式化命名，按title.ID.EXT模板输出
yt-dlp -f "bv,ba/b" -o "%(title)s.f%(format_id)s.%(ext)s" [--proxy ...] URL

# 条件过滤，通过表格中的各项条件筛选目标规格的资源
-f w 	# 下载质量最差的资源文件（同时包含音视频），wv纯视频，wa纯音频，适合测试命令时使用
-f "best[height=720]" 	# 筛选最佳质量的720p视频
-f "[filesize>10M]" 	# 筛选>10M的文件
-f "all[vcodec=none]" 	# 筛选所有纯音频
-f "(mp4,webm)[height<480]"		# 筛选低于480p的最佳mp4视频和webm音轨，合并
-f 'bv[height=1080][ext=mp4]+ba[ext=m4a]' --merge-output-format mp4  # 筛选1080p的mp4视频，与最佳的m4a音频下载合并
```

#### 3.3.3 字幕下载 –write-subs，–write-auto-subs

含义：下载字幕（投稿外挂的或自动翻译生成的）

用例：

```python
yt-dlp [--proxy ...] URL --list-subs	# 列出所有支持的字幕信息（语言标识名、语言名、文件格式）
```

下图列出的字幕使用`--write-subs`下载
![img](https://i3.wp.com/img-blog.csdnimg.cn/391c2c5229304bac97c3fd78ce6f7ffd.png)
下图的字幕使用`--write-auto-subs`下载![img](https://i3.wp.com/img-blog.csdnimg.cn/d00ef6909b6a4cfca082080f6069e6f9.png)

```python
# 下载视频时一同下载srt格式的中文字幕，--sub-lang后的值从图中的Langeuage列取得
yt-dlp --write-auto-subs --sub-format srt --sub-lang zh-Hans [--proxy ...] URL

# 单独下载最佳格式的英文字幕
yt-dlp --write-auto-subs --sub-format best --sub-lang en --skip-download [--proxy ...] URL

# 在视频中嵌入自动生成的阿拉伯语字幕，字幕嵌入操作仅适用于mp4，Webm和MKV视频
yt-dlp --write-auto-subs --sub-lang ar --embed-subs --merge-output-format mp4 [--proxy ...] URL
```

#### 3.3.4 批量下载 -a FILE

下载文本中所有视频

```python
yt-dlp -a urls.txt [--proxy ...] URL
```

#### 3.3.5 片段提取 –download-sections

下载时间戳范围的片段

```python
yt-dlp --download-sections "*1:30-inf" [--proxy ...] URL      # 前缀*，范围边界0:00 - inf
```

下载指定章节的片段

```python
yt-dlp --download-sections "intro" [--proxy ...] URL
```

下载所有章节切片并按id.title.ext命名，同时下载一份完整的视频。
输出模板参数有section_number，section_title，section_start和section_end

```python
yt-dlp --split-chapters -o "chapter:%(section_number)03d. %(section_title)s.%(ext)s" [--proxy ...] URL
```

#### 3.3.6 格式化命名和存储 -o TEMPLATE

格式化命名文件并指定路径保存

```python
-o "~/YouTube/%(title)s.%(ext)s"
-o "%(uploader)s/%(upload_date)s - %(title)s (%(id)s).%(ext)s"
-o "%(duration>%H-%M-%S)s" # 视频时长
```

输出模板的语法见[output-template](https://github.com/yt-dlp/yt-dlp#output-template)

#### 3.3.7 更多

**–merge-output-format FORMAT**：视频合并操作

**-j, –dump-json**：打印JSON信息

**–embed-thumbnail**：将视频缩略图嵌入视频封面，需要合并操作

```python
yt-dlp --embed-thumbnail --merge-output-format mp4 [--proxy ...] URL
```

**–embed-metadata**：嵌入元数据，如视频简介描述，需要合并操作

**–audio-format FORMAT**：纯音频下载，支持格式转换

```python
yt-dlp -x --audio-format mp3 [--proxy ...] URL -o '%(title)s_%(id)s.mp3'
```

**–skip-download**：跳过视频下载，仅下载相关文件

**–cookies-from-browser BROWSER**：对于要求登录或会员才可下载的网址，调取浏览器cookies
目前支持的浏览器有brave, chrome, chromium, edge, firefox, opera, safari, vivaldi
​![img](https://i3.wp.com/img-blog.csdnimg.cn/338c2da900a44dafbcc7fa2d130d29bb.png)

### 3.4 其他平台使用

#### 3.4.1 b站

下载高清视频需要调取浏览器cookie登录

```python
# 下载单P视频
yt-dlp https://www.bilibili.com/video/BV1dM411t7Ls --cookies-from-browser chrome
# 分P视频仅下载P1
yt-dlp https://www.bilibili.com/video/BV1vs4y1b7rU?p=1 --cookies-from-browser chrome
```

## 4. 进阶技巧

### 4.1 Aria2下载加速

作为外部下载器加速下载，多线程并发，提升带宽利用率。 详情见[Aria2 Manual](https://aria2.github.io/manual/en/html/)
下面仅介绍arias作为命令行工具的下载配置以及基础用法

#### 4.1.1 官网下载

访问官网[releases](https://github.com/aria2/aria2/releases)页面，根据选择的版本和本机环境在Assets下找到安装包，点击下载
我这里选择windows x64的安装包
![img](https://i3.wp.com/img-blog.csdnimg.cn/2dca6e19d70a4544a43fdf71a1618521.jpeg)
下载成功后解压，为了方便我直接放D盘并改名aria2

#### 4.1.2 环境变量配置

打开文件夹，复制aria2c.exe的路径（我这里是D:\aria2），在环境变量path中配置（方法同2.2）

快捷操作：
`win+R`调出【运行】对话框 -> 输入sysdm.cpl，回车打开【系统属性】 -> 【高级】-> 【环境变量】 -> 【用户变量】
双击path新建，粘贴路径

#### 4.1.3 命令行调用格式

```python
aria2c [OPTIONS] [URI | MAGNET | TORRENT_FILE | METALINK_FILE]...
```

命令行输入`aria2c -h`查看具体参数说明
最简单的用法是aria2c URL，例如：

```python
aria2c https://www.bilibili.com/
```

#### 4.1.4 在yt-dlp中调用Aria2

```python
# --downloader：指定下载器，aria2c以外还支持avconv,axel,curl,ffmpeg,httpie,wget
# --downloader-args：下载参数 -c：断点续传；-j：并发数；-x：线程数（最多16）；-k：分段（每段1M）

yt-dlp --downloader aria2c --downloader-args aria2c:"-c -j 3 -x 8 -k 1M" [--proxy ...] URL
```

### 4.2 Python程序调用

基础用例：

```python
from yt_dlp import YoutubeDL

URLS = ['https://www.youtube.com/watch?v=BaW_jenozKc']
with YoutubeDL() as ydl:
    ydl.download(URLS)
```

更多用例参考见[embedding-examples](https://github.com/yt-dlp/yt-dlp#embedding-examples)
了解可用参数和公共函数列表，见[yt_dlp.YoutubeDL.py](https://github.com/yt-dlp/yt-dlp/blob/master/yt_dlp/YoutubeDL.py)

## 5.报错解决

### 5.1 无法连接

> WARNING: [youtube] Unable to download webpage: <urlopen error [WinError 10061] 由于目标计算机积极拒绝，无法连接。>

解决：

1. 检查vpn或代理是否正常连接
2. 检查命令的地址和脚本地址是否一致

## 6. 拓展阅读

ArchWiki：https://wiki.archlinux.org/title/Yt-dlp

------

1. 支持的视频列表见[supportedsites](https://github.com/yt-dlp/yt-dlp/blob/master/supportedsites.md) [↩︎](https://www.iotword.com/9620.html)

### 您可能感兴趣的内容:

- [STM32实验STM32智能小车：电子设计大赛之旅](https://www.iotword.com/8661.html)
- [《从Arduino Mixly入门到精通的指南》](https://www.iotword.com/7256.html)
- [【我是土堆-PyTorch教程】学习笔记](https://www.iotword.com/5541.html)
- [CVPR 2022 论文列表](https://www.iotword.com/3525.html)
- [torch各种版本下载](https://www.iotword.com/2764.html)