//
//  ZLUnitVC.m
//  ZLead
//
//  Created by 董建伟 on 2019/6/11.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLUnitVC.h"
#import "GeneralTableView.h"
@interface ZLUnitVC ()

@property (nonatomic, strong) NSMutableArray *dataArr; // 数据源
@end

@implementation ZLUnitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择单位";
    kWeakSelf(weakSelf)
    GeneralTableView *tableView = [[GeneralTableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain array:self.dataArr cellHeight:50*kp cell:^UITableViewCell * _Nonnull(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        static NSString *indentifier = @"brand";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        }
        cell.textLabel.text = weakSelf.dataArr[indexPath.row];
        return cell;
    } selectedCell:^(NSIndexPath * _Nonnull indexPath) {
        NSString *title = [weakSelf.dataArr objectAtIndex:indexPath.row];
        weakSelf.selecItem(title);
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.view addSubview:tableView];
    // Do any additional setup after loading the view.
}
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
        [_dataArr addObject:@"个"];
        [_dataArr addObject:@"箱"];
        [_dataArr addObject:@"盆"];
        [_dataArr addObject:@"双"];
    }
    return _dataArr;
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
