//
//  YWMessageFriendsAddViewController.m
//  YuWa
//
//  Created by Tian Wei You on 16/9/29.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWMessageFriendsAddViewController.h"

#import "YWMessageFriendAddCell.h"

#define MESSAGEADDFRIENDCELL @"YWMessageFriendAddCell"
@interface YWMessageFriendsAddViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic,strong)NSMutableArray * dataArr;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIView *searchBGView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation YWMessageFriendsAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"好友申请";
    [self dataSet];
    [self makeUI];
}

- (void)dataSet{
    [self.tableView registerNib:[UINib nibWithNibName:MESSAGEADDFRIENDCELL bundle:nil] forCellReuseIdentifier:MESSAGEADDFRIENDCELL];
    self.tableView.alwaysBounceVertical = YES;
    
    NSMutableArray * friendsRequest = [NSMutableArray arrayWithArray:[KUSERDEFAULT valueForKey:FRIENDSREQUEST]];
    if (!friendsRequest)friendsRequest = [NSMutableArray arrayWithCapacity:0];
    if (friendsRequest.count > 0) {
        for (int i = 0; i<friendsRequest.count; i++) {
            NSMutableDictionary * requestDic = [NSMutableDictionary dictionaryWithDictionary:friendsRequest[i]];
            if ([requestDic[@"status"] isEqualToString:@"0"]){
                [requestDic setObject:@"1" forKey:@"status"];
                [friendsRequest replaceObjectAtIndex:i withObject:requestDic];
            }
        }
        [KUSERDEFAULT setObject:friendsRequest forKey:FRIENDSREQUEST];
    }
    
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    [friendsRequest enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull requestDic, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.dataArr addObject:[YWMessageFriendAddModel yy_modelWithDictionary:requestDic]];
    }];
}

- (void)makeUI{
    self.searchBGView.layer.cornerRadius = 5.f;
    self.searchBGView.layer.masksToBounds = YES;
}

#pragma mark- UITableViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.searchTextField resignFirstResponder];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75.f;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle ==UITableViewCellEditingStyleDelete){
        YWMessageFriendAddModel * model = self.dataArr[indexPath.row];
        if ([model.status isEqualToString:@"1"]) {
            EMError *error = [[EMClient sharedClient].contactManager declineInvitationForUsername:model.hxID];
            if (!error) {
                MyLog(@"发送拒绝成功");
                NSMutableArray * friendsRequest = [NSMutableArray arrayWithArray:[KUSERDEFAULT valueForKey:FRIENDSREQUEST]];
                [friendsRequest removeObjectAtIndex:indexPath.row];
                [KUSERDEFAULT setObject:friendsRequest forKey:FRIENDSREQUEST];
            }
        }else{
            NSMutableArray * friendsRequest = [NSMutableArray arrayWithArray:[KUSERDEFAULT valueForKey:FRIENDSREQUEST]];
            [friendsRequest removeObjectAtIndex:indexPath.row];
            [KUSERDEFAULT setObject:friendsRequest forKey:FRIENDSREQUEST];
        }
        [self.dataArr removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }
}

#pragma mark- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YWMessageFriendAddCell * friendCell = [tableView dequeueReusableCellWithIdentifier:MESSAGEADDFRIENDCELL];
    friendCell.model = self.dataArr[indexPath.row];
    return friendCell;
}

#pragma mark- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField.text isEqualToString:@""]){
        [textField resignFirstResponder];
        return NO;
    }
//    [self selectLocationWithLocation:textField.text];
    return YES;
}


@end