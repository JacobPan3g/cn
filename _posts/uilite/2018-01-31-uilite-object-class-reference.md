---
layout: post
title: UILite.Object Class Reference
categories: UILite
tags: uilite reference
author: Jacob Pan
date: 2018-01-31
---

* content
{:toc}


## 构造函数

```js
Gallery({mContent: mParent: })
```

构造函数的参数与UILite.Object类一致，mContent可以是js数组对象

```js
[
    new UILite.File(),
    <div>hello</div>
]
```


## 公共变量

### mtBtnNext

页面Next按钮的Dom对象

### mtBtnPre

页面Pre按钮的Dom对象


## 公共函数

### getCurIdx()

获取当前显示页面的idx

### setCurIdx(idx)

显示指定idx的页面


## 使用示例

### 创建实例

```js
var myGallery = new UILite.Gallery();
myGallery.add(new UILite.File());
myGallery.add("<div>hello</div>");
myGallery.add(new UILite.Object("<div>world</div>"));

myGallery.setParent(document.body);
myGallery.show();
```

`add()`继承与UILite.Container。

### 构造函数完成所有初始化

```js
var myGallery = new UILite.Gallery({
    mContent: [
        new UILite.File(),
        "<div>hello</div>",
        new UILite.Object("<div>world</div>"),
    ],
    mParent: document.body,
});

myGallery.show();
```

### 获取和设置idx

```js
var idx = myGallery.getCurIdx();
myGallery.setCurIdx(2);
```

> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)

