---
layout: post
title: Makefile笔记
categories: linux
tags: makefile
author: Jacob Pan
---

* content
{:toc}


Makefile主要用来make的输入，命令`make filename`的意思就是要把filename生成。


## 基本

```makefile
target: dependences
	shell cmd
```
以上是Makefile的基本格式。


## targets: %:

通过`%`可以对target进行模式拓展

```makefile
targets = aa bb

targets: %: %.c
	gcc -o $@ $^
```

这里会自动拓展成

```makefile
aa: aa.c
	gcc -o aa aa.c

bb: bb.c
	gcc -o bb bb.c
```


## 自动变量

如上面的例子，`$@`代表target，`$^`代表全部的依赖文件，还有以下自动变量:

- `$<` 依赖文件中的第一个文件


## 参数

通过make可以传递参数，在Makefile里可以获取到

```makefile
aa: aa.c
	gcc $(CFLAG) -o $@ $^
```
通过`make CFLAG=-g`，就可以把参数传入到makefile中，变成`gcc -g -o aa aa.c`


## ifeq, ifdef

```makefile
ifdef VAR
target = aa
else
target = bb
endif

ifeq ($(VAR), 1)
CFLAG = -g
endif

target:
	gcc $(CFLAG) -o $@ $^
```
上述例子描述了`ifdef`和`ifeq`的用法，请注意`ifdef`后面跟的变量名加`$()`，此外，还有`ifndef`和`ifneq`。

这里的makefile可以通过`make VAR=1`传入参数，使makefile针对不同情况执行不同的命令。


## 常用函数

### subst

```
$(subst <from>,<to>,<text>)
```

### addsuffix, addprefix

```
$(addsuffix <suffix>,<names...>)
$(addprefix <suffix>,<names...>)
```

更多makefile函数可见[makefile中常用函数](http://blog.csdn.net/yangxuan0261/article/details/52060582)


## 引用其他makefile

如果当前目录下有一个`makefile.in`，可以通过下面语句来引入

```
include makefile.in
```

## 警告和错误信息

```
$(warning ...)      // 打印warning信息
$(error ...)        // 打印error信息，并立马退出make
```


> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)

