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


## 1. 安装svn

Ubuntu下

```
# apt-get install subversion
```


## 2. 修改commit默认编辑器

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


---
> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)
