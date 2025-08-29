# 使用 winget 包管理器，简化 Windows 应用管理

![命令行](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/3f7a6f2650f44ddca00c21995729781c~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)

如果您是高级 Windows 用户或曾经使用过基于 Linux 的操作系统，那么对[包管理器](https://link.juejin.cn?target=https%3A%2F%2Fwww.sysgeek.cn%2Flinux-package-management%2F)的概念应该有所了解。包管理器提供了集中的方式来安装和更新应用程序。Microsoft 为 Windows 11 和 Windows 10 用户提供了官方 [Windows Package Manager](https://link.juejin.cn?target=https%3A%2F%2Fwww.sysgeek.cn%2Fwindows-package-manager-release%2F) 包管理器，简称为 winget。

Windows Package Manager 作为 [App Installer](https://link.juejin.cn?target=https%3A%2F%2Fapps.microsoft.com%2Fstore%2Fdetail%2Fapp-installer%2F9NBLGGH4NNS1) 软件包的一部分被集成到 Windows 系统中，它完全基于命令行，主要通过 [Windows Terminal](https://link.juejin.cn?target=https%3A%2F%2Fwww.sysgeek.cn%2Fintroducing-windows-terminal%2F) 来使用。本文将介绍如何在 Windows 中使用 winget 包管理器，让您像 Linux 那样管理 Windows 中的软件包

## 使用 winget 搜索和安装应用程序

对于不熟悉基于文本界面的用户来说，刚开始使用 winget 时可能有点令人望而却步，但实际上它非常简单易用。winget 的基本用法只涉及搜索和安装应用程序。请按照以下步骤操作：

1在 Windows 11 中鼠标右击「开始」菜单 – 选择打开「终端管理员」。

2要搜索应用程序，请执行：

**复制

```sql
sql
复制代码winget search <AppName>
```

例如，输入`winget search Chrome`来尝试查找 Google Chrome。

![使用 winget 搜索应用程序](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/877ed07682ef4516839be296492e394e~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)

使用 winget 搜索应用程序

3如果首次使用`winget`命令，需要同意服务条款，请按`Y`然后按回车键。查询结果中可以看到包括不同版本的 Chrome，以及一些名称相似的应用程序。

4为了获取和安装正确的应用程序，最准确的方法是使用第二列中列出的包 **ID**。例如，要安装 Google Chrome 的稳定版，可以使用如下命令：

**复制

```
复制代码winget install Google.Chrome
```

![使用 winget 安装应用程序](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/34f6d5c347c94d67b7c4ad34dbd2a204~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)

使用 winget 安装应用程序

- 如果要安装的程序需要通过 Microsoft Store 获取（源在列表的最后一列），还需要同意服务条款，请按`Y`然后按回车键。
- 也可以在安装命令中添加`--accept-package-agreements`参数，以自动接受任何协议。

5安装完成后，可以重复这个过程来安装其他任何需要的应用程序。

在 Windows 11 中使用基于文本的命令行界面安装应用程序非常简单，而且有许多应用程序都可以通过`winget`命令实现静默安装，而且速度非常快。正如我们之前提到的，您也可以使用 Windows Package Manager 安装来自 Microsoft Store 的应用程序。

## 使用 winget 更新应用程序

Windows Package Manager 的另一个功能是通过集中的界面保持应用程序的更新。如果有一个或多个应用程序可在 winget 仓库中获取（即使不是通过该仓库安装），也可以使用它一次性轻松更新这些应用：

1在 Windows 11 中鼠标右击「开始」菜单 – 选择打开「终端管理员」。

2执行以下命令查看可用的软件更新包列表：

**复制

```shell
shell复制代码winget update
##或者
winget upgrade
```

![使用 winget 更新应用程序](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/2c22f64c671849cc9f9f3a7f67031b87~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)

使用 winget 更新应用程序

3要更新特定的软件包，请运行：

**复制

```sql
sql
复制代码winget update <ID>
```

![使用 winget 更新应用程序](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/8af5028b9bfa41f7aae4d29df3a02a86~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)

使用 winget 更新应用程序

请将`<ID>`替换为想要更新的包 **ID**。

4如果要更新所有软件包，可以运行：

**复制

```sql
sql
复制代码winget update --all
```

5也可以添加`--include-unknown`参数来安装计算机上未知版本软件包的最新版本。

6软件包将逐个进行更新。同样地，一些安装程序在更新时可能需要人工干预，但可以使用`--disable-interactivity`参数来跳过。

您可以随时再次运行此操作，以确保应用程序保持最新。

## 使用 winget 卸载应用程序

当然，我们也可以使用 winget 包管理器来卸载应用程序：

1在 Windows 11 中鼠标右击「开始」菜单 – 选择打开「终端管理员」。

2运行以下命令查看计算机上安装的所有软件包：

**复制

```
复制代码winget list
```

3找到想要卸载的应用程序包 **ID**，再运行以下命令：

**复制

```bash
bash
复制代码winget uninstall <id>
```

![使用 winget 卸载应用程序](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/fa536bb9360d44d1b7607e32f91f08dd~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)

使用 winget 卸载应用程序

将`<id>`替换为要移除的包 **ID**。

4按照屏幕上的指示进行操作，或者使用`--disable-interactivity`参数以静默方式移除应用程序。

## 使用 winget 导出和导入软件包列表

winget 工具的另一个强大功能是能够将 Windows 中已安装的所有软件包导出为一个 JSON 文件。在设置新电脑时，就可以导入该文件，以便一次性安装列表中的所有应用程序。

### 导出软件包列表

要导出 Windows 中已安装的软件包列表，只需运行：

**复制

```arduino
arduino
复制代码winget export -o <output>
```

将`<output>`替换为要存储包列表文件的路径。某些应用可能需要同意源协议。

- 可以使用`--source`参数仅筛选来自选定源（如 **winget** 或 **msstore**）的软件包。
- 可以使用`--version`参数导出特定版本的应用程序，而不是安装最新版本。

![使用 winget 导出软件包列表](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/036a3e0677cc4c2a96037cd2c7c0231d~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)

使用 winget 导出软件包列表

还可以将该文件移动到 U 盘或 OneDrive 这样的云服务中，以便稍后在其他设备上导入。在此过程中，可能会出现许多错误，因为许多应用程序是预装在 Windows 中的，或者可能不是通过 **winget** 或 **msstore** 源安装的。

此操作只会导出软件包列表，不包括实际的安装程序。在导入时，新电脑需要连接到 Internet，以便下载和安装这些软件包。

### 导入软件包列表

要导入软件包列表，可以使用以下命令：

**复制

```arduino
arduino
复制代码winget import -i <import-file>
```

其中`<import-file>`是要导入的文件路径，还可以添加`--accept-package-agreements`参数以接受所有需要同意的源的协议。

![使用 winget 导入软件包列表](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/b6dffa09880e431bbe74131a3fb23fd6~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)

使用 winget 导入软件包列表

- Windows Package Manager 将尝试逐个安装软件包列表中的所有应用程序。
- 由于其中一些是随 Windows 11 一起提供的应用程序包，因此可能已经安装了某些应用程序。
- 对于新的应用程序和更新，可能需要与每个安装程序进行交互，或者在导入时使用`--disable-interactivity`参数来跳过所有安装程序的交互过程。

------

本文应该让您对如何使用 winget 包管理器有了一个基本了解。您可以进一步深入，通过添加自定义源获取应用程序，例如公司内部的应用程序存储库，并验证应用程序的清单文件。但本文介绍的核心功能已经非常实用。

