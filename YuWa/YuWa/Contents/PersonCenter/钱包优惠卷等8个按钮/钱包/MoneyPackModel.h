//
//  MoneyPackModel.h
//  YuWa
//
//  Created by 蒋威 on 2016/11/15.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoneyPackModel : NSObject
//"ctime" = 1509203656,
//"money" = 0.00,
//"log_info" = 在2015-10-28 23:14:16注册成功,

@property(nonatomic,strong)NSString*ctime;
@property(nonatomic,strong)NSString*money;
@property(nonatomic,strong)NSString*log_info;


@end
