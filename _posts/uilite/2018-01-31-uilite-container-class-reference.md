---
layout: post
title: UILite.Container Class Reference
categories: UILite
tags: uilite reference
author: Jacob Pan
date: 2018-01-31
---

* content
{:toc}


## 构造函数

```js
Container({mContent: mParent: })
```

构造函数的参数与UILite.Object类一致，mContent可以是js数组对象

```js
[
    new UILite.File(),
    <div>hello</div>
]
```


## 公共变量

### mtBody

Container对象用于插入新dom的位置。

### maoContainees

用于储存Container对象成员的数组


## 公共函数

### waiting(isWait)

把当前对象设置成等待状态，会在dom加上`uil_waiting`类，可通过css做相应的处理。

### add(content)

往`maoContainees`添加内容，被保存前若不是UILite对象，会先创建成UILite.Object再保存。


## 使用示例

这是一个虚类，一般不用于创建实例，而用于继承，如Window，Form，Gallery，Tab等都是继承Contianer类的。


> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)

