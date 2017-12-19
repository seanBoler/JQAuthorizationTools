//
//  JQAuthorizationTools.h
//  JQAuthorizationTool
//
//  Created by zhangjiaqi on 2017/12/18.
//  Copyright © 2017年 zhangjiaqi. All rights reserved.
//


@import Photos;                             //获取相册权限
@import AVFoundation;                       //获取音频及相机权限
@import Contacts;                           //获取通讯录权限
@import AddressBook;                        //ios 9.0 之前
@import EventKit;                           //获取日历权限
@import CoreLocation;                       //定位


/**
 访问权限 设置
 
 <key>NSContactsUsageDescription</key>
 <string>请求访问通讯录</string>
 <key>NSMicrophoneUsageDescription</key>
 <string>请求访问麦克风</string>
 <key>NSPhotoLibraryUsageDescription</key>
 <string>请求访问相册</string>
 <key>NSCameraUsageDescription</key>
 <string>请求访问相机</string>
 <key>NSLocationAlwaysUsageDescription</key>
 <string>始终访问地理位置</string>
 <key>NSLocationWhenInUseUsageDescription</key>
 <string>在使用期间访问地理位置</string>
 <key>NSCalendarsUsageDescription</key>
 <string>请求访问日历</string>
 
 */



#import <Foundation/Foundation.h>
@interface JQAuthorizationTools : NSObject <CLLocationManagerDelegate>


#pragma mark            --- 获取用户相机权限 ---
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


#pragma mark            ---   获取通讯录权限   ---
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


#pragma mark            ---   获取定位权限   ---
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

@end
