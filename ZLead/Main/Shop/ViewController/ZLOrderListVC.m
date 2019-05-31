//
//  ZLOrderListVC.m
//  ZLead
//
//  Created by dmy on 2019/5/30.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLOrderListVC.h"
#import "ZLOrderListCell.h"

@interface ZLOrderListVC () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *orderListTableView;
@end

@implementation ZLOrderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViews];
}

- (void)setupViews {
    self.orderListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarHeight - dis(42)) style:UITableViewStylePlain];
    self.orderListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.orderListTableView.backgroundColor = [UIColor clearColor];
    [self.orderListTableView registerClass:[ZLOrderListCell class] forCellReuseIdentifier:@"ZLOrderListCell"];
    self.orderListTableView.delegate = self;
    self.orderListTableView.dataSource = self;
    [self.view addSubview:self.orderListTableView];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZLOrderListCell heightForCell];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZLBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLOrderListCell"];
    [cell setupData:nil];
    return cell;
}

@end
