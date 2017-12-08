---
layout: post
title:  在Ubuntu使用wireshark抓无线数据包
date:   2017-10-07 16:44:01 +0800
categories: ubuntu
tags: wireless
author: Jacob Pan
---

* content
{:toc}


众所周知，在windowns下使用wireshark只能抓取有线数据包，要抓无线数据包只能用Omnipeek；而在Linux下，我们可以直接使用wireshark来抓取无线数据包


## 1. 安装wireshark

```
# apt-get install wireshark-qt
```

在安装指引弹出的对话框中，问`是否允许非管理员用户用wireshark抓包`，可以选`否`。


## 2. 设置无线网卡为混杂模式

```
# iwconfig wlan0 down
# iwconfig wlan0 mode monitor
# iwconfig wlan0 up
```

其中`wlan0`是无线网卡的名字，不同PC可能会不一样，可以通过`iwconfig`查看。


## 3. 设置要抓包的无线信道

```
# iwconfig wlan0 channel 6
```

最后，就可以打开wireshark开始抓包了，后面的操作和windowns下一样，选定网卡，设置过滤条件... Enjoy it.


## 4. 解决lua加载错误

若打开wireshark后，老是会弹出`Lua:Error during loading`对话框，可以通过以下方法解决：

使用管理员权限编辑文件`/usr/share/wireshark/init.lua`，把倒数第二行改成：

```
--dofile(DATA_DIR.."console.lua") 
```

这样就不会再弹出错误对话框了。


---
> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)
