---
layout: post
title:  Linux下挂载硬盘
categories: linux
tags: config
author: Jacob Pan
---

* content
{:toc}


## 1. 查看当下PC有哪些硬盘可挂载

```sh
# fdisk -l
```


## 2. 使用命令mount挂载硬盘到特定目录

首先，目录一定要是空白的目录，可以通过`mkdir`创建一个新目录, 然后通过`mount`挂载
```sh
# mount /dev/sda9 ~/mnt/files/
```
一般来说，要挂载的硬盘叫做“设备”，所挂载的目录叫做“挂载点”。

挂载完成后，可以通过
```
df
```
来查看当前PC所挂载的所有硬盘。


## 3. 卸载硬盘

```
# umount <device>
# umount <mount point>
```
以上两条命令都可以卸载硬盘。


## 4. 开机自动挂载设备

编辑`/etc/fstab`文件，添加以下类似内容

```
/dev/sda5       /home/jacob/mnt/d          ntfs-3g     defaults        0       0
/dev/sda10      /home/jacob/mnt/mind       ext4        defaults        0       0
```

其中，
- 第一列是设备的名字
- 第二列是挂载点
- 第三列是设备的类型，其中ext4系统默认支持，ntfs-3g是windowns的硬盘格式，若linux不支持，需要安装`ntfs-3g`

修改完`/etc/fstav`后，可采用`# mount -a`将所有写在该文件里的设备全部挂载上


---
> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)
