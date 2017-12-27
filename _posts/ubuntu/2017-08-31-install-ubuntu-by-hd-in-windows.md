---
layout: post
title:  Windows7下如何硬盘安装Ubuntu
date:   2017-08-31 16:31:01 +0800
categories: ubuntu
tags: install
author: Jacob Pan
---

* content
{:toc}


一般来说，折腾双系统是每一位程序猿都有过的经历，如何在windows7下安装双系统ubuntu呢？今天来给大家介绍一下如何直接在windows7硬盘安装ubuntu，而不需要使用U盘或者光盘，或外置硬盘。


## 1. 准备好ubuntu iso镜像

可以直接在官网上找，下载后在windows下使用解压软件找到iso里的`initrd.lz`和`vmlinuz.efi`(ps:若是安装32位的ubuntu，第二个文件是`vmlinuz`，而没有后缀`.efi`), 一般会在iso根目录下的`casper`里。

把上诉两个文件和镜像本身放在windows任意一个磁盘的根目录下，我这里以f盘为例。


## 2. 使用EasyBCD引导ubuntu镜像

在windows下安装EasyBCD，我现在用的是2.2版本的。完成后打开EasyBCD，在左边选择`添加新条目`, 然后选择`NeoGrub`标签，点击`安装`，此时EasyBCD会自己创建一个引导，很快，不用几秒钟。接着点击旁边的`配置`, 在弹出的编辑器中加入一下指令：

```
title Install Ubuntu
root (hd0,7)
kernel (hd0,7)/vmlinuz.eft boot=casper iso-scan/filename=/ubuntu.iso ro quiet splash locale=zh_CN.UTF-8
initrd (hd0,7)/initrd.lz
```

其中，有几个地方需要注意一下：
1. 第2，3，4行都出现了的`(hd0,7)`是代表第一步准备的镜像和文件所在的磁盘, 在windows下, c盘是`(hd0,1)`, d盘是`(hd0,5)`, e盘是`(hd0,6)`, f盘是`(hd0,7)`, 依此类推，第一步中我把镜像以及相关文件都放在了f盘，因此我这里是`(hd0,7)`, 大家可根据自己第一步选择的磁盘修改，再次重申一下，无论放在哪个盘，都要放在该磁盘的根目录下
2. 第3行开头处有一个`vmlinuz.eft`, 这个就是我们第一步所准备的其中一个文件的名字，如果安装的是32位ubuntu，这个文件名字是`vmlinuz`, 这里也要做相应的修改
3. 第3行中间处的`filename=/ubuntu.iso`, 斜杠后面的是ubuntu镜像的名字,这里也可以根据自己要安装镜像的名字来自定义。

好了，添加上述指令后，保存，关闭。


## 3. 重启电脑，引导镜像

重启电脑，留意开机界面，会发现多了一个`NeoGrub`选项，选中它，就可以进入ubuntu的安装镜像了. (ps: 如果本来已经双系统，开机时选择启动windows,然后在windows启动页面再选择`NeoGrub`引导ubuntu镜像)。

在开始安装之前，还有最后一步十分重要的别忘了做 —— "卸载`isodevice`分区"
```
# umount -l /isodevice
```
若没有卸载iso分区，安装过程会报错的，这一步也是硬盘安装所独有的，大家一定别忘了这一步。这个分区的名字可以通过`$ mount | grep isodevice`来查看。

---

以上步骤我曾经成功在windows 8下安装Ubuntu 12.04和16.04，也尝试过用来安装Centos 6.4, 故理论上上述步骤可以用来windows下硬盘安装一般的linux系统。

后面就可以根据自己的喜好分区，安装ubuntu了，Enjoy yourself！


> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)

