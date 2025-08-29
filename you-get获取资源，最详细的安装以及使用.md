you-get获取资源，最详细的安装以及使用
======================

You-get 是一个python的爬虫程序，支持下载多种音视频媒体资源。占用资源少，使用简单、便捷。

以b站视频为例，想要下载自己想要的学习文件，右键视频复制地址

![](https://pic3.zhimg.com/80/v2-f7aa5e36a3814813a5ac9c4bdc1b4512_1440w.webp)

运行cmd，“you-get 该视频链接“ 直接下载

![](https://pic3.zhimg.com/80/v2-6f5e84c7a1376a4d4e8548723d5911ca_1440w.webp)

下载的文件默认在用户文件夹下，直接就可以观看使用了

![](https://pic4.zhimg.com/80/v2-4bd2270da32613eaa3731a9136570dc3_1440w.webp)



you-get下载安装
-----------

准备工作

1. 安装python 3.8 及以上版本
2. 安装ffmpeg音视频解码工具
3. 安装you-get程序

### python 安装

**官网下载地址**

[https://www.python.org/downloads/​www.python.org/downloads/](https://link.zhihu.com/?target=https%3A//www.python.org/downloads/)

* 进入官网，选择适合自己电脑的版本，这里我们选择windows

![](https://pic1.zhimg.com/80/v2-657e67703dc4ad8f701abd823842707c_1440w.webp)

* 找到windows x64的安装程序，下载

![](https://pic4.zhimg.com/80/v2-2053e24141eb9e009f671e0dd5e64c37_1440w.webp)

* 下载完成，运行程序，选择默认安装install now，切记一定要勾选下面添加到系统环境变量的框。

如果忘记勾选，则需要手动添加，参考ffmpeg的添加方法。把下面2图的两个路径找到，添加系统环境变量（如果找不到文件夹，打开查看隐藏文件夹）

![](https://pic4.zhimg.com/80/v2-776a87c4557b7cd5af110b3a86e9eddb_1440w.webp)

![](https://pic3.zhimg.com/80/v2-671071db2ae0ef243fe81e8f7aea233a_1440w.webp)

* 等待安装完成，运行cmd。输入python，回车，如果出现版本号，表示安装成功

![](https://pic2.zhimg.com/80/v2-9ee116ca92376203cc5e5293fccaac45_1440w.webp)





### ffmpeg安装

官方下载网址

[Download FFmpeg​www.ffmpeg.org/download.html#build-windows](https://link.zhihu.com/?target=https%3A//www.ffmpeg.org/download.html%23build-windows)

![](https://pic3.zhimg.com/80/v2-17fdca698c9c6460fc398d5a25df6536_1440w.webp)

* 这里windows 会显示两个下载地址，选择哪一个都行

选择Windows builds from gyan.dev，进入页面，选择最新版本 的full版 下载即可

![](https://pic4.zhimg.com/80/v2-5e5808dc0d55eda9573f19878fb58db7_1440w.webp)

选择Windows builds by BtbN，进入github，选择最新更新 win64 gpl版本 下载即可

![](https://pic4.zhimg.com/80/v2-99bac3db55f6995d59c4f469e3d96723_1440w.webp)

* 下载完成之后解压压缩包到指定位置。找到压缩包之下的bin文件夹，复制路径添加到系统环境变量

![](https://pic3.zhimg.com/80/v2-40b5ae3323be5c2ee573998a054eead6_1440w.webp)

* **添加到系统变量**

首先打开系统设置，选择系统信息。（win10在系统设置，关于，高级设置下）

![](https://pic3.zhimg.com/80/v2-fcc44f973627b58c761394aaf8d9f93e_1440w.webp)

win11系统

![](https://pic2.zhimg.com/80/v2-f26de22134035c36a4320482cc69b229_1440w.webp)

win10系统

点击高级设置

![](https://pic3.zhimg.com/80/v2-a842c6c52bf3494c46c83097fa40fd76_1440w.webp)

win11系统

点击环境变量

![](https://pic1.zhimg.com/80/v2-216b90496df62f06eb891c869f56ae20_1440w.webp)

找到path，选中点击编辑

![](https://pic1.zhimg.com/80/v2-46b685ba12e7871fcab41fed85308cf4_1440w.webp)

点击新建，把复制的ffmpeg文件夹下的bin的路径粘贴进来，然后确认

![](https://pic4.zhimg.com/80/v2-4f2848cc3e86f18cf77fb7dd78fe5dfb_1440w.webp)

* ffmpeg安装完成了，运行cmd，输入命令ffmpeg -v，出现版本信息即代表安装成功

![](https://pic4.zhimg.com/80/v2-c746f8d4ff446916ff0aef52ac6617ab_1440w.webp)

### 安装you-get

* 运行cmd

![](https://pic1.zhimg.com/80/v2-764b659bfffac8c2cea1b915881ccb6c_1440w.webp)

* 输入命令 pip install you-get，等待下载安装成功

![](https://pic2.zhimg.com/80/v2-dc5db0fc08c4b174af27e3fcc88280b5_1440w.webp)
使用方法
----

* You-get 视频链接——下载视频（默认的下载路径 在用户的文件夹下 ）

![](https://pic3.zhimg.com/80/v2-e9aeb5dd899cdbf351b4a7a2c56d0d2a_1440w.webp)

* You-get -i 视频链接 ——查看视频质量和信息

![](https://pic3.zhimg.com/80/v2-d3866e1a0810fa651c11bebf16098ab6_1440w.webp)

* You-get –fomat=flv-360 链接 ——下载指定清晰度和视频（查到信息之后，下载指定视频，如果不指定，默认是第一个）

![](https://pic2.zhimg.com/80/v2-4ebd61d13157f1ceaba291d6ccc7a119_1440w.webp)

* Ctrl + c ——暂停下载
* You-get -f 视频链接 ——强制重新下载，覆盖之前文件
* You-get -o （小写）下载路径 视频链接 ——设置下载路径（路径文件名不能有空格，否则会报错）

![](https://pic3.zhimg.com/80/v2-69734b6f09fdebebe3e21e229a14fd1a_1440w.webp)

* You-get -O（大写） 名字 视频链接 ——设置下载文件名称

![](https://pic2.zhimg.com/80/v2-69e899b6573255efbb5479e61589c635_1440w.webp)

* You-get -u 网址 ——获取真实的视频地址

![](https://pic4.zhimg.com/80/v2-4b9339f3ab6b5bb43c686c4a6b0938cb_1440w.webp)

* You-get --playlist 链接 ——批量下载（下载一个系列的批量视频）

![](https://pic4.zhimg.com/80/v2-ac3f85fbdb1c38f9073be1339c3ecc9b_1440w.webp)

* You-get --cookies=cookies路径 链接 ——下载会员视频，cookies目前只支持 火狐和netscape

火狐浏览器的cookies文件路径 ： C:\Users\users name\AppData\Roaming\Mozilla Firefox\Profilesldln2mhmn.default\cookies.sqlite
使用说明
----

you-get可以支持的网站

![](https://pic4.zhimg.com/80/v2-62e15690de20b9718dd150bd80dd8397_1440w.webp)

![](https://pic3.zhimg.com/80/v2-eab239c2c3b39ed90bbdba99e03d6ec2_1440w.webp)

![](https://pic4.zhimg.com/80/v2-efacedee76b5cda76c6c0ac7f5af2c1f_1440w.webp)

![](https://pic3.zhimg.com/80/v2-e18f84abaf94e1943dc90629525938e6_1440w.webp)

![](https://pic1.zhimg.com/80/v2-0ef9c3821e5e1399a29c85555b6237ac_1440w.webp)

![](https://pic1.zhimg.com/80/v2-92756a36df2b26228809a3319dbdd19c_1440w.webp)
