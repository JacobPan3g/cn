---
layout: post
title: Windows xp下硬盘安装centos6.4
categories: linux
tags: install
author: Jacob Pan
---

* content
{:toc}


我曾经写过两篇windows xp和win7下硬盘安装ubuntu的文章，至于如何在xp下硬盘安装centos6.4，大体方法和xp下安装ubuntu一样，具体步骤可以参看博客里的相应文章，差异主要如下：


## 提取iso中的文件不同

centos镜像提取出来的是`vmlinuz`和`initrd.img`


## menu.lst内容不同

```
root (hd0,0)
kernel /vmlinuz
initrd /initrd.img
```

网上有帖子说，解压grub4dos把`grldr`和`menu.lst`放到C盘根目录，并编辑`boot.ini`后，直接重启系统，点击新增加的引导项进入grub命令行，可以通过下面命令找到vmlinuz所在的分区编号：

```
find /vmlinuz   # 返回 (hd0,0)
reboot          # 重启
```

也可以直接在命令行敲入第二第三行，使用`boot`命令直接引导镜像。


> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)

