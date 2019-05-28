//
//  ZLPerHeaderView.m
//  ZLead
//
//  Created by qzwh on 2019/5/27.
//  Copyright © 2019年 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLPerHeaderView.h"

@interface ZLPerHeaderView ()

@property (nonatomic, strong)UIButton *msgItem;
/** 头像 */
@property (nonatomic, strong)UIImageView *headerImgV;
/** name */
@property (nonatomic, strong)UILabel *nameLbl;
/** phone */
@property (nonatomic, strong)UILabel *phoneLbl;
/** eye */
@property (nonatomic, strong)UIButton *eyeBtn;

@end

@implementation ZLPerHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addGradientLayer];
        [self setup];
    }
    return self;
}

- (void)setup {
    self.headerImgV.backgroundColor = [UIColor blueColor];
    [self.headerImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(dis(15));
        make.centerY.equalTo(self);
        make.width.height.mas_equalTo(dis(60));
    }];
    
    [self.nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerImgV.mas_right).offset(dis(10));
        make.bottom.equalTo(self.headerImgV.mas_centerY);
    }];
    
    [self.phoneLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLbl);
        make.top.equalTo(self.nameLbl.mas_bottom).offset(dis(4));
    }];
    self.eyeBtn.backgroundColor = [UIColor blueColor];
    [self.eyeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneLbl.mas_right).offset(dis(10));
        make.centerY.equalTo(self.phoneLbl);
        make.width.height.mas_equalTo(15);
    }];
}



#pragma mark - lazy method
- (UIImageView *)headerImgV {
    if (!_headerImgV) {
        _headerImgV = [[UIImageView alloc] init];
        _headerImgV.layer.cornerRadius = dis(30);
        [self addSubview:_headerImgV];
    }
    return _headerImgV;
}

- (UILabel *)nameLbl {
    if (!_nameLbl) {
        _nameLbl = [[UILabel alloc] init];
        _nameLbl.text = @"name";
        _nameLbl.textColor = [UIColor whiteColor];
        _nameLbl.font = kFont15;
        [self addSubview:_nameLbl];
    }
    return _nameLbl;
}

- (UILabel *)phoneLbl {
    if (!_phoneLbl) {
        _phoneLbl = [[UILabel alloc] init];
        _phoneLbl.text = @"phone";
        _phoneLbl.textColor = [UIColor whiteColor];
        _phoneLbl.font = [UIFont systemFontOfSize:11];
        [self addSubview:_phoneLbl];
    }
    return _phoneLbl;
}

- (UIButton *)eyeBtn {
    if (!_eyeBtn) {
        _eyeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_eyeBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_eyeBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        [self addSubview:_eyeBtn];
    }
    return _eyeBtn;
}

#pragma mark - private
- (void)addGradientLayer {
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0, 0, kScreenWith, 222);
    gl.startPoint = CGPointMake(0.68, 0.84);
    gl.endPoint = CGPointMake(0.68, 0.25);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:197/255.0 blue:2/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:255/255.0 green:164/255.0 blue:1/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:255/255.0 green:164/255.0 blue:0/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0), @(0.6f), @(1.0f)];
    [self.layer addSublayer:gl];
}

@end
