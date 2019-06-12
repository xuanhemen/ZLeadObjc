//
//  ZLGoodsVC.m
//  ZLead
//
//  Created by 董建伟 on 2019/5/23.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLGoodsVC.h"
#import "ZLGoodsHeaderView.h"
#import "ZLGoodsManagerView.h"
#import "ZLGoodsListCell.h"

#import "ZLAddWayVC.h"

#import "ZLFilterView.h"
#import "ZLGoodsEmptyView.h"
#import "WHActionSheet.h"


#import "ZLGoodsSearchVC.h"
#import "ZLClassifyFilterListVC.h"
#import "ZLClassifyManageVC.h"

#import "ZLGoodsModel.h"
#import "ZLFilterDataModel.h"
#import "ZLClassifyItemModel.h"

@interface ZLGoodsVC ()<UITableViewDelegate, UITableViewDataSource, ZLGoodsHeaderViewDelegate, ZLFilterViewDelegate>
@property (nonatomic, strong) ZLGoodsHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZLGoodsManagerView *bottomManagerView;
@property (nonatomic, assign) BOOL allowEdit;
@property (nonatomic, assign) BOOL isAllSelected;
@property (nonatomic, strong) ZLFilterView *filterView;
@property (nonatomic, assign) BOOL showFilter;
@property (nonatomic, strong) ZLFilterDataModel *filterDataModel;
@property (nonatomic, strong) ZLGoodsEmptyView *goodsEmptyView;
@property (nonatomic, assign) NSInteger currentSelectedIndex;
@property (nonatomic, strong) NSMutableArray *sellingGoodsList;
@property (nonatomic, strong) NSMutableArray *unSellingGoodsList;
@property (nonatomic, strong) NSMutableArray *soldOutGoodsList;
@property (nonatomic, assign) NSInteger sellingPageIndex;//销售中商品当前第几页
@property (nonatomic, assign) NSInteger unsellPageIndex;
@property (nonatomic, assign) NSInteger soldOutPageIndex;
@end

@implementation ZLGoodsVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self styleForNav];
    [self layoutChildViews];
    [self addTableRefresh];
    
    [self setupData];
}

