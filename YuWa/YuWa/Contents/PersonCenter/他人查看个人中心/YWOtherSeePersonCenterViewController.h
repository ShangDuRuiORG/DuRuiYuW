//
//  YWOtherSeePersonCenterViewController.h
//  YuWa
//
//  Created by 蒋威 on 16/10/8.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VIPPersonCenterViewController.h"


@interface YWOtherSeePersonCenterViewController : UIViewController

@property(nonatomic,strong)NSString * uid;
@property(nonatomic,copy)NSString * nickName;
@property(nonatomic,copy)NSString * otherIcon;   //此人的头像

@end
