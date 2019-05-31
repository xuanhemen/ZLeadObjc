//
//  ZLGoodsVC.m
//  ZLead
//
//  Created by 董建伟 on 2019/5/23.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLGoodsVC.h"
#import "ZLGoodsHeaderView.h"
#import "ZLGoodsListCell.h"

#import "ZLGoodsSearchVC.h"

@interface ZLGoodsVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)ZLGoodsHeaderView *headerView;
@property (nonatomic, strong)UITableView *tableView;

/** <#注释#> */
@property (nonatomic,assign) BOOL allowEdit;



@end

@implementation ZLGoodsVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[UIColor zl_mainColor]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.tintColor = [UIColor blueColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self styleForNav];
    [self layoutChildViews];
}
/** 导航栏 */
- (void)styleForNav {
    UIView *searchV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, dis(255), 30)];
    searchV.backgroundColor = [UIColor whiteColor];
    searchV.layer.cornerRadius = 15;
    self.navigationItem.titleView = searchV;
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapG:)];
    [searchV addGestureRecognizer:tapG];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(abbccc)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithTitle:@"管理" style:UIBarButtonItemStyleDone target:self action:@selector(managerBtnClicked:)];
    UIBarButtonItem *rightItem2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(abbccc)];
    self.navigationItem.rightBarButtonItems = @[rightItem2, rightItem1];
}

- (void)layoutChildViews {
    self.headerView = [[ZLGoodsHeaderView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, kScreenWidth, 45)];
    [self.view addSubview:self.headerView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.headerView.mas_bottom);
        make.bottom.equalTo(self.view);
    }];
}

#pragma mark - action
- (void)tapG:(UITapGestureRecognizer *)tap {
    ZLGoodsSearchVC *searchVc = [[ZLGoodsSearchVC alloc] init];
    [self.navigationController pushViewController:searchVc animated:NO];
}

- (void)managerBtnClicked:(UIBarButtonItem *)sender {
    sender.title = self.allowEdit ? @"管理": @"完成";
    self.allowEdit = !self.allowEdit;
}

- (void)abbccc {
    
}

#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return dis(130);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZLGoodsListCell *cell = [ZLGoodsListCell listCellWithTableView:tableView];
    cell.allowEdit = self.allowEdit;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        NSLog(@"删除");
        
    }];
//    [[UIButton appearanceWhenContainedInInstancesOfClasses:@[[ZLGoodsListCell class]]] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    action1.backgroundColor = [UIColor colorWithHexString:@"#F0F0F0"];
    
    
    UITableViewRowAction *action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"下架" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        NSLog(@"更多");
        
    }];
    
    action2.backgroundColor = [UIColor colorWithHexString:@"#FFB32A"];
    
    UITableViewRowAction *action3 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"置顶" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    action3.backgroundColor = [UIColor colorWithHexString:@"#FF7527"];
    
    UITableViewRowAction *action4 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"取消\n置顶" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    action4.backgroundColor = [UIColor colorWithHexString:@"#FF3731"];
    
    NSArray *arr = @[action4,action3, action2, action1];
    
    return arr;
}

#pragma mark - setter
- (void)setAllowEdit:(BOOL)allowEdit {
    _allowEdit = allowEdit;
    [self.tableView reloadData];
}

#pragma mark - lazy load
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

@end
