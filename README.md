# JQAuthorizationTools
## 获取用户权限

-    功能介绍：  
- 1.获取/判断相机权限
- 2.获取/判断相册权限
- 3.获取/判断麦克风权限
- 4.获取/判断日历权限
- 5.获取/判断通讯录权限
- 6.判断定位权限


`苹果对权限获取的请求，要求详细的描述使用的功能 （苹果对用户权限的提示要求详细化说明， 要简要说明调取说明功能用来干什么 ）`
      
## plist 文件设置提示:
       
- <key>NSCameraUsageDescription</key>
`<key>NSCameraUsageDescription</key>`
`<string>需要访问您的相机，以便您正常使用拍照、扫码、扫红包等功能</string>`
- <key>NSCalendarsUsageDescription</key>
`<key>NSCalendarsUsageDescription</key>`
`<string>请求访问日历</string>`
- <key>NSContactsUsageDescription</key>
`<key>NSContactsUsageDescription</key>`
`<string>请求访问通讯录</string>`
- <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
`<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>`
`<string>请求使用您的定位功能</string>`
- <key>NSLocationAlwaysUsageDescription</key>
`<key>NSLocationAlwaysUsageDescription</key>`
`<string>始终访问地理位置</string>`
- <key>NSLocationWhenInUseUsageDescription</key>
`<key>NSLocationWhenInUseUsageDescription</key>`
`<string>在使用期间访问地理位置</string>`
- <key>NSMicrophoneUsageDescription</key>
`<key>NSMicrophoneUsageDescription</key>`
`<string>请求访问麦克风</string>`
- <key>NSPhotoLibraryUsageDescription</key>
`<key>NSPhotoLibraryUsageDescription</key>`
`<string>请求访问相册</string>`
          
          
![image](https://github.com/seanBoler/JQAuthorizationTools/blob/master/JQAuthorizationTool/authorizationToos.gif)



###  使用：
-  1.直接将AuthorizationTool 文件拖入项目
-  2.引入 #import "JQAuthorizationTools.h"

****

## 获取/判断相机访问权限

``` objc

/**
	获取用户的相机访问权限。
	authorized     用户允许访问相机
	denied         用户拒绝当前应用访问相机
	restricted     因为系统原因, 无法访问相机
	noCamera       没有检测到相机
*/
         

+ (void)AVCameraAuthorizationTools_StatusAuthorizedBlock:(void (^)(void))authorized
         StatusDeniedBlock:(void (^)(void))denied
	StatusRestrictedBlock:(void (^)(void))restricted
	EquipmentWithoutCameraBlock:(void (^)(void))noCamera;
 
      [JQAuthorizationTools AVCameraAuthorizationTools_StatusAuthorizedBlock:^{           //已授权
          [self alerviewmessage:@"相机权限已开启"];
      } StatusDeniedBlock:^{                                         //已关闭
          [self alertViewControllerWithmessage:[NSString stringWithFormat:@"相机权限未开启 \n 可通过 [设置 -> 隐私 -> 相机 - %@] 打开访问开关",_app_name]
      actionBlock:^(UIAlertAction * _Nonnull action) {
      
          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
      }];
      } StatusRestrictedBlock:^{                                     //限制访问
          [self alerviewmessage:@"相机访问被限制"];
       } EquipmentWithoutCameraBlock:^{                               //未检测到功能
          [self alerviewmessage:@"未检测到您的相机"];
      }];
```
      
      
## 获取/判断相册权限
***
``` objc
#pragma mark            ---  获取相册权限  ---
/**
	authorized         用户允许访问相册
	denied             用户拒绝当前应用访问相册
	restricted         因为系统原因, 无法访问相册
	noPhoto            没有检测到相册
*/
+ (void)UIImagePickerStatus_AuthorizedBlock:(void(^)(void))authorized
	DeniedBlock:(void(^)(void))denied
	RestrictedBlock:(void(^)(void))restricted
	noPhotoBlock:(void(^)(void))noPhoto;
```


``` objc
	[JQAuthorizationTools UIImagePickerStatus_AuthorizedBlock:^{                        //已授权
        [self alerviewmessage:@"相册权限已开启"];
	} DeniedBlock:^{                                                                    //已关闭
        [self alertViewControllerWithmessage:[NSString stringWithFormat:@"相册权限未开启 \n 可通过 [设置 -> 隐私 -> 相册 - %@] 打开访问开关",_app_name]
	actionBlock:^(UIAlertAction * _Nonnull action) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        
	}];
	} RestrictedBlock:^{                                                                //限制访问
        [self alerviewmessage:@"相册访问被限制"];
        
	} noPhotoBlock:^{                                                                   //未检测到功能
	[self alerviewmessage:@"未检测到您的相册"];
	}];
        
```
        
## 获取/判断麦克风权限
***
``` objc
#pragma mark            ---   获取麦克风   ---
/**
	authorized         用户允许访问麦克风
	restricted         因为系统原因, 无法访问麦克风
	denied             用户拒绝当前应用访问麦克风
	noAudio            没有检测到麦克风
*/
+ (void)AudioAuthorizationStatus_AuthorizedBlock:(void(^)(void))authorized
	DeniedBlock:(void(^)(void))denied
	RestrictedBlock:(void(^)(void))restricted
	noAudioBlock:(void(^)(void))noAudio;
        
```

## 获取/判断日历权限
***
``` objc
#pragma mark             ---   获取日历权限   ---

/**
	authorized         用户允许访问日历
	restricted         因为系统原因, 无法访问日历
	denied             用户拒绝当前应用访问日历
	noEvent            没有检测到日历
*/
+ (void)EventAuthorizationStatus_AuthorizedBlock:(void(^)(void))authorized
	DeniedBlock:(void(^)(void))denied
	RestrictedBlock:(void(^)(void))restricted
	noEventBlock:(void(^)(void))noEvent;
        
```
        

``` objc
[JQAuthorizationTools EventAuthorizationStatus_AuthorizedBlock:^{                   //已授权
        [self alerviewmessage:@"日历权限已开启"];
        
	} DeniedBlock:^{                                                                    //已关闭
        
        [self alertViewControllerWithmessage:[NSString stringWithFormat:@"日历权限未开启 \n 可通过 [设置 -> 隐私 -> 日历 - %@] 打开访问开关",_app_name]
	actionBlock:^(UIAlertAction * _Nonnull action) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        
	}];
	} RestrictedBlock:^{                                                                //限制访问
        [self alerviewmessage:@"日历访问被限制"];
	} noEventBlock:^{                                                                   //未检测到功能
        [self alerviewmessage:@"未检测到您的日历"];
	}];

```

## 获取/判断通讯录权限
***

``` objc

/**
	获取通讯录权限
	authorized         用户允许访问通讯录
	restricted         因为系统原因, 无法访问通讯录
	denied             用户拒绝当前应用访问通讯录
	noContact          没有检测到通讯录
*/

+ (void)ContactAuthorizationStatus_AuthorizedBlock:(void(^)(void))authorized
	DeniedBlock:(void(^)(void))denied
	RestrictedBlock:(void(^)(void))restricted
	noContactBlock:(void(^)(void))noContact;

        
```

``` objc
[JQAuthorizationTools ContactAuthorizationStatus_AuthorizedBlock:^{                   //已授权
        [self alerviewmessage:@"通讯录权限已开启"];
        
	} DeniedBlock:^{                                                                      //已关闭
        [self alertViewControllerWithmessage:[NSString stringWithFormat:@"通讯录权限未开启 \n 可通过 [设置 -> 隐私 -> 通讯录 - %@] 打开访问开关",_app_name]
            actionBlock:^(UIAlertAction * _Nonnull action) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }];
	} RestrictedBlock:^{                                                                  //限制访问
        [self alerviewmessage:@"通讯录访问被限制"];
        
	} noContactBlock:^{                                                                   //未检测到功能
        [self alerviewmessage:@"未检测到您的通讯录"];
	}];
        
```
        
        
##  判断定位权限
***
``` objc
/**
	always             用户允许应用一直允许访问定位
	WhenInUse          用户只允许在使用应用程序时访问定位
	denied             用户拒绝当前应用访问定位权限
	noContact          没有检测到定位权限
*/
	+ (void)locationAuthorizationStatus_AlwaysBlock:(void(^)(void))always
        WhenInUseBlock:(void(^)(void))WhenInUse
        DeniedBlock:(void(^)(void))Denied
        RestrictedBlock:(void(^)(void))Restricted
        noLocationBlock:(void(^)(void))noLocation;
 
```


``` objc
 [JQAuthorizationTools locationAuthorizationStatus_AlwaysBlock:^{                     //用户允许一直访问定位权限
        [self alerviewmessage:@"后台定位权限已开启"];
	} WhenInUseBlock:^{                                                                  //用户允许在程序使用期间访问权限
        [self alerviewmessage:@"前台台定位权限已开启"];
	} DeniedBlock:^{                                                                     //已关闭
        [self alertViewControllerWithmessage:[NSString stringWithFormat:@"定位权限未开启 \n 可通过 [设置 -> 隐私 -> 位置 - %@] 设置为 ->始终/使用期间",_app_name]
            actionBlock:^(UIAlertAction * _Nonnull action) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }];
	} RestrictedBlock:^{                                                                 //限制访问
        [self alerviewmessage:@"定位访问被限制"];
	} noLocationBlock:^{                                                                 //未检测到功能
        [self alerviewmessage:@"未检测到您的定位"];
	}];
```


## 定位权限的获取需要单独拿出来设置
***

* AppDelegate 代理去设置CLLocationManager
* 遵循一下的协议来进行权限的获取

``` objc
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
        switch (status) {
            case kCLAuthorizationStatusNotDetermined:
	
             if ([manager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                 [manager requestAlwaysAuthorization];
                 }

	          两种方法选择一种使用
            //if ([manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            //  [manager requestWhenInUseAuthorization];
            //}
                break;
	    default:
                break;
        }
	}
```

