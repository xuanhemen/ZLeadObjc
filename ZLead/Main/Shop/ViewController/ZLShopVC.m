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
#import "ZLUserInfo.h"
#import "ZLShopModel.h"

@interface ZLShopVC () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) ZLShopTopView *shopNameView;
@property (nonatomic, strong) ZLShopModel *shopModel;
@end

@implementation ZLShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self setupViews];
    [self setupData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - Views

- (void)setupViews {
    __weak typeof (self) weakSelf = self;
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.backgroundColor = [UIColor zl_bgColor];
    [self.mainTableView registerClass:[ZLShopBusinessMenuCell class] forCellReuseIdentifier:@"ZLShopBusinessMenuCell"];
    [self.mainTableView registerClass:[ZLShopManagerNoteCell class] forCellReuseIdentifier:@"ZLShopManagerNoteCell"];
    self.mainTableView.tableHeaderView = [self setupTableViewHeaderView];
    [self.view addSubview:self.mainTableView];

    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.view);
        make.height.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).offset(kStatusBarHeight);
        make.bottom.equalTo(weakSelf.view);
    }];
}

- (UIView *)setupTableViewHeaderView  {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, dis(315))];
    headerView.backgroundColor = [UIColor whiteColor];
    __weak typeof (self) weakSelf = self;
    if (!self.shopNameView) {
        self.shopNameView = [[ZLShopTopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, dis(92))];
        self.shopNameView.changeShopBlock = ^{
            ZLShopListVC *shopListVC = [[ZLShopListVC alloc] init];
            [weakSelf.navigationController pushViewController:shopListVC animated:YES];
        };
    }
    [headerView addSubview:self.shopNameView];
    ZLShopTurnoverView *headView = [[ZLShopTurnoverView alloc] initWithFrame:CGRectMake(0, dis(92), kScreenWidth, dis(223))];
    [headerView addSubview:headView];
    return headerView;
}

#pragma mark - setupData

- (void)setupData {
    [[NetManager sharedInstance] getShopListWithUserId:@"0010001770316129" sucess:^(NSArray *dataList, NSInteger total) { //@"0010000137432355"
        self.shopModel = [dataList firstObject];
        [self.shopNameView setupData:self.shopModel];
        self.mainTableView.tableHeaderView = [self setupTableViewHeaderView];
    } fail:^(NSError * _Nonnull error) {
        self.shopModel = [[ZLShopModel alloc] init];
        self.shopModel.shopName = @"我的小店";
        [self.shopNameView setupData:self.shopModel];
        self.mainTableView.tableHeaderView = [self setupTableViewHeaderView];
    }];
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
                self.hidesBottomBarWhenPushed = YES;
                ZLOrderManageVC *orderManageVC = [[ZLOrderManageVC alloc] init];
                [weakSelf.navigationController pushViewController:orderManageVC animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            } else if (businessType == 1) {
                self.hidesBottomBarWhenPushed = YES;
                ZLMakeOrderVC *makeOrderVC = [[ZLMakeOrderVC alloc] init];
                [weakSelf.navigationController pushViewController:makeOrderVC animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }  else if (businessType == 2) {
                self.hidesBottomBarWhenPushed = YES;
                ZLOfflinePaymentVC *offlinePaymentVC = [[ZLOfflinePaymentVC alloc] init];
                [weakSelf.navigationController pushViewController:offlinePaymentVC animated:YES];
                self.hidesBottomBarWhenPushed = NO;
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
