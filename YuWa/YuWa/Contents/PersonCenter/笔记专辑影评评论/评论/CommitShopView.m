//
//  CommitShopView.m
//  YuWa
//
//  Created by 蒋威 on 16/10/18.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "CommitShopView.h"

@implementation CommitShopView


-(void)awakeFromNib{
    [super awakeFromNib];
    UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchHeader)];
    [self addGestureRecognizer:tap];
    
    
}

-(void)touchHeader{
    MyLog(@"11");
    if (self.touchBlock) {
        self.touchBlock();
    }
}

@end
