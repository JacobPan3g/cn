---
layout: post
title:  Linux使用svn
date:   2017-10-07 18:15:01 +0800
categories: cmd
tags: svn
author: Jacob Pan
---

* content
{:toc}


## 安装svn

Ubuntu下

```
# apt-get install subversion
```


## 修改commit默认编辑器

```
# update-alternatives --config editor
```

会出现下面选项供选择：

```
There are 4 choices for the alternative editor (providing /usr/bin/editor).

  Selection    Path                Priority   Status
------------------------------------------------------------
  0            /bin/nano            40        auto mode
  1            /bin/ed             -100       manual mode
  2            /bin/nano            40        manual mode
* 3            /usr/bin/vim.basic   30        manual mode
  4            /usr/bin/vim.tiny    10        manual mode

Press <enter> to keep the current choice[*], or type selection number: 
```

选择自己想要的编辑器，再按回车便可。


### 通过配置文件修改

也可以通过svn配置文件`~/.subversion/config`修改默认编辑器，找到`editor-cmd`注释的位置，新增一行`editor-cmd=vim`


## 添加so文件

默认情况下so文件是不提交的，在配置文件`~/.subversion/config`找到`global-ignores`，把注释去掉，同时把里面的`*.so *.so.[0-9]*`去掉。

这样就可以通过svn命令查看，添加，提交so文件了。


---
> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)
