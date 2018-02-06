---
layout: post
title: 在Mac下搭建Android开发环境
categories: android
tags: config
author: Jacob Pan
date: 2018-02-05
---

* content
{:toc}


## 安装JDK

在java官网下载jdk8，下载地址是[http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)，下载后完成安装，在命令行输入下述命令

```
java -version
```
输出版本号"java version"和"Java SE Runtime Environment"即说明安装成功。


## 安装Android Studio

在官网下载Android Studio(下文简称AS)，在本文编写时是3.0版，下载地址是[http://www.android-studio.org](http://www.android-studio.org)，下载的是一个dmg包，直接把App拉到Application下即可。


## 配置Android Studio

打开AS，会弹出"Android Studio First Run"窗口，点击"Cancel"

接下来会弹出"Android Studio Setup Wizard"窗口，在"Install Type"步骤中选中"Custom"，按需要选中下载部件，建议按默认的来就行，这里的"Android Virtual Device"可以不选(下文会解释)，点击"Next"，下一步点击"Finish"。AS就开始下载部件，整个下载过程都比较顺利，等了大约30分钟完成，没有出现某些部件无法下载的情况。


## 问题及解法

### 创建Empty Project后编译，出现提示"android-26"没有下载

完整的错误提示是"Gradle sync failed: Failed to find target with hash string 'android-26'"

这里提示的不是SDK platform 26，而是Build Tools revision 26.0.2，直接点击错误提示下面的链接完成下载即可。

### Mac下无法打开AVD

编译完成后想用android虚拟设备(AVD)调试，提示"intel HAXM is required to run this AVD. Unknown Error"

经查实，intel HAXM已经安装，目前还没有找到解决方法，决定绕开这个问题，不使用AVD调试程序，这就是为什么上文AS配置时我不选择安装android虚拟设备的原因，解决方案有两个：

1. 直接用真机调试

   打开真机的USB调试，有些机型需要在设置里的系统版本号点击4次开启"开发者选项"，里面才有USB调试的开启按钮。把真机连接PC，在编译App后在Connected Device下选中该设备进行调试。

2. 使用Genymotion调试

   Genymotion是一款很快的android虚拟机，下载安装后，在Settings - ADB下，选择"Use custom Android SDK tools"并填入sdk路径，该路径可以在AS的Preferences - Apperarance & Behavior - System Settings - Android SDK下看到。

   然后开启Genymotion虚拟机，编译项目时就可以在Connected Device下选择该虚拟设备调试了。


> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)

