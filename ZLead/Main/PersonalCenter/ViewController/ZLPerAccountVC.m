//
//  ZLPerAccountVC.m
//  ZLead
//
//  Created by qzwh on 2019/5/27.
//  Copyright © 2019年 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLPerAccountVC.h"

@interface ZLPerAccountVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy)NSArray *topicArr;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIView *footer;

@end

@implementation ZLPerAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topicArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"accountCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.topicArr[indexPath.row];
    return cell;
}

#pragma mark - lazy load
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = self.footer;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"F7F7F7"];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (UIView *)footer {
    if (!_footer) {
        _footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWith, 200)];
        _footer.backgroundColor = [UIColor zl_bgColor];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor colorWithHexString:@"#FFB223"];
        btn.layer.cornerRadius = 45.0/2;
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn setTitle:@"退出登录" forState:UIControlStateNormal];
        [_footer addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->_footer).offset(24);
            make.centerX.equalTo(self->_footer);
            make.top.equalTo(self->_footer).offset(60);
            make.height.mas_offset(45);
        }];
    }
    return _footer;
}

- (NSArray *)topicArr {
    if (!_topicArr) {
        _topicArr = @[@"更换手机号", @"昵称", @"修改密码"];
    }
    return _topicArr;
}

@end
