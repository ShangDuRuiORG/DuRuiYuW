//
//  YWBaoBaoViewController.m
//  YuWa
//
//  Created by Tian Wei You on 16/11/11.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWBaoBaoViewController.h"

@interface YWBaoBaoViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *BGView;
@property (weak, nonatomic) IBOutlet UIView *LVView;
@property (weak, nonatomic) IBOutlet UIView *showLVView;
@property (weak, nonatomic) IBOutlet UILabel *showLVLabel;
@property (weak, nonatomic) IBOutlet UIImageView *LVShowImageView;
@property (weak, nonatomic) IBOutlet UIImageView *skillView;

@property (weak, nonatomic) IBOutlet UIImageView *baobaoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *baobaoLVUpImageView;


@property (weak, nonatomic) IBOutlet UIButton *LVUpBtn;

@property (nonatomic,strong)UserSession * user;
@property (nonatomic,strong)NSMutableArray * baobaoGifArr;
@property (nonatomic,strong)NSMutableArray * baobaoBGGifArr;
@property (nonatomic,strong)NSMutableArray * baobaoLVUpGifArr;

@end

@implementation YWBaoBaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dataSet];
    [self makeUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0.f];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1.f];
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)dataSet{
    self.user = [UserSession instance];
    //23333333要删
    self.user.baobaoLV = 1;
    self.user.baobaoEXP = 200;
    self.user.baobaoNeedEXP = 1000;
    //23333333要删
    
    self.baobaoGifArr = [NSMutableArray arrayWithCapacity:0];
    self.baobaoBGGifArr = [NSMutableArray arrayWithCapacity:0];
    self.baobaoLVUpGifArr = [NSMutableArray arrayWithCapacity:0];
    //233333初始化初始Gif
}

- (void)makeUI{
    self.LVView.layer.borderColor = [UIColor colorWithHexString:@"#2f5bbe"].CGColor;
    self.LVView.layer.borderWidth = 2.f;
    self.LVView.layer.cornerRadius = 11.f;
    self.LVView.layer.masksToBounds = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.skillView.height = 20.f * kScreen_Width / 375.f;
        self.skillView.y = self.skillView.y - self.skillView.height + 20.f ;
    });
    
    [self showLvInfo];
}

- (void)showLvInfo{
    self.showLVLabel.text = [NSString stringWithFormat:@"%zi/%zi",self.user.baobaoEXP,self.user.baobaoNeedEXP];
    self.LVShowImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"baobaoLV%zi",(self.user.baobaoLV - 1)]];
    self.skillView.image = [UIImage imageNamed:[NSString stringWithFormat:@"baobaoSkill%zi",(self.user.baobaoLV - 1)]];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{//经验槽
        self.showLVView.x = ((kScreen_Width - 52.f - 87.f)*(self.user.baobaoEXP>=self.user.baobaoNeedEXP?1.f:([[NSString stringWithFormat:@"%zi",self.user.baobaoEXP] floatValue])/[[NSString stringWithFormat:@"%zi",self.user.baobaoNeedEXP] floatValue]));
    });
    
    for (int i = 0; i<self.user.baobaoLV; i++) {//技能栏
        UIButton * skillBtn = [self.view viewWithTag:(i+1)];
        [skillBtn setUserInteractionEnabled:YES];
        skillBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.f];
        [skillBtn setTitleColor:[UIColor colorWithHexString:@"#afe5ff"] forState:UIControlStateNormal];
    }
    
    [self.LVUpBtn setUserInteractionEnabled:(self.user.baobaoEXP >= self.user.baobaoNeedEXP?YES:NO)];
    
    //Gif动画
    self.baobaoImageView.animationImages = self.baobaoGifArr;
    self.baobaoImageView.animationDuration = 3;
    self.baobaoImageView.animationRepeatCount = 0;
    [self.baobaoImageView startAnimating];
    self.BGView.animationImages = self.baobaoBGGifArr;
    self.BGView.animationDuration = 3;
    self.BGView.animationRepeatCount = 0;
    [self.BGView startAnimating];
}

- (IBAction)lvUpAction:(id)sender {
    if (self.user.baobaoLV>4)return;
    [self.LVUpBtn setUserInteractionEnabled:NO];
    [self requestLvUP];
}

- (IBAction)skillAction:(UIButton *)sender {
    //2333333技能

}

- (void)lvUpGifShow{
    self.baobaoLVUpImageView.hidden = NO;
    self.baobaoLVUpImageView.animationImages = self.baobaoLVUpGifArr;//Gif动画
    self.baobaoLVUpImageView.animationDuration = 3;
    self.baobaoLVUpImageView.animationRepeatCount = 1;
    [self.baobaoLVUpImageView startAnimating];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.baobaoLVUpImageView.hidden = YES;
    });
}

#pragma mark - Http
- (void)requestLvUP{
    if (self.user.baobaoEXP < self.user.baobaoNeedEXP)return;
    
    //2333333 Success
    //233333333请求成功后修改UserSession数据
    for (int i = 0; i < 30; i++) {
//        [self.baobaoGifArr replaceObjectAtIndex:i withObject:<#(nonnull id)#>];
//        [self.baobaoBGGifArr replaceObjectAtIndex:i withObject:<#(nonnull id)#>];
//        [self.baobaoLVUpGifArr replaceObjectAtIndex:i withObject:<#(nonnull id)#>];
    }
    [self lvUpGifShow];
    [self showLvInfo];
    
    
    //2333333 Faild
    [self.LVUpBtn setUserInteractionEnabled:YES];
}


@end