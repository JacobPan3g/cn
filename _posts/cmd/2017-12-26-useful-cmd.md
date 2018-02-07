---
layout: post
title: 一些有用的命令
categories: cmd
tags: shell
author: Jacob Pan
---

* content
{:toc}


## 查看当前目录下各个文件的大小

```shell
du -ah --max-depth=1
```
- `-a` 所有文件
- `-h` 人类能读懂的方式，会把数字转化成KB, MB等单位
- `--max-depth=1` 只显示1层

## date命令

```shell
date +%Y-%m-%d
```
以上命令可以输出诸如"2018-02-06"的日期，其中有更多的`%X`可参考`man date`，在所有这些格式化字符前需要有一个`+`


## 寻找命令的位置

```shell
which ls    # 返回 /bin/ls
```


> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)

