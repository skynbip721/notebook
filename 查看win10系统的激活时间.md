# 查看win10系统的激活时间

相信大部分人在使用win10系统办公时都会遇到“windows系统即将过期，请前往激活”的提示。其实我们可以提前查询自己电脑系统的激活时间，给自己提前做一个准备，下面就是具体的查看方法。

## 工具/原料

- 一台正常使用的电脑

## 方法/步骤

1. 1

   在键盘上按下“win”+“R”按键，出现“运行”窗口后输入命令“slmgr.vbs -xpr”，最后点击“确定”。

   [![怎么查看win10系统的激活时间](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/81422f277f8c4110b373c0bb831e3731~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)](https://link.juejin.cn?target=)

2. 2

   这时候电脑会直接弹出一个窗口，提示我们电脑的过期时间，点击“确定”将此窗口关闭。

   [![怎么查看win10系统的激活时间](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/7bd1c889fda34621804e34a74ed6bbab~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)](https://link.juejin.cn?target=)

3. 3

   如果有的小伙伴想要查看更加详细的电脑激活信息，再次按下键盘的“win”+“R”按键，在弹出的运行窗口中输入命令“slmgr.vbs -dlv”后点击确定。

   [![怎么查看win10系统的激活时间](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/3ff7c91a184e48aea78d62d6b94e4b2d~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)](https://link.juejin.cn?target=)

4. 4

   这时候电脑就会弹出更加详细的系统激活等信息，点击“确定”关闭窗口。

   [![怎么查看win10系统的激活时间](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/2f66fd480c704cf9b07f6d913a65ae52~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)](https://link.juejin.cn?target=)

   END

## 注意事项

- 以上就是本次我为大家带来的查看系统激活时间的办法，如果觉得有用的话麻烦大家投个票哦。



1、Win+R，输入winver
查询系统内核版本，以及注册用户
2、Win+R，输入slmgr.vbs -dlv
查询到Windows的激活信息，包括：激活ID、安装ID、激活截止日期等；
3、Win+R，输入slmgr.vbs -dli
查询到操作系统版本、部分产品密钥、许可证状态等；
4、Win+R，输入slmgr.vbs -xpr
查询Windows是否永久激活；
5、Win+R，输入slmgr.vbs 来获得系统的激活信息；
