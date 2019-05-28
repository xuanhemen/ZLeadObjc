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

- (void)loadView {
    self.makeOrderView = [[ZLMakeOrderView alloc] init];
    self.view = _makeOrderView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
//    [self setupViews];
    self.title = @"一键开单";
    [self config];
    [self setupData];

}

- (void)setupData {
    for (int i = 0; i < 10; i++) {
        ZLShopGoodsModel *goodsModel = [[ZLShopGoodsModel alloc] init];
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

#pragma mark - private Method

- (void)totalPrice {
    
}

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
    [((ZLShoppingCartCell *)cell).shoppingCartView setSubviewsFrame:YES];
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

@end

