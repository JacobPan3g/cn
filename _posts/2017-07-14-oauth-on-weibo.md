---
layout: post
title:  新浪微博的OAuth2认证过程
date:   2017-07-13 15:31:01 +0800
categories: other
tag: weibo
---

* content
{:toc}


## 1. 创建应用

在weibo.com上申请一个应用，获取app key和app secret, 填写redirect uri

## 2. 获取code

通过在浏览器访问
```
https://api.weibo.com/oauth2/authorize?client_id=xxxxx&redirect_uri=http%3A%2F%2Fwww.weibo.com&response_type=code&forcelogin=true
```

其中`client_id`和`redirect_uri`是必须的，`client_id`是app key，
`redirect_uri`是回调地址，都必须和应用所配置的相一致.
我这里的`redirect_uri`填了`http://www.weibo.com`

在页面中填入登录的新浪微博账号和密码，按确定后便会跳转到
`http://www.weibo.com?code=xxxxxxxxxx`，这里的参数`code`就是我们所需的

## 3. 获取access token

这个过程需要通过post，可以利用工具`curl`来模拟post请求
```
curl -d "client_id=xxx&client_secret=xxx&grant_type=authorization_code&redirect_uri=http%3A%2F%2Fwww.weibo.com&code=xxxxx" "https://api.weibo.com/oauth2/access_token"
```

其中，`client_secret`是app secret，`code`是上一步获取到的.

这一步的返回如下:
`{"access_token":"xxxx", ...}`
这就是我们所需的access token.

(ps: 若是用curl模拟get，直接 curl "http://abc.com?p1=a&p2=b")

## 4. 使用access token调用微博api的各个接口

这里用"获取自己所发微博"举例，在浏览器打开
```
https://api.weibo.com/2/statuses/user_timeline.json?access_token=xxxx
```
并使用浏览器的调试工具查看返回结果，会自动对json进行格式化

---

以上就是如何使用浏览器模拟微博的oauth2认证过程，省去使用sdk，可以直接用
在我们的应用中，但是，有一个小问题我想不明白，第二步获取的code必须是通过
回调uri的参数处获得，不知道各sdk里是如何获取到这个code的？
