# nmcli命令详解

# 以下是nmcli命令的一些常用选项和用法： 

```
connection show    -- 显示所有网络连接的详细信息。
connection up <UUID>   --启动网络连接。
connection down <UUID>  -- 停止网络连接。
connection modify <UUID> ipv4.addresses <IP地址>/<子网掩码>  -- 修改网络连接的IPv4地址。connection modify <UUID> ipv4.gateway <网关>  -- 修改网络连接的IPv4网关。
connection modify <UUID> ipv4.method manual  -- 将网络连接的IPv4配置方法设置为手动。
connection modify <UUID> ipv6.addresses <IP地址>/<子网掩码>   -- 修改网络连接的IPv6地址。connection modify <UUID> ipv6.gateway <网关>  -- 修改网络连接的IPv6网关。
connection modify <UUID> ipv6.method manual  -- 将网络连接的IPv6配置方法设置为手动。
connection modify <UUID> dns <DNS服务器>  -- 修改网络连接的DNS服务器。
connection modify <UUID> mtu <MTU值>  -- 修改网络连接的MTU值。
connection show --active  显示所有启用状态的网络连接。
connection  delete  <UUID>  -- 删除网卡
```

### 1）修改网卡名称

```sh
nmcli c modify uuid f136e0e3-5faf-4d2f-8c5f-4ce976585b30 con-name ens33
```

![图片](https://mmbiz.qpic.cn/sz_mmbiz_png/gjtiahmRuyfdVzAbjYM9x7c3Gf6Stsr3BOyR1GE0U3kMnDZ4AquVTqCAUUAtTcPibwrwYEqXe2ic0mANdH8WQK8CQ/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

![图片](https://mmbiz.qpic.cn/sz_mmbiz_png/gjtiahmRuyfdVzAbjYM9x7c3Gf6Stsr3BGdLian7a4TlvzflBz1GQTECCCibgRUR3ibIfSVWUQ8PNMo1W9icodsiap8g/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

### 

### 2）添加网卡

```shell
nmcli connection add type ethernet con-name ens37 ifname ens37
```

![图片](https://mmbiz.qpic.cn/sz_mmbiz_png/gjtiahmRuyfdVzAbjYM9x7c3Gf6Stsr3BEiadnfSsAibvZZdg9rzlWib60GfLslz5eVTzAEadjST88ibjPkZmgh0xNw/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

### 3）启动或停止网卡

```sh
nmcli connection reload ——重载网卡
nmcli connection up ens33 ——激活网卡ens33
nmcli connection down ens33 ——停用网卡ens33
nmcli connection down ens33 && nmcli connection up ens33 ——重启网卡ens33
```

![图片](https://mmbiz.qpic.cn/sz_mmbiz_png/gjtiahmRuyfdVzAbjYM9x7c3Gf6Stsr3BnlDtZwPAX34icKm5jtDf77grMBlQx5ic0KykCVus89tMf8JSaSiby2TxA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

### 4）设置网卡获取IP模式

> 使用 nmcli 来设置网卡为静态IP ，可以使用以下命令：

```sh
nmcli connection modify <网卡名> ipv4.method manual ipv4.addresses <静态IP地址>/<子网掩码> ipv4.gateway <网关IP地址> ipv4.dns <DNS服务器IP地址>

nmcli connection modify ens37 ipv4.method manual ipv4.addresses 192.168.70.133/24 ipv4.gateway 192.168.70.2 ipv4.dns 114.114.114.114
#配置完静态IP后需要重启网卡使配置生效
nmcli c down ens37 && nmcli c up ens37
#查看网卡的详细信息
nmcli connection show ens37
```

![图片](https://mmbiz.qpic.cn/sz_mmbiz_png/gjtiahmRuyfdVzAbjYM9x7c3Gf6Stsr3BlI2Jzz3Q97mgEwMOib79cDE0v6ddUJP9iasDNgOiacj1XxiacDESCWH6YA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

![图片](https://mmbiz.qpic.cn/sz_mmbiz_png/gjtiahmRuyfdVzAbjYM9x7c3Gf6Stsr3BEXXxgdVXoh2cPAc4yzqVj8lB2RzhEo6YJ8FdOSG3ooq1tY9DO1GoSw/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

![图片](https://mmbiz.qpic.cn/sz_mmbiz_png/gjtiahmRuyfdVzAbjYM9x7c3Gf6Stsr3BT7SaTXibb5iaicGKd1SCDuewwZqDX4c51SA0j4CkGe3cx8LqknoG1anlg/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

> 使用nmcli命令将网卡eth0模式设置为dhcp

```sh
#删除配置的静态IP
nmcli connection modify ens37 ipv4.addresses "" ipv4.gateway "" ipv4.dns ""
#修改网卡为dhcp模式
nmcli connection modify eth0 ipv4.method auto
#重启网卡
nmcli c down ens37 && nmcli c up ens37
```