//
//  JQAuthorizationTools.m
//  JQAuthorizationTool
//
//  Created by zhangjiaqi on 2017/12/18.
//  Copyright © 2017年 zhangjiaqi. All rights reserved.
//

#import "JQAuthorizationTools.h"

@implementation JQAuthorizationTools


#pragma mark --- 获取用户相机权限 ---
+(void)AVCameraAuthorizationTools_StatusAuthorizedBlock:(void (^)(void))authorized
                                      StatusDeniedBlock:(void (^)(void))denied
                                  StatusRestrictedBlock:(void (^)(void))restricted
                            EquipmentWithoutCameraBlock:(void (^)(void))noCamera{
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {                 //用户从未进行过授权等处理，首次访问相应内容会提示用户进行授权
            
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                    });
                    // 用户第一次同意了访问相机权限
                } else {
                    // 用户第一次拒绝了访问相机权限
                }
            }];
        } else if (status == AVAuthorizationStatusAuthorized) {             // 用户允许当前应用访问相机
            if (authorized) {
                authorized();
            }
        } else if (status == AVAuthorizationStatusDenied) {                 // 用户拒绝当前应用访问相机
            if (denied) {
                denied();
            }
        } else if (status == AVAuthorizationStatusRestricted) {             //因为系统原因, 无法访问相册
            if (restricted) {
                restricted();
            }
        }
    } else {
        //未检测到摄像头
        if (noCamera) {
            noCamera();
        }
    }
}


#pragma mark  ---  获取相册权限  ---
+ (void)UIImagePickerStatus_AuthorizedBlock:(void(^)(void))authorized
                                DeniedBlock:(void(^)(void))denied
                            RestrictedBlock:(void(^)(void))restricted
                               noPhotoBlock:(void(^)(void))noPhoto{
    
    
    
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusNotDetermined) {                                       //用户从未进行过授权等处理，首次访问相应内容会提示用户进行授权
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            
            if (status == PHAuthorizationStatusAuthorized){//已经授权应用访问照片数据

            }
        }];
        
    } else if(status == PHAuthorizationStatusAuthorized){                                    //已经授权应用访问照片数据
        if (authorized) {
            authorized();
        }
    }else if(status == PHAuthorizationStatusDenied){                                        //用户已经明确否认了这一照片数据的应用程序访问
        if (denied) {
            denied();
        }
        
    }else if (status == PHAuthorizationStatusRestricted){                                    //此应用程序没有被授权访问的照片数据
        if (restricted) {
            restricted();
        }
    }else{
        
        //没有检测到有相册
        if (noPhoto) {
            noPhoto();
        }
    }
}



#pragma mark  ---   获取麦克风权限   ---
+ (void)AudioAuthorizationStatus_AuthorizedBlock:(void(^)(void))authorized
                                     DeniedBlock:(void(^)(void))denied
                                 RestrictedBlock:(void(^)(void))restricted
                                    noAudioBlock:(void(^)(void))noAudio{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    
    if (status == AVAuthorizationStatusNotDetermined) {                     //用户从未进行过授权等处理，首次访问相应内容会提示用户进行授权
        
        [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
            if (granted) {
                //第一次授权后
                dispatch_async(dispatch_get_main_queue(), ^{
                });
                
            }else{
                // 用户第一次拒绝了访问权限
            }
        }];
    } else if (status ==   AVAuthorizationStatusAuthorized){                //已经授权应用访问麦克风
        if (authorized) {
            authorized();
        }
    } else if (status == AVAuthorizationStatusRestricted) {                 //此应用程序没有被授权访问的麦克风
        if (restricted) {
            restricted();
        }
    } else if (status == AVAuthorizationStatusDenied) {                     //用户拒绝当前应用访问麦克风
        if (denied) {
            denied();
        }
    } else {                                                                //没有检测到麦克风
        if (noAudio) {
            noAudio();
        }
    }
}



