//
//  ZLGoodsSearchVC.m
//  ZLead
//
//  Created by qzwh on 2019/5/30.
//  Copyright © 2019年 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLGoodsSearchVC.h"
#import "ZLSearchHistoryView.h"

@interface ZLGoodsSearchVC ()<SearchTagDelegate>

@property (nonatomic, strong)ZLSearchHistoryView *historyView;

@end

@implementation ZLGoodsSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self styleForNav];
    
    [self.view addSubview:self.historyView];
    self.historyView.tags = @[@"锤子",@"见过",@"膜拜单车",@"微信支付",@"Q",@"王者",@"蓝淋网",@"阿珂",@"半生",@"猎场",@"QQ空间",@"王者荣耀助手",@"斯卡哈复健科",@"安抚",@"沙发上",@"日打的费",@"问问",@"无人区",@"阿斯废弃物人情味",@"沙发上"];
}


- (void)styleForNav {
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.titleView = [self searchView];
}

- (UIView *)searchView {
    UIView *conView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - dis(30), 30)];

    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(kScreenWidth - 80, 0, 50, 30);
    cancelBtn.titleLabel.font = kFont15;
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [conView addSubview:cancelBtn];
    [cancelBtn addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 90, 30)];
    bgView.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    bgView.layer.cornerRadius = 15;
    [conView addSubview:bgView];
    
    UIImageView *searchImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_search"]];
    searchImgV.frame = CGRectMake(15, 8.5, 13, 13);
    [bgView addSubview:searchImgV];
    
    UITextField *textF = [[UITextField alloc] initWithFrame:CGRectMake(33, 0, kScreenWidth - 130, 30)];
    textF.placeholder = @"输入搜索商品的关键词";
    textF.font = kFont13;
    [bgView addSubview:textF];
    
    return conView;
}

- (void)pop {
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - delegate
- (void)handleSelectTag:(NSString *)keyword {
    NSLog(@"%@", keyword);
}

- (void)deleteData {
    
}

#pragma mark - lazy load
- (ZLSearchHistoryView *)historyView {
    if (!_historyView) {
        _historyView = [[ZLSearchHistoryView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, kScreenWidth, 0)];
        _historyView.delegate = self;
    }
    return _historyView;
}


@end
