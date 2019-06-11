//
//  ZLAddPlatformVC.m
//  ZLead
//
//  Created by 董建伟 on 2019/6/5.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLAddPlatformVC.h"
#import "ZLAddPlatformGoodsCell.h"
#import "ZLFilterView.h"
#import "ZLBatchSetClassifyView.h"
#import "ZLShopGoodsSearchBarView.h"

#import "ZLGoodsSearchVC.h"

#import "ZLGoodsModel.h"
#import "ZLFilterDataModel.h"
#import "ZLClassifyItemModel.h"

@interface ZLAddPlatformVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *goodsListTableView;
@property (nonatomic, strong) ZLBatchSetClassifyView *batchSetClassifyView;
@property (nonatomic, strong) NSMutableArray *goodsList;
@property (nonatomic, strong) ZLFilterView *filterView;
@property (nonatomic, assign) BOOL showFilter;
@property (nonatomic, strong) ZLFilterDataModel *filterDataModel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) ZLShopGoodsSearchBarView *searchBarView;
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
    
    [self setupData];
    

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
    self.titleLabel.text = @"一级分类/一级分类/一级分类/一级分类/二级分类/三级分类";
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#202020"];
    self.titleLabel.lineBreakMode = NSLineBreakByTruncatingHead;
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = self.titleLabel;
    
    UIButton *importButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [importButton setTitle:@"导入" forState:UIControlStateNormal];
    importButton.titleLabel.font = kFont14;
    importButton.frame = CGRectMake(0, 0, 40, 19);
    [importButton setTitleColor:[UIColor zl_mainColor] forState:UIControlStateNormal];
    [importButton addTarget:self action:@selector(importButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithCustomView:importButton];
    
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
    [self.view addSubview:self.searchBarView];
    
   [self.batchSetClassifyView setSelectedGoodsNum:0];
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
    for (int i = 0; i < 10; i++) {
        ZLGoodsModel *goodsModel = [[ZLGoodsModel alloc] init];
        goodsModel.goodsNum = i+1;
        goodsModel.top = NO;
        [self.goodsList addObject:goodsModel];
    }
    [self.goodsListTableView reloadData];
}

#pragma mark - private Method

/**
 是否全选
 */
- (void)judgeIsAllSelected {
   
}

- (void)allSelected:(BOOL )isSelected {
    for (int i = 0; i < 10; i++) {
        ZLGoodsModel *goodsModel = [self.goodsList objectAtIndex:i];
        goodsModel.goodsNum = i+1;
        goodsModel.isSelected = isSelected;
        [self.goodsList addObject:goodsModel];
    }
    [self.goodsListTableView reloadData];
}

#pragma mark - action

- (void)classificationButtonAction:(UIButton *)btn {
    if (!self.showFilter) {
        [self.filterView dismiss];
        self.filterDataModel  = [[ZLFilterDataModel alloc] init];
        NSArray *sectionTitles = @[@"分类", @"一级分类", @"二级分类"];
        NSMutableArray *allItems = [[NSMutableArray alloc] init];
        for (NSInteger section = 0; section < 3; section ++) {
            ZLFilterDataModel *filterDataModel  = [[ZLFilterDataModel alloc] init];
            filterDataModel.sectionName = [sectionTitles objectAtIndex:section];
            filterDataModel.indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
            NSMutableArray *items = [[NSMutableArray alloc] init];
            for (NSInteger i = 0; i < 10; i++) {
                ZLClassifyItemModel *itemModel = [[ZLClassifyItemModel alloc] init];
                itemModel.classifyId = i + 1;
                itemModel.title = [NSString stringWithFormat:@"分类%@", @(i)];
                [items addObject:itemModel];
            }
            filterDataModel.dataList = items;
            [allItems addObject:filterDataModel];
        }
        self.filterDataModel.dataList = allItems;
        self.filterView = [ZLFilterView createFilterViewWidthConfiguration:self.filterDataModel pushDirection:ZLFilterViewPushDirectionFromRight  filterViewBlock:^(NSString * _Nonnull firstClassify, NSString * _Nonnull secondClassify, NSString * _Nonnull thirdClassify) {
            
        }];
        self.filterView.durationTime = 0.5;
        [self.filterView show];
    } else {
        [self.filterView dismiss];
    }
    
}

- (void)importButtonAction:(UIButton *)sender {

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
    [cell setupData:[self.goodsList objectAtIndex:indexPath.row]];
    kWeakSelf(weakSelf);
    cell.selectedButtonBlock = ^(ZLAddPlatformGoodsCell * _Nonnull cell, BOOL isSelected) {
        ZLGoodsModel *goodsModel = [weakSelf.goodsList objectAtIndex:indexPath.row];
        goodsModel.isSelected = !goodsModel.isSelected;
        [weakSelf.goodsListTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    return cell;
}

#pragma mark - lazy load

- (UITableView *)goodsListTableView {
    if (!_goodsListTableView) {
        _goodsListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavBarHeight + dis(50), kScreenWidth, kScreenHeight -kNavBarHeight - dis(100)) style:UITableViewStylePlain];
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
        _batchSetClassifyView.batchSetClassifyBlock = ^{
            
        };
    }
    return _batchSetClassifyView;
}

@end


