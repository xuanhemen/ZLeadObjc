//
//  ZLPerButtonView.m
//  ZLead
//
//  Created by qzwh on 2019/5/27.
//  Copyright © 2019年 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLPerButtonView.h"

@interface ZLPerButton : UIControl

/** image */
@property (nonatomic, strong)UIImageView *imageView;
/** topic */
@property (nonatomic, strong)UILabel *titleLbl;

@end

@implementation ZLPerButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(dis(-10));
    }];
    self.imageView.backgroundColor = [UIColor zl_bgColor];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.titleLbl.mas_top).offset(dis(-10));
        make.centerX.equalTo(self);
        make.width.height.mas_offset(dis(45));
        make.top.equalTo(self).offset(dis(10));
    }];
}

#pragma mark - lazy load
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (UILabel *)titleLbl {
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        _titleLbl.textColor = [UIColor colorWithHexString:@"#333333"];
        _titleLbl.font = [UIFont systemFontOfSize:12];
        [self addSubview:_titleLbl];
    }
    return _titleLbl;
}

@end

@interface ZLPerButtonView ()

@property (nonatomic, copy)NSArray *contentArr;

@end

@implementation ZLPerButtonView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 10;
        self.backgroundColor = [UIColor whiteColor];
        [self setup];
    }
    return self;
}

- (void)setup {
    NSInteger count = self.contentArr.count < 4 ? self.contentArr.count : 4;
    ZLPerButton *lastBtn = nil;
    CGFloat width = (kScreenWidth - 50 - count * 10) / count;
    for (NSInteger i = 0; i < count; i++) {
        NSDictionary *dic = self.contentArr[i];
        ZLPerButton *perBtn = [[ZLPerButton alloc] init];
        perBtn.tag = 123 + i;
        perBtn.titleLbl.text = dic[@"topic"];
        perBtn.imageView.image = [UIImage imageNamed:dic[@"icon"]];
        [self addSubview:perBtn];
        
        [perBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            if (lastBtn) {
                make.left.equalTo(lastBtn.mas_right).offset(10);
            }else {
                make.left.equalTo(self).offset(10);
            }
            make.width.mas_equalTo(width);
        }];
        [perBtn addTarget:self action:@selector(perButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        lastBtn = perBtn;
    }
}

- (void)perButtonClicked:(UIButton *)btn {
    NSInteger index = btn.tag - 123;
    if (self.perButtonBlock) {
        self.perButtonBlock(index);
    }
}


- (NSArray *)contentArr {
    if (!_contentArr) {
        _contentArr = @[@{@"topic": @"账号设置", @"icon": @""},
                        @{@"topic": @"切换店铺", @"icon": @""},
                        @{@"topic": @"提现账户设置", @"icon": @""},
                        @{@"topic": @"账户提现", @"icon": @""}];
    }
    return _contentArr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
