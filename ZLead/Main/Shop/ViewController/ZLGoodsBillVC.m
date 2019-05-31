//
//  ZLGoodsBillVC.m
//  ZLead
//
//  Created by dmy on 2019/5/28.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLGoodsBillVC.h"
#import "ZLGoodsBillView.h"
#import "ZLGoodsBillCell.h"
#import "ZLPaymentMethodCell.h"
#import "ZLShopGoodsModel.h"
#import "ZLPaymentMethodSectionHeaderView.h"

@interface ZLGoodsBillVC () <UITableViewDataSource, UITableViewDelegate, ZLShoppingCartCellDelegate>
@property (nonatomic, strong) ZLGoodsBillView *goodsBillView;
@property (nonatomic, strong) NSMutableArray *goodsList;
@end

@implementation ZLGoodsBillVC

- (void)loadView {
    self.goodsBillView = [[ZLGoodsBillView alloc] init];
    self.view = _goodsBillView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    [self.goodsBillView.billTableView reloadData];
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
    self.goodsBillView.billTableView.delegate = self;
    self.goodsBillView.billTableView.dataSource = self;
    kWeakSelf(weakSelf);
//    self.goodsBillView.allSelectedBlock = ^(BOOL isSelected) {
//        for (int i = 0; i < weakSelf.goodsList.count; i++) {
//            ZLShopGoodsModel *goodsModel = weakSelf.goodsList[i];
//            goodsModel.isSelected = isSelected;
//        }
//        [weakSelf.goodsBillView.goodsListTableView reloadData];
//    };
}

#pragma mark - private Method

- (void)totalPrice {
    
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.goodsList.count;
    } else {
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [ZLGoodsBillCell heightForCell];
    } else {
        return [ZLPaymentMethodCell heightForCell];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZLBaseCell *cell = nil;
    if (indexPath.section == 0) {
        cell =[tableView dequeueReusableCellWithIdentifier:@"ZLGoodsBillCell"];
        [cell setupData:[self.goodsList objectAtIndex:indexPath.row]];
        //    [((ZLGoodsBillCell *)cell).shoppingCartView setSubviewsFrame:NO];
        ((ZLGoodsBillCell *)cell).delegate = self;
    } else {
       cell= [tableView dequeueReusableCellWithIdentifier:@"ZLPaymentMethodCell"];
        [cell setupData:nil];
    }
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        ZLPaymentMethodSectionHeaderView *headerView = [[ZLPaymentMethodSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, dis(53))];
        return headerView;
    } else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return dis(53);
    } else {
        return CGFLOAT_MIN;
    }
}

#pragma mark - ZLShoppingCartCellDelegate

- (void)numButtonClick:(ZLShoppingCartCell *)cell isAdd:(BOOL)isAdd {
    NSIndexPath *index = [self.goodsBillView.billTableView indexPathForCell:cell];
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
    [self.goodsBillView.billTableView reloadData];
}

@end
