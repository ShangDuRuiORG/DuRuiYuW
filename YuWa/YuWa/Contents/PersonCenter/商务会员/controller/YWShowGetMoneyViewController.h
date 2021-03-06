//
//  YWShowGetMoneyViewController.h
//  YuWa
//
//  Created by 蒋威 on 2016/11/24.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntroduceMoneyViewController.h"

@interface YWShowGetMoneyViewController : UIViewController

@property(nonatomic,strong)NSString*time;  //时间分类,0昨天1今天2近周3近月4全部
@property(nonatomic,strong)NSString*type;  //分红类型,0介绍分红1商务分红2积分分红3历史总收入4总待结算5直接介绍6间接介绍

@property(nonatomic,assign)IntroduceType introducetype;

@end
