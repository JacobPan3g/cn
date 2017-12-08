---
layout: post
title:  用find同时把多个GBK文件转成UTF-8
date:   2017-09-01 15:25:01 +0800
categories: cmd
tags: shell
author: Jacob Pan
---

* content
{:toc}


通过一下命令，可以一次性把`dir/`下多个gbk文件转成utf-8文件，并放在指定目录下：

```
$ find <dir> -type d -exec mkdir -p <utf dir>/{} \;
$ find <dir> -type f -exec bash -c "iconv -f GBK -t UTF-8 {} -o <utf dir>/{}" \;
```

其中
1. 第一行命令是用来模拟`dir/`的目录结构创建一个目录树，这里创建的只有目录, 里面时没有文件的, 后半段命令的`{}`代表的是前半段`find`输出的每一行
2. 第二行命令的核心是后半段，原型是`iconv -f GBK -t UTF-8 <file> -o <out dir>`, 把`<file>`转成utf-8并放在`<out dir>`里


---
> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)

