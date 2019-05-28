//
//  ZLPerAccountOfWithdrawVC.m
//  ZLead
//
//  Created by qzwh on 2019/5/27.
//  Copyright © 2019年 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLPerAccountOfWithdrawVC.h"
#import "ZLAddBankCardVC.h"
#import "ZLSetWechatVC.h"

@interface ZLPerAccountOfWithdrawVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy)NSArray *topicArr;
@property (nonatomic, strong)UITableView *tableView;

@end

@implementation ZLPerAccountOfWithdrawVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置提现账户";
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"accountOfWithdrawCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        cell.textLabel.font = kFont14;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.text = @"未设置";
        cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#CCCCCC"];
        cell.detailTextLabel.font = kFont14;
    }
    NSDictionary *dic = self.topicArr[indexPath.row];
    cell.textLabel.text = dic[@"topic"];
    cell.imageView.image = [UIImage imageNamed:dic[@"icon"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        cell.preservesSuperviewLayoutMargins = NO;
    }
    //3.调整(iOS8以上)view边距
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 15, 0, 0)];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = self.topicArr[indexPath.row];
    NSString *topic = dic[@"topic"];
    if ([topic isEqualToString:@"银行卡"]) {
        ZLAddBankCardVC *bankCardVc = [[ZLAddBankCardVC alloc] init];
        [self.navigationController pushViewController:bankCardVc animated:YES];
    }else if ([topic isEqualToString:@"支付宝"]) {
        ZLSetWechatVC *wechatVc = [[ZLSetWechatVC alloc] init];
        wechatVc.type = AccountTypeAlipay;
        [self.navigationController pushViewController:wechatVc animated:YES];
    }else if ([topic isEqualToString:@"微信钱包"]) {
        ZLSetWechatVC *wechatVc = [[ZLSetWechatVC alloc] init];
        wechatVc.type = AccountTypeWechat;
        [self.navigationController pushViewController:wechatVc animated:YES];
    }
}

#pragma mark - lazy load
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [self.view addSubview:_tableView];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
        
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
        }
        //2.调整(iOS8以上)view边距(或者在cell中设置preservesSuperviewLayoutMargins,二者等效)
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            _tableView.layoutMargins = UIEdgeInsetsMake(0, 15, 0, 0);
        }
    }
    return _tableView;
}

- (NSArray *)topicArr {
    if (!_topicArr) {
        _topicArr = @[@{@"icon": @"ic_account_alipay", @"topic": @"银行卡"},
                      @{@"icon": @"ic_account_alipay", @"topic": @"支付宝"},
                      @{@"icon": @"ic_account_wechat", @"topic": @"微信钱包"}];
    }
    return _topicArr;
}

@end
