---
layout: post
title:  Mac下修改系统默认Xcode
date:   2017-09-01 10:22:01 +0800
categories: mac
tag: xcode
author: Jacob Pan
---

* content
{:toc}

查看当前系统默认xcode
```
$ xcode-select -p
```

切换系统默认xcode
```
# xcode-select -switch /Applications/Xcode.app
```

当在mac下同时安装多个xcode时，第二个xcode会以`xcode 2`来命名，系统会自动把新安装的xcode 2作为默认xcode，由于名字存在空格，在编译一些软件时会存在一些问题。

例如我之前编译`libnet`时，根据项目的`BUILD-FROM-GIT.txt`开始编译过程, 由于我的默认xcode的名字时`xcode 2`, 从而引发了一下错误:
```
/bin/sh: /Applications/Xcode: No such file or directory
```

后来我用上述命令把"系统默认xcode"切换成xcode(名字不含` 2`的)，才能通过编译.


---
> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)
