//
//  RBPublicTagSaveModel.h
//  YuWa
//
//  Created by 蒋威 on 16/9/22.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHTagView.h"

@interface RBPublicTagSaveModel : NSObject

@property (nonatomic, assign)XHTagAnimationStyle tagAnimationStyle;
@property (nonatomic, strong)NSArray * tagTextArr;
@property (nonatomic,assign)CGPoint centerLocationPoint;//起始位置
@property (nonatomic,assign)CGFloat x;
@property (nonatomic,assign)CGFloat y;

- (instancetype)initWithTagView:(XHTagView *)tagView;

@end
