---
layout: post
title: jekyll基本
categories: blog
tags: jekyll
author: Jacob Pan
---

* content
{:toc}


## get started

使用jekyll创建blog，建议在ubuntu下面搭建，因为十分方便，直接使用

```
# apt-get install jekyll
```
就可以安装好了，而不用想在其他平台下，先安装ruby，然后才能安装jekyll这么繁琐。

然后直接在github上或者jekyll官网上下载一个自己喜欢的blog模块，在根目录执行

```
$ jekyll serve
```
就可以在浏览器通过`127.0.0.1:4000`访问本地的blog了


## 为文章添加图片

可以在blog根目录下创建一个img文件，把图片放在里面，然后在文章中使用路径`/img/xxx.png`就可以访问到该图片的。


## 局域网访问

若使用`jekyll serve`启动，只能在本机浏览器访问blog，而局域网内其他PC访问不了

```
jekyll serve -H 0.0.0.0
```
通过上述命令启动，就可以在局域网内其他PC通过当前IP地址来访问访问blog了；若需要改变端口，可使用-P选项。


> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)

