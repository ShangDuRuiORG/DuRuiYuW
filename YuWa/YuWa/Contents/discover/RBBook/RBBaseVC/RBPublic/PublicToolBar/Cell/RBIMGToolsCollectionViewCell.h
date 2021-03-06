//
//  RBIMGToolsCollectionViewCell.h
//  YuWa
//
//  Created by 蒋威 on 16/9/21.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UIImage+Utility.h"
#import "JWTools.h"

@interface RBIMGToolsCollectionViewCell : UICollectionViewCell
@property (nonatomic,assign)NSInteger idx;

@property (weak, nonatomic) IBOutlet UIImageView *showImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic,copy)NSString * filterName;


@end
