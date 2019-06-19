//
//  ZLMakeOrderVC.m
//  ZLead
//
//  Created by dmy on 2019/5/27.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLMakeOrderVC.h"
#import "ZLMakeOrderView.h"
#import "ZLShoppingCartCell.h"
#import "ZLShopGoodsModel.h"
#import "ZLGoodsBillVC.h"

@interface ZLMakeOrderVC () <UITableViewDataSource, UITableViewDelegate, ZLShoppingCartCellDelegate>
@property (nonatomic, strong) ZLMakeOrderView *makeOrderView;
@property (nonatomic, strong) NSMutableArray *goodsList;
@end

@implementation ZLMakeOrderVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:[UIColor blackColor]}];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
    [super willMoveToParentViewController:parent];
    if (!parent) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        self.navigationController.navigationBar.barTintColor = [UIColor zl_mainColor];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    }
}

- (void)loadView {
    self.makeOrderView = [[ZLMakeOrderView alloc] init];
    self.view = _makeOrderView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self setupViews];
    [self config];
    [self configNav];
    [self setupData];

}

- (void)setupData {
    for (int i = 0; i < 10; i++) {
        ZLShopGoodsModel *goodsModel = [[ZLShopGoodsModel alloc] init];
        goodsModel.salePrice = i + 1;
        goodsModel.goodsNum = i+1;
        [self.goodsList addObject:goodsModel];
    }
    [self.makeOrderView.goodsListTableView reloadData];
}

#pragma mark - init

- (NSMutableArray *)goodsList {
    if (!_goodsList) {
        NSMutableArray *goodsList = [[NSMutableArray alloc] initWithCapacity:0];
        self.goodsList = goodsList;
    }
    return _goodsList;
}

#pragma mark - Views

- (void)setupViews {
    
}

- (void)config {
    self.makeOrderView.goodsListTableView.delegate = self;
    self.makeOrderView.goodsListTableView.dataSource = self;
    kWeakSelf(weakSelf);
    self.makeOrderView.allSelectedBlock = ^(BOOL isSelected) {
        for (int i = 0; i < weakSelf.goodsList.count; i++) {
            ZLShopGoodsModel *goodsModel = weakSelf.goodsList[i];
            goodsModel.isSelected = isSelected;
        }
        [weakSelf.makeOrderView.goodsListTableView reloadData];
    };
    self.makeOrderView.calculateButtonBlock = ^{
        weakSelf.hidesBottomBarWhenPushed = YES;
        ZLGoodsBillVC *billVC = [[ZLGoodsBillVC alloc] init];
        [weakSelf.navigationController pushViewController:billVC animated:YES];
    };
}

- (void)configNav {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(0, 0, 19, 19);
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, dis(200), 30)];
    titleLabel.text = @"一键开单";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor colorWithHexString:@"#202020"];
    titleLabel.lineBreakMode = NSLineBreakByTruncatingHead;
    titleLabel.font = [UIFont systemFontOfSize:17];
    self.navigationItem.titleView = titleLabel;
    
    UIButton *filterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [filterButton setTitleColor:[UIColor zl_mainColor] forState:UIControlStateNormal];
    [filterButton setTitle:@"筛选" forState:UIControlStateNormal];
    filterButton.titleLabel.font = kFont15;
    filterButton.frame = CGRectMake(0, 0, 19, 19);
    [filterButton setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [filterButton addTarget:self action:@selector(filterButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithCustomView:filterButton];
    self.navigationItem.rightBarButtonItem = rightItem1;
    
    UIButton *scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [scanButton setImage:[UIImage imageNamed:@"shop-scan-icon"] forState:UIControlStateNormal];
    scanButton.frame = CGRectMake(0, 0, 19, 19);
    [scanButton addTarget:self action:@selector(scanButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem2 = [[UIBarButtonItem alloc] initWithCustomView:scanButton];
    self.navigationItem.rightBarButtonItems = @[rightItem2, rightItem1];
}

#pragma mark - UIButton Action

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)filterButtonAction {
    
}

- (void)scanButtonAction {
    
}

#pragma mark - private Method

/**
 是否全选
 */
- (void)judgeIsAllSelected {
    NSInteger count = 0;
    //先遍历购物车商品, 得到购物车有多少商品
    for (ZLShopGoodsModel *goodsModel in self.goodsList) {
        if (goodsModel.isSelected) {
            count ++;
        }
        
    }
    //如果购物车总商品数量 等于 选中的商品数量, 即表示全选了
    if (count == self.goodsList.count) {
        self.makeOrderView.allSelectedButton.selected = YES;
    } else {
        self.makeOrderView.allSelectedButton.selected = NO;
    }
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.goodsList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZLShoppingCartCell heightForCell];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZLBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLShoppingCartCell"];
    [((ZLShoppingCartCell *)cell).shoppingCartView setSubviewsFrame:NO];
    [(ZLShoppingCartCell *)cell setupData:[self.goodsList objectAtIndex:indexPath.row]];
    ((ZLShoppingCartCell *)cell).delegate = self;
    return cell;
}

#pragma mark - ZLShoppingCartCellDelegate

- (void)numButtonClick:(ZLShoppingCartCell *)cell isAdd:(BOOL)isAdd {
    NSIndexPath *index = [self.makeOrderView.goodsListTableView indexPathForCell:cell];
    if (isAdd) {
        ZLShopGoodsModel *goodsModel = self.goodsList[index.row];
        if (goodsModel.goodsNum > 0) {
            goodsModel.goodsNum ++;
        }
    } else {
        ZLShopGoodsModel *goodsModel = self.goodsList[index.row];
        if (goodsModel.goodsNum > 1) {
            goodsModel.goodsNum --;
        }
    }
    [self.makeOrderView.goodsListTableView reloadData];
    [self judgeIsAllSelected];
}

- (void)selectedButtonClick:(ZLShoppingCartCell *)cell isSelected:(BOOL)isSelected {
    NSIndexPath *index = [self.makeOrderView.goodsListTableView indexPathForCell:cell];
    ZLShopGoodsModel *goodsModel = self.goodsList[index.row];
    goodsModel.isSelected = isSelected;
    [self.makeOrderView.goodsListTableView reloadData];
    [self judgeIsAllSelected];
}

@end

