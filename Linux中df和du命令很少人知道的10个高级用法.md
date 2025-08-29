# Linux中df和du命令很少人知道的10个高级用法

当涉及到在Linux系统中管理磁盘空间时，df和du命令是非常有用的工具。除了基本用法外，它们还具有一些高级用法，可以提供更详细和定制化的磁盘信息。下面是Linux中df和du命令的十个常用的高级用法，附带相应的代码和输出。

1. **df -i** - 显示文件系统的inode使用情况，而不是磁盘空间使用情况。



```
$ df -i
```

输出示例：

```
Filesystem      Inodes  IUsed  IFree IUse% Mounted on
/dev/sda1      2621440 200000 2421440    8% /
tmpfs           102400      1 102399    1% /dev/shm
/dev/sdb1      6553600  50000 6503600    1% /data
```

1. **df -T** - 显示文件系统类型。



```
$ df -T
```

输出示例：

```
Filesystem     Type     1K-blocks    Used Available Use% Mounted on
/dev/sda1      ext4       20511360 9783776   9757632  51% /
tmpfs          tmpfs       3983616       0   3983616   0% /dev/shm
/dev/sdb1      ext4      102401280 50108800  52392304  50% /data
```

1. **df -h --total** - 显示总磁盘空间使用情况，包括所有文件系统。

   

```
$ df -h --total
```

输出示例：

```
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        20G   10G   10G  50% /
tmpfs           3.8G     0  3.8G   0% /dev/shm
/dev/sdb1       100G   48G   52G  48% /data
total           123G   58G   62G  48%
```

1. **df -m** - 以MB为单位显示磁盘空间使用情况。

   

```
$ df -m
```

输出示例：

```
Filesystem     1M-blocks  Used Available Use% Mounted on
/dev/sda1           20079  9553      9489  51% /
tmpfs                3894     0      3894   0% /dev/shm
/dev/sdb1           99968 48977     50815  50% /data
```

1. **df -x** - 显示指定文件系统类型之外的文件系统。

   

```
$ df -x tmpfs -x devtmpfs
```

输出示例：

```
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/sda1       20511360 9783776   9757632  51% /
/dev/sdb1      102401280 50108800  52392304  50% /data
```

1. **du -a** - 显示目录下所有文件和子目录的磁盘使用情况。



```
$ du -a /path/to/directory
```

输出示例：

```
4       /path/to/directory/file1.txt
8       /path/to/directory/file2.txt
12      /path/to/directory/subdirectory
24      /path/to/directory
```

1. **du -h --max-depth=1** - 以人类可读的格式显示目录下一级子目录的磁盘使用情况。



```
$ du -h --max-depth=1 /path/to/directory
```

输出示例：

```
4.0K    /path/to/directory/file1.txt
8.0K    /path/to/directory/file2.txt
12K     /path/to/directory/subdirectory
24K     /path/to/directory
```

1. **du -shx** - 显示指定目录的磁盘使用情况，排除挂载的文件系统。



```
$ du -shx /path/to/directory
```

输出示例：

```
24K     /path/to/directory
```

1. **du -c** - 显示多个目录的总磁盘使用情况。



```
$ du -c /path/to/directory1 /path/to/directory2
```

输出示例：

```
4       /path/to/directory1
12      /path/to/directory2
16      total
```

1. **du -L** - 跟踪符号链接指向的文件或目录的磁盘使用情况。



```
$ du -L /path/to/symlink
```

输出示例：

```
8       /path/to/symlink/file.txt
```



这些高级用法可以帮助您更全面地了解磁盘空间的使用情况，从而更好地管理和优化您的系统。无论是查看文件系统类型、检查inode使用情况还是定制化显示格式，df和du命令提供了丰富的选项来满足您的需求。