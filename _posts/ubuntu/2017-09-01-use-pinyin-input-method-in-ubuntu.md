---
layout: post
title:  在Ubuntu下使用拼音输入法
date:   2017-09-01 12:54:01 +0800
categories: ubuntu
tags: config
author: Jacob Pan
---

* content
{:toc}


安装ubuntu时，如果不是安装中文版，是默认没有中文输入法的，因为安装中文版的话，home下的各个目录都是中文的，这样用起来比较别扭，我还是比较偏向于安装英文版，然后再把中文输入法手动安装就可以了.


## 1. 安装中文语言

"Setting" -- "Language Support", 此时会提示“语言支持没有完整安装”, 这个可以不用管，可以直接点"Remind Me Later", 接着在对话框中间点击"Install/Remove Languages...", 在弹出对话框中找到"Chinese(simplified)"并勾选，点击"Apply"，等待安装完成，logout当前用户。


## 2. 配置拼音输入法

重新登录后打开“Setting” -- “Language Support”，在`Keyboard input method system`中选择`fcitx`, 然后再logout当前用户

重新登录系统后，桌面右上角的小键盘的就会变成一个小企鹅，代表fcitx启动成功了。点击小企鹅，选择“ConfigureFcitx”，在“Input Method”标签中点击右下角的“+”, 找到“Pinyin”或者“Sunpinyin”，点击"OK”按钮，这样子你就可以通过右上角的小键盘处选择拼音输入法了，亦可以通过`<ctrl>+<space>`或`<shift>`进行中英文的切换, enjoy it!


## 3. sogou输入法安装

现在在ubuntu也可以安装sogou输入法了，sogou官网有提供deb安装包，直接下载下来使用`# dpkg -i sogou.deb`就可以安装了.

由于sogou输入法依赖于fcitx，如果安装过程报错可以先安装fcitx, 通过命令`# apt-get install fcitx`即可。可以通过`$ dpkg -l | grep fcitx`查看系统是否已安装fcitx。

我觉得ubuntu内置的中文输入法也够用了，这里大家可以根据自己的喜好自行选择哈。

---
> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)

