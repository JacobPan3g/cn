---
layout: post
title: Mac开发：使用WebView打开html文件
categories: mac
tags: macOS
author: Jacob Pan
date: 2018-01-29
---

* content
{:toc}


通过WebView，Mac App可以利用PC本地的Safari浏览器内核来加载html文件，里的js也可以和oc代码交互，通过这种方式可以直接适用前端技术来开发Mac App界面。


## 往项目加入前端文件

把前端文件以一整个文件夹拖进xcode项目，在弹出的对话框选择"Create folder references"，在"Add to targets"处勾选target，点击"Add"按钮，添加后，xcode左边的工程目录如下图，其中ui目录就是前端文件目录:

```
HelloWebView
├── HelloWebView
│   ├── HelloWebViewController.h
│   ├── HelloWebViewController.m
│   ├── AppDelegate.h
│   ├── AppDelegate.m
│   ├── Image.xcassets
│   ├── MainMenuxib
│   ├── ui
│   │   ├── css
│   │   ├── js
│   │   └── demo
│   │       └── index.html
│   └── Supporting Files
└── Products
```

通过这种方式添加进来的前端文件可以保持完整的层次结构，调用目录关系不会变。若通过"Create groups"来添加文件夹，所有文件其实都在项目根目录下，这样就会出现文件找不到的错误。

通过上述方式添加进来的前端文件，在最后打包App时会一起打包进去。


## 使用WebView展示html文件

1. 在相应的NIB文件添加WebView，根据需要调整大小
2. 在相应的Controller.h添加WebView成员，并与NIB中WebView对像相连，还要添加头文件

   ```
   ...
   #import <WebKit/WebKit.h>
   @interface XXX: XXX {
       ...
   }
   @property (weak) IBOutlet WebView *webview;
   ```
3. 在相应的Contriller.m中的`awakeFromNib()`添加以下逻辑(ps: 没有该函数可以自行定义):

   ```
   - (void)awakeFromNib
   {
       NSString* path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"ui/demo"];
       NSURL* url = [NSURL fileURLWithPath:path];
       NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
       [[self.webview  mainFrame ] loadRequest:request];
   }
   
   ``` 
   注意：
   - 上述第3行是指定前端入口恩见index.html的路径，本例子该文件是放在`ui/demo/index.html`
   - 项目的根目录指的是与xxx.xcodeproj平行的以target为名字的目录，而不是xxx.xcodeproj所在的目录


## 添加Webkit库

在项目Target的"Build Phases" - "Link Binary With Libraries"中添加WebKit.framwork

然后编译运动，就能看到用前端代码事件的UI了，注意，若发现页面展示与预期效果不太一致，可以先在本机的safari上把html页面调通，再放在WebView上运行，因为WebView适用的就是safari的浏览器内核来加载html页面的。


> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)

