//
//  PHCategoryModel.m
//  YuWa
//
//  Created by 蒋威 on 2016/11/8.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "PHCategoryModel.h"
#import "PHSubCategoryModel.h"

@implementation PHCategoryModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"tag":PHSubCategoryModel.class};
    
}

@end
