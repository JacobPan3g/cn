---
layout: post
title: Windows下搭建qt开放环境
categories: windows
tags: qt
author: Jacob Pan
---

* content
{:toc}

Qt是一个跨平台的GUI库，接口用C++呈现，支持Windows，Linux，Mac，据说还支持Android，若开发桌面应用需要考虑支持跨平台，Qt是一个不错的解决方案。


## 可供选择的方案

需要在windows下搭建qt开发环境，有以下几种选择:
1. 使用qt的visual studio插件，直接在vs中开发qt应用
2. 使用qt提供的qtCreator设计界面，用visual studio里的编译器，此处需要下载vs的qt包`qt-opensource-windows-x86-msvc201x-x.x.x`
3. 使用qt提供的qtCreator设计界面，用MinGw编译应用，需要下载MinGw的qt包`qt-win-opensource-x.x.x-mingw.exe`

我比较偏向选择方案2，因为qtCreator本身就是用qt实现的IDE，用其来设计qt应用更加有qt的感觉，同时，熟悉了qtCreator后，以后转到Linux或Mac开发qt程序，也可以继续使用qtCreator。而编译器方面，在windows下开发，个人比较推荐还是用微软提供的visual studio里的编译工具，而方案3的MinGw编译器是一套windows下的gcc，若你更加偏向于gcc，也可以采用方案3。

qt包的下载地址是：[download.qt.io](http://download.qt.io)
我采用vs2013作为编译器，选用qt5.6，因此下载的qt包是: `qt-opensource-windows-x86-msvc2013-5.6.3.exe`

ps: qt5.9是长期支持版本，不过比较大，要2G，大家可以选择按需选择


## 安装qt包

在安装qt包之前，需要先在PC安装好visual studio，再安装qt包，安装完成后会自带qtCreator，并且会自动检测当前系统下所有qt版本与编译器版本，在“Tool” - “Options” - “Build & Run”页面可以查看到，如下如：

![Build & Run][buildRun]

同理，在同页面下的"Compilers"标签里可以看到本系统所安装的编译器。

若这已安装的qt版本和比那一起，但这两个页面里没有出现，可以通过右边的`Add`来添加。

![Compilers][compilers]

ps: 这里需要提一下“Kits”标签页，这个是可以自定义"qt版本+编译器"组合，即当你系统安装多个不同qt版本或不同的编译器，可以通过kits设置你需要的组合，用来编译qt应用。


## Hello World

环境搭好后，新建一个qt工程，“File” - “New File or Project”， 点击“Choose”按钮，输入工程名字并选好路径，点击“Next”，这里就可以选择相应的kits(ps:第二节的ps提到)，然后一路点击"Next"按钮，新工程建立完成。

点击左下角的三角形编译运行，弹出一个空白的窗口，就证明qt环境搭建成功。

![Example][example]

## 资料

### 《QtCreator快速入门》
入门：看完这个就可以基本了解如何使用QT开发GUI程序，完成入门

### 《C++ GUI Qt4编程(第二版)》
进阶：不过这个是基于Qt4的，与Qt5有一定的差距，网上有《C++ GUI Qt5 编程》的英文版，有需要的话可以找来看看。由于Qt5比较新，目前大部分资料都是Qt4的



> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)

[buildRun]: https://jacobpan3g.github.io/img/qt-in-windows-buildRun.png
[compilers]: https://jacobpan3g.github.io/img/qt-compilers.png
[example]: https://jacobpan3g.github.io/img/qt-example.png
