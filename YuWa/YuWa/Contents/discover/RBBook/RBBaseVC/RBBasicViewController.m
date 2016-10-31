//
//  RBBasicViewController.m
//  NewVipxox
//
//  Created by Tian Wei You on 16/9/8.
//  Copyright © 2016年 WeiJiang. All rights reserved.
//

#import "RBBasicViewController.h"
#import "YWLoginViewController.h"
#import "TZImagePickerController.h"

@interface RBBasicViewController ()<UITextFieldDelegate,TZImagePickerControllerDelegate>
@property (nonatomic,assign)BOOL isRePlayComment;//是否是回复用户评论
@property (nonatomic,strong)NSDictionary * commentDic;

@end

@implementation RBBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeEmojisKeyBoards];
    [self makeCommentToolsView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //键盘弹出
    [self addTextViewNotification];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //取消键盘监听
    [self cancelComment];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if (self.commentToolsView.height != 44.f) {
        self.commentToolsView.frame = CGRectMake(0.f, kScreen_Height - 44.f, kScreen_Width, 44.f);
    }
}

- (BOOL)isLogin{
    if (![UserSession instance].isLogin) {
        YWLoginViewController * vc = [[YWLoginViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    return [UserSession instance].isLogin;
}

- (void)makeCommentToolsView{
    self.commentToolsView = [[[NSBundle mainBundle]loadNibNamed:@"RBCommentToolsView" owner:nil options:nil] firstObject];
    self.commentToolsView.hidden = YES;
    WEAKSELF;
    self.commentToolsView.connectBlock = ^(){
        RBConnectionViewController * vc = [[RBConnectionViewController alloc]init];
        vc.connectNameBlock = ^(NSString * name){//@的人
            weakSelf.commentToolsView.sendTextField.hidden = NO;
            weakSelf.commentToolsView.sendTextField.text = [NSString stringWithFormat:@"%@@%@ ",weakSelf.commentToolsView.sendTextField.text,name];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.commentToolsView.sendTextField becomeFirstResponder];
            });
        };
        [weakSelf presentViewController:vc animated:YES completion:nil];
    };
    self.commentToolsView.showEmojisBlock = ^(BOOL isShowEmojis){
        weakSelf.isShowEmojis = isShowEmojis;
        [weakSelf.commentToolsView.sendTextField resignFirstResponder];
        if (isShowEmojis) {
            weakSelf.commentToolsView.sendTextField.inputView = weakSelf.emojisKeyBoards;
        }else{
            weakSelf.commentToolsView.sendTextField.inputView = nil;
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.commentToolsView.sendTextField becomeFirstResponder];
        });
    };
    self.commentToolsView.sendTextField.delegate = self;
    [self.view addSubview:self.commentToolsView];
}

- (void)makeEmojisKeyBoards{
    WEAKSELF;
    self.emojisKeyBoards = [[[NSBundle mainBundle]loadNibNamed:@"JWEmojisKeyBoards" owner:nil options:nil]firstObject];
    self.emojisKeyBoards.sendBlock = ^(){
        if ([weakSelf.commentToolsView.sendTextField.text isEqualToString:@""]) {
            [weakSelf showHUDWithStr:@"评论不能为空哟" withSuccess:NO];
        }else{
            [weakSelf requestSendComment];
            [weakSelf.commentToolsView.sendTextField resignFirstResponder];
        }
    };
    self.emojisKeyBoards.deleteStrBlock = ^(){
        if (self.commentToolsView.sendTextField.text.length > 0) {
            NSMutableString * strTemp = [NSMutableString stringWithString:weakSelf.commentToolsView.sendTextField.text];
            if (strTemp.length>=2) {
                NSString * strTempTest = [strTemp substringFromIndex:strTemp.length-2];
                if ([JWTools stringContainsEmoji:strTempTest]&&[weakSelf.emojisKeyBoards isOneLengthEmojionithStr:[strTemp substringFromIndex:strTemp.length-1]]) {
                    [strTemp deleteCharactersInRange:NSMakeRange(strTemp.length - 1, 1)];
                }
            }
            [strTemp deleteCharactersInRange:NSMakeRange(strTemp.length - 1, 1)];
            
            weakSelf.commentToolsView.sendTextField.text = strTemp;
        }
    };
    self.emojisKeyBoards.addStrBlock = ^(NSString * addStr){
        weakSelf.commentToolsView.sendTextField.text = [NSString stringWithFormat:@"%@%@",weakSelf.commentToolsView.sendTextField.text,addStr];
    };
    
}

