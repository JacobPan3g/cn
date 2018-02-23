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


## Animation

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


## Transition

Transition也是动画的一种，可以指定某一个属性变化。

```css
div {
    width: 100px;
    transition: width 2s linear;
    -webkit-transition: width 2s linear;
}
div:hover {
    width: 300px;
}
```

其中，`-webkit-transition`是为了兼容safari。


## Transform

Transform是转换，有以下一系列的动作:

```
matrix
translate
scale
rotate
skew
perspective
```

结合transition可以实现很多动画，如

```css
div {
    transition: transform 0.5s linear;
    -webkit-transition: -webkit-transform 0.5s linear;
}
div:hover {
    transform: translate(79px, 0);
    -webkit-transform: translate(79px, 0);
}
```
以上代码可以让div在hover状态向右逐渐位移79px。


> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)

