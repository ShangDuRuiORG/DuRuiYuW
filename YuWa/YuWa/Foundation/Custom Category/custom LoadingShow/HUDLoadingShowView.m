//
//  HUDLoadingShowView.m
//  NewVipxox
//
//  Created by 蒋威 on 16/8/29.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "HUDLoadingShowView.h"

@implementation HUDLoadingShowView


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.userInteractionEnabled=NO;
        
        UIImageView*imageView=[self viewWithTag:1];
        imageView.animationImages=[self animationImages];
        imageView.animationDuration=3;
        imageView.animationRepeatCount=0;
        [imageView startAnimating];

        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

-(NSArray*)animationImages{
//    NSFileManager*fileM=[NSFileManager defaultManager];
//    NSString*path=[[NSBundle mainBundle]pathForResource:@"GifBundle" ofType:@"bundle"];
//    NSArray*array=[fileM contentsOfDirectoryAtPath:path error:nil];
//    
//    NSMutableArray*imageArrays=[NSMutableArray array];
//    
//    for (NSString*imageStr in array) {
//        UIImage*image=[UIImage imageNamed:[@"GifBundle.bundle" stringByAppendingPathComponent:imageStr]];
//        [imageArrays addObject:image];
//        
//    }
    
    NSMutableArray*imageArrays=[NSMutableArray array];
    for (int i=0; i<32; i++) {
        UIImage*image=[UIImage imageNamed:[NSString stringWithFormat:@"赛亚人000%d",i]];
        [imageArrays addObject:image];
    }
    
    
    
    return imageArrays;
}

@end
