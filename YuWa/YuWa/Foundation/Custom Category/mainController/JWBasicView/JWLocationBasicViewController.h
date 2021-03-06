//
//  JWLocationBasicViewController.h
//  YuWa
//
//  Created by 蒋威 on 16/9/26.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWBasicViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface JWLocationBasicViewController : JWBasicViewController<CLLocationManagerDelegate>

@property (nonatomic,strong)YWLocation * location;

@property(nonatomic, strong)CLLocationManager * loctionManger;

@end
