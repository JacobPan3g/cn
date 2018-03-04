---
layout: post
title: SMJobBless官方Demo笔记
subtitle: 2018-02-07-smbjobbless-demo-note
categories: mac
tags: note
author: Jacob Pan
date: 2018-02-07
---

* content
{:toc}


SMJobBless是苹果官方提供的用于“MacOS app获取root权限”的demo。


## 具体思路

使用Security.framework和ServiceManagement.framework两个库，把需要root权限的操作封装成一个进程，作为项目的子Target，把该子进程注册LaunchdDaemon。

成为LaunchdDaemon后：
- 子进程会被放在`/Library/PrivilegedHelperTools`
- 相应的配置文件`.plist`被放在`/Library/LaunchDaemons`，Launchd加载该子进程会需要读取该配置文件

更多介绍请见"参考资料1"


## 编译SMJobBless

从官网下载SMJobBless源码(下面"参考资料3"也有链接)，具体操作Demo里的ReadMe.txt也讲述得比较清楚，只是由于新版本Xcode的编译产物不再放在项目目录里，所以ReadMe.txt里有一些步骤的路径要做一些调整

1. 在xcode先编译项目

2. 用终端进入项目根目录，运行下面命令

   ```shell
   ./SMJobBlessUtil.py setreq <path-to-SMJobBlessApp.app> SMJobBlessApp/SMJobBlessApp-Info.plist SMJobBlessHelper/SMJobBlessHelper-Info.plist
   ```
   其中`<path-to-SMJobBlessApp.app>`可以在xcode左边的Navigator的product下的编译产物APP"右击-Show in Finder"的到编译产物的路径。

   脚本运行成功后会输出
   ```
   SMJobBlessApp/SMJobBlessApp-Info.plist: updated
   SMJobBlessHelper/SMJobBlessHelper-Info.plist: updated
   ```

3. 在Xcode对项目Clean，然后再Build

4. 终端在项目根目录下执行

   ```shell
   ./SMJobBlessUtil.py check <path-to-SMJobBlessApp.app>
   ```
   没有输出任何东西即说明check通过。

5. Run编译产物APP，会弹出输入账号密码的认证窗口，提示要"Install Helper"；输入密码后，若Xcode打印出"Job is available!"的log，已经App的UI上有"The Helper Tool is available!"，即说明Demo成功运行。

   
## 参考资料

1. [通过ServiceManagement注册LaunchdDaemon](http://blog.csdn.net/suhuaiqiang_janlay/article/details/71374287)

2. [Apple官方论坛关于如何编译SMJobBless的解析](https://forums.developer.apple.com/thread/30309)

3. [Apple官方Demo: SMJobBless](https://developer.apple.com/library/content/samplecode/SMJobBless/Introduction/Intro.html)

4. [Apple官方Demo: EvenBetterAuthorizationSample](https://developer.apple.com/library/content/samplecode/EvenBetterAuthorizationSample/Introduction/Intro.html)

   这个是SMJobBless进一步的Demo，结合Sand-box的特性。

5. [StackOverflow: AuthorizationExecuteWithPrivileges is deprecated
](https://stackoverflow.com/questions/9134841/writing-a-privileged-helper-tool-with-smjobbless)

6. [StackOverflow: Writing a privileged helper tool with SMJobBless()](https://stackoverflow.com/questions/9134841/writing-a-privileged-helper-tool-with-smjobbless)

7. [Apple官方文档: Authorization Services Programming Guide
](https://developer.apple.com/library/content/documentation/Security/Conceptual/authorization_concepts/)

> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)

