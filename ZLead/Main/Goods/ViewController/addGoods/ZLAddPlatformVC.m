//
//  ZLAddPlatformVC.m
//  ZLead
//
//  Created by 董建伟 on 2019/6/5.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLAddPlatformVC.h"
#import "ZLSearchAddPlatformGoodsVC.h"
#import "ZLAddPlatformGoodsCell.h"
#import "ZLFilterView.h"
#import "ZLBatchSetClassifyView.h"
#import "ZLShopGoodsSearchBarView.h"

#import "ZLGoodsSearchVC.h"

#import "ZLGoodsModel.h"
#import "ZLFilterDataModel.h"
#import "ZLClassifyItemModel.h"

@interface ZLAddPlatformVC ()<UITableViewDelegate, UITableViewDataSource, ZLAddPlatformGoodsCellDelegate, ZLFilterViewDelegate>
@property (nonatomic, strong) UITableView *goodsListTableView;
@property (nonatomic, strong) ZLBatchSetClassifyView *batchSetClassifyView;
@property (nonatomic, strong) NSMutableArray *goodsList;
@property (nonatomic, strong) ZLFilterView *filterView;
@property (nonatomic, assign) BOOL showFilter;
@property (nonatomic, strong) ZLFilterDataModel *filterDataModel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) ZLShopGoodsSearchBarView *searchBarView;
@property (nonatomic, assign) NSInteger goodsTotalNum;
@property (nonatomic, strong) UIButton *importButton;
@property (nonatomic, assign) NSInteger pageIndex;
@end

@implementation ZLAddPlatformVC

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

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configNav];
    
    [self setupViews];
    
    self.pageIndex = 1;
    [self setupData];
    
    [self getClassifyList];
}

