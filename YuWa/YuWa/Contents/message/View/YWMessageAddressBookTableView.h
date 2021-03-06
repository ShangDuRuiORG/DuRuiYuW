//
//  YWMessageAddressBookTableView.h
//  YuWa
//
//  Created by 蒋威 on 16/9/28.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWMessageAddressBookTableViewCell.h"
#import "YWMessageAddressBookHeader.h"

#define MESSAGEADDRESSHEADER @"YWMessageAddressBookHeader"
#define MESSAGEADDRESSCELL @"YWMessageAddressBookTableViewCell"
@interface YWMessageAddressBookTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,copy)void (^friendsAddBlock)();
@property (nonatomic,copy)void (^friendsChatBlock)(YWMessageAddressBookModel *);

@property (nonatomic,strong)NSMutableArray * dataArr;
@property (nonatomic,strong)NSMutableArray * keyArr;
@property (nonatomic,strong)NSArray * sortArr;
@property (nonatomic,copy)NSString * pagens;
@property (nonatomic,assign)NSInteger pages;

- (void)dataSet;
- (void)headerRereshing;

@end
