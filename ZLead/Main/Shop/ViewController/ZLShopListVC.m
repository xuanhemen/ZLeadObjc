//
//  ZLShopListVC.m
//  ZLead
//
//  Created by dmy on 2019/5/25.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLShopListVC.h"
#import "ZLShopListCell.h"
#import "ZLAddShopVC.h"

@interface ZLShopListVC () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *shopListTableView;

@end

@implementation ZLShopListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViews];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
    self.title = @"店铺切换";
}


#pragma mark - Views

- (void)setupViews {
    __weak typeof (self) weakSelf = self;
    self.shopListTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.shopListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.shopListTableView.delegate = self;
    self.shopListTableView.dataSource = self;
    self.shopListTableView.tableFooterView = [self createTableViewFooterView];
    [self.shopListTableView registerClass:[ZLShopListCell class] forCellReuseIdentifier:@"ZLShopListCell"];
    self.shopListTableView.backgroundColor = [UIColor clearColor];
    self.shopListTableView.backgroundView = nil;
    [self.view addSubview:self.shopListTableView];
    
    [self.shopListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.view);
        make.height.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view);
    }];
}

- (UIView *)createTableViewFooterView {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWith, dis(115))];
    UIButton *addShopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addShopButton.frame = kRect(24, 60, 327, 44);
    addShopButton.backgroundColor = [UIColor colorWithHexString:@"#FFB223"];
    addShopButton.layer.cornerRadius = dis(22);
    [addShopButton setTitle:@"新增店铺" forState:UIControlStateNormal];
    [addShopButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addShopButton.titleLabel.font = kFont16;
    [footerView addSubview:addShopButton];
    [addShopButton addTarget:self action:@selector(addShopButtonAction) forControlEvents:UIControlEventTouchUpInside];
    return footerView;
}

#pragma mark - UIButton Actions

- (void)addShopButtonAction {
    self.hidesBottomBarWhenPushed = YES;
    ZLAddShopVC *addShopVC = [[ZLAddShopVC alloc] init];
    [self.navigationController pushViewController:addShopVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   return [ZLShopListCell heightForCell];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZLBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLShopListCell"];
    return cell;
}

@end

