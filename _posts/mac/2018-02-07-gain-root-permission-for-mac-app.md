---
layout: post
subtitle: 2018-02-07-gain-root-permission-for-mac-app
title: MacOS App代码提权
categories: mac
tags: root
author: Jacob Pan
date: 2018-02-07
---

* content
{:toc}


在MacOS App开发中，有一些操作需要管理员权限，需要弹出认证对话框让用户输入账号和密码，这个过程就是MacOS App提权的过程，主要有下面几种方式：


## 1. AuthorizationExecuteWithPrivileges()

使用这个接口最有代表的库是[STPrivilegedTask](https://github.com/sveinbjornt/STPrivilegedTask)，这是一个封装得很好得App提权库，接口与NSTask十分像，使用起来十分方便。

可惜得是AuthorizationExecuteWithPrivileges()接口在MacOS 10.7开始deprecated，据说在10.12的版本该接口就关闭了。

因此，若要兼容10.12以后的MacOS版本，就不得不放弃使用STPrivilegedTask库了。


## 2. 使用ServiceManagement.framework注册LaunchdDaemon

这是Apple官方目前推荐的提权方式，官方有一个SMJobBless的Demo，是用来有点复杂，具体请见另一篇文档"SMJobBless官方Demo笔记"

该方法有一个几个小缺点：

- 弹出认证对话框的提示内容是"需要Install Helper"，而且每次打开都是这样的提示，对于小白用户来说，会不会误导用户App老是在安装什么东西？
- LaunchdDaemon及其配置文件是需要安装到`/Library`下的，当用户把App卸载后会不会存在"残留问题"？


## 3. 使用AppleScript

```
do shell script "..." with administrator privileges
```
省略号部分填入shell脚本，任何可执行文件都需要写全路径，如`/bin/ls`。

以上是AppleScript脚本，通过这种方式提权有以下有点：

- 比上述"注册LaunchdDaemon"方法实现起来简单很多
- 同时也不用担心卸载残留的问题，因为全部东西都在.app里

AppleScript脚本在objective-c中有两种执行方式：

- 通过NSTask执行"/usr/bin/osascript -e \"do shell ...\""
- 通过NSAppleScript执行

方法1有两个缺点：

- `do shell script`会在所有shell执行完成后再把所有stdout返回，因此当启动的是Daemon进程，就算使用NSTask的fileHandle Notification，也无法把stdout分次读取出来。

- 这种方法的认证窗口提示信息是"osascript wants to make changes."，对于小白用户来说会不会有一种这样的感觉"我明明安装的是XXX.app，怎么来了一个osascript让我输入账号密码？会不会是恶意程序？"

而使用NSAppleScript方法时，认证窗口的提示信息是"APP_NAME wants to make changes."，感觉这样的提示更加友好。但也有一些缺点:

- NSAppleScript执行Daemon进程的话会直到Daemon退出才退出，即会一直占用线程

  解法：建议在子线程使用NSAppleScript，以免UI无法响应

- 也存在stdout只能等待Daemon退出才全部打印的问题


> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)

