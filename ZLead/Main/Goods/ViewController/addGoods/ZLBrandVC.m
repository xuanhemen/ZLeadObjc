//
//  ZLBrandVC.m
//  ZLead
//
//  Created by 董建伟 on 2019/6/11.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLBrandVC.h"
#import "GeneralTableView.h"
@interface ZLBrandVC ()

@property (nonatomic, strong) NSMutableArray *dataArr; // 品牌数据源

@property (nonatomic, strong) GeneralTableView *tableView; // 列表
@end

@implementation ZLBrandVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationItem.title = @"品牌";
    
      _tableView = [[GeneralTableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain array:self.dataArr cellHeight:50*kp cell:^UITableViewCell * _Nonnull(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPaht) {
        static NSString *indentifier = @"brand";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        }
        return cell;
    } selectedCell:^(NSIndexPath * _Nonnull indexPath) {
        
    }];
    [self.view addSubview:_tableView];
    
    [self initData]; //请求品牌数据
    // Do any additional setup after loading the view.
}
- (void)initData {
   
}
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
        [_dataArr addObject:@"华为"];
        [_dataArr addObject:@"苹果"];
        [_dataArr addObject:@"华为"];
        [_dataArr addObject:@"苹果"];
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
