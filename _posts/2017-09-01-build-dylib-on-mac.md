---
layout: post
title:  Mac下编译dylib库
date:   2017-09-01 16:21:01 +0800
categories: mac
tag: dylib
author: Jacob Pan
---

* content
{:toc}

Mac下的dylib库，其实就是Linux下的动态库`*.so`，下面分享一下在mac下面如何编译动态库, 用一个简单的例子说明，首先，创建一下目录结构：
```
.
├── libfoo.h
├── libfoo.c
└── main.c
```

```c
// libfoo.h
#ifndef __LIBFOO_H__
#define __LIBFOO_H__
void lib_function();
#endif
```

```c
// libfoo.c
#include <stdio.h>
void lib_function() {
    printf("dylib hello world\n");
}
```

```c
// main.c
#include "libfoo.h"
int main() {
    lib_function();
    return 0;
}
```

使用一下命令，把`libfoo.dylib`编译出来
```
gcc -dynamiclib foo.c -o libfoo.dylib
```

然后尝试用`main.c`调用这个dylib
```
gcc main.c -L. -lfoo -o main
./main
```

若整个过程没有报错，并有以下打印，就说明这个dylib编译成功。
```
dylib hello world
```

---
> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)
