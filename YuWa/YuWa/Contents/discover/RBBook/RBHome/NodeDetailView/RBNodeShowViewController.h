//
//  RBNodeShowViewController.h
//  NewVipxox
//
//  Created by 蒋威 on 16/9/12.
//  Copyright © 2016年 WeiJiang. All rights reserved.
//

#import "RBBasicViewController.h"
#import "RBHomeModel.h"

@interface RBNodeShowViewController : RBBasicViewController

@property (nonatomic,strong)RBHomeModel * model;

@property (nonatomic,assign)BOOL isUser;//是否是自己

@end
