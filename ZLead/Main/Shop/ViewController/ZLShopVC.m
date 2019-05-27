//
//  ZLShopVC.m
//  ZLead
//
//  Created by 董建伟 on 2019/5/23.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLShopVC.h"
#import "ZLShopBusinessMenuCell.h"
#import "ZLShopManagerNoteCell.h"
#import "ZLShopTurnoverView.h"
#import "ZLShopTopView.h"
#import "ZLShopListVC.h"
#import "ZLOrderManageVC.h"
#import "ZLMakeOrderVC.h"
#import "ZLOfflinePaymentVC.h"
#import "ZLShopManagerNoteVC.h"

@interface ZLShopVC () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) ZLShopTopView *shopNameView;
@end

@implementation ZLShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self setupViews];
}

#pragma mark - Views

- (void)setupViews {
    __weak typeof (self) weakSelf = self;
    
    self.shopNameView = [[ZLShopTopView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, kScreenWith, 61)];
    self.shopNameView.changeShopBlock = ^{
        ZLShopListVC *shopListVC = [[ZLShopListVC alloc] init];
        [weakSelf.navigationController pushViewController:shopListVC animated:YES];
    };
    [self.view addSubview:self.shopNameView];
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.mainTableView registerClass:[ZLShopBusinessMenuCell class] forCellReuseIdentifier:@"ZLShopBusinessMenuCell"];
    [self.mainTableView registerClass:[ZLShopManagerNoteCell class] forCellReuseIdentifier:@"ZLShopManagerNoteCell"];
    self.mainTableView.tableHeaderView = [self setupTableViewHeaderView];
    [self.view addSubview:self.mainTableView];

    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.view);
        make.height.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).offset(kNavBarHeight + 61);
        make.bottom.equalTo(weakSelf.view);
    }];
    
    [self setupTableViewHeaderView];
}

- (UIView *)setupTableViewHeaderView  {
    ZLShopTurnoverView *headView = [[ZLShopTurnoverView alloc] initWithFrame:CGRectMake(0, 0, kScreenWith, 223)];
    return headView;
}


#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [ZLShopBusinessMenuCell heightForCell];
    } else  {
        return [ZLShopManagerNoteCell heightForCell];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZLBaseCell *cell = nil;
    __weak typeof (self) weakSelf = self;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"ZLShopBusinessMenuCell"];
        ((ZLShopBusinessMenuCell *)cell).shopBusinessBlock = ^(NSInteger businessType) {
            if (businessType == 0) {
                ZLOrderManageVC *orderManageVC = [[ZLOrderManageVC alloc] init];
                [weakSelf.navigationController pushViewController:orderManageVC animated:YES];
            } else if (businessType == 1) {
                ZLMakeOrderVC *makeOrderVC = [[ZLMakeOrderVC alloc] init];
                [weakSelf.navigationController pushViewController:makeOrderVC animated:YES];
            }  else if (businessType == 2) {
                ZLOfflinePaymentVC *offlinePaymentVC = [[ZLOfflinePaymentVC alloc] init];
                [weakSelf.navigationController pushViewController:offlinePaymentVC animated:YES];
            }
        };
    } else  {
        cell = [tableView dequeueReusableCellWithIdentifier:@"ZLShopManagerNoteCell"];
        ((ZLShopManagerNoteCell *)cell).shopManagerActionBlock = ^{
            ZLShopManagerNoteVC *shopManagerNote = [[ZLShopManagerNoteVC alloc] init];
            [weakSelf.navigationController pushViewController:shopManagerNote animated:YES];
            
        };
        
        ((ZLShopManagerNoteCell *)cell).aboutUsActionBlock = ^{
            
        };
        
    }
    return cell;
}

@end
