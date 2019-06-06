//
//  ZLGoodsSearchResultVC.m
//  ZLead
//
//  Created by dmy on 2019/6/6.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLGoodsSearchResultVC.h"
#import "ZLGoodsHeaderView.h"
#import "ZLGoodsManagerView.h"
#import "ZLGoodsListCell.h"

#import "ZLGoodsSearchVC.h"

#import "ZLGoodsModel.h"
#import "ZLClassifyItemModel.h"

@interface ZLGoodsSearchResultVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) ZLGoodsHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZLGoodsManagerView *bottomManagerView;
/** <#注释#> */
@property (nonatomic, assign) BOOL allowEdit;
@property (nonatomic, strong) NSMutableArray *goodsList;
@property (nonatomic, assign) BOOL isAllSelected;
@end

@implementation ZLGoodsSearchResultVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self styleForNav];
    [self layoutChildViews];
    
    [self setupData];
}

/** 导航栏 */
- (void)styleForNav {
    UIView *searchV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, dis(255), 30)];
    searchV.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    searchV.layer.cornerRadius = 15;
    UIImageView *searchIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 8, 13, 13)];
    searchIcon.image = [UIImage imageNamed:@"search-icon-gray"];
    [searchV addSubview:searchIcon];
    UILabel *searchPL = [[UILabel alloc] initWithFrame:CGRectMake(32, 0, 200, 30)];
    searchPL.font = kFont13;
    searchPL.text = @"输入搜索商品的关键词";
    searchPL.textColor = [UIColor colorWithHexString:@"#333333"];
    [searchV addSubview:searchPL];
    self.navigationItem.titleView = searchV;
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapG:)];
    [searchV addGestureRecognizer:tapG];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(0, 0, 19, 19);
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *manageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    manageButton.frame = CGRectMake(0, 0, 19, 19);
    [manageButton setTitle:@"管理" forState:UIControlStateNormal];
    [manageButton setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    manageButton.titleLabel.font = kFont15;
    [manageButton addTarget:self action:@selector(managerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithCustomView:manageButton];
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setImage:[UIImage imageNamed:@"goods-add-icon-gray"] forState:UIControlStateNormal];
    addButton.frame = CGRectMake(0, 0, 19, 19);
    [addButton addTarget:self action:@selector(addGoodsButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem2 = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    self.navigationItem.rightBarButtonItems = @[rightItem2, rightItem1];
}

- (void)layoutChildViews {
    self.headerView = [[ZLGoodsHeaderView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, kScreenWidth, 45)];
    [self.view addSubview:self.headerView];
    
    self.tableView.frame = CGRectMake(0, kNavBarHeight + 45, kScreenWidth, kScreenHeight - kNavBarHeight - 45);
    
    self.bottomManagerView = [[ZLGoodsManagerView alloc] initWithFrame:CGRectMake(0, kScreenHeight - dis(50), kScreenWidth, dis(50))];
    self.bottomManagerView.hidden = YES;
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

- (void)tapG:(UITapGestureRecognizer *)tap {
    ZLGoodsSearchVC *searchVc = [[ZLGoodsSearchVC alloc] init];
    [self.navigationController pushViewController:searchVc animated:NO];
}

- (void)back:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)managerButtonAction:(UIBarButtonItem *)sender {
    sender.title = self.allowEdit ? @"管理": @"完成";
    self.allowEdit = !self.allowEdit;
    self.bottomManagerView.hidden = !self.allowEdit;
    self.isAllSelected = NO;
    [self.bottomManagerView reset];
    //    [self judgeIsAllSelected];
}

- (void)addGoodsButtonAction {
    
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
        self.tableView.frame = CGRectMake(0, kNavBarHeight + 45, kScreenWidth, kScreenHeight - kNavBarHeight - 45);
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

