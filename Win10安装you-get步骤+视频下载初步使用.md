# Win10安装you-get步骤+视频下载初步使用

## 一、you-get简介

  you-get是一个很小的命令行工具，能够通过几条命令就可以从Web网站上抓取下载媒体内容（视频、音频、图片），在一些场景下非常实用。它基于Python开发，是一个开源的项目。

安装了you-get后，下面展示一个 `从优酷上下载视频的例子：`

1.通过电脑的`windows键+R键`打开运行窗口，输入cmd，点击确定打开cmd命令行窗口，如下图所示。
![在这里插入图片描述](https://img-blog.csdnimg.cn/0ec3d952a43f4e8988bf16187c2b2202.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAbHl3U3R1ZGluZw==,size_12,color_FFFFFF,t_70,g_se,x_16)
2.如下图所示，在win10的cmd命令行窗口输入：`you-get [url地址]` 就可以从网站上直接下载喜欢的视频到电脑了，非常方便，而且速度很快。
![在这里插入图片描述](https://img-blog.csdnimg.cn/78b33c324b9c4029b3f1d27c226cdf04.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAbHl3U3R1ZGluZw==,size_20,color_FFFFFF,t_70,g_se,x_16)
3.下载完之后，you-get默认将视频放在下图文件目录下。
![在这里插入图片描述](https://img-blog.csdnimg.cn/1a7cfb11de2b41c5957657a7a860d44d.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAbHl3U3R1ZGluZw==,size_14,color_FFFFFF,t_70,g_se,x_16)
you-get官网地址：https://you-get.org/
you-get开源项目GitHub地址：https://github.com/soimort/you-get

## 二、you-get安装

**you-get需要以下依赖：**

- **Python** 3.2及以上版本
- **FFmpeg** 1.0及以上版本
- **RTMPDump**（*可选，非必须安装*）

**首先需要安装Python,步骤如下：***文章地址https://www.yii666.com/blog/325478.html*

1.去官网下载Python安装包，要求Python版本需要在3.2及以上，下图直接安装最新版。
官网下载地址：https://www.python.org/downloads/
![Python下载](https://img-blog.csdnimg.cn/7331f1f8d3ae494bb0366d2fc2512d96.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAbHl3U3R1ZGluZw==,size_20,color_FFFFFF,t_70,g_se,x_16)
2.下载到电脑，如下图所示：
![Python安装程序](https://img-blog.csdnimg.cn/1d155ec2d74b4afb921413b5784b7862.png)
3.双击运行exe安装执行文件，如下图所示，先选择勾选添加到PATH环境变量，然后点击自定义安装。
![在这里插入图片描述](https://img-blog.csdnimg.cn/336133ea108c49ad830af148dfdd2462.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAbHl3U3R1ZGluZw==,size_20,color_FFFFFF,t_70,g_se,x_16)
4.到这里，默认不管，直接点击next下一步。
![在这里插入图片描述](https://img-blog.csdnimg.cn/04621bd2caf84c58bbdac9b54b0673af.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAbHl3U3R1ZGluZw==,size_20,color_FFFFFF,t_70,g_se,x_16)
5.选择安装的路径，尽量不要安装在C盘，然后点击安装。
![在这里插入图片描述](https://img-blog.csdnimg.cn/5befe907a2e54a909be0a827c698c3d6.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAbHl3U3R1ZGluZw==,size_20,color_FFFFFF,t_70,g_se,x_16)
6.安装正在进行，稍微等待。
![在这里插入图片描述](https://img-blog.csdnimg.cn/9f5484d5e015487ba6ba194747225c9d.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAbHl3U3R1ZGluZw==,size_20,color_FFFFFF,t_70,g_se,x_16)
7.安装成功后，如下图所示，点击关闭即可。
![在这里插入图片描述](https://img-blog.csdnimg.cn/8ab9f54ceb174c14acfca60f3b57c8a8.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAbHl3U3R1ZGluZw==,size_20,color_FFFFFF,t_70,g_se,x_16)
8.打开cmd命令行窗口，测试是否安装成功，输入 `python -V` 命令查看Python安装版本，如下图所示，说明Python已经安装成功。
![在这里插入图片描述](https://img-blog.csdnimg.cn/33d3468a2a864b928c7fbd670bbc41cc.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAbHl3U3R1ZGluZw==,size_14,color_FFFFFF,t_70,g_se,x_16)
**you-get的官方版本是在PyPI上发布的，可以通过Python自带的pip包管理器轻松地从PyPI镜像安装。**

注意，必须使用Python 3版本的pip，前缀需要写成`pip3`:

> PyPI（Python Package Index ），其实表示的是 Python 的 Packag 索引，这个也是 Python 的官方索引。 你需要的包（Package）基本上都可以从这里面找到。

1.通过`pip3 install you-get`命令安装you-get，如下图所示：
![在这里插入图片描述](https://img-blog.csdnimg.cn/9727908290dc4a829f8eace3216f4176.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAbHl3U3R1ZGluZw==,size_20,color_FFFFFF,t_70,g_se,x_16)
2.安装you-get的过程中你可能会遇到如下图所示的问题，意思是Python的pip管理包版本需要升级到22.0.3版本。

```javascript
WARNING: You are using pip version 21.2.4 ; however，version 22.0.3 is available.
You should consider upgrading via the 'D:install\FythonlPython3_10_2Ypython.exe -m pip install --upgrade pip' command.
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/3b19c0d7565f4f0891b121e8425e4533.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAbHl3U3R1ZGluZw==,size_20,color_FFFFFF,t_70,g_se,x_16)
3.在cmd命令行输入：`python -m pip install --upgrade pip` 更新pip管理包到最新版本即可。
![在这里插入图片描述](https://img-blog.csdnimg.cn/e6a7aac2121444eebf3165aafdd966b0.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAbHl3U3R1ZGluZw==,size_20,color_FFFFFF,t_70,g_se,x_16)
4.pip更新完之后，重新输入：`pip3 install you-get` 命令，安装you-get，如下图所示：
![在这里插入图片描述](https://img-blog.csdnimg.cn/aa72f9fa434a4a1aae16dcf73a015d1e.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAbHl3U3R1ZGluZw==,size_20,color_FFFFFF,t_70,g_se,x_16)
**通过Python的pip管理包工具直接下载安装FFmpeg**网址:yii666.com<

> **FFmpeg**：
>   FFmpeg是一套可以用来记录、转换数字音频、视频，并能将其转化为流的开源计算机程序。采用LGPL或GPL许可证。它提供了录制、转换以及流化音视频的完整解决方案。它包含了非常先进的音频/视频编解码库libavcodec，为了保证高可移植性和编解码质量，libavcodec里很多code都是从头开发的。网址:yii666.com

FFmpeg官网：https://www.ffmpeg.org

输入`pip3 install ffmpeg` 命令，即可完成安装，如下图所示：
![在这里插入图片描述](https://img-blog.csdnimg.cn/6722dd00d07c4940b6f918ce660494e2.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAbHl3U3R1ZGluZw==,size_20,color_FFFFFF,t_70,g_se,x_16)

## 三、测试you-get的功能

1.这里以优酷举例子，从优酷上找到一个视频，复制网址链接：https://v.youku.com/v_show/id_XNTIwNTEyOTczMg==.html?spm=a2ha1.14919748_WEBHOME_GRAY.drawer5.d_zj1_2&scm=20140719.manual.7182.url_http%3A%2F%2Fv.youku.com%2Fv_show%2Fid_XNTIwNTEyOTczMg%3D%3D.html

2.在cmd命令窗口输入：`you-get -i [url]` 命令，出现下图所示，说明you-get可以正常使用了。
![在这里插入图片描述](https://img-blog.csdnimg.cn/ef729f4252614e1386d286a31ca85a0e.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAbHl3U3R1ZGluZw==,size_20,color_FFFFFF,t_70,g_se,x_16)

## 四、you-get 常用命令

```
// 查看you-get版本
you-get --version
缩写：you-get -V
// 查看帮助
you-get --help
缩写：you-get -h
// 查看Web网站媒体资源信息
you-get --info [url]
缩写：you-get -i [url]
// 下载Web网站媒体资源，默认以最高清晰度下载
you-get [url]
// 下载Web网站媒体资源，指定清晰度下载
you-get --format=[资源清晰度] [url]
缩写：you-get -F=[资源清晰度] [url]
```

## 五、you-get下载指定清晰度的视频

以下争对不需要账号登录，就可以下载的视频
1.首先在cmd命令窗口输入：`you-get -i [url地址]` 命令，查看视频资源信息，可以看到这个视频有超清、高清、标清清晰度可以选择下载。

> **you-get -i** https://v.youku.com/v_show/id_XNTIwNTEyMjUxNg==.html?spm=a2hbt.13141534.1_3.1&s=fccf96f33f7b41f09e36&scm=20140719.apircmd.61519.video_XNTIwNTEyMjUxNg==

![在这里插入图片描述](https://img-blog.csdnimg.cn/84b69af05fc64f1d9f864b26018a90ed.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAbHl3U3R1ZGluZw==,size_20,color_FFFFFF,t_70,g_se,x_16)
2.这里以下载标清视频举例，通过在cmd命令窗口输入`you-get --format=[资源清晰度] [url]` 命令，即可下载标清的视频。

> **you-get --format=mp4sd** https://v.youku.com/v_show/id_XNTIwNTEyMjUxNg==.html?spm=a2hbt.13141534.1_3.1&s=fccf96f33f7b41f09e36&scm=20140719.apircmd.61519.video_XNTIwNTEyMjUxNg==

![在这里插入图片描述](https://img-blog.csdnimg.cn/d21b68c3041542f98674681d1af90558.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAbHl3U3R1ZGluZw==,size_20,color_FFFFFF,t_70,g_se,x_16)

## 六、配置cookies

有些网站需要登录才能下载完整版视频，而且有些还需要会员账号才能下载
![在这里插入图片描述](https://img-blog.csdnimg.cn/f5927056093f4aa38326560e7a04700c.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAbHl3U3R1ZGluZw==,size_20,color_FFFFFF,t_70,g_se,x_16)
根据官方给出的文档，目前只支持火狐浏览器和Netscape浏览器的cookies，这里以火狐浏览器为例，进行配置cookies。

**1.下载安装火狐浏览器**
官网：http://www.firefox.com.cn

**2.登录视频网站**
用账号登录视频网站，如果要下载会员视频，前提你得有会员账号，网站需要先登录账号，获取网站登录的cookies，即可在命令行下载会员视频了。

**3.找到cookies文件位置**
这里以火狐浏览器为例，火狐浏览器的cookies文件`cookies.sqlite` 位置默认在C:\Users\pc\AppData\Roaming\Mozilla\Firefox\Profiles下，在Profiles里面搜索cookies.sqlite就可以找到，其中pc是自己的用户名。文章来源地址https://www.yii666.com/blog/325478.html

**4.下载视频**
通过输入命令 `you-get --cookies=[COOKIES_FILE所在位置以及文件名] [url]` 即可下载完整版或者会员视频**文章来源地址:https://www.yii666.com/blog/325478.html**