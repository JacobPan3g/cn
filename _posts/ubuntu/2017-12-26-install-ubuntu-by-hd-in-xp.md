---
layout: post
title: Windows xp下硬盘安装ubuntu
categories: ubuntu
tags: install
author: Jacob Pan
---

* content
{:toc}


之前写过一篇文章阐述如何在win7下硬盘安装ubuntu，而不需要安装U盘或光盘。接下来，介绍一下在xp下如何硬盘安装ubuntu，在操作上面，有一点点小差别


## 1. 准备好ubuntu iso镜像

并把镜像`casper/`里的`initrd.lz`和`vmlinz`提取出来，连同iso镜像放在某一磁盘的根目录下，为简单起见，这里都放在c盘下


## 2. 使用grub4dos引导ubuntu镜像

这里就是和win7下操作的不同之处，win7用的是easyBSD。

下载grub4dos，解压后把`grldr`和`menu.lst`拷贝到C盘根目录，此时，包括第一步，一共有以下几个文件放到了c盘根目录:

```
install.lz
vmlinz
ubuntu-xx.04-destop-i386.iso
grldr
menu.lst
```


### 编辑boot.ini

编辑`C:\boot.ini`，在文件结尾添加

```
c:\grldr="start grub4dos"
```
ps: 若在C盘根目录下找不到该文件，可以通过`文件夹选项`-`查看`-`高级设置`中，把`隐藏受保护的操作系统文件(推荐)`不勾选，然后选择`显示所有文件和文件夹`，就可以把系统隐藏文件显示出来，从而找到`boot.ini`


### 编辑menu.lst

接下来编辑`menu.lst`，以添加引导项。添加下面内容到文件结尾

```
title Install Ubuntu
root (hd0,0)
kernel (hd0,0)/vmlinuz boot=casper iso-scan/filename=/ubuntu-xx.04-desktop-i386.iso
initrd (hd0,0)/initrd.lz
```

其中

- `(hd0,0)` 一般情况下代表的是C盘，这里的`hd0`代表第一块硬盘，`0`代表第一个分区。若到时重启系统选择新增的引导项提示找不到文件时，可以重复修改该文件，直到找到正确的数字编号为止。
  
  若第一步的iso镜像等三个文件放在了其他磁盘根目录下，同理，也可通过上述方法找到正取的编号

- 若需要安装中文版本的，可在第二行结尾添加` locale=zh_CN.UTF-8`，这样子安装界面就会是中文，安装的系统也是中文环境的。


## 3. 重启电脑，引导镜像

重启电脑，开机页面会多了一项`start grub4dos`，点击后，选择`Install Ubuntu`，细心的读者会发现，这两项都是我们上面第2步填写过的title内容。iso镜像路径没有错的话，就可以成功引导镜像了。

镜像引导成功后的第一步，记得要先卸载isodevice分区

```
sudo umount -l /isodevice
```


> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)

