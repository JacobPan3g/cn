---
layout: post
title: 在safari下适用css的animation
categories: css
tags: compatibility
author: Jacob Pan
date: 2018-01-29
---

* content
{:toc}

在chrome和firefox下，使用css的animation，需要先定义一个动画，然后在相应元素的css通过`animation`来适用它。如下面例子定义了一个旋转的animation

```css
@keyframes rotate
{
    from {transform:rotate(0deg);}
    to {transform:rotate(360deg);}
} 

XXX {
    animation: rotate 1s linear infinite;
}
```

然而，上面在safari浏览器却不能用，应改成

```css
@-webkit-keyframes rotate
{
    from {-webkit-transform:rotate(0deg);}
    to {-webkit-transform:rotate(360deg);}
}

XXX {
    -webkit-animation: rotate 1s linear infinite;
}
```

若要兼容两种浏览器，就把上面两个都写上，通过两种方式定义animation即可。


> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)

