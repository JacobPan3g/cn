---
layout: post
title: Cocoa Programing for Mac os X 4th笔记
categories: book
tags: mac
author: Jacob Pan
date: 2018-01-25
---

* content
{:toc}


## ch01 Cocoa: what Is It?

### Farmeworks概述

> Frameworks

这里很好地简述了cocoa里3个重要库的基本作用

- Foundation: oc相关的库
- AppKit: UI控件库，即ApplicationKit
- Core Data: 数据存储库，也叫persistence framework

### 睡眠和坚持是学好新知识的法宝

> How to Learn

这一段作者的观点很有意思，说要学好新知识有两个技巧

- 每天睡够10小时
- 不要质疑自己的智力

...


## ch02 Let's Get Started


### Xcode可创建项目的区别

> In Xcocd - Create a New Project

1. Application: 带界面的app
2. Tool: 命令行工具或daemon进程
3. Bundle: 也叫plug-in，可以在runtime动态加载
4. framework: 库，只能在compile时加载

### XIB与NIB的区别

> In Interface Builder - Lay Out the Interface - For the More Curious: XIBs and NIBs

- XIB是XML文件，用于生成NIB，XIB便于版本控制
- NIB是给APP使用的界面资源文件；NIB的缩写是NeXT Interface Builder。

### Dock下的不可见对象

> In Interface Builder - The Dock

这里提及了一下Dock下的几个不可见对象（Window，Menu之外的对象）:

- File's Owner: 在本xib是NSApplication对象，它把用户事件传递给window, ch12详细介绍
- First Responder: 一个有用的虚构对象，在ch21详细介绍

### outlets和actions

> In Interface Builder - Create a Class

- outlets: 指向其他对象实例变量，需要控制该控件的需要
- actions: 可以被UI触发的方法，用于消息输入

### Error: 样例NSTextField未定义错误

> In Interface Builder - The Dock - Create a Class

在写RandomController.h时，使用NSTextField声明变量会报错，因为NSTextField时AppKit的类，这里头文件只包含了`Foundation/Foundation.h`，因此会报错。解决方案有两个：

1. 添加`#import <AppKit/AppKit.h>`
2. 把`#import <Foundation/Foundation.h>`直接换成`#import <Cocoa/Cocoa.h>`，像AppDelegate.h一样

### outlets和actions的连线

> In Interface Builder - Make Connections

首先，需要现在xib添加一个object，在右侧制定是RandomController类

- outlets: 右击object，drag到Label
- actions: 从Button开始crtl drag到object

### oc只支持单继承

> A Look at Objective-C

与Java一样

### oc里的几个特殊类型

> A Look at Objective-C - Types and Constants in Objective-C

- id: 可指向任何对象的指针
- nil: 空对象
- BOOL: char
- YES: 1
- NO: 0
- IBOutlet: 一个空宏，让Interface Builder工具知道哪个是outlet
- IBAction: 相当于void，也是给Interface Builder知道哪个是action

### `#import`保证只包含一次

> A Look at Objective-C - Look at the Header File

### oc里的关键字以@开始

> A Look at Objective-C - Look at the Header File

@interface, @end, @implementation, @class, @selector, @protocol, @property, @synthesize

### .h与.m文件之间的切换

> A Look at Objective-C - Edit the Implementation File

有两种方法:
- Top menu - Navigate - Jump to Next Counterpart 
- 按Ctrl-Cmd-up

### oc所有方法都是public，所有变量都是protected

> A Look at Objective-C - Edit the Implementation File

### <option-单击>可以在类名或函数名调出帮助

> Documentation

### Mac App的生命周期

> Chronology of an Application

```
NSApplicationMain -> create instance of NSApplication
load NIB file -> every object is called `awakeFormNib`
Main event loop ...
call `terminate()` if quit
```

### Window Server把UI事件分配给各个APP

> Chronology of an Application

- 输入：UI事件包含Mouse和Keyboard
- 输出：屏幕的显示


## ch03 Objective-C

### oc = c预编译器 + 库

苹果用的不是gcc，而是clang/LLVM(Low Level Virtual Machine)，也是一个开源编译器

### oc的变量都是指针，除了基本type

> Creating and Using Instances

除了int, char, float等c基本变量

### 通常APP项目大写开头，命令行tool小写开头

> Using Existing Classes

### oc里很少出现对象复制

> Using Existing Classes

如NSMutableArray的`addObject:`是直接把指针添加到数组中，而不会复制对象。

### NSLog()的Format和C的printf差不多

