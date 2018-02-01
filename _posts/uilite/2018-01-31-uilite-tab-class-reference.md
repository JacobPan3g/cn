---
layout: post
title: UILite.Tab Class Reference
categories: UILite
tags: uilite reference
author: Jacob Pan
date: 2018-01-31
---

* content
{:toc}


## 构造函数

```js
Tab({mContent: mParent: })
```

构造函数的参数与UILite.Object类一致，其中，mContent的html可以是以下格式：

```html
<span>tab1</span>
<span>tab2</span>
<span>tab3</span>
<div><span class="UILFile"></span></div>
<div>Tab view</div>
<div>Html argument</div>
```
> ps: 上述的传入html或者dom对象，以及dom对象的解析暂未实现，因为这个从dom转换成UIL对象涉及到嵌套解析，这个逻辑比较复杂且容易出错。

另外，mContent还可以是一个js对象

```js
{
    tab1: new UILite.File(),
    tab2: <p>Hello</p>
}
```

## 公共变量

### matTabs

页面上的tab dom数组


## 公共函数

### getCurTab()

获取当前显示页面的tab。

### setCurTab(tab)

显示指定tab对应的页面。

切换时，先会保存tab再`matTabs`的下标，然后把其它tab的页面隐藏，把指定tab的页面显示出来。

### add(aContent, aTab)

重载了UILite.Container.add(aContent)，主要用来添加tab。

添加的tab会转换成dom对象，并加入`matTabs`数组中，aContent是UILite.Object子类的话就直接添加到`maoContainer`数组中，不是的话会将其生成UILite.Object对象再放进数组中。


## 使用示例

### 创建实例

```js
var myTab = new UILite.Tab();
myTab.add(new UILite.File(), "tab1");
myTab.add("<p>Hello</p>", "tab1");

myTab.setParent(document.body);
myTab.show();
```
创建Tab对象后，通过`add()`添加tab，并把自己的dom添加到body标签。

### 构造函数完成所有初始化

```js
var myTab = new UILite.Tab({
    mContent: {
        tab1: new UILite.File(),
        tab2: "<p>Hello</p>",
    },
    mParent: document.body,
});

myTab.show();
```
直接通过构造函数添加tab和设置parent，其他与上例一样。

### 获取和设置tab

```js
var lastTab = myTab.getCurTab();
myTab.setCurTab("tab2");
```


> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)

