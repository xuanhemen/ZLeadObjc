//
//  ZLClassifyListVC.m
//  ZLead
//
//  Created by dmy on 2019/6/6.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLClassifyFilterListVC.h"
#import "ZLGoodsHeaderView.h"
#import "ZLGoodsManagerView.h"
#import "ZLGoodsListCell.h"
#import "ZLFilterView.h"

#import "ZLGoodsSearchVC.h"

#import "ZLGoodsModel.h"
#import "ZLFilterDataModel.h"
#import "ZLClassifyItemModel.h"

@interface ZLClassifyFilterListVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) ZLGoodsHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZLGoodsManagerView *bottomManagerView;
@property (nonatomic, assign) BOOL allowEdit;
@property (nonatomic, strong) NSMutableArray *goodsList;
@property (nonatomic, assign) BOOL isAllSelected;
@property (nonatomic, strong) ZLFilterView *filterView;
@property (nonatomic, assign) BOOL showFilter;
@property (nonatomic, strong) ZLFilterDataModel *filterDataModel;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation ZLClassifyFilterListVC

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configNav];
    [self layoutChildViews];
    
    [self setupData];
}

/** 导航栏 */
- (void)configNav {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(0, 0, 19, 19);
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
    
    UIButton *managerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [managerButton setTitle:@"管理" forState:UIControlStateNormal];
    managerButton.titleLabel.font = kFont14;
    managerButton.frame = CGRectMake(0, 0, 40, 19);
    [managerButton setTitleColor:[UIColor zl_mainColor] forState:UIControlStateNormal];
    [managerButton addTarget:self action:@selector(managerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithCustomView:managerButton];
    
    UIButton *filterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [filterButton setTitle:@"筛选" forState:UIControlStateNormal];
    filterButton.titleLabel.font = kFont14;
    filterButton.frame = CGRectMake(0, 0, 40, 19);
    [filterButton setTitleColor:[UIColor zl_mainColor] forState:UIControlStateNormal];
    [filterButton addTarget:self action:@selector(classificationButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem2 = [[UIBarButtonItem alloc] initWithCustomView:filterButton];
    self.navigationItem.rightBarButtonItems = @[rightItem2, rightItem1];
}

- (void)layoutChildViews {
    self.headerView = [[ZLGoodsHeaderView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, kScreenWidth, 45)];
    [self.view addSubview:self.headerView];
    
    self.tableView.frame = CGRectMake(0, kNavBarHeight + 45, kScreenWidth, kScreenHeight - kNavBarHeight - 45);
    
    self.bottomManagerView = [[ZLGoodsManagerView alloc] initWithFrame:CGRectMake(0, kScreenHeight - dis(50), kScreenWidth, dis(50))];
    self.bottomManagerView.hidden = YES;
    [self.bottomManagerView configStyleForClassifyFilterView];
    kWeakSelf(weakSelf);
    self.bottomManagerView.allSelectedBlock = ^(BOOL isSelected) {
        [weakSelf allSelected:isSelected];
    };
    self.bottomManagerView.topBlock = ^{
        for (int i = 0; i < 10; i++) {
            ZLGoodsModel *goodsModel = [weakSelf.goodsList objectAtIndex:i];
            goodsModel.goodsNum = i+1;
            if (goodsModel.isSelected) {
                goodsModel.top = YES;
            }
            [weakSelf.goodsList addObject:goodsModel];
        }
        [weakSelf.tableView reloadData];
    };
    self.bottomManagerView.cancelTopBlock = ^{
        for (int i = 0; i < 10; i++) {
            ZLGoodsModel *goodsModel = [weakSelf.goodsList objectAtIndex:i];
            goodsModel.goodsNum = i+1;
            if (goodsModel.isSelected) {
                goodsModel.top = NO;
            }
            [weakSelf.goodsList addObject:goodsModel];
        }
        [weakSelf.tableView reloadData];
    };
    [self.view addSubview:self.bottomManagerView];
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
    [self.tableView reloadData];
}

#pragma mark - private Method

/**
 是否全选
 */
- (void)judgeIsAllSelected {
    NSInteger count = 0;
    BOOL enabelCancelTop = NO;
    for (ZLGoodsModel *goodsModel in self.goodsList) {
        if (goodsModel.isSelected) {
            count ++;
            if (goodsModel.top) {
                enabelCancelTop = YES;
            }
        }
    }
    if (count == self.goodsList.count) {
        self.bottomManagerView.allSelectedButton.selected = YES;
        self.isAllSelected = YES;
    } else {
        self.bottomManagerView.allSelectedButton.selected = NO;
        self.isAllSelected = NO;
    }
    if (enabelCancelTop) {
        [self.bottomManagerView refreshCanelTopButton:enabelCancelTop];
    }
}

- (void)allSelected:(BOOL )isSelected {
    for (int i = 0; i < 10; i++) {
        ZLGoodsModel *goodsModel = [self.goodsList objectAtIndex:i];
        goodsModel.goodsNum = i+1;
        goodsModel.isSelected = isSelected;
        [self.goodsList addObject:goodsModel];
    }
    [self.tableView reloadData];
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

- (void)managerButtonAction:(UIButton *)sender {
    [sender setTitle:self.allowEdit ? @"管理": @"完成" forState:UIControlStateNormal];
    self.allowEdit = !self.allowEdit;
    self.bottomManagerView.hidden = !self.allowEdit;
    self.isAllSelected = NO;
    [self.bottomManagerView reset];
    //    [self judgeIsAllSelected];
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
    return dis(130);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZLGoodsListCell *cell = [ZLGoodsListCell listCellWithTableView:tableView];
    cell.allowEdit = self.allowEdit;
    [cell setupData:[self.goodsList objectAtIndex:indexPath.row]];
    kWeakSelf(weakSelf);
    cell.selectedButtonBlock = ^(BOOL isSelected) {
        ZLGoodsModel *goodsModel = [weakSelf.goodsList objectAtIndex:indexPath.row];
        goodsModel.isSelected = isSelected;
        [weakSelf judgeIsAllSelected];
    };
    return cell;
}

#pragma mark - setter

- (void)setAllowEdit:(BOOL)allowEdit {
    _allowEdit = allowEdit;
    if (_allowEdit) {
        self.tableView.frame = CGRectMake(0, kNavBarHeight + 45, kScreenWidth, kScreenHeight - dis(50) - kNavBarHeight - 45);
    } else {
        self.tableView.frame = CGRectMake(0, kNavBarHeight + 45, kScreenWidth, kScreenHeight  - kNavBarHeight - 45);
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

@end

