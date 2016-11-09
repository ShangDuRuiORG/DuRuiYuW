//
//  YWPayViewController.h
//  YuWa
//
//  Created by 黄佳峰 on 16/10/10.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,PayCategory){
    PayCategoryAutoPay=0,   //主动支付
    PayCategorySaoma //扫码
    
    
};


@interface YWPayViewController : UIViewController
@property(nonatomic,assign)PayCategory whichPay;  //哪种支付
@property(nonatomic,assign)CGFloat payAllMoney;    //需要支付的总额
@property(nonatomic,assign)CGFloat NOZheMoney;     //不打折的金额
@property(nonatomic,assign)CGFloat shouldPayMoney;   //应该支付的钱


//----------------------------------------------
@property(nonatomic,strong)NSString*shopID;  //店铺的id
@property(nonatomic,assign)CGFloat shopZhekou;  //店铺的折扣


@end
