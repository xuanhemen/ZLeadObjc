//
//  ZLAddGoodsView.m
//  ZLead
//
//  Created by 董建伟 on 2019/6/10.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLAddGoodsView.h"
#import "ZLSpeTableView.h"
@interface ZLAddGoodsView ()

@property (nonatomic, strong) UIView *bottomView; // 底部视图
@end

@implementation ZLAddGoodsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame viewModel:(ZLAddGoodsViewModel *)viewModel {
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView.delegate = viewModel;
        self.tableView.dataSource = viewModel;
        [self addSubview:self.bottomView];
        [self.bottomView addSubview:self.sureBtn];
        [viewModel.addlistView subscribeNext:^(id  _Nullable x) {
            viewModel.isAdd = @"多规格";
            NSDictionary *formParams = x;
            NSInteger count = formParams.count;
            ZLSpeTableView *footView = [[ZLSpeTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, dis(50*(count+2))) param:formParams viewModel:viewModel];
            self.tableView.tableFooterView = footView;
        }];
    }
    return self;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.frame.size.height-kTabBarHeight) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor zl_bgColor];
        _tableView.sectionFooterHeight = 0;
        _tableView.rowHeight = dis(50);;
        _tableView.sectionHeaderHeight = dis(70);
        UIView *footView = [[UIView alloc] init];
        footView.backgroundColor = [UIColor zl_bgColor];
        footView.frame = CGRectMake(0, 0, kScreenWidth, dis(100));
        _tableView.tableFooterView = footView;
        [self addSubview:_tableView];
    }
    return _tableView;
    
}
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, kTabBarHeight));
        }];
    }
    return _bottomView;
}
- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [[_sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [self showMsg:@"上传"];
        }];
        _sureBtn.backgroundColor = [UIColor zl_mainColor];
        _sureBtn.layer.masksToBounds = YES;
        _sureBtn.layer.cornerRadius = 4;
        [self.bottomView addSubview:_sureBtn];
        [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bottomView);
            make.top.equalTo(self.bottomView).offset(dis(5));
            make.size.mas_equalTo(kSize(kScreenWidth-50, 44));
        }];
    }
    return _sureBtn;
}
@end
