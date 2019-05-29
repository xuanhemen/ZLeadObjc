//
//  ZLShareView.m
//  ZLead
//
//  Created by qzwh on 2019/5/27.
//  Copyright © 2019年 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLPerShareView.h"

@interface ZLPerShareView ()

@property (nonatomic, strong)UILabel *shareLbl;
@property (nonatomic, strong)UILabel *detailLbl;
@property (nonatomic, strong)UIImageView *imageView;

@end

@implementation ZLPerShareView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 10;
        self.backgroundColor = [UIColor whiteColor];
        [self setup];
    }
    return self;
}

- (void)setup {
    [self.shareLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(22);
    }];
    
    [self.detailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shareLbl);
        make.top.equalTo(self.shareLbl.mas_bottom).offset(10);
    }];
}

#pragma mark - lazy load
- (UILabel *)shareLbl {
    if (!_shareLbl) {
        _shareLbl = [[UILabel alloc] init];
        _shareLbl.text = @"分享";
        _shareLbl.textColor = [UIColor colorWithHexString:@"#333333"];
        _shareLbl.font = kFont15;
        [self addSubview:_shareLbl];
    }
    return _shareLbl;
}

- (UILabel *)detailLbl {
    if (!_detailLbl) {
        _detailLbl = [[UILabel alloc] init];
        _detailLbl.text = @"推荐好友一起开店挣钱";
        _detailLbl.textColor = [UIColor colorWithHexString:@"#4F5362"];
        _detailLbl.font = [UIFont systemFontOfSize:12];
        [self addSubview:_detailLbl];
    }
    return _detailLbl;
}

//- (UIImageView *)imageView {
//
//}

@end
