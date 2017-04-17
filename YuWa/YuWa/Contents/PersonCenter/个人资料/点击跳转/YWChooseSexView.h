//
//  YWChooseSexView.h
//  YuWa
//
//  Created by 蒋威 on 2016/11/14.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface YWChooseSexView : UIView
@property(nonatomic,strong)UIPickerView*pickerView;
@property(nonatomic,copy)void(^touchConfirmBlock)(NSString*value);
@property(nonatomic,copy)void(^touchCancelBlock)();

-(YWChooseSexView*)initWithCustomeHeight:(CGFloat)height;
@end
