---
layout: post
title:  Ubuntu下如何映射端口
date:   2017-08-31 15:31:01 +0800
categories: ubuntu
tag: config
---

* content
{:toc}


若PC上有两张网卡，需要把网卡A的网络共享到网卡B的局域网中，类似路由器wan口到lan口的映射。在windows下十分简单，直接在`网络中心`中打开网卡A的共享功能就行，而若在`Ubuntu`中，需要一下命令：
```
# sysctl net.ipv4.ip_forward=1
# iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
```
其中，eth1是网卡A的ifname

以上是在`Ubuntu 16.04`的做法，在`Ubuntu 12.04`，可以直接
```
# echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
```

---
> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)
