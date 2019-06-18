//
//  ZLBrandVC.m
//  ZLead
//
//  Created by 董建伟 on 2019/6/11.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLBrandVC.h"
#import "GeneralTableView.h"
#import "ZLSearchBarView.h"
#import "ZLBrandModel.h"
#import "SCIndexView.h"
#import "UITableView+SCIndexView.h"
@interface ZLBrandVC () <ZLSearchBarViewDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArr; // 品牌数据源

@property (nonatomic, strong) UITableView *tableView; // 列表

@property (nonatomic, copy) NSArray *indexArr; // 索引数组

@end

@implementation ZLBrandVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addSearchBar]; //添加搜索视图
    [self.view addSubview:self.tableView];
    [self initData];
    // Do any additional setup after loading the view.
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = dis(50);
        _tableView.sectionHeaderHeight = dis(30);
        
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _indexArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[_dataArr objectAtIndex:section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"brand";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    ZLBrandModel *model = [[_dataArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = model.sgbName;
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *secView = [[UIView alloc] init];
    secView.backgroundColor = [UIColor zl_bgColor];
    UILabel *lbael = [[UILabel alloc] init];
    lbael.text = [_indexArr objectAtIndex:section];
    [secView addSubview:lbael];
    [lbael mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(secView);
        make.left.equalTo(secView).offset(15);
    }];
    return secView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZLBrandModel *model = [[_dataArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    self.selecItem(model.sgbName, model.sgbId);
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)addSearchBar {
    ZLSearchBarView *searchView = [[ZLSearchBarView alloc] init];
    searchView.delegate = self;
    searchView.searchTextField.delegate = self;
    [[searchView.searchTextField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        
        return YES;
    }] subscribeNext:^(NSString * _Nullable x) {
        
    }];
    searchView.delegate = self;
    [searchView changeSearchBarViewStyle:NO];
    searchView.frame = CGRectMake(0, 0, kScreenWidth, 30);
    self.navigationItem.titleView = searchView;
}
- (void)addIndexView {
    SCIndexViewConfiguration *indexViewConfiguration = [SCIndexViewConfiguration configuration];
    _tableView.sc_indexViewConfiguration = indexViewConfiguration;
    _tableView.sc_translucentForTableViewInNavigationBar = YES;
    _tableView.sc_indexViewDataSource = self.indexArr;
}
- (void)searchGoods {
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}
- (void)initData {
    [self showHUD];
    NSDictionary *dic = [NSDictionary dictionary];
    [NetManager postWithURLString:@"ZlwGoods/getGoodsBrand" parameters:dic success:^(NSDictionary * _Nonnull response) {
        [self dismissHUD];
        self.indexArr = [response objectForKey:@"index"];
        NSDictionary *brandDic = [response objectForKey:@"brand"];
        for (NSString *key in self.indexArr) {
            NSArray *brandArr = [brandDic objectForKey:key];
            NSArray *array = [ZLBrandModel mj_objectArrayWithKeyValuesArray:brandArr];
            [self.dataArr addObject:array];
        }
        [self.tableView reloadData];
        [self addIndexView]; //添加索引
    } failure:^(NSDictionary * _Nonnull errorMsg) {
        
    }];
}
- (NSArray *)indexArr {
    if (!_indexArr) {
        _indexArr = [NSArray array];
    }
    return _indexArr;
}
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (void)backPreviousPage {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.hidesBackButton = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:[UIColor blackColor]}];
}

- (void)dealloc {
    
    NSLog(@"走了吗");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