> Using Existing Classes

具体请见`Table 3.1 Possible Tokens in Objective-C Format Strings`

### 不能直接在main.m里定义oc函数

> Using Existing Classes

oc函数要定义在以下上下文里

```
@implementation

... 

@end
```
经试验，也不能在main.h里定义其他C函数。

### NSString可以保存多字节语言

> Using Existing Classes

C String只能保存ascii码，在处理多字节语言时很不方便，如中文，而NSString可以保存Unicode，不用担心本地化问题。

### 往空对象发msg返回0

> Sending Messages to nil

官方能确定的，接受返回值的若是pointer，值为nil；若为int，值为0；其它类型不确定。

### NSObject的description在打印对象时被调用

> NSObject, NSArray, NSMutableArray,
and NSString > NSObject

在`NSLog(@"%@", ...)`和gdb中的`po`命令都会自动调用description方法。

### NSObject的isEqual:方法

> NSObject, NSArray, NSMutableArray,
and NSString > NSObject

对于对象，若没有重载isEqual:方法，以下两句相同，都是比较是否指向同一内存地址(即比较指针里的地址值)
```
a == b
[a isEqual: b]
```
NSString的isEqual:已被重载，`[str1 isEqual: str2]`比较的是字符的内容，而不是`==`的比内存地址。


## ch05 (UI)Target/Action

### 对于UI控件视角的Target和Action

对于UI控件，一个Button，Target就是与其绑定了Action的Controller，Action就是用户触发动作后发给Controller的消息，即定义在Controller的IBAction方法

发送Action给Target是NSControl类的职责，大部分UI控件都是继承与NSControl，如NSButton，NSTextField等；而NSControl的继承关系是

```
NSControl->NSView->NSResponder->NSObject
```
其中NSView负责绘制控件，NSResponder负责相应事件，NSObject提供最基础的init()等方法

ps: 在使用AppKit.framework中，一般不需要继承，直接使用就行

### NSButton, NSSlider, NSTextField控件的常用action

> Some Commonly Used Subclasses of NSControl

同时列举了一下所有UI控件。

### 直接用连线完成connection

> Lay Out the XIB File

打开Assistance Editor，用ctrl-drag从IB的控件往.h文件拉可以直接生成IBOutlet和IBAction代码

ps: 此处添加代码发现没有`-init`函数，就直接添加到`applicationDidFinishLaunching:`，效果是一样的

### property变量会自动生成`_名字`的私有变量

> Lay Out the XIB File

同时会生成相应的getter和setter。

### 设定Windwo打开时第一个相应控件

> Lay Out the XIB File > NSWindow’s initialFirstResponder Outlet

ctrl-click点击(相当于右击)IB里dock的Window对象，把弹出列表中的initialFirstResponder链接到想要第一个相应的控件即可。

### 用代码创建action

> For the More Curious: Setting the Target Programmatically

目前提及到设置控件的Action都是通过连线实现的，也可以通过以代码实现，这一节介绍了编译前的做法，和runtime的做法，几点笔记：

1. `SEL`代表函数，可以理解成函数指针
2. `@selector(function_name)`与`NSSelectorFromString(@"function_name")`的区别: 前者其实是一个宏，在编译时会自动替换成相应的函数，后者是在runtime时候寻找函数的

### xcode调试程序的帮手Dignostics

> Debugging Hints

这一节让我最深刻的是调试程序crash的方法，可以通过Product-Scheme-Edit Scheme，在左侧选择"Run"，在上面标签选择"Dignostics"，里面有一些调试选择可以帮助定位bug

### document-based app可以多开

> Challenge

非document-based app只能打开一个，在xcode创建项目时可以选定这个选项


## ch06 Helper Objects

### Delegates就是一个接口？

> Delegates

这里的delegate，其实就是帮某一个对象去完成一些事情，要成为delegates，主要有3步

1. 在.h文件什么实现某个delegate
2. 在.m文件实现delegate里的方法
3. 把自身self传入那个对象的setDelegate()函数中

感觉就像时配置以下处理函数的感觉，这个不能通过函数指针直接配置进那个对象吗?


### NSTableView例子书上缺少的步骤与收获

缺少的步骤：
1. 在选中TableView设置为1列时，TableView的title还是两列，需要手动把title中间的分割线拉到右侧
2. 在.m文件实现Delegate函数时，需要先在.m文件声明自己是TableView的DataSource和Delegate，添加`<NSTableViewDataSource, NSTableViewDelegate>` (可以不做)

