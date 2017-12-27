---
layout: post
title:  Linux使用samba实现与Windows文件共享--最简单的方法
date:   2017-10-07 16:20:01 +0800
categories: linux
tags: config
author: Jacob Pan
---

* content
{:toc}


## 1. 下载samba

Ubuntu下

```
# apt-get install samba
```

## 2. 修改配置文件

备份原来的配置文件

```
# mv /etc/samba/smb.conf /etc/samba/smb.conf.backup
# touch /etc/samba/smb.conf
```

将一下内容写进新建的配置文件中

```
[global]
   security = user

[jsamba]
   path = /home/jacob
   valid users = jacob
   writeable = yes
   public = yes
```

其中，`jacob`是我的用户名，这里你改成自己的用户名。


## 3. 添加smb用户

```
# smbpasswd -a jacob
```
同理，这里的`jacob`改成你自己的用户，必须要和上述配置的`valid users`那一项里的内容相一致

```
# smbpasswd -x jacob
```
通过这条命令可以删除用户，更多的选项可见`smbpasswd -h`


## 4. 重启smbd

```
# service smbd restart
# service smbd status
```
第二条命令可以查看当前smbd的运行状态。

大功告成，现在用windows文件浏览器就可以通过ip地址`\\192.168.XX.XX`访问你的linux文件了


## 问题及解决方法

### win无法访问

在lubuntu 14.04下发现用windows登录不上，linux下使用smbclient能登录上

在windows输入ip地址登录不上，提示“\XXX\XXX is not accessible. You might not have permission to use this network resource.”，在linux使用smbclient

```shell
smbclient -L 192.168.0.xx       # 列出共享文件夹
smbclient \\192.168.0.xx\xxx    # 访问文件夹
```
链接成功后，就可以使用`ls`，`cd`等命令访问共享文件夹了。

查看samba的log，在`/var/log/samba/log.smbd`，发现有下面错误提示

```
Bad talloc magic value - access after free
```
安装一下libtalloc2，重启smbd就能解决

```
sudo apt-get install libtalloc2
```


---
> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)
