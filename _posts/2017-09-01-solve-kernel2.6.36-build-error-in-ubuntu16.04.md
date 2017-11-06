---
layout: post
title:  Ubuntu16.04下编译Linux2.6.36的kernel出现timeconst.h错误的解决方法
date:   2017-09-01 14:09:00 +0800
categories: ubuntu
tags: kernel
---

* content
{:toc}


最近发现在Ubuntu16.04下编译Linux 2.6.36的内核会出现一下错误

```
Can't use 'defined(@array)' (Maybe you should just omit the defined()?) at kernel/timeconst.pl line 373.
/linux-2.6.36/kernel/Makefile:137: recipe for target 'kernel/timeconst.h' failed
make[3]: *** [kernel/timeconst.h] Error 255
/tmp/GmGWZPad:953: recipe for target 'kernel' failed
```

根据上述提示，直接把内核源码中`./kernel/timeconst.pl`第373行的if条件中的`defined(@val)`改成`@val`，再次编译就可通过了.


---
> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)