/** 导航栏 */
- (void)styleForNav {
    UIView *searchV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, dis(255), 30)];
    searchV.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.3];
    searchV.layer.cornerRadius = 15;
    UIImageView *searchIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 8, 13, 13)];
    searchIcon.image = [UIImage imageNamed:@"goods-search-icon"];
    [searchV addSubview:searchIcon];
    UILabel *searchPL = [[UILabel alloc] initWithFrame:CGRectMake(32, 0, 200, 30)];
    searchPL.font = kFont13;
    searchPL.text = @"输入搜索商品的关键词";
    searchPL.textColor = [UIColor whiteColor];
    [searchV addSubview:searchPL];
    self.navigationItem.titleView = searchV;
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapG:)];
    [searchV addGestureRecognizer:tapG];
    
    UIButton *classificationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [classificationButton setImage:[UIImage imageNamed:@"goods-classification-icon"] forState:UIControlStateNormal];
    classificationButton.frame = CGRectMake(0, 0, 19, 19);
    [classificationButton addTarget:self action:@selector(classificationButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:classificationButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *managerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [managerButton setTitle:@"管理" forState:UIControlStateNormal];
    managerButton.titleLabel.font = kFont14;
    managerButton.frame = CGRectMake(0, 0, 40, 19);
    [managerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [managerButton addTarget:self action:@selector(managerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithCustomView:managerButton];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setImage:[UIImage imageNamed:@"goods-add-icon"] forState:UIControlStateNormal];
    addButton.frame = CGRectMake(0, 0, 19, 19);
    [addButton addTarget:self action:@selector(addGoodsButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem2 = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    self.navigationItem.rightBarButtonItems = @[rightItem2, rightItem1];
}

- (void)layoutChildViews {
    self.headerView = [[ZLGoodsHeaderView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, kScreenWidth, 45)];
    self.headerView.delegate = self;
    [self.view addSubview:self.headerView];
    
    self.tableView.frame = CGRectMake(0, kNavBarHeight + 45, kScreenWidth, kScreenHeight - kTabBarHeight - kNavBarHeight - 45);

    self.bottomManagerView = [[ZLGoodsManagerView alloc] initWithFrame:CGRectMake(0, kScreenHeight - kTabBarHeight - dis(50), kScreenWidth, dis(50))];
    self.bottomManagerView.hidden = YES;
    kWeakSelf(weakSelf);
    self.bottomManagerView.allSelectedBlock = ^(BOOL isSelected) {
        [weakSelf allSelected:isSelected];
    };
 
    self.bottomManagerView.topBlock = ^{
        NSMutableArray *goodsList = nil;
        if (self.currentSelectedIndex == 0) {
            goodsList = self.sellingGoodsList;
        } else if (self.currentSelectedIndex == 1) {
            goodsList = self.unSellingGoodsList;
        } else {
            goodsList = self.soldOutGoodsList;
        }
        for (int i = 0; i < 10; i++) {
            ZLGoodsModel *goodsModel = [goodsList objectAtIndex:i];
            goodsModel.goodsNum = i+1;
            if (goodsModel.isSelected) {
                goodsModel.top = YES;
            }
        }
        [weakSelf.tableView reloadData];
        [weakSelf.bottomManagerView refreshCanelTopButton:YES];
    };
    self.bottomManagerView.cancelTopBlock = ^{
        NSMutableArray *goodsList = nil;
        if (self.currentSelectedIndex == 0) {
            goodsList = self.sellingGoodsList;
        } else if (self.currentSelectedIndex == 1) {
            goodsList = self.unSellingGoodsList;
        } else {
            goodsList = self.soldOutGoodsList;
        }
        int topCount = 0;
        for (int i = 0; i < 10; i++) {
            ZLGoodsModel *goodsModel = [goodsList objectAtIndex:i];
            goodsModel.goodsNum = i+1;
            if (goodsModel.isSelected) {
                goodsModel.top = NO;
            }
        }
        [weakSelf.tableView reloadData];
        [weakSelf.bottomManagerView refreshCanelTopButton:topCount ? YES : NO];
    };
    self.bottomManagerView.delBlock = ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"您确定删除商品吗？删除后不可恢复" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            DLog(@"点击取消");
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            DLog(@"点击确认");
        }]];
        [weakSelf presentViewController:alertController animated:YES completion:nil];
    };
    self.bottomManagerView.unShelveBlock = ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"您确定要下架此商品吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            DLog(@"点击取消");
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            DLog(@"点击确认");
        }]];
        [weakSelf presentViewController:alertController animated:YES completion:nil];
    };
    [self.view addSubview:self.bottomManagerView];
}

- (void)addTableRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
}

#pragma mark - Init

- (NSMutableArray *)sellingGoodsList {
    if (!_sellingGoodsList) {
        _sellingGoodsList = [[NSMutableArray alloc] init];
    }
    return _sellingGoodsList;
}

- (NSMutableArray *)unSellingGoodsList {
    if (!_unSellingGoodsList) {
        _unSellingGoodsList = [[NSMutableArray alloc] init];
    }
    return _unSellingGoodsList;
}

- (NSMutableArray *)soldOutGoodsList {
    if (!_soldOutGoodsList) {
        _soldOutGoodsList = [[NSMutableArray alloc] init];
    }
    return _soldOutGoodsList;
}

#pragma mark - setupData

- (void)setupData {
    for (int i = 0; i < 10; i++) {
        ZLGoodsModel *goodsModel = [[ZLGoodsModel alloc] init];
        goodsModel.goodsNum = i+1;
        goodsModel.top = NO;
        [self.sellingGoodsList addObject:goodsModel];
    }
    for (int i = 0; i < 10; i++) {
        ZLGoodsModel *goodsModel = [[ZLGoodsModel alloc] init];
        goodsModel.goodsNum = i+10;
        goodsModel.goodsName = @"sfsfdsf";
        goodsModel.top = NO;
        [self.unSellingGoodsList addObject:goodsModel];
    }
    [self.tableView reloadData];
}

- (void)headerRefresh {
    [self.tableView.mj_header endRefreshing];
}

