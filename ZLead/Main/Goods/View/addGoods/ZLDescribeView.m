//
//  ZLDescribeView.m
//  ZLead
//
//  Created by 董建伟 on 2019/6/10.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLDescribeView.h"
@interface ZLDescribeView ()

@property (nonatomic, strong) UITextView *textView; // 商品名称输入框
@property (nonatomic, strong) UILabel *placeLb; // 占位符

@property (nonatomic, strong) UILabel *countLb; // 计数lable

@end
@implementation ZLDescribeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}
- (void)initView {
    _textView = [[UITextView alloc] init];
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.frame = CGRectMake(0, 0, kScreenWidth, (200-(kScreenWidth-40)/3)*kp);
    kWeakSelf(weakSelf)
    [[_textView.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        if (!IsStrEmpty(value)) {
            weakSelf.placeLb.text = @"";
            weakSelf.countLb.text = [NSString stringWithFormat:@"%lu / 30",(unsigned long)weakSelf.textView.text.length];
        }else{
            weakSelf.placeLb.text = @"请在此输入商品名称";
            weakSelf.countLb.text = @"0 / 30";
        }
        if (value.length>30) {
            weakSelf.textView.text = [weakSelf.textView.text substringToIndex:30];
            weakSelf.countLb.text = [NSString stringWithFormat:@"%lu / 30",(unsigned long)weakSelf.textView.text.length];
            [self showMsg:@"最多输入30位"];
        }

        return YES;
    }] subscribeNext:^(NSString * _Nullable x) {
        
    }];
    [self addSubview:_textView];
    [_textView addSubview:self.placeLb]; //添加占位符
    [self addSubview:self.countLb]; //添加计数
    
}
- (UILabel *)placeLb {
    if (!_placeLb) {
        _placeLb = [[UILabel alloc] init];
        _placeLb.text = @"请在此输入商品名称";
        _placeLb.textColor = lightColor;
        _placeLb.font = kFont14;
        [_textView addSubview:_placeLb];
        [_placeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.textView).offset(dis(15));
            make.top.equalTo(self.textView).offset(dis(7));
        }];
    }
    return _placeLb;
}
- (UILabel *)countLb {
    if (!_countLb) {
        _countLb = [[UILabel alloc] init];
        _countLb.text = @"0 / 30";
        _countLb.textColor = [UIColor lightGrayColor];
        _countLb.font = kFont14;
        [self addSubview:_countLb];
        [_countLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-dis(15));
            make.bottom.equalTo(self).offset(-dis(10));
            
        }];
    }
    return _countLb;
}
@end
