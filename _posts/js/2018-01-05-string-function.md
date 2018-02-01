---
layout: post
title: js字符串处理函数
categories: js
tags: string
author: Jacob Pan
---

* content
{:toc}


## 替换

```js
var str = "/path/to/file.js";
str.replace(/file.js$/, "other.js");
// "/path/to/other.js"
```

## 提取字符串

```js
var str = "/path/to/file.js";
var idx = str.search(/file.js$/);
str.slice(0, idx);
// "/path/to/"
```

## trim实现

```js
function trim(s) {
    return s.replace(/(^\s*)|(\s*$)/g, "");
}
trim("  aaa   ");
// "aaa"
```

更多请见[JavaScript String 对象](http://www.w3school.com.cn/jsref/jsref_obj_string.asp)。

> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)

