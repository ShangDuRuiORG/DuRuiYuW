//
//  DetailStoreFirstTableViewCell.m
//  YuWa
//
//  Created by 黄佳峰 on 16/9/23.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "DetailStoreFirstTableViewCell.h"

@implementation DetailStoreFirstTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIButton*button=[self viewWithTag:24];
    [button addTarget:self action:@selector(touchLocate) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView*imageView=[self viewWithTag:23];
    imageView.userInteractionEnabled=YES;
    UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchPhone)];
    [imageView addGestureRecognizer:tap];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)touchPay:(UIButton *)sender {
    if (self.touchPayBlock) {
        self.touchPayBlock();
    }
    
}
- (void)touchLocate{
    MyLog(@"locate");
    if (self.touchLocateBlock) {
        self.touchLocateBlock();
    }
   
    
}

- (void)touchPhone{
    MyLog(@"phone");
    if (self.touchPhoneBlock) {
        self.touchPhoneBlock();
    }

}

@end
