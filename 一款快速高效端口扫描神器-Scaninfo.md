# 一款快速高效端口扫描神器-Scaninfo

> 我们在“肾透”前期。端口扫描是必不可少的手段之一。通常我们都是用nmap神器进行扫描。但是nmap扫描很慢，masscan扫描也是不错的选择，但是不精确。能否在两者之间找到一款工具，能兼容两者的不足呢？

# 关于

`Scaninfo`是一款开源、轻量、快速、跨平台、的红队内外网打点扫描器。能够快速的端口扫描和服务识别比masscan更快。同时能更好的进行web探测与指纹识别，并将结果进行输出。

# 安装

程序基于`GO`语言开发。大家可以在github项目中下载自行编译。当然也可以用编译好的。

```
https://github.com/redtoolskobe/scaninfo
```

linux端下载

```
wget https://github.com/redtoolskobe/scaninfo/releases/download/v1.1.0/scaninfo_linux_x64
```

![图片](https://mmbiz.qpic.cn/mmbiz_png/Xb3L3wnAiathKXGHR62nPfibCA0Lz45ImEhRuQRqkwHibw5e2YefDJcP71gJEqEgDV0hcNqDibPfiawjmZdU0Tmibmxg/640?wx_fmt=png&tp=wxpic&wxfrom=5&wx_lazy=1&wx_co=1)

# 使用

**常用参数**

| 命令  |              功能              |
| :---- | :----------------------------: |
| -ei   |            排除某IP            |
| -uf   |   指定要web指纹识别的url文件   |
| -o    | 指定保存的结果文件默认为result |
| -p    |     指定端口默认使用top100     |
| -m    |    指定扫描的模块默认为全部    |
| -show |       查看扫描支持的模块       |

**示例**

常规扫描，-m参数后面跟指定模块（ssh smb mysql redis）等。web指纹识别

```
scaninfo -uf 22.txt -m  webfinger
```

![图片](https://mmbiz.qpic.cn/mmbiz_png/Xb3L3wnAiathKXGHR62nPfibCA0Lz45ImEUicib0bknqVKvHYlxDTOx6WE7nEboTNXL741y5CmapXnYyjxiaoWWgCicA/640?wx_fmt=png&tp=wxpic&wxfrom=5&wx_lazy=1&wx_co=1)

端口扫描

```
scaninfo  -i  192.168.123.1/24  -p  1-65535  -eq 53  -m port
```

![图片](https://mmbiz.qpic.cn/mmbiz_png/Xb3L3wnAiathKXGHR62nPfibCA0Lz45ImE2JKZ3TD3zsvXoXZiazeZkjsXjHEBMuh6iacM5f6L8L3PS3OvumnHIpwQ/640?wx_fmt=png&tp=wxpic&wxfrom=5&wx_lazy=1&wx_co=1)

`-eq`排除当前的`53`端口。