//
//  MoneyDetailViewController.h
//  YuWa
//
//  Created by 蒋威 on 2016/11/24.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntroduceMoneyViewController.h"

@interface MoneyDetailViewController : UIViewController

@property(nonatomic,strong)NSString*idd;

@property(nonatomic,assign)IntroduceType introducetype;
@end
