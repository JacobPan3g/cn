---
layout: post
title: Ubuntu下的一些使用技巧
categories: ubuntu
tags: tips
author: Jacob Pan
---

* content
{:toc}


## 把Home中文目录名改成英文

```shell
export LANG=en_US
xdg-user-dirs-gtk-update
```
弹出对话框勾选`不再提醒`，点`确定`


## 开启sshd

```
sudo apt-get install openssh-server
```
安装了即可


> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)