#pragma mark  ---   获取日历权限   ---
+ (void)EventAuthorizationStatus_AuthorizedBlock:(void(^)(void))authorized
                                     DeniedBlock:(void(^)(void))denied
                                 RestrictedBlock:(void(^)(void))restricted
                                    noEventBlock:(void(^)(void))noEvent{
    
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    switch (status) {
        case EKAuthorizationStatusNotDetermined:                    //用户从未进行过授权等处理，首次访问相应内容会提示用户进行授权
        {
        EKEventStore *store = [[EKEventStore alloc] init];
        if (store){
            [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
                if (granted) {
                    //第一次授权后
                    
                }else{
                    
                }
            }];
        }
        }
            break;
            
        case EKAuthorizationStatusAuthorized:                               //已经授权应用访问日历
            if (authorized) {
                authorized();
            }
            break;
            
        case EKAuthorizationStatusRestricted:                               //此应用程序没有被授权访问的日历
            if (restricted) {
                restricted();
            }
            break;
            
        case EKAuthorizationStatusDenied:                                    //用户拒绝当前应用访问日历
            if (denied) {
                denied();
            }
            break;
        default:                                                             //没有检测到日历
            if (noEvent) {
                noEvent();
            }
            break;
    }
    
    /*
     if (status == EKAuthorizationStatusNotDetermined) {                     //用户从未进行过授权等处理，首次访问相应内容会提示用户进行授权
     
     EKEventStore *store = [[EKEventStore alloc] init];
     if (store){
     [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
     if (granted) {
     //第一次授权后
     
     }else{
     
     }
     }];
     }
     } else if (status == EKAuthorizationStatusAuthorized){                  //已经授权应用访问日历
     if (authorized) {
     authorized();
     }
     } else if (status == EKAuthorizationStatusRestricted) {                 //此应用程序没有被授权访问的日历
     if (restricted) {
     restricted();
     }
     } else if (status == EKAuthorizationStatusDenied) {                     //用户拒绝当前应用访问日历
     if (denied) {
     denied();
     }
     } else {                                                                //没有检测到日历
     if (noEvent) {
     noEvent();
     }
     }
     */
    
}

#pragma mark  ---   获取通讯录权限   ---
+ (void)ContactAuthorizationStatus_AuthorizedBlock:(void(^)(void))authorized
                                       DeniedBlock:(void(^)(void))denied
                                   RestrictedBlock:(void(^)(void))restricted
                                    noContactBlock:(void(^)(void))noContact{
    //这里有一个枚举类:CNEntityType,不过没关系，只有一个值:CNEntityTypeContacts
    //ios 9.0 之后版本
    if (([UIDevice currentDevice].systemVersion.floatValue >= 9.0f) ? YES : NO) {
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        
        if (status == CNAuthorizationStatusNotDetermined) {                         //用户从未进行过授权等处理，首次访问相应内容会提示用户进行授权
            
            CNContactStore *contactStore = [[CNContactStore alloc] init];
            if (contactStore == NULL) {
                
            }
            [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                
                if (error) {
                }else{
                    if (granted) {
                    }else{
                    }
                }
            }];
            
        }else if (status == CNAuthorizationStatusAuthorized){                       //已经授权应用访问通讯录
            if (authorized) {
                authorized();
            }
        }else if (status == CNAuthorizationStatusRestricted) {                      //此应用程序没有被授权访问的通讯录
            if (restricted) {
                restricted();
            }
        }else if (status == CNAuthorizationStatusDenied) {                          //用户拒绝当前应用访问通讯录
            if (denied) {
                denied();
            }
        }else{
            if (noContact) {
                noContact();
            }
        }
    }else{
        //ios 9.0 之前版本
        ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
        
        if (status == kABAuthorizationStatusNotDetermined) {                            //用户从未进行过授权等处理，首次访问相应内容会提示用户进行授权
            
            __block ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
            if (addressBookRef == NULL) {
            }
            ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
                if (granted) {
                }else{
                }
                if (addressBookRef) {
                    CFRelease(addressBookRef);
                    addressBookRef = NULL;
                }
            });
        }else if(status == kABAuthorizationStatusAuthorized){                           //已经授权应用访问通讯录
            if (authorized) {
                authorized();
            }
        } else if (status == kABAuthorizationStatusRestricted) {                        //此应用程序没有被授权访问的通讯录
            if (restricted) {
                restricted();
            }
        } else if (status == kABAuthorizationStatusDenied) {                            //用户拒绝当前应用访问通讯录
            if (denied) {
                denied();
            }
        } else {
            if (noContact) {
                noContact();
            }
        }
    }
    
}


#pragma mark  ---   获取定位权限   ---
+ (void)locationAuthorizationStatus_AlwaysBlock:(void(^)(void))always                               
                                 WhenInUseBlock:(void(^)(void))WhenInUse
                                    DeniedBlock:(void(^)(void))Denied
                                RestrictedBlock:(void(^)(void))Restricted
                                noLocationBlock:(void(^)(void))noLocation{
    
    BOOL isLocationServicesEnabled = [CLLocationManager locationServicesEnabled];
    if (!isLocationServicesEnabled) {
        
    }else{
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        
        if (status == kCLAuthorizationStatusNotDetermined) {                            //第一次获取定位
            
        }else if (status == kCLAuthorizationStatusAuthorizedAlways) {                   //授权应用可以一直获取定位
            if (always) {
                always();
            }
        }else if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {                //授权当前应用在使用中获取定位
            if (WhenInUse) {
                WhenInUse();
            }
        }else if (status == kCLAuthorizationStatusDenied) {                             //用户拒绝当前应用访问获取定位
            if (Denied) {
                Denied();
            }
        }else if (status == kCLAuthorizationStatusRestricted) {                         //此应用程序没有被授权访问的获取定位
            if (Restricted) {
                Restricted();
            }
        }else{                                                                          // kCLAuthorizationStatusAuthorized < ios8
            
            if (noLocation) {
                noLocation();
            }
        }
    }
}



@end
