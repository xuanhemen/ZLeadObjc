//
//  ZLShopListVC.m
//  ZLead
//
//  Created by dmy on 2019/5/25.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLShopListVC.h"
#import "ZLShopListCell.h"
#import "ZLAddStoreVC.h"
#import "ZLShopModel.h"

@interface ZLShopListVC () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *shopListTableView;

@property (nonatomic, strong)UIView *footer;

@property (nonatomic, strong) NSArray *shopList;
@end

@implementation ZLShopListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViews];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
    self.title = @"店铺切换";
    [self setupData];
}


#pragma mark - Views

- (void)setupViews {
    __weak typeof (self) weakSelf = self;
    self.shopListTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.shopListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.shopListTableView.delegate = self;
    self.shopListTableView.dataSource = self;
    self.shopListTableView.tableFooterView = self.footer;
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

#pragma mark - setupData

- (void)setupData {
    [[NetManager sharedInstance] getShopListWithUserId:@"0010001770316129" sucess:^(NSArray *dataList, NSInteger total) { //@"0010000137432355"
        self.shopList = dataList;
        [self.shopListTableView reloadData];
    } fail:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.shopList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   return [ZLShopListCell heightForCell];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZLBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLShopListCell"];
    [cell setupData:[self.shopList objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - action
- (void)addStore:(UIButton *)sender {
    ZLAddStoreVC *addStoreVc = [[ZLAddStoreVC alloc] init];
    [self.navigationController pushViewController:addStoreVc animated:YES];
}

#pragma mark - lazy load
- (UIView *)footer {
    if (!_footer) {
        _footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
        _footer.backgroundColor = [UIColor zl_bgColor];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor colorWithHexString:@"#FFB223"];
        btn.layer.cornerRadius = dis(45)/2;
        [btn setTitle:@"新增店铺" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_footer addSubview:btn];
        [btn addTarget:self action:@selector(addStore:) forControlEvents:UIControlEventTouchUpInside];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->_footer).offset(25);
            make.centerX.equalTo(self->_footer);
            make.top.equalTo(self->_footer).offset(60);
            make.height.mas_equalTo(dis(45));
        }];
    }
    return _footer;
}

@end

