---
layout: post
title: Ubuntu的一个wifi启动错误
categories: ubuntu
tags: wireless
author: Jacob Pan
---

* content
{:toc}


在使用`ifconfiig`启动wlan时，提示错误`SIOCSIFFLAGS: Operation not possible due to RF-kill`，因为rfkill把wifi设备给block了。

通过下面命令可以查看

```
rfkill list
```

通过下面命令可以unblock无线设备

```
sudo rfkill unblock wifi
```

这样就可以启动wlan了。


> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)

