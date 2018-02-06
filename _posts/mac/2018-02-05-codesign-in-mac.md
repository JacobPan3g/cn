---
layout: post
title: Mac下软件签名笔记
categories: mac
tags: codesign
author: Jacob Pan
date: 2018-02-05
---

* content
{:toc}


## 验证签名

```
codesign -v -d XXX.app
spctl -v -a XXX.app
```
- 第一条用来检测是否已签名
- 第二条用来检测是否能通过GateKeeper

ps: 以上两条命令都可以对app或者命令行可执行文件进行检测，使用`-vvv`替代`-v`可看到更多信息。


## 对macOS命令行工程签名

对macOS命令好工具的工程签名，不需要制定Bundle identity(即com.xxx.xxx)和provisioning profile，只需要填写Code Signing Identity(证书)即可。

若输入了provisioning profile签名，run时会提示"error: ::posix_spawnp (...) err = Permission denied (0x0000000d)"错误


## 使用命令行进行签名

```
codesign -f -s "XXX" -v "XXX.app" --deep
```
其中`-s`后面跟的时证书


> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)