收获：
1. 设置delegate和dataSource时，也可以直接在IB通过连线实现，通过该方式连接Delegate就不用在delegate的.h文件声明遵守这个delegate的protocol（即上面第二步可以不做）
2. 几个函数的执行顺序：init() - awakeFromNib() - applicationDidFinishLaunching()；如何把初始化Tableview的数据源`_voice`放到了applicationDidFinishLaunching()里做，需要再加一句`[_tableView reloadData]`才能把数据再列表中展现出来，而若放在前二者里就不需要。

### Delegate就是NSTableView的outlet

> Edit SpeakLineAppDelegate.m > Common Errors in Implementing a Delegate

即IBOutlet NSTextField和Controller之间也是一种Delegate关系，NSTextField遵守某种Delegate，Controller可以通过调用Delegate里的方法，这些方法可以用来输出或输入。


## 08 NSArrayController

### NSDocument主要负责文件读写

> Starting the RaiseMan Application

Document-based程序工程会自动创建NSDocument子类

### 引入Cocoa.h与Foundation.h的区别

> Starting the RaiseMan Application

`#import <Cocoa/Cocoa.h>`和`#import<Foundation/Foundation.h>`是有区别的，前者是包含MacOS所有库，包括GUI和oc；而后者只是oc的库。

所以一些Model类，无需知道UI细节的，应该只包含Foundation.h，这样就能方便移植到命令行项目或ios项目

### 绑定NSArrayController的Content Array

> Starting the RaiseMan Application - RMDocument.xib

在RaiseMan Demo中，通过下面binging动作，NSArrayController的增删查改就能直接操作到Document.h定义的employees数组中:

在xib文件中，添加NSArrayController对象后都dock后，

1. 在右侧窗口选择"Attributes Inspector"，在下面Object Controller填入每一项的类名：Person，并填入Person的两个成员变量到keys中，这里主要得益于oc可以通过Key-Value Coding来直接设置成员变量(ps: 需要把成员变量设成property)
2. 在右侧窗口选择"Bindings Inspector"，设置Content Arry为File's Owner的employees(ps: employees是定义在Document.h的一个NSMutableArray对象)
3. 把add和remove按钮直接分别connect到Dock中NSArrayController对象中已经实现的add:和remove:方法

根据以上步骤，NSArrayController只存在于xib文件中，无需在代码中定义。

### 通过Bindings为NSTableView Cell绑定显示内容

> Starting the RaiseMan Application - RMDocument.xib

在RaiseMan Demo中，通过Binding可以在xib中借助NSArrayController指定NSTableView Cell的显示内容:

1. 选择第一列TableView Column，在Bind to选择Array Controller，并勾选；在Controller Key填入arrangedObjects，在Model Key Path填入personName(ps: 要显示的Person成员变量名)

2. 同理，第二列Column也是在Binding设置与第一步同样的内容，只是Model Key Path填入另一个成员变量名expectedRaise皆可

这样TableView就会通过NSArrayController获取内容并显示出来。

### 为TableView Cell添加Number Formatter

> Starting the RaiseMan Application - RMDocument.xib

添加了Number Formatter后，在用户输入时会检查格式。

Number Formatter是在Xcode 6.2是一个'#'的标识，注意与Text Fieldwith Number Formatter的区分，后者是一个Text Field。

### 重载setNilValueForKey:来处理输入空内容异常

> Starting the RaiseMan Application - Key-Value Coding and nil

RaiseMan Demo中，当输入Raise为空时，因无法转换成float，会抛出以下异常并crash：

```
RaiseMan[1983:303] Exception detected while handling key input.
RaiseMan[1983:303] [<Person 0x60000003b260> setNilValueForKey]: could not set nil as the value for the key expectedRaise.
```
从异常信息中也可以看到是setNilValueForKey:抛出的异常，setNilValueForKey:是NSObject定义的函数，通过定义Person类中该方法可以处理该异常，具体重载内容请见书中代码。

## 34 Concurrency

### NSTableView的DataSource

> Multithreading > Simple Cocoa Background Threads

在TableView的DataSouce里，填充的数组不能是

```
@property (weak) NSArray *results;
```
而需要定义成私有变量，这样才能让TableView加载成功。

还有，发现DataSouce的`tableView:objectValueForTableColumn:row`会被调用很多次，这是为何呢？

### BgThread Demo的补充

> Multithreading > Simple Cocoa Background Threads

对于Backgrond Thread，书里没有给出完整的Demo，我根据书忠的代码，写了一个完整的Demo，其中数据源的result需要定义成私有变量，如上一条笔记所说。