- (void)footerRefresh {
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - private Method

/**
 是否全选
 */
- (void)judgeIsAllSelected {
    NSInteger count = 0;
    BOOL enabelCancelTop = NO;
    NSArray *goodsList = nil;
    if (self.currentSelectedIndex == 0) {
        goodsList = self.sellingGoodsList;
    } else if (self.currentSelectedIndex == 1) {
        goodsList = self.unSellingGoodsList;
    } else {
        goodsList = self.soldOutGoodsList;
    }
    for (ZLGoodsModel *goodsModel in goodsList) {
        if (goodsModel.isSelected) {
            count ++;
            if (goodsModel.top) {
                enabelCancelTop = YES;
            }
        }
    }
    if (count == goodsList.count) {
        self.bottomManagerView.allSelectedButton.selected = YES;
        self.isAllSelected = YES;
    } else {
        self.bottomManagerView.allSelectedButton.selected = NO;
        self.isAllSelected = NO;
    }
    if (count > 0) {
        [self.bottomManagerView refreshUnShelveButton:YES];
        [self.bottomManagerView refreshDelButton:YES];
        [self.bottomManagerView refreshTopButton:YES];
    } else {
        [self.bottomManagerView refreshUnShelveButton:NO];
        [self.bottomManagerView refreshDelButton:NO];
        [self.bottomManagerView refreshTopButton:NO];
    }
    if (enabelCancelTop) {
        [self.bottomManagerView refreshCanelTopButton:enabelCancelTop];
    }
}

- (void)allSelected:(BOOL )isSelected {
    NSArray *goodsList = nil;
    if (self.currentSelectedIndex == 0) {
        goodsList = self.sellingGoodsList;
    } else if (self.currentSelectedIndex == 1) {
        goodsList = self.unSellingGoodsList;
    } else {
        goodsList = self.soldOutGoodsList;
    }
    for (int i = 0; i < goodsList.count; i++) {
        ZLGoodsModel *goodsModel = [goodsList objectAtIndex:i];
        goodsModel.goodsNum = i+1;
        goodsModel.isSelected = isSelected;
    }
    [self.tableView reloadData];
}

#pragma mark - action

- (void)tapG:(UITapGestureRecognizer *)tap {
    ZLGoodsSearchVC *searchVc = [[ZLGoodsSearchVC alloc] init];
    [self.navigationController pushViewController:searchVc animated:NO];
}

- (void)classificationButtonAction:(UIButton *)btn {
    if (!self.showFilter) {
        [self.filterView dismiss];
        self.filterDataModel  = [[ZLFilterDataModel alloc] init];
        NSArray *sectionTitles = @[@"分类", @"一级分类", @"二级分类"];
        NSMutableArray *allItems = [[NSMutableArray alloc] init];
        ZLFilterDataModel *filterDataModel  = [[ZLFilterDataModel alloc] init];
        filterDataModel.sectionName = [sectionTitles objectAtIndex:0];
        filterDataModel.indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        NSArray *sectionClassifys = @[@"店铺", @"平台"];
        NSMutableArray *firstItems = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < sectionClassifys.count; i++) {
            ZLClassifyItemModel *itemModel = [[ZLClassifyItemModel alloc] init];
            itemModel.classifyId = i + 1;
            itemModel.isSelected = (i == 0) ? YES : NO;
            itemModel.title = [sectionClassifys objectAtIndex:i];
            [firstItems addObject:itemModel];
        }
        filterDataModel.dataList = firstItems;
        [allItems addObject:filterDataModel];
        for (NSInteger section = 1; section < 3; section ++) {
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
        self.filterView = [ZLFilterView createFilterViewWidthConfiguration:self.filterDataModel pushDirection:ZLFilterViewPushDirectionFromLeft  filterViewBlock:^(NSString * _Nonnull firstClassify, NSString * _Nonnull secondClassify, NSString * _Nonnull thirdClassify) {
        }];
        self.filterView.delegate = self;
        kWeakSelf(weakSelf)
        self.filterView.filterViewBlock = ^(NSString * _Nonnull firstClassify, NSString * _Nonnull secondClassify, NSString * _Nonnull thirdClassify) {
            ZLClassifyFilterListVC *classifyFilterListVC = [[ZLClassifyFilterListVC alloc] init];
            [weakSelf.navigationController pushViewController:classifyFilterListVC animated:YES];
        };
        self.filterView.manageClassifyBlock = ^(NSInteger classifyType) {
            ZLClassifyManageVC *classifyManageVC = [[ZLClassifyManageVC alloc] init];
            [weakSelf.navigationController pushViewController:classifyManageVC animated:YES];
        };
        self.filterView.durationTime = 0.5;
        [self.filterView show];
    } else {
        [self.filterView dismiss];
    }
    
}

- (void)managerButtonAction:(UIButton *)sender {
    [sender setTitle:self.allowEdit ? @"管理": @"完成" forState:UIControlStateNormal];
    self.allowEdit = !self.allowEdit;
    self.bottomManagerView.hidden = !self.allowEdit;
    self.isAllSelected = NO;
    [self.bottomManagerView reset];
//    [self judgeIsAllSelected];
}

- (void)addGoodsButtonAction {
    ZLAddWayVC *vc = [[ZLAddWayVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.currentSelectedIndex == 0) {
        return self.sellingGoodsList.count;
    } else if (self.currentSelectedIndex == 1) {
        return self.unSellingGoodsList.count;
    } else {
        return self.soldOutGoodsList.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return dis(130);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZLGoodsListCell *cell = [ZLGoodsListCell listCellWithTableView:tableView];
    cell.allowEdit = self.allowEdit;
    if (self.currentSelectedIndex == 0) {
        [cell setupData:[self.sellingGoodsList objectAtIndex:indexPath.row]];
    } else if (self.currentSelectedIndex == 1) {
        [cell setupData:[self.unSellingGoodsList objectAtIndex:indexPath.row]];
    } else {
        [cell setupData:[self.soldOutGoodsList objectAtIndex:indexPath.row]];
    }
    kWeakSelf(weakSelf);
    cell.selectedButtonBlock = ^(BOOL isSelected) {
        ZLGoodsModel *goodsModel = nil;
        if (self.currentSelectedIndex == 0) {
             goodsModel = [weakSelf.sellingGoodsList objectAtIndex:indexPath.row];
        } else if (self.currentSelectedIndex == 1) {
            goodsModel = [weakSelf.unSellingGoodsList objectAtIndex:indexPath.row];
        } else {
            goodsModel = [weakSelf.soldOutGoodsList objectAtIndex:indexPath.row];
        }
        goodsModel.isSelected = isSelected;
        [weakSelf judgeIsAllSelected];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark - ZLGoodsHeaderViewDelegate

- (void)goodsHeaderView:(ZLGoodsHeaderView *)headerView didSelectedIndex:(NSInteger)index {
    self.currentSelectedIndex = index;
    [self.tableView reloadData];
}

#pragma mark - ZLFilterViewDelegate
//选择上一级的分类刷新下一级的数据,如果点的是平台/店铺刷新整个列表
- (void)filterView:(ZLFilterView *)filterView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    ZLFilterDataModel *filterDataModel = [self.filterDataModel.dataList objectAtIndex:indexPath.section];
//    ZLClassifyItemModel *classifyItemModel = [filterDataModel.dataList objectAtIndex:indexPath.row];
    //请求下一级的数据
    //刷新下一级的数据
    if (indexPath.section == 0) {
        [filterView reloadData:self.filterDataModel];
    } else {
        [filterView reloadData:self.filterDataModel section:indexPath.section + 1];
    }
}

#pragma mark - setter

- (void)setAllowEdit:(BOOL)allowEdit {
    _allowEdit = allowEdit;
    if (_allowEdit) {
        self.tableView.frame = CGRectMake(0, kNavBarHeight + 45, kScreenWidth, kScreenHeight - kTabBarHeight - dis(50) - kNavBarHeight - 45);
    } else {
        self.tableView.frame = CGRectMake(0, kNavBarHeight + 45, kScreenWidth, kScreenHeight - kTabBarHeight - kNavBarHeight - 45);
    }
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

- (ZLGoodsEmptyView *)goodsEmptyView {
    if (!_goodsEmptyView) {
        _goodsEmptyView = [[ZLGoodsEmptyView alloc] initWithFrame:CGRectMake(0, kNavBarHeight + 45, kScreenWidth, kScreenHeight - kNavBarHeight - 45 - kTabBarHeight)];
        [self.view addSubview:_goodsEmptyView];
        kWeakSelf(weakSelf)
        _goodsEmptyView.operateButtonBlock = ^{
            ZLAddWayVC *vc = [[ZLAddWayVC alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
    }
    return _goodsEmptyView;
}

@end
