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


## 4. 重启smbd

```
# service smbd restart
# service smbd status
```
第二条命令可以查看当前smbd的运行状态。

大功告成，现在用windows文件浏览器就可以通过ip地址`\\192.168.XX.XX`访问你的linux文件了


---
> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)