## 36 NSTask

### 开发文档base应用

> ZIPspector

创建Document-Based Application需要制定后缀，首先在project创建页面需要输入后缀，然后在Targget-Info-Document Types中需要选定角色"Viewer/Editor"和填入UTI到identifier处。

测试时run了之后，需要"在menu打开文档"，或者"在文档右击－使用该App打开"才能调试。

### 设置TableViewCell为不可编辑

> ZIPspector

在IB设置UI控件属性需要先选中，在右边的Attribute Inspector的第一行可以看到当前所选择的控件。

先选中TableViewCell，在Inspector第一行显示为"Table Column"，在最下面有一栏state就可以看到。

要改变Cloumn的大小，选中Cloumn后，多点击几次，知道出现边界有一个小方格，就可以通过拖动小方格来调整大小。

### NSTableView显示数据只需要DataSource

> ZIPspector

原来NSTableView显示数据只需要把其它类指定为DataSource，而不需要指定Delegate，只有当需要对用户选中Item时响应才需要指定后者。

### NSTableView条目数正常内容不正常

> ZIPspector

当dataSource对象里使用`tableView:objectValueForTableColumn:row:`提供内容时，一定要记得把TableView设定成Cell Base，而不是View Base，不然内容会无法填充。

### Toggle类型Button

> ZIPspector - iPing

原来这种点击一下就变成另外一些内容的按钮时Toggle Button，如看视频的开始暂停按钮，在Inspector把type改为Toggle，填入alternate内容，把State改成Off即可。

### 基于NIB开发的框架图例说明

> ZIPspector - iPing - Figure 36.8 Object Diagram

这里提供了一种思路用来画MacOS基于NIB或者Storyboard开发的程序的框架画法，因为很多connection在IB里完成，代码里根本看不到，所以这种图例用来阐述程序的逻辑非常有用。

### NSPipe和NSFileHandle

> ZIPspector - iPing

NSPipe是用来接收NSTask的stdout:

```
NSPipe *pipe = [[NSPipe alloc] init];
[task setStandardOutput:pipe];
```
NSFileHandle是NSPipe对象返回的一个对象:

```
NSFileHandle *fh = [pipe fileHandleForReading];
```
可以用来读取NSPipe里面的数据，有两种读法：

1. 一种是一次性全部读完，如在ZIPspector例子中

   ```
   [task waitUntilExit];
   NSData *data = [[pipe fileHandleForReading] readDataToEndOfFile];
   ```
   这种方法需要等task执行完成后才能确保data被全部读出来。

2. 另一种是task每往pipe写一次就读一次，需要借助NSNotification

   ```
   NSFileHandle *fh = [pipe fileHandleForReading];
   NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
   [nc removeObserver:self];
   [nc addObserver:self selector:@selector(dataReady:)
              name:NSFileHandleReadCompletionNotification object:fh];

   [task launch];
   [fh readInBackgroundAndNotify];
   ```
   其中`[fh readInBackgroundAndNotify]`是去读fileHandle，读完后产生`NSFileHandleReadCompletionNotification`，这个函数是一次性的，因此在绑定notification的`dataReay:`方法需要再次调用fh的readInBackgroundAndNotify。

### Task的NSTaskDidTerminateNotification

> ZIPspector - iPing

iPing例子中用到了两个Notification，第一个是NSFileHandleReadCompletionNotification，当fileHandle的readInBackgroundAndNotify方法读完后发布。

另外一个是Task的NSTaskDidTerminateNotification，当task完成后会发布，利用这个可以在task完成后获取task的执行状态或者做另外一些动作。

### Task的返回状态

> ZIPspector

```
int status = [task terminationStatus];
if (status != 0) {
    ...
}
```

通过上述方法可以获取task的返回状态，ZIPspector例子还进一步使用了返回Error的方法

### 用NSTextStorage拼接字符串

> ZIPspector - iPing

在iPing例子中，直接使用NSTextView的NSTextStorage对象，把从pipe通过NSFileHandle读到的数据直接添加到结尾：

```
NSString *s = [[NSString alloc] initWithData:d encoding:NSUTF8StringEncoding];
NSTextStorage *ts = [outputView textStorage];
[ts replaceCharactersInRange:NSMakeRange([ts length], 0) withString:s];
```
第一行是从NSData转换成NSString，第三行使用替代函数替代NSRange范围的字符，这里的NSRange是指向数据末尾的，且长度为0，即直接把字符添加到原内容的结尾。


> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)

