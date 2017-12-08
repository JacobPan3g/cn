---
layout: post
title: 一行log宏：c语言debug跟踪小利器
categories: c
tags: debug log
author: Jacob Pan
---

* content
{:toc}


昨天在跟踪busybox中一个后台进程源码的启动问题时，由于不确定输出有没有被重定向，为了快速解决问题，信手拈来写了一个一样的log宏，放在源码中一些关键的位置，跟踪源码的走向非常有用，且高效，一下子就找到问题症结所在了。

```c
#include <stdio.h>
#include <stdlib.h>

#define LOG_LINE() do{char a[99]={0};snprintf(a,sizeof(a),"echo %d > /dev/console",__LINE__);system(a);}while(0)
```

然后在一下想要跟踪的关键位置使用

```
LOG_LINE()
```
编译运行程序，就可以根据打印的行号来跟踪问题出在哪里了，可以在`echo`后面添加一些容易识别的标识，以方便在众多log中一眼认出。

该宏短小精炼，问题跟踪解决后清理代码也很方便。


> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)

