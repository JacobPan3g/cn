---
layout: post
title: 在Busybox 1.19.4中启用syslogd
categories: cmd
tags: log
author: Jacob Pan
---

* content
{:toc}


syslog是linux下内置的一种log工具，十分实用。实现了log到文件，log到内存，循环打印log，log优先级，开发程序过程借助其来定位bug非常方便，比单纯的`printf()`强大多了，特别对于输出被重定向的后台进程。

这里我会采用busybox 1.19.4的syslog来示范，由于这个版本是专门给嵌入式设备使用的，因此有一些功能被精简掉了，如syslog.conf，该版本不支持配置文件，所有配置都在启动syslogd守护进程时通过参数输入。


## 启动syslogd守护进程

要使用syslog需要启动一个后台进程syslogd，可以通过多种方式打印log

- log到文件里
  
  ```
  syslogd -O /tmp/syslog.log
  ```
  请注意这个log文件会随着log增加而越来越大，需要和logrorate的配合来控制log文件的大小，对于没有logrorate的嵌入式设备，有可能被占据所有空间，因此不太推荐

- log到内存

  ```
  syslogd -C4
  ```
  这样可以通过制定特定大小的内存来保存log，存满了会自动把最旧的那一条删去，通过`logread`可以把log读取出来。比较推荐这种方式，一则可以制定固定大小的内存(单位是kb，`-C4`代表为log预留4kb的缓存空间)，不用担心把所有内存耗掉，二则通过`logread`可以实时观测log(下文会介绍`logread`的使用)

- log到服务器，这个需要和局域网内的log服务器配合使用，具体本文先不涉及


## log 优先级

log一共有8个不同优先级，方便在不同场景下的过滤显示：

* emerg 0 系统不可用
* alert 1 必须马上采取行动的事件
* crit 2 关键的事件
* err 3 错误事件
* warning 4 警告事件
* notice 5 普通但重要的事件
* info 6 有用的信息
* debug 7 调试信息

一般情况下，用得最多的是err，notice，info，debug这四种信息，在release版本，info和debug信息不会被打印。其中err和debug信息不言而喻，根据个人的经验，notice和info消息的区别是：

- notice消息：一些重要模块的启动退出信息，如"wifi模块的启动"，"ledsch模块的启动"
- info消息：一些模块内部的信息，一些定时信息，如"nrd模块每1min的扫描信道"，"某一表项的老化"，这些消息不适合打印到release版本中，因为这些信息随着时间增多的幅度较大，很容易把全部log缓存空间填满，从而冲刷了旧log，因此放在info信息中

设置syslogd打印log过滤可以在启动守护进程时通过选项`-l N`设置, N的范围是1-8

```
syslogd -C4 -l 6
```
上述命令只答应notice或以上(<6)的信息，这是release时的设置，一旦设置后就不能修改，因此，当开发或debug时可重启syslogd守护进程，通过`-l 8`把所有的log都打印。

ps: 更多的syslogd参数可参看`syslogd -h`


## logread

守护进程通过`syslogd -C4`启动后，可以通过logread读取log

```
logread
logread -f
```

1. 第一条命令是读取缓存空间中的log
2. 第二条命令是循环读出log，实时打印


## syslog的C接口

在程序中，可以通过一下接口使用syslog

```c
#include <syslog.h>

void openlog(const char *ident, int option, int facility);
void syslog(int priority, const char *format, ...);
void closelog(void);

void vsyslog(int priority, const char *format, va_list ap);
```

其中，`syslog()`第二个参数就是log的内容，而第一个参数`priority`就是上述的八个优先级，对应下面的8个宏：

```
LOG_EMERG
LOG_ALERT
LOG_CRIT
LOG_ERR
LOG_WARNING
LOG_NOTICE
LOG_INFO
LOG_DEBUG
```

还有，`openlog()`中第一个参数`ident`一般传入进程名作为log标识，而第二、三个参数一般会使用`LOD_PID`和`LOD_USER`，具体可以通过`man openlog`查看。


## 实例

```c
#include <syslog.h>

int main()
{
	openlog("log_test",LOG_PID,LOG_USER);
	syslog(LOG_INFO,"PID information, pid=%d\n",getpid());
	syslog(LOG_DEBUG,"debug message");
	closelog();

	return 0;
}
```

编译运行后，通过logread就可以看到以下的log

```
Dec  8 15:23:42 jpei user.info log_test[6741]: PID information, pid=6741
Dec  8 15:23:42 jpei user.debug log_test[6741]: debug message
```


## logger - syslog的shell接口

logger是syslog提供的shell工具，通过logger可以设置优先级，进程名，把log打印到缓存区中，与通过C接口的log一样，可以通过logread读取出来，具体可以参看`logger -h`。


## 开启Busybox 1.19.4中的syslogd踩过的坑

- syslogd守护进程无法启动

  在busybox源码添加打印，经分析，原来是syslogd守护进程的PID路径问题，源码中默认PID路径是`/var/run/syslogd.pid`，在我开发的嵌入式设备中文件系统是只读的，只有`/tmp`可写，把PID路径改成`/tmp/syslogd.pid`就syslogd就可以运行了。


> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)

