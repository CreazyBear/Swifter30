#### 环境

xcode：8.3.3
模拟器：iPhone 7
系统：iOS 10

#### 新建项目

`xcode -> File -> new -> Target -> iMessage Extension`

#### 处理警告

新创建的项目，还啥也没做就一堆警告，尴尬。一共三个

##### 警告一

```
objc[55816]: Class PLBuildVersion is implemented in both /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/System/Library/PrivateFrameworks/PhotoLibraryServices.framework/PhotoLibraryServices (0x124fcb6f0) and /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/System/Library/PrivateFrameworks/AssetsLibraryServices.framework/AssetsLibraryServices (0x124b59cc0). One of the two will be used. Which one is undefined.
```

这个告警的字面意思就是说PLBuildVersion这个类在`AssetsLibraryServices.framework`和`PhotoLibraryServices.framework`中都定义了。一般好像不会有问题，但根据stackoverflow上的描述，有人崩在这里了。so，警告是无法解决了，但别人提出了一个防止崩溃的方法，如下图：

![TuNiuApp-Info.plist Xcode, 今天 at 下午6.55.06](/var/folders/8n/ctvwj_6s1t30nx2sms_tpgmr0000gn/T/ro.nextwave.Snappy/ro.nextwave.Snappy/TuNiuApp-Info.plist Xcode, 今天 at 下午6.55.06.png)

其实不用加这么多，重点是添加权限描述。

##### 警告二

```
2017-08-03 18:34:47.005 iMessageExtension[55816:2564570] Failed to inherit CoreMedia permissions from 55814: (null)
```

问题原因：I have no idear

解决方法：I have no idear

##### 警告三

```
2017-08-03 18:34:47.096382+0800 iMessageExtension[55816:2564531] [App] if we're in the real pre-commit handler we can't actually add any new fences due to CA restriction
2017-08-03 18:34:47.102420+0800 iMessageExtension[55816:2564531] [App] if we're in the real pre-commit handler we can't actually add any new fences due to CA restriction
```

无法解决问题的解决方法：如下图，将NSExtensionPrincipalClass添加上info.plist->NSExtension中就好了。此时NSExtension中就同时指定了NSExtensionPrincipalClass和NSExtensionMainStoryboard。对于我的环境而言，警告的确是没有了。这里有一个问题，那就是图中标识的1和2不能共存，共存之后，UI界面无法改变~！所以需要删除第2项。尴尬，iMessage感觉好鸡肋。

![Info.plist Xcode, 今天 at 下午6.39.12](/var/folders/8n/ctvwj_6s1t30nx2sms_tpgmr0000gn/T/ro.nextwave.Snappy/ro.nextwave.Snappy/Info.plist Xcode, 今天 at 下午6.39.12.png)



新建的项目，什么也没干就冒出来三个警告，还都无能为力~！WTF



#### 修改配置项，使用纯代码开发

创建完extension后，默认使用sb进行UI开发，通过修改info.plist来修改，如下图。

![Info.plist Xcode, 今天 at 下午4.45.32](/var/folders/8n/ctvwj_6s1t30nx2sms_tpgmr0000gn/T/ro.nextwave.Snappy/ro.nextwave.Snappy/Info.plist Xcode, 今天 at 下午4.45.32.png)



![Info.plist Xcode, 今天 at 下午4.44.57](/var/folders/8n/ctvwj_6s1t30nx2sms_tpgmr0000gn/T/ro.nextwave.Snappy/ro.nextwave.Snappy/Info.plist Xcode, 今天 at 下午4.44.57.png)



iMessage extension中没有`appdelegate`，但有一个类似的：`MSMessagesAppViewController`。我们新建一个`BGMessagesViewController`继承这个类。

在解决警告时我提到过一个问题：添加`NSExtensionPrincipalClass`同时删除`NSExtensionMainStoryboard`时，会存在问题。

下图是修改后的`NSExtension`

![Info.plist Xcode, 今天 at 下午7.44.12](/var/folders/8n/ctvwj_6s1t30nx2sms_tpgmr0000gn/T/ro.nextwave.Snappy/ro.nextwave.Snappy/Info.plist Xcode, 今天 at 下午7.44.12.png)

*问题描述*：如果创建Extension时，选择的语言是swfit，那么这样做会崩溃。

