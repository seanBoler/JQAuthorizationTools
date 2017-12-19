//
//  ViewController.m
//  JQAuthorizationTool
//
//  Created by zhangjiaqi on 2017/12/18.
//  Copyright © 2017年 zhangjiaqi. All rights reserved.
//

#import "ViewController.h"

#import "JQAuthorizationTools.h"                        //获取权限状态

// app名称

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property  (nonatomic,strong)UITableView *tableView;
@property  (nonatomic,strong)NSMutableArray *array;

@property  (nonatomic,strong)NSString *app_name;
@property  (nonatomic,strong)NSString *app_build;

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"权限工具";
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableViewCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray arrayWithArray:@[@"获取相机权限",@"获取相册权限",@"获取麦克风权限",@"获取日历权限",@"获取通讯录权限",@"获取定位权限"]];
        [self.tableView reloadData];
    }
    return _array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    _app_name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    _app_build = [infoDictionary objectForKey:@"CFBundleIdentifier"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor colorWithRed:51/255 green:51/255 blue:51/255 alpha:1];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.array[indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:                         //获取相机权限
            [self cameraAuthorization];
            break;
            
        case 1:                         //获取相册权限
            [self imagePickerAuthorization];
            break;
            
        case 2:                         //获取音频权限
            [self AudioAuthorizationStatus];
            break;
            
        case 3:                         //获取日历权限
            [self EventAuthorizationStatus];
            break;
            
        case 4:                         //获取通讯录权限
            [self ContactAuthorizationStatus];
            break;
            
        case 5:                         //获取定位权限
            [self locationAuthorizationStatus];
            break;
        default:
            break;
    }
}

#pragma mark         -- 相机权限
- (void)cameraAuthorization{
    
    [JQAuthorizationTools AVCameraAuthorizationTools_StatusAuthorizedBlock:^{           //已授权
        [self alerviewmessage:@"相机权限已开启"];
    } StatusDeniedBlock:^{                                                              //已关闭
        [self alertViewControllerWithmessage:[NSString stringWithFormat:@"相机权限未开启 \n 可通过 [设置 -> 隐私 -> 相机 - %@] 打开访问开关",_app_name]
                                 actionBlock:^(UIAlertAction * _Nonnull action) {
                                     
                                     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                                 }];
    } StatusRestrictedBlock:^{                                                          //限制访问
        [self alerviewmessage:@"相机访问被限制"];
    } EquipmentWithoutCameraBlock:^{                                                    //未检测到功能
        [self alerviewmessage:@"未检测到您的相机"];
    }];
}


#pragma mark        -- 相册权限
- (void)imagePickerAuthorization{
    
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
}



#pragma mark       -- 获取音频权限
- (void)AudioAuthorizationStatus{
    
    [JQAuthorizationTools AudioAuthorizationStatus_AuthorizedBlock:^{                   //已授权
        [self alerviewmessage:@"麦克风权限已开启"];
        
    } DeniedBlock:^{                                                                    //已关闭
        [self alertViewControllerWithmessage:[NSString stringWithFormat:@"麦克风权限未开启 \n 可通过 [设置 -> 隐私 -> 麦克风 - %@] 打开访问开关",_app_name]
                                 actionBlock:^(UIAlertAction * _Nonnull action) {
                                     
                                     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];

                                 }];
    } RestrictedBlock:^{                                                                //限制访问
        [self alerviewmessage:@"麦克风访问被限制"];
    } noAudioBlock:^{                                                                   //未检测到功能
        [self alerviewmessage:@"未检测到您的麦克风"];
    }];
    
}


#pragma mark        -- 获取日历权限
- (void)EventAuthorizationStatus{
    
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
}


#pragma mark        --- 获取通讯录权限
- (void)ContactAuthorizationStatus{
    
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
    
}

#pragma mark        --  获取定位权限
- (void)locationAuthorizationStatus{
    
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
}






- (void)alertViewControllerWithmessage:(NSString *)message actionBlock:(void (^)(UIAlertAction * _Nonnull action))actionHander;
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:actionHander]];
    
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}


- (void)alerviewmessage:(NSString *)message{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}





@end
