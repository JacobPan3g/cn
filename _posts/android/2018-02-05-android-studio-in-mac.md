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

#### 1. 直接用真机调试

打开真机的USB调试，有些机型需要在设置里的系统版本号点击4次开启"开发者选项"，里面才有USB调试的开启按钮。把真机连接PC，在编译App后在Connected Device下选中该设备进行调试。

#### 2. 使用Genymotion调试

Genymotion是一款很快的android虚拟机，下载安装后，在Settings - ADB下，选择"Use custom Android SDK tools"并填入sdk路径，该路径可以在AS的Preferences - Apperarance & Behavior - System Settings - Android SDK下看到。

然后开启Genymotion虚拟机，编译项目时就可以在Connected Device下选择该虚拟设备调试了。Genymotion是x86而不是arm框架的，很多应用安装不了，会提示不兼容。

可以通过Genymotion-ARM-Translation把x86转换成arm框架，这个在网上可以下载

1. 针对4.x的安卓版本

   打开Genymotion后，直接把Genymotion-ARM-Translation_v1.1.zip直接拉进虚拟机，重启。

2. 针对5.x的安卓版本

   打开Genymotion后，把ARM_Translation_Lollipop.zip拉进去，然后使用adb输入命令:

   ```
   adb shell /system/etc/houdini_patcher.sh
   ```
   再重启虚拟机。

#### 3. 使用夜神模拟器
 夜神模拟器有win版和mac版的，时arm框架的，使用起来也十分流畅，一些大型游戏和应用都能安装成功，运行起来也很流畅。

和真机一样，在setting里打开"USB调试"，然后用sdk的adb通过以下命令连接该虚拟机

```
adb connect 127.0.0.1:62001
```
就可以通过`adb devices`就可以看到这个设备了。

至于这个`62001`端口，可以通过以下命令获取

```
lsof -i tcp:62001
```
通过上面命令可以看到，占有该端口的进程是`VBoxHeadl`，通过下面命令可以在不知道端口时用来查询端口

```
lsof -i tcp | grep VBoxHeadl
```
但是若有多个VBoxHeadl进程，就难以辨别哪个时夜神模拟器的。

通过上面的connect之后，就可以用夜神模拟器来调试App了。

ps: 夜神模拟器里也包含adb，mac版在`Nox App Player.app/Contents/MacOS/`下，win版在`C:\Users\XXX\AppData\Roaming\Nox\bin`下。


> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)