//发笔记
- (void)publishNodeAction{
    if (![self isLogin])return;
    TZImagePickerController *imagePickerVC = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    imagePickerVC.allowPickingVideo = NO;
    [imagePickerVC setDidFinishPickingPhotosHandle:^(NSArray * photos , NSArray * assets,BOOL isSelectOriginalPhoto){
        
    }];
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

//发专辑
- (void)publishAlbumAction{
    if (![self isLogin])return;
    MyLog(@"Add Album");
}

//添加评论
- (void)commentActionWithNodeDic:(NSDictionary *)node{
    if (![self isLogin])return;
    self.commentToolsView.hidden = NO;
    if (self.commentToolsView.y > kScreen_Height - 44.f)self.commentToolsView.y = kScreen_Height - 44.f;
    self.commentToolsView.sendTextField.text = @"";
    self.commentToolsView.sendTextField.placeholder = @"添加评论";
    self.isRePlayComment = NO;
    self.commentSendDic = [NSMutableDictionary dictionaryWithDictionary:node];
    [self.commentToolsView.sendTextField becomeFirstResponder];
}
//回复用户评论
- (void)commentActionWithUserDic:(NSDictionary *)user{
    if (![self isLogin])return;
    self.commentToolsView.hidden = NO;
    if (self.commentToolsView.y > kScreen_Height - 44.f)self.commentToolsView.y = kScreen_Height - 44.f;
    self.commentToolsView.sendTextField.text = @"";
    self.commentToolsView.sendTextField.placeholder = [NSString stringWithFormat:@"回复 %@ :",user[@"userName"]];
    self.isRePlayComment = YES;
    self.commentSendDic = [NSMutableDictionary dictionaryWithDictionary:user];
    [self.commentToolsView.sendTextField becomeFirstResponder];
}

- (void)cancelComment{
    [self.commentToolsView.sendTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - KeyBoard KVO
- (void)keyboardChangeFrame:(NSNotification *)notification{
    CGRect startRect = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.commentToolsView.frame = CGRectMake(self.commentToolsView.x, self.commentToolsView.y - (startRect.origin.y - endRect.origin.y), self.commentToolsView.width, self.commentToolsView.height);
    } completion:nil];
}

- (void)addTextViewNotification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField.text isEqualToString:@""]) {
        [self showHUDWithStr:@"评论不能为空哟" withSuccess:NO];
        return YES;
    }
    [self requestSendComment];
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - Http
- (void)requestSendComment{
    if (self.commentDic[@"userID"]) {
        [self requestSendRePlayComment];
        return;
    }
    NSDictionary * pragram = @{@"device_id":[JWTools getUUID],@"token":[UserSession instance].token,@"user_id":[UserSession instance].token,@"note_id":@([self.commentDic[@"nodeID"] integerValue]),@"customer_content":self.commentToolsView.sendTextField.text};
    
    [[HttpObject manager]postDataWithType:YuWaType_RB_COMMENT withPragram:pragram success:^(id responsObj) {
        MyLog(@"Regieter Code pragram is %@",pragram);
        MyLog(@"Regieter Code is %@",responsObj);
    } failur:^(id responsObj, NSError *error) {
        MyLog(@"Regieter Code pragram is %@",pragram);
        MyLog(@"Regieter Code error is %@",responsObj);
    }];
    //h333333333
}

- (void)requestSendRePlayComment{
    //回复用户评论
}

@end
