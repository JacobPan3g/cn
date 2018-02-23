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


## 在Xcode工程项目里签名

下载并安装好相关证书，在Xcode里签名有以下步骤

### 1. 添加icon

在Navigation窗口打开项目文件`Image.xcassets`，就会看到AppIcon的配置，把不同大小的八张图片拉进去，编译即可。

ps: 关于如何制作这8种不同大小的icon，下面有一小节专门说明。

### 2. 设置Build Setting

在Navigation窗口点击最上面的项目名字，在PROJECT或者TARGETS栏设置Build Setting － Code Signing (ps: 前者是全局的，后者是针对单个Target的)

－ 先在Provisioning选择相应的provision，provision文件也分"Mac应用商店发布"和"开发者ID发布"两种，均需要在Apple开发者账号里申请，证书安装好后会自动下载到Mac中

- 然后在Code Signing Identity选择开发团队码，若Provision选对了，这里有且只有一个选项

完成上面两步后，尝试编译项目(ps: 这里需要连接外网)，若APP没有提示错误，并能成功运行，说明Debug版本签名成功

### 3. 导出签名后的发布版本

完成上面配置后，点击顶层菜单Project - Archive，在弹出的窗口先点击"Validate..."来验证一下发布APP是否签名成功，若成功会提示

```
Validation Successful
Your app successfully passed all validation checks.
```

然后点击"Export..."，选择相应路径导出即可。


## 制作icns图标


## 签名分类


> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)

