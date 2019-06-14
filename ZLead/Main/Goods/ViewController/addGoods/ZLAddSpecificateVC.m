//
//  ZLAddSpecificateVC.m
//  ZLead
//
//  Created by 董建伟 on 2019/6/11.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLAddSpecificateVC.h"
#import "GeneralTableView.h"
#import "ZLAddSpeCell.h"
@interface ZLAddSpecificateVC ()<UITextFieldDelegate>

@property (nonatomic, strong) GeneralTableView *tableView;

@property (nonatomic, strong) NSArray *dataArr;


@end

@implementation ZLAddSpecificateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加信息";
    
    [self addSaveButton]; //添加保存btn
    [self addTableView];
    // Do any additional setup after loading the view.
}
- (void)addSaveButton {
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor zl_mainColor] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = kFont15;
    kWeakSelf(weakSelf)
    [[saveBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) { //点击保存
        [self.view endEditing:YES];
        NSString *wdsjStr = self.infoDic[@"wdsj"];
        NSString *mdsjStr = self.infoDic[@"mdsj"];
        NSString *cbjStr = self.infoDic[@"cbj"];
        NSString *kcStr = self.infoDic[@"kc"];
        if ([wdsjStr isEqualToString:@""]) {
            [self showMsg:@"请填写网店售价"];
            return ;
        }
        if ([mdsjStr isEqualToString:@""]) {
            [self showMsg:@"请填写门店售价"];
            return ;
        }
        if ([cbjStr isEqualToString:@""]) {
            [self.infoDic removeObjectForKey:@"cbj"];
        }
        if ([kcStr isEqualToString:@""]) {
            [self showMsg:@"请填写库存"];
            return ;
        }
        weakSelf.passParams(weakSelf.infoDic);
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    self.navigationItem.rightBarButtonItem = item;
}
- (void)addTableView {
    kWeakSelf(weakSelf)
    _tableView = [[GeneralTableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain array:self.dataArr cellHeight:dis(50) cell:^UITableViewCell * _Nonnull(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        ZLAddSpeCell *cell = [[ZLAddSpeCell alloc] init];
        cell.titleLb.text = [self.dataArr objectAtIndex:indexPath.row];
        if (indexPath.row==0) {
            cell.textField.text = [weakSelf.infoDic objectForKey:@"wdsj"];
        }
        if (indexPath.row==1) {
            cell.textField.text = [weakSelf.infoDic objectForKey:@"mdsj"];
        }
        if (indexPath.row==2) {
            cell.markLb.hidden = YES;
            cell.textField.text = [weakSelf.infoDic objectForKey:@"cbj"];
        }
        if (indexPath.row==3) {
           cell.textField.text = [weakSelf.infoDic objectForKey:@"kc"];
           cell.textField.placeholder = @"0 ";
        }
        cell.textField.delegate = weakSelf;
        cell.textField.tag = indexPath.row;
        
        return cell;
    } selectedCell:^(NSIndexPath * _Nonnull indexPath) {
        ZLAddSpeCell *cell =  [weakSelf.tableView cellForRowAtIndexPath:indexPath];
        [cell.textField becomeFirstResponder];
        
    }];
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSInteger tag = textField.tag;
    if (tag==0) {
        [self.infoDic setObject:textField.text forKey:@"wdsj"]; //网店售价
    }else if (tag==1) {
        [self.infoDic setObject:textField.text forKey:@"mdsj"]; //门店售价
    }else if (tag==2) {
        [self.infoDic setObject:textField.text forKey:@"cbj"]; //成本价
    }else if (tag==3) {
        [self.infoDic setObject:textField.text forKey:@"kc"]; //库存
    }
}
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = @[@"网店售价",@"门店售价",@"成本价",@"库存"];
    }
    return _dataArr;
}
- (NSMutableDictionary *)infoDic {
    if (!_infoDic) {
        _infoDic = [NSMutableDictionary dictionary];
        _infoDic[@"wdsj"] = @"";
        _infoDic[@"mdsj"] = @"";
        _infoDic[@"cbj"] = @"";
        _infoDic[@"kc"] = @"";
    }
    return _infoDic;
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
