# Tor（洋葱） 浏览器的简单配置

#### 下载安装

- • 下载地址：https://www.torproject.org/download/alpha/

#### 网络配置

安装打开浏览器后需要进行一些配置

![图片](https://mmbiz.qpic.cn/mmbiz_png/N7gpx0ZPKPAJaNkQ0KaO9JhRRT5uqbbSicIicGMSCBF49QQ7npPVccDJ8Ym1pY5jBZKmIqGCciadtoTU0icK4s5micA/640?wx_fmt=png&from=appmsg&wxfrom=13&tp=wxpic)

有2种方式，**建议使用第二种**

#### 1.网桥连接

网桥配置有三种方式

![图片](https://mmbiz.qpic.cn/mmbiz_png/N7gpx0ZPKPAJaNkQ0KaO9JhRRT5uqbbSm8T19skiaO8PecBeTibzjBEhOLdHeiaf9nv9Fxv9QekPQKurHibrHDOxLg/640?wx_fmt=png&from=appmsg&tp=wxpic&wxfrom=5&wx_lazy=1&wx_co=1)

- • 内置网桥

一般使用内置网桥即可，这种方式的有点在于点击即用，缺点是速度不能保证



![图片](https://mmbiz.qpic.cn/mmbiz_png/N7gpx0ZPKPAJaNkQ0KaO9JhRRT5uqbbSDDhibXhXyhyCwEUqFRPmicbOh6TzKyYUy0f6J2lDRWGLVX0aqK3x2v6w/640?wx_fmt=png&from=appmsg&tp=wxpic&wxfrom=5&wx_lazy=1&wx_co=1)

内置网桥有三种选择，选择任意一个都行

- • 请求网桥

  ![图片](https://mmbiz.qpic.cn/mmbiz_png/N7gpx0ZPKPAJaNkQ0KaO9JhRRT5uqbbSyNvaEL4qs7EMEateoPbtoClIu3pcnU1R5IgfOro613J6Mn05OF2cTA/640?wx_fmt=png&from=appmsg&tp=wxpic&wxfrom=5&wx_lazy=1&wx_co=1)

  如果选择请求网球，浏览器会向Tor发送请求，获取 3 个obfs4网桥配置获取的值可以保存，可以不断刷新获取新的值，这样就可以筛选出一些速度还不错的网桥

- • 手动添加网桥（输入已知网桥）这里其实就是填写获取的一些网桥，最直接的方式是上面的那个步骤，其次还可以通过发送邮件、网页获取的方式来获取网桥

#### 2.代理网络连接

点击clash的图标，查看当前配置的端口

![图片](https://mmbiz.qpic.cn/mmbiz_png/N7gpx0ZPKPAJaNkQ0KaO9JhRRT5uqbbS7tHTDsq9jdSR8sP0J8kibAKB7SEblfHgrFibJ77oqGd4L93vrABQUSPg/640?wx_fmt=png&from=appmsg&tp=wxpic&wxfrom=5&wx_lazy=1&wx_co=1)

一般默认的都是 7890

本地IP一般为：`127.0.0.1`（你可复制`127.0.0.1`到浏览器打开，提示 It's Works. 就是对的）；

配置**使用代理访问互联网**

![图片](https://mmbiz.qpic.cn/mmbiz_png/N7gpx0ZPKPAJaNkQ0KaO9JhRRT5uqbbSSITGNicDHsVxRMY700ib3lptg1ianEsZI5G7ye0Snz8Ciaz98C1xasAbyQ/640?wx_fmt=png&from=appmsg&tp=wxpic&wxfrom=5&wx_lazy=1&wx_co=1)

![图片](https://mmbiz.qpic.cn/mmbiz_jpg/N7gpx0ZPKPAJaNkQ0KaO9JhRRT5uqbbS1lLcUyW77muspeT4iayRziceOjEhOFD9WZDVVImHy7tWn4qjvxBQKnkQ/640?wx_fmt=jpeg&from=appmsg&tp=wxpic&wxfrom=5&wx_lazy=1&wx_co=1)

如上图，在设置中为你的 Tor 浏览器设置代理；个人不建议使用网桥，会非常慢。

#### 获取网桥

#### 邮件获取：

mail自助获取tor的 obfs3或scramblesuit桥接ip

给 bridges@torproject.org 发邮件（要Gmail）

标题 get transport obfs3 正文 get transport obfs3 或 标题 get transport scramblesuit 正文 get transport scramblesuit

#### 直接网页获取tor和obfsproxy的桥接ip

**1. 直接随机获取网桥ip**

https://bridges.torproject.org/bridges



![图片](https://mmbiz.qpic.cn/mmbiz_png/N7gpx0ZPKPAJaNkQ0KaO9JhRRT5uqbbStMTD4ZofNoCHgLa2dLiaURs4cSgiafXcb3lON6JiadUicLiaOWkYAxP5XvA/640?wx_fmt=png&from=appmsg&tp=wxpic&wxfrom=5&wx_lazy=1&wx_co=1)

输入其十分难以辨识的验证码，才能打开网页获得网桥ip，不知道他们为什么要搞那么大的辨识难度。

获得的网桥样子是：

```
193.182.111.23:80 C0C333B87E110E3BA49DB70E9D504688FAD5D556
195.201.202.125:443 D44C0BC5AF900547704BCE5062E4B169672120E8
```

 **请注意：只添加前面的地址和端口, 最后面的长串数字字母是数字指纹,不要添加** **即：只要: 192.36.27.104:20326**

**2. 高级用法：指定获取网桥ip的类型：**

现在tor的网桥有几种类型，如：普通的、obfs2、obfs3等等，如果你自己需要某种类型的网桥ip，可以在如下页面进行选择指定：

1）打开页面：https://bridges.torproject.org/options

2）选择网桥类型：



![图片](https://mmbiz.qpic.cn/mmbiz_png/N7gpx0ZPKPAJaNkQ0KaO9JhRRT5uqbbSrlk2IOpaz9iaiam58fryWz7RicMuIXuuU3tXV5pP8aIs3JjGAiass2bpjQ/640?wx_fmt=png&from=appmsg&tp=wxpic&wxfrom=5&wx_lazy=1&wx_co=1)