/** 导航栏 */
- (void)configNav {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(0, 0, 40, 30);
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, dis(200), 30)];
    self.titleLabel.text = @"从平台添加商品";
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#202020"];
    self.titleLabel.lineBreakMode = NSLineBreakByTruncatingHead;
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = self.titleLabel;
    
    self.importButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.importButton setTitle:@"导入" forState:UIControlStateNormal];
    self.importButton.titleLabel.font = kFont14;
    self.importButton.frame = CGRectMake(0, 0, 40, 19);
    [self.importButton setTitleColor:self.goodsTotalNum ? [UIColor zl_mainColor] : [UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [self.importButton addTarget:self action:@selector(importButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithCustomView:self.importButton];
    
    UIButton *filterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [filterButton setTitle:@"筛选" forState:UIControlStateNormal];
    filterButton.titleLabel.font = kFont14;
    filterButton.frame = CGRectMake(0, 0, 40, 19);
    [filterButton setTitleColor:[UIColor zl_mainColor] forState:UIControlStateNormal];
    [filterButton addTarget:self action:@selector(classificationButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem2 = [[UIBarButtonItem alloc] initWithCustomView:filterButton];
    self.navigationItem.rightBarButtonItems = @[rightItem2, rightItem1];
}

- (void)setupViews {
    self.searchBarView = [[ZLShopGoodsSearchBarView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, kScreenWidth, dis(50))];
    kWeakSelf(weakSelf)
    self.searchBarView.startSearchBlock = ^{
        ZLSearchAddPlatformGoodsVC *searchVC = [[ZLSearchAddPlatformGoodsVC alloc] init];
        [weakSelf.navigationController pushViewController:searchVC animated:NO];
    };
    [self.view addSubview:self.searchBarView];
    
   [self.batchSetClassifyView setSelectedGoodsNum:0];
}


- (void)addTableRefresh {
    self.goodsListTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    self.goodsListTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
}

#pragma mark - Init

- (NSMutableArray *)goodsList {
    if (!_goodsList) {
        _goodsList = [[NSMutableArray alloc] init];
    }
    return _goodsList;
}

#pragma mark - setupData

- (void)setupData {
    [self getPlatformGoodsList:self.pageIndex refreshPart:nil];
}

- (void)getPlatformGoodsList:(NSInteger)pageNum refreshPart:(NSString *)refreshPart {
    [[NetManager sharedInstance] getPlatformGoodsList:pageNum shopId:@"1" sucess:^(NSArray * _Nonnull dataList, NSInteger total) {
        if (self.pageIndex == 1) {
            [self.goodsList removeAllObjects];
        }
        [self.goodsList addObjectsFromArray:dataList];
        [self.goodsListTableView reloadData];
    } fail:^(NSError * _Nonnull error) {
        
    }];
}

- (void)getClassifyList {
    [self getAllPlatFormClassWithSucess:^(NSArray *dataList) {
        
    }];
}

- (void)getPlatFormClassWithParentId:(NSString *)parentId sucess:(void (^) (NSArray *dataList))sucess {
    [[NetManager sharedInstance] getPlatFormClass:parentId sucess:^(NSArray * _Nonnull dataList, NSInteger total) {
        if ([parentId isEqualToString:@"0"]) {
            [self updateFilterMenuData:dataList];
        }
        sucess(dataList);
    } fail:^(NSError * _Nonnull error) {
        
    }];
}

- (void)getAllPlatFormClassWithSucess:(void (^) (NSArray *dataList))sucess {
    [[NetManager sharedInstance] getAllPlatFormClassWithsSucess:^(NSArray * _Nonnull dataList, NSInteger total) {
        [self updateFilterMenuData:dataList];
    } fail:^(NSError * _Nonnull error) {
        
    }];
}

- (void)updateFilterMenuData:(NSArray *)dataList {
    NSMutableArray *sectionDataList = [[NSMutableArray alloc] initWithArray:self.filterDataModel.dataList];
    for (int i = 0; i < self.filterDataModel.dataList.count; i++) {
        ZLFilterDataModel *firstFilterDataModel = [sectionDataList objectAtIndex:i];
        if (i == 0) {
            
        } else if (i == 1) {
            firstFilterDataModel.isUnflod = YES;
            firstFilterDataModel.selectedClassifyItemModel = nil;
            firstFilterDataModel.dataList = dataList;
        } else {
            firstFilterDataModel.isUnflod = NO;
            firstFilterDataModel.selectedClassifyItemModel = nil;
            firstFilterDataModel.dataList = [NSArray array];
        }
        [sectionDataList replaceObjectAtIndex:i withObject:firstFilterDataModel];
    }
    self.filterDataModel.dataList = sectionDataList;
    [self.filterView reloadData:self.filterDataModel];
}
- (void)headerRefresh {
    self.pageIndex = 1;
    [self getPlatformGoodsList:self.pageIndex refreshPart:kRefreshHeader];
}

- (void)footerRefresh {
    self.pageIndex ++;
    [self getPlatformGoodsList:self.pageIndex refreshPart:kRefreshFooter];
}

#pragma mark - setter

- (void)setGoodsTotalNum:(NSInteger)goodsTotalNum {
    _goodsTotalNum = goodsTotalNum;
    [self.importButton setTitleColor:_goodsTotalNum ? [UIColor zl_mainColor] : [UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [self.batchSetClassifyView setSelectedGoodsNum:_goodsTotalNum];
}

#pragma mark - private Method

- (void)calculateGoodsTotalNum {
    NSInteger count = 0;
    for (int i = 0; i < self.goodsList.count; i++) {
        ZLGoodsModel *goodsModel = [self.goodsList objectAtIndex:i];
        if (goodsModel.isSelected) {
            count ++;
        }
    }
    self.goodsTotalNum = count;
}

/**
 是否全选
 */
- (void)judgeIsAllSelected {
   
}

- (void)allSelected:(BOOL )isSelected {
    for (int i = 0; i < self.goodsList.count; i++) {
        ZLGoodsModel *goodsModel = [self.goodsList objectAtIndex:i];
        goodsModel.goodsNum = i+1;
        goodsModel.isSelected = isSelected;
        [self.goodsList addObject:goodsModel];
    }
    [self.goodsListTableView reloadData];
}

- (void)batchSetClassify:(ZLClassifyItemModel *)firstClassify secondClassify:(ZLClassifyItemModel *)secondClassify thirdClassify:(ZLClassifyItemModel *)thirdClassify {
    for (int i = 0; i < self.goodsList.count; i++) {
        ZLGoodsModel *goodsModel = [self.goodsList objectAtIndex:i];
        if (goodsModel.isSelected) {
            goodsModel.goodsClassName1 = firstClassify.title;
            goodsModel.goodsClassName2 = secondClassify.title;
            goodsModel.goodsClassName3 = thirdClassify.title;
            goodsModel.goodsClassId1 = firstClassify.classifyId;
            goodsModel.goodsClassId2 = secondClassify.classifyId;
            goodsModel.goodsClassId3 = thirdClassify.classifyId;
        }
    }
    [self.goodsListTableView reloadData];
}

#pragma mark - action

- (void)classificationButtonAction:(UIButton *)btn {
    if (!self.showFilter) {
        [self.filterView dismiss];
        kWeakSelf(weakSelf)
        self.filterView = [ZLFilterView createFilterViewWidthConfiguration:self.filterDataModel pushDirection:ZLFilterViewPushDirectionFromRight  filterViewBlock:^(ZLClassifyItemModel * _Nonnull firstClassify, ZLClassifyItemModel * _Nonnull secondClassify, ZLClassifyItemModel * _Nonnull thirdClassify) {
            [weakSelf batchSetClassify:firstClassify secondClassify:secondClassify thirdClassify:thirdClassify];
        }];
        self.filterView.delegate = self;
        self.filterView.isPlatform = YES;
        self.filterView.durationTime = 0.5;
        [self.filterView show];
        
        [self getAllPlatFormClassWithSucess:^(NSArray *dataList) {
            
        }];
    } else {
        [self.filterView dismiss];
    }
}

- (void)importButtonAction:(UIButton *)sender {
    [self.view endEditing:YES];
    if (self.goodsTotalNum <= 0) {
        [self showMsg:@"请选择要导入的商品"];
        return;
    }
    NSMutableArray *dicts = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < self.goodsList.count; i++) {
        ZLGoodsModel *goods = [self.goodsList objectAtIndex:i];
        if (goods.isSelected) {
            if (goods.goodsName.length <= 0) {
                [self showMsg:@"请输入商品名称"];
                return;
            }
            float offlinePrice = [goods.offlinePrice floatValue];
            float onlinePrice = [goods.onlinePrice floatValue];
            if (goods.onlinePrice.length <= 0 || onlinePrice <= 0) {
                [self showMsg:@"请输入网店售价"];
                return;
            }
            
            if (goods.offlinePrice.length <= 0  || offlinePrice <= 0) {
                [self showMsg:@"请输入门店售价"];
                return;
            }
            if (goods.goodsClassId1.length <= 0) {
                [self showMsg:@"请设置一级分类"];
                return;
            }
            if (goods.goodsClassId2.length <= 0) {
                [self showMsg:@"请设置二级分类"];
                return;
            }
            NSMutableDictionary *goodsDicts = [NSMutableDictionary dictionary];
            goodsDicts[@"shopId"] = [ZLUserInfo sharedInstance].currentShopId;
            goodsDicts[@"spuCode"] = goods.spuCode;
            goodsDicts[@"sgInventory"] = [NSString stringWithFormat:@"%@", @(goods.goodsNum)];
            goodsDicts[@"sgpPublicEprice"] = goods.onlinePrice;
            goodsDicts[@"sgpPublicPrice"] = goods.offlinePrice;
            goodsDicts[@"shopClass1"] = goods.goodsClassId1;
            goodsDicts[@"shopClass2"] = goods.goodsClassId2;
            goodsDicts[@"pgId"] = goods.spuId;
            [dicts addObject:goodsDicts];
        }
    }
    [[NetManager sharedInstance] importGoods:dicts sucess:^{
        DLog(@"导入商品成功");
        [self.importButton setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        self.pageIndex = 1;
        [self setupData];
    } fail:^(NSError * _Nonnull error) {
        
    }];
}

- (void)filterButtonAction {
    
}

- (void)backAction  {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.goodsList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZLAddPlatformGoodsCell heightForCell:[self.goodsList objectAtIndex:indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZLAddPlatformGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLAddPlatformGoodsCell"];
    cell.delegate = self;
    [cell setupData:[self.goodsList objectAtIndex:indexPath.row]];
    kWeakSelf(weakSelf);
    cell.selectedButtonBlock = ^(ZLAddPlatformGoodsCell * _Nonnull cell, BOOL isSelected) {
        ZLGoodsModel *goodsModel = [weakSelf.goodsList objectAtIndex:indexPath.row];
        goodsModel.isSelected = !goodsModel.isSelected;
        [weakSelf calculateGoodsTotalNum];
        [weakSelf.goodsListTableView beginUpdates];
        [weakSelf.goodsListTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [weakSelf.goodsListTableView endUpdates];
    };
    return cell;
}

#pragma mark - lazy load

- (UITableView *)goodsListTableView {
    if (!_goodsListTableView) {
        _goodsListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavBarHeight + dis(50), kScreenWidth, kScreenHeight - kNavBarHeight - dis(100)) style:UITableViewStylePlain];
        _goodsListTableView.delegate = self;
        _goodsListTableView.dataSource = self;
        [self.view addSubview:_goodsListTableView];
        _goodsListTableView.tableFooterView = [UIView new];
        _goodsListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_goodsListTableView registerClass:[ZLAddPlatformGoodsCell class] forCellReuseIdentifier:@"ZLAddPlatformGoodsCell"];
        
    }
    return _goodsListTableView;
}

- (ZLBatchSetClassifyView *)batchSetClassifyView {
    if (!_batchSetClassifyView) {
        _batchSetClassifyView = [[ZLBatchSetClassifyView alloc] initWithFrame:CGRectMake(0, kScreenHeight - dis(50) - kSafeHeight, kScreenWidth, dis(50))];
        [self.view addSubview:_batchSetClassifyView];
        kWeakSelf(weakSelf)
        _batchSetClassifyView.batchSetClassifyBlock = ^{
            [weakSelf.filterView dismiss];
            weakSelf.filterView = [ZLFilterView createFilterViewWidthConfiguration:weakSelf.filterDataModel pushDirection:ZLFilterViewPushDirectionFromRight  filterViewBlock:^(ZLClassifyItemModel * _Nonnull firstClassify, ZLClassifyItemModel * _Nonnull secondClassify, ZLClassifyItemModel * _Nonnull thirdClassify) {
                DLog(@"批量设置分类");
                [weakSelf batchSetClassify:firstClassify secondClassify:secondClassify thirdClassify:thirdClassify];
            }];
            weakSelf.filterView.delegate = weakSelf;
            weakSelf.filterView.isPlatform = YES;
            weakSelf.filterView.durationTime = 0.5;
            [weakSelf.filterView show];
        };
    }
    [self getAllPlatFormClassWithSucess:^(NSArray *dataList) {
        
    }];
    return _batchSetClassifyView;
}

- (ZLFilterDataModel *)filterDataModel {
    if (!_filterDataModel) {
        _filterDataModel = [[ZLFilterDataModel alloc] init];
        NSArray *sectionTitles = @[@"", @"一级分类", @"二级分类", @"三级分类"];
        NSMutableArray *allItems = [[NSMutableArray alloc] init];
        ZLFilterDataModel *filterDataModel  = [[ZLFilterDataModel alloc] init];
        filterDataModel.sectionName = [sectionTitles objectAtIndex:0];
        filterDataModel.indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [allItems addObject:filterDataModel];
        for (NSInteger section = 1; section < sectionTitles.count; section ++) {
            ZLFilterDataModel *filterDataModel  = [[ZLFilterDataModel alloc] init];
            filterDataModel.sectionName = [sectionTitles objectAtIndex:section];
            filterDataModel.indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
            if (section == 1) {
                filterDataModel.isUnflod = YES;
            }
            [allItems addObject:filterDataModel];
        }
        self.filterDataModel.dataList = allItems;
    }
    return _filterDataModel;
}

#pragma mark - ZLAddPlatformGoodsCellDelegate

- (void)addPlatformGoodsCell:(ZLAddPlatformGoodsCell *)cell goodsNameChanged:(NSString *)goodsName {
    NSIndexPath *indexPath = [self.goodsListTableView indexPathForCell:cell];
    ZLGoodsModel *goodsModel = [self.goodsList objectAtIndex:indexPath.row];
    goodsModel.goodsName = goodsName;
}

- (void)addPlatformGoodsCell:(ZLAddPlatformGoodsCell *)cell goodsNumChanged:(NSInteger )goodsNum {
    NSIndexPath *indexPath = [self.goodsListTableView indexPathForCell:cell];
    ZLGoodsModel *goodsModel = [self.goodsList objectAtIndex:indexPath.row];
    goodsModel.goodsNum = goodsNum;
}

- (void)addPlatformGoodsCell:(ZLAddPlatformGoodsCell *)cell goodsNumOnlinePriceChanged:(CGFloat )onlinePrice {
    NSIndexPath *indexPath = [self.goodsListTableView indexPathForCell:cell];
    ZLGoodsModel *goodsModel = [self.goodsList objectAtIndex:indexPath.row];
    goodsModel.onlinePrice = [NSString stringWithFormat:@"%.2f", onlinePrice];
//    [self.goodsListTableView beginUpdates];
//    [self.goodsListTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//    [self.goodsListTableView endUpdates];
}

- (void)addPlatformGoodsCell:(ZLAddPlatformGoodsCell *)cell goodsNumOfflinePriceChanged:(CGFloat )offlinePrice {
    NSIndexPath *indexPath = [self.goodsListTableView indexPathForCell:cell];
    ZLGoodsModel *goodsModel = [self.goodsList objectAtIndex:indexPath.row];
    goodsModel.offlinePrice = [NSString stringWithFormat:@"%.2f", offlinePrice];
}

- (void)addPlatformGoodsCell:(ZLAddPlatformGoodsCell *)cell shopClassifyNameButton:(UIButton *)classifyNameButton {
    kWeakSelf(weakSelf)
    self.filterView = [ZLFilterView createFilterViewWidthConfiguration:self.filterDataModel pushDirection:ZLFilterViewPushDirectionFromRight  filterViewBlock:^(ZLClassifyItemModel * _Nonnull firstClassify, ZLClassifyItemModel * _Nonnull secondClassify, ZLClassifyItemModel * _Nonnull thirdClassify) {
        NSIndexPath *indexPath = [weakSelf.goodsListTableView indexPathForCell:cell];
        ZLGoodsModel *goodsModel = [weakSelf.goodsList objectAtIndex:indexPath.row];
        goodsModel.goodsClassName1 = firstClassify.title;
        goodsModel.goodsClassName2 = secondClassify.title;
        goodsModel.goodsClassName3 = thirdClassify.title;
        goodsModel.goodsClassId1 = firstClassify.classifyId;
        goodsModel.goodsClassId2 = secondClassify.classifyId;
        goodsModel.goodsClassId3 = thirdClassify.classifyId;
        [classifyNameButton setTitle:[NSString stringWithFormat:@"%@/%@/%@", firstClassify.title, secondClassify.title, thirdClassify.title] forState:UIControlStateNormal];
        [cell setupData:goodsModel];
    }];
    self.filterView.isPlatform = YES;
    self.filterView.delegate = self;
    self.filterView.durationTime = 0.5;
    [self.filterView show];
}

#pragma mark - ZLFilterViewDelegate
//选择上一级的分类刷新下一级的数据,如果点的是平台/店铺刷新整个列表
- (void)filterView:(ZLFilterView *)filterView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ZLFilterDataModel *filterDataModel = [self.filterDataModel.dataList objectAtIndex:indexPath.section];
    filterDataModel.isUnflod = NO;
    ZLClassifyItemModel *classifyItemModel = [filterDataModel.dataList objectAtIndex:indexPath.row];
    //请求下一级的数据
    //刷新下一级的数据
    if (indexPath.section == 0) {//平台分类和店铺分类切换
        if (indexPath.row == 0) {
//            [self getShopClassWithParentId:@"0" sucess:^(NSArray *dataList) {
//
//            }];
        } else {
//            [self getPlatFormClassWithParentId:@"0" sucess:^(NSArray *dataList) {
//
//            }];
        }
    } else {
        NSInteger nextSection = indexPath.section + 1;
        if (nextSection < self.filterDataModel.dataList.count) {
            ZLFilterDataModel *nextFilterDataModel = [self.filterDataModel.dataList objectAtIndex:indexPath.section + 1];
            nextFilterDataModel.isUnflod = YES;
            nextFilterDataModel.selectedClassifyItemModel = nil;
            nextFilterDataModel.dataList = classifyItemModel.childrenList;
            NSMutableArray *dataList = [[NSMutableArray alloc] initWithArray:self.filterDataModel.dataList];
            [dataList replaceObjectAtIndex:indexPath.section + 1 withObject:nextFilterDataModel];
            self.filterDataModel.dataList = dataList;
            [filterView reloadData:self.filterDataModel section:indexPath.section + 1];
        }
    }
}


@end


