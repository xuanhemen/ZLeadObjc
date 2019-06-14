//
//  ZLClassifyListViewController.m
//  ZLead
//
//  Created by dmy on 2019/6/6.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLClassifyManageVC.h"
#import "ZLAddClassifyNameVC.h"
#import "ZLClassifyListCell.h"
#import "ZLClassifyItemModel.h"

@interface ZLClassifyManageVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *classifyListTableView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSMutableArray *classifyList;
@end

@implementation ZLClassifyManageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNav];
    [self.view addSubview:self.classifyListTableView];
    [self setupData];
}

- (UITableView *)classifyListTableView {
    if (!_classifyListTableView) {
        _classifyListTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _classifyListTableView.delegate = self;
        _classifyListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _classifyListTableView.dataSource = self;
        [_classifyListTableView registerClass:[ZLClassifyListCell class] forCellReuseIdentifier:@"ZLClassifyListCell"];
    }
    return _classifyListTableView;
}

- (void)configNav {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(0, 0, 19, 19);
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, dis(200), 30)];
    self.titleLabel.text = @"一级分类";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#202020"];
    self.titleLabel.lineBreakMode = NSLineBreakByTruncatingHead;
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    self.navigationItem.titleView = self.titleLabel;
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setTitleColor:[UIColor zl_mainColor] forState:UIControlStateNormal];
    [addButton setTitle:@"添加" forState:UIControlStateNormal];
    addButton.titleLabel.font = kFont15;
    addButton.frame = CGRectMake(0, 0, 19, 19);
    [addButton addTarget:self action:@selector(addButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - init

- (NSMutableArray *)classifyList {
    if (!_classifyList) {
        _classifyList = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _classifyList;
}

#pragma mark - SetupData

- (void)setupData {
    [[NetManager sharedInstance] getShopClassWithParentId:@"0" shopId:@"1" sucess:^(NSArray * _Nonnull dataList, NSInteger total) {
        [self.classifyList addObjectsFromArray:dataList];
        [self.classifyListTableView reloadData];
    } fail:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark - UIButton Actions

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addButtonAction {
    ZLAddClassifyNameVC *addClassifyNameVC = [[ZLAddClassifyNameVC alloc] init];
    [self.navigationController pushViewController:addClassifyNameVC animated:YES];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.classifyList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZLClassifyListCell *classifyListCell = [tableView dequeueReusableCellWithIdentifier:@"ZLClassifyListCell"];
    [classifyListCell setupData:[self.classifyList objectAtIndex:indexPath.row]];
    kWeakSelf(weakSelf)
    classifyListCell.delGoodsClassifyBlock = ^(ZLClassifyItemModel * _Nonnull classifyItemModel, ZLClassifyListCell * _Nonnull cell) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"您确定删除商品吗？删除后不可恢复" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            DLog(@"点击取消");
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            DLog(@"点击确认");
            NSIndexPath *indexPath = [weakSelf.classifyListTableView indexPathForCell:cell];
            [[NetManager sharedInstance] removeShopGoodsClass:classifyItemModel.classifyId sucess:^{
                [weakSelf.classifyList removeObjectAtIndex:indexPath.row];
                [self.classifyListTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            } fail:^(NSError * _Nonnull error) {
                [self showMsg:@"删除失败"];
            }];
        }]];
        [weakSelf presentViewController:alertController animated:YES completion:nil];
    };
    classifyListCell.editGoodsClassifyBlock = ^(ZLClassifyItemModel * _Nonnull classifyItemModel, ZLClassifyListCell * _Nonnull cell) {
        ZLAddClassifyNameVC *addClassifyNameVC = [[ZLAddClassifyNameVC alloc] init];
        [weakSelf.navigationController pushViewController:addClassifyNameVC animated:YES];
    };
    return classifyListCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return dis(50);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
