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
    
    self.shopNameView = [[ZLShopTopView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, ScreenWidth, 61)];
    self.shopNameView.changeShopBlock = ^{
        ZLShopListVC *shopListVC = [[ZLShopListVC alloc] init];
        [weakSelf.navigationController pushViewController:shopListVC animated:YES];
    };
    [self.view addSubview:self.shopNameView];
    
//    [self.shopNameView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf.view);
//        make.width.equalTo(weakSelf.view);
//        make.height.mas_equalTo(61);
//        make.top.equalTo(weakSelf.view).offset(kNavigationBarHeight);
//    }];
    
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
    ZLShopTurnoverView *headView = [[ZLShopTurnoverView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
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
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"ZLShopBusinessMenuCell"];
    } else  {
        cell = [tableView dequeueReusableCellWithIdentifier:@"ZLShopManagerNoteCell"];
    }
    return cell;
}

@end
