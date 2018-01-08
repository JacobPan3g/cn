---
layout: post
title: 跑wifi无线吞吐量
categories: cmd
tags: wireless
author: Jacob Pan
---

* content
{:toc}


先搭建好拓扑


## 协商速率

sta连上后，一定要先留意一下无线网卡的协商速率，只有这个正常后，才能开始跑速率


## chariot

使用chariot跑速率的话，需要安装endpoint，linux下也有endpoint


## iperf

iperf是一个命令行测速工具，在windows，linux，iphone，android都有支持，嵌入式设备也能通过源码编译进去

```shell
iperf -s -p 5000
iperf -p 5000 -c 192.168.0.xx -P 10 -t 3600
```


> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)

