# WSProgressHUD

`WSProgressHUD` 

![progress](http://upload-images.jianshu.io/upload_images/1870793-7b83044258a1399e.gif?imageMogr2/auto-orient/strip)

# 使用
一行代码添加，进度条走完以后会调用一个闭包将进度条的key传回，没有后续操作可无视
```Swift
        WSProgressHUD.showPieProgress(view: view,
                                      hudKey: "key",
                                      progress: CGFloat(progress)) { (hudKey) in
                                      print("key为 \(hudKey) 的进度条已结束")
        }
```
