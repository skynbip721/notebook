# Windows 10中使用命令行管理WIFI无线网络

![WIFI无线网络](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/01c24f9c7099414c83d1e6c5f77957ac~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)

在 Windows 10 中，我们通常都使用「设置」应用或「控制面板」来管理和配置 WIFI 无线网络连接。然而要执行更高级的任务，例如：查看不同 WIFI 配置文件的连接密码、[创建 WIFI 共享热点](https://link.juejin.cn?target=https%3A%2F%2Fwww.sysgeek.cn%2Fwindows-10-wifi-hotspot%2F)、输出无线网络配置文件的详细信息或生成无线网上报告时，都无法使用「设置」和「控制面板」来完成。

针对以上提及的高级需求和任务，微软从 Windows 2000 开始便内置了一个 Netsh（Network Shell）命令行工具，以帮助用户执行本地或远程计算机上不同网卡的信息查看、配置及排错工作。

虽然 Netsh 功能十分强大，可以管理无线和有线网络，但在本文中我们将主要关注使用 Netsh WLAN 命令：查看当前配置、生成报告、删除以及导出和导出无线网络配置文件等操作。

> 在正式开始之前，我们先约定所有命令都以管理员权限执行，你可以按下 **Windows + X** 并选择「命令提示符（管理员）」来打开命令行。

## 查看WIFI无线网络配置文件

当我们在 Windwos 10 中连接过不同的 WIFI 之后，操作系统都会自动生成一个单独的「无线网络配置文件」并存储在计算机中，使用如下命令我们便可以看到当前系统中所有连接过的 WIFI 配置文件：

**复制

```sql
sql
复制代码Netsh WLAN show profiles
```

![查看WIFI无线网络配置文件](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/0746a9cf4a7c4f5ab09a4793ae533219~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)

（家用电脑，所以只连过 1 个 WIFI 网络）

以上命令会显示出所有无线网卡连接过的 WIFI 配置文件，如果你有多块无线网卡，还可以使用 interface 参数跟上网卡名称进行单独列出：

**复制

```ini
ini
复制代码Netsh WLAN show profiles interface="无线网上名称"
```

## 查看无线网卡驱动信息

要查看当前 Windows 10 的无线网卡驱动信息可以使用如下命令：

**复制

```sql
sql
复制代码Netsh WLAN show drivers
```

![查看无线网卡驱动信息](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/33156fbac7f342d0b15b9b7fc0941cb1~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)

「Show drivers」将详细显示无线网卡的驱动程序、供应商、版本号、支持的无线类型及其它更多相关信息。

你也可以随时使用如下命令来查看当前无线网卡所支持及兼容的（系统及硬件）功能：

**复制

```sql
sql
复制代码Netsh WLAN show wirelesscapabilities
```

![查看无线网卡驱动信息](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/32b79b7e2af04c9a9658ce0c1344daf5~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)

## 查看无线网卡配置

当你需要查看无线网卡的：无线电类型、信道、传输速率等信息时，可以使用如下命令：

**复制

```sql
sql
复制代码Netsh WLAN show interfaces
```

![查看无线网卡配置](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/b954dcd4ac57441ebb3870ac8344ebb1~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)

「Show interfaces」将详细显示所有无线网卡的信息，你也可以使用如下命令来指定网卡：

**复制

```ini
ini
复制代码Netsh WLAN show interface name="网卡名称"
```

## 查看WIFI密码

如果时间久了，你忘了某个已连接过的 WIFI 密码，可以使用如下命令进行查看：

**复制

```ini
ini
复制代码Netsh WLAN show profile name="无线名称" key=clear
```

![查看WIFI配置文件中的密钥](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/65179b7bc79e4d73ad10dfc27f30d16c~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)

请记住，在「控制面板」的网卡属性中可以查看当前无线网络的密码，使用上诉命令可以查看所有连接过的 WIFI 密钥。

## 停止自动连接到某个WIFI无线网络

通常我们都会配置 Windows 10 自动连接到 WIFI，但在有多个无线网络的情况下，系统自动选择连接的那个 WIFI 可能信号较差，此时我们可以使用如下命令以阻止系统自动连接到某个 WIFI 无线网络：

**复制

```ini
ini
复制代码Netsh WLAN set profileparameter name="无线名称" connectionmode=manual
```

![停止自动连接到某个WIFI无线网络](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/67640ad57fb54f6399fbeb7c9b1391e0~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)

如果你想恢复自动连接，只需将最后的参数改为 auto 即可。

## 删除WIFI配置文件

当你不需要再连接某个无线网络、更改了 SSID 或需要重置配置文件时，可以使用如下命令来删除指定的 WIFI 配置文件：

**复制

```ini
ini
复制代码Netsh WLAN delete profile name="无线名称"
```

![删除WIFI配置文件](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/04bd3037f9e847459dd3083a03aca40d~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)

> 注意：如果你使用 Microsoft Account 登录到 Windows 10，WIFI 的配置文件默认会在不同设备间进行同步，但删除 WIFI 配置文件的操作不会同步到其它设备上。

## 导入和导出WIFI无线网络配置文件

在 Windows 7 中，用户可以直接在「控制面板」中导入和导出无线网络配置文件，但从 Windows 8/10 开始，微软从界面中移除了该功能。不过，我们还是可以使用命令行来完成操作。

下列命令可以导出 WIFI 无线网络配置的 xml 文件：

**复制

```arduino
arduino
复制代码Netsh WLAN export profile key=clear folder="存放路径"
```

![导入WIFI无线网络配置文件](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/5cda56cf6aca4cd6822d5b75a403f196~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)

默认情况下会为每个 WIFI 连接都导出一个单独的配置文件，如果你只想导出单个配置文件，可以使用如下命令：

**复制

```arduino
arduino
复制代码Netsh WLAN export profile name="无线名称" key=clear folder="存放路径"
```

> 注意：导出的 XML 配置文件是明文存储，而且会导出 WIFI 连接密码，所以请一定妥善保存。

导出配置文件也非常简单，使用如下命令即可：

**复制

```ini
ini
复制代码Netsh WLAN add profile filename="存放路径"
```

## 生成无线网卡报告

你可以使用如下命令来创建和生成详细的无线网卡报告：

**复制

```sql
sql
复制代码Netsh WLAN show WLANreport
```

![生成无线网卡报告](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/e1d5a2b77e8a427d870ca15b9acad784~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)

大家可以在如下路径中去查看这个诊断报告：

**复制

```makefile
makefile
复制代码C:\ProgramData\Microsoft\Windows\WlanReport\wlan-report-latest.html
```

[![无线网卡报告](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/ce56ca40ca8245aaabc089046ce85818~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)](https://link.juejin.cn?target=https%3A%2F%2Fimg.sysgeek.cn%2Fimg%2F201602%2Fc536aae8aa42_137A7%2Fmanage-wireless-networks-using-netsh-wlan-11.jpg)

该报告是非常详细和专业的无线网卡诊断报告，无线网络的连接和断开时间都有记录。

## Netsh WLAN命令小结

虽然我们在 Windows 10 中还是可以使用「设置」和「控制面板」来配置管理无线网络，但使用 Netsh 命令行管理 WIFI 无线网络无疑是一种更为强大和专业的方式，它可以帮助我们工具、配置和故障排除无线网络故障。

本文中，我们只介绍了 Netsh WLAN 的常见用法，你还可以直接输入它来进行更为深入的探索。

![Netsh WLAN](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/9db65383bfd14bff9eb228ba4c9b5055~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)

作者：ArchLinux
链接：https://juejin.cn/post/7210387904748814391
来源：稀土掘金
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。