```
 *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '*** setObjectForKey: object cannot be nil (key: C97B1A7E-F753-45D5-8F54-CF7DA2D23FF5)'
*** First throw call stack:
(
	0   CoreFoundation                      0x000000010c924b0b __exceptionPreprocess + 171
	1   libobjc.A.dylib                     0x0000000108a40141 objc_exception_throw + 48
	2   CoreFoundation                      0x000000010c83f682 -[__NSDictionaryM setObject:forKey:] + 1042
	3   Foundation                          0x0000000108749d5e -[_NSExtensionContextVendor _setPrincipalObject:forUUID:] + 106
	4   Foundation                          0x00000001087492ff __105-[_NSExtensionContextVendor _beginRequestWithExtensionItems:listenerEndpoint:withContextUUID:completion:]_block_invoke + 804
	5   libdispatch.dylib                   0x000000010d910585 _dispatch_call_block_and_release + 12
	6   libdispatch.dylib                   0x000000010d931792 _dispatch_client_callout + 8
	7   libdispatch.dylib                   0x000000010d917237 _dispatch_queue_serial_drain + 1022
	8   libdispatch.dylib                   0x000000010d91798f _dispatch_queue_invoke + 1053
	9   libdispatch.dylib                   0x000000010d917d31 _dispatch_queue_override_invoke + 374
	10  libdispatch.dylib                   0x000000010d919899 _dispatch_root_queue_drain + 813
	11  libdispatch.dylib                   0x000000010d91950d _dispatch_worker_thread3 + 113
	12  libsystem_pthread.dylib             0x000000010dcc55a2 _pthread_wqthread + 1299
	13  libsystem_pthread.dylib             0x000000010dcc507d start_wqthread + 13
)
libc++abi.dylib: terminating with uncaught exception of type NSException
```

*问题分析：*主要原因是因为swfit新的特性：module。可以看下面的例子：

swift项目

```
(lldb) po self
<iMessageDemo.ViewController: 0x7f89d0508ad0>
```

oc项目

```
(lldb) po self
<ViewController: 0x7fdf86e04330>

```

可以看到，对于swift项目，在查找一个类的时候需要知道类所在的module。所以上面的crash是因为找到不对应的类文件。

解决方案：根据上述分析，在设置类的时候，我们把module加上就好了。如下图

![Info.plist Xcode, 今天 at 下午8.04.21](/var/folders/8n/ctvwj_6s1t30nx2sms_tpgmr0000gn/T/ro.nextwave.Snappy/ro.nextwave.Snappy/Info.plist Xcode, 今天 at 下午8.04.21.png)





#### MSMessagesAppViewController中处理会话回调的方法

##### willBecomeActive

Called when the extension is about to move from the inactive to active state.
This will happen when the extension is about to present UI.
当需要展示UI的时候就会被调用
Use this method to configure the extension and restore previously stored state.



##### didResignActive

Called when the extension is about to move from the active to inactive state.
This will happen when the user dissmises the extension, changes to a different
conversation or quits Messages.
翻译：这函数会在extension消失、切换会话或者退出消息的时候被调用。
说人话：
extension消失: (1)手指向下滑动时，imessage功能条回到屏幕最下方时，extension消失；

​			(2)在extension状态，点击输入框时，切换到输入状态，extension消失；

切换会话或者退出消息：顶部导航返回，退出短信

Use this method to release shared resources, save user data, invalidate timers,
and store enough state information to restore your extension to its current state
in case it is terminated later.sys

> 我在模拟器上，在extension状态直接Home时，crash~! 但之前真机上是没有问题的~！鸡肋



##### didReceive

Called when a message arrives that was generated by another instance of this
extension on a remote device.

收到相同的extension发来的消息。这里说“a remote device”，我们知道，iMessage是可以自己给自己发消息的。当自己给自己发送消息的时候，短信界面有两个会话，一个是自己收，另一个是自己发。那么问题来了，这算“a remote device”么~！😂

搞笑了，这个方法可以在收到同类extension发来的消息时被调用，即使此时这个extension不在活跃状态。

Use this method to trigger UI updates in response to the message.



#####  didStartSending

Called when the user taps the send button.



##### didCancelSending

Called when the user deletes the message without sending it.

Use this to clean up state related to the deleted message.



##### willTransition

Called before the extension transitions to a new presentation style.

Use this method to prepare for the change in presentation style.

#####  didTransition

Called after the extension transitions to a new presentation style.

Use this method to finalize any behaviors associated with the change in presentation style.

最后这两上放一起说好了。iMessage的界面有两种状态，一种是收缩，另一种是展开。收缩状态的大小大概和输入法键盘的大小差不多（这里的大小有问题）。展开状态就是全屏了。从开发过程和使用过程，我发现收缩状态时大小存在一定的问题：即收缩状态的大小并不统一。所以，有时会看到extension的应用选择界面存在重叠的情况~！尴尬



#### Sticker

