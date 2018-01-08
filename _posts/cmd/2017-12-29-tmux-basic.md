---
layout: post
title: tmux使用技巧
categories: cmd
tags: tmux
author: Jacob Pan
---

* content
{:toc}


tmux是一个强大的终端分屏工具


## 新建会话

```shell
tmux new -s <session name>
```
建议给每一个会会话命名，这样日后切换会话时更加方便。


## 切换会话

当建立了多个会话后，可以实时切换到不同的tmux会话中，每个会话的命令执行记录都会被保存下来

```shell
tmux ls
tmux a -t <name>    # attach
```
上述方法是在shell命令行里切换，若原先在一个tmux会话中，可以先使用`<tmux_prefix + d>`与原会话分离(detach)

还有一个方法，可以从一个tmux会话中直接切换到另一个会话中

```
<tmux_prefix + s>   # 列出会话列表后直接通过方向键选择
```

ps: `<tmux_prefix>`是在tmux会话中要执行指令时的前缀，默认是`<ctrl b>`，同时按下ctrl和b按键


## 重命名

```
<tmux_profix>$      # 重命名session
<tmux_profix>,      # 重命名plane
```

更多请见[Tmux 入门介绍](http://blog.csdn.net/skykingf/article/details/46345057)


> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)

