//
//  ZLUnitVC.m
//  ZLead
//
//  Created by 董建伟 on 2019/6/11.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLUnitVC.h"
#import "GeneralTableView.h"
#import "ZLUnitModel.h"
@interface ZLUnitVC ()

@property (nonatomic, strong) NSMutableArray *dataArr; // 数据源

@property (nonatomic, strong) GeneralTableView *tableView; //
@end

@implementation ZLUnitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择单位";

    [self.view addSubview:self.tableView];
    [self initData]; //请求数据
    // Do any additional setup after loading the view.
}
- (GeneralTableView *)tableView {
     kWeakSelf(weakSelf)
    if (!_tableView) {
        _tableView = [[GeneralTableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain array:self.dataArr cellHeight:50*kp cell:^UITableViewCell * _Nonnull(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
            static NSString *indentifier = @"brand";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
            }
            ZLUnitModel *model = weakSelf.dataArr[indexPath.row];
            cell.textLabel.text = model.sguName;
            return cell;
        } selectedCell:^(NSIndexPath * _Nonnull indexPath) {
            ZLUnitModel *model = [weakSelf.dataArr objectAtIndex:indexPath.row];
            weakSelf.selecItem(model.sguName,model.sguId);
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];

        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (void)initData {
    [self showHUD];
    NSDictionary *dic = [NSDictionary dictionary];
    [NetManager postWithURLString:@"ZlwGoods/getShopGoodsUnit" parameters:dic success:^(NSDictionary * _Nonnull response) {
        [self dismissHUD];
        NSArray *dataArr = [response objectForKey:@"unit"];
        for (NSDictionary *dic in dataArr) {
            ZLUnitModel *model = [ZLUnitModel mj_objectWithKeyValues:dic];
            [self.dataArr addObject:model];
        }
        [self.tableView reloadData];
    } failure:^(NSDictionary * _Nonnull errorMsg) {
        
    }];
}
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:[UIColor blackColor]}];
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
