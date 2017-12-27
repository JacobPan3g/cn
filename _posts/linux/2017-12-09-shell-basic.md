---
layout: post
title: shell基本
categories: linux
tags: shell
author: Jacob Pan
---

* content
{:toc}


## 判断 []

注意`[]`内一定要两边留有空格，不然会报错，如

```shell
[! -f test.sh]      # error
[ ! -f test.sh ]
```

一些常用的option如下：

文件

- -f 判断文件是否存在(不包括目录)
- -L 判断文件是否为链接文件
- -d 判断是否为目录
- -r 判断是否可读
- -w 判断是否可写
- -x 判断是否可执行

逻辑

- -a 与
- -o 或
- ! 非


## for循环

```shell
arr = "1 2 3"
for item in $arr
do
    echo $item
done
```


## 函数定义

```shell
func()
{
    echo $1
}

func "hello world"
```


## 参数

shell脚本参数可以通过`$0, $1, $2, ...`读取，其中`$0`是脚本自己的名字，还有一些特殊参数

- `$#` 参数的个数
- `$@` 参数的内容
- `$*` 参数的内容，但若是包在括号里`"$*"`传入另一个函数，会被当做1整个字符串；而`"$@"`会被当做多个参数(与没引号的`$@`,`$*`一致)

可以通过下面arg.sh脚本验证：

```shell
arg()
{
    echo $#
}

# arg.sh aaa bbb ccc 
arg $@      # 3
arg $*      # 3
arg "$@"    # 3
arg "$*"    # 1
```


## getopts

getopts用来处理参数中的option的，使用实例如下：

```shell
while getopts "ac:h" opt
do
    case $opt in
        h) echo "hlep";;
        a) echo "all";;
        c) echo "create $OPTARG";;
        ?) echo "invalid option";;
    esac
    shift
done
#shift $(($OPTIND - 1)) 
```

上述例子主要是识别参数中的`-a -c -h`选项，其中，`-c`后面需跟参数，在代码中该参数保存在$OPTARG。注意，每次swich完记得要`shift`，也可以在循环外面shift，如最后一行注释部分。

(ps: shell的case不需要加break，末尾的`;;`就有break的作用；另外，`;&`表示无条件继续，`;;&`表示有条件继续，这两个特性在`$BASH_VERSION=4.1.x`以上的版本才支持)


> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)

