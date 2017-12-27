---
layout: post
title: Linux下使用git
categories: cmd
tags: git
author: Jacob Pan
---

* content
{:toc}


Git是一款分布式版本控制软件，相比Svn，我更喜欢git分布式的特性。


## 常用命令

```shell
git init
git add
git commit
git pull
git push
git remote
```


## 配置

通过配置可以让git更加个性化，而且更加好用，git的配置文件在`~/.gitconfig`, 以下是我的配置

```
[core]
    editor = vim
    excludesfile = /home/jacob/.gitconf/gitignore
[color]
    ui = true
[merge]
    tool = vimdiff
[user]
    name = YOUR_NAME
    email = EMAIL@email.com
[push]
    default = matching
```

- `core.editor` 设置commit时的编辑器
- `core.excludesfile` 设置全局gitignore文件
- `color.ui` 使`git status`时的输出结果有颜色
- `merge.tool` merge时使用的工具
- `user.name`和`user.email` 用户名字和邮箱，commit时需要记录用户信息，email用来区分由该次提交的作者

以上可以通过编辑配置文件配置，也可以通过命令，如若配置`user.email`

```
git config --global user.email "you@example.com"
```
运行改命令后就会在`~/.gitconfig`中生成相应的项。其中的`--global`代表配置级别：

- `--system` 更加高级的配置，这个是PC下所有用户都生效的配置，配置时需要管理员权限
- `--global` 用户Home的全局配置，只对当前用户生效，这种级别使用得最多
- `--local` 项目相关的配置，配置文件放在项目根目录下的`.git/config`


## git命令自动补全

一些老版本git没有命令自动补全，可以在git源码(ps: 可以在github上找到)找到`git-completion.bash`，在每次开机时`source git-completion.bash`即可。


## 创建本地bare仓库

git里的bare仓库相当于svn中的服务器，可用于提交。其实，bare仓库就是我们项目中的`.git/`，事实上，每一个git仓库抽取出来的`.git/`都可以成为用于提交的bare仓库

```
git init --bare xxx.git
```
以上命令用来创建一个bare仓库，创建成功后，通过下面命令提交了

```
git remote add XXX 192.168.0.XX:path/to/xxx.git
git push XXX master
```


> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)

