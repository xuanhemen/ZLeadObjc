//
//  ZLShopListVC.m
//  ZLead
//
//  Created by dmy on 2019/5/25.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLShopListVC.h"
#import "ZLShopListCell.h"

@interface ZLShopListVC () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *shopListTableView;

@end

@implementation ZLShopListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViews];
    
    self.title = @"店铺切换";
}


#pragma mark - Views

- (void)setupViews {
    __weak typeof (self) weakSelf = self;
    self.shopListTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.shopListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.shopListTableView.delegate = self;
    self.shopListTableView.dataSource = self;
    [self.shopListTableView registerClass:[ZLShopListCell class] forCellReuseIdentifier:@"ZLShopListCell"];
    [self.view addSubview:self.shopListTableView];
    
    [self.shopListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.view);
        make.height.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view);
    }];

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

