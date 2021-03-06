//
//  AppDelegate.h
//  NewVipxox
//
//  Created by 蒋威 on 16/8/29.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

///本地添加
- (void)addLocalPushNotificationWithTime:(NSTimeInterval)secs withAlertBody:(NSString *)con;

//支付宝的支付结果传到控制其中
@property(nonatomic,strong)void(^aliPayBlock)(NSDictionary*resultDatas);

@end

