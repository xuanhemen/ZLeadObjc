//
//  ZLImgTextView.m
//  ZLead
//
//  Created by 董建伟 on 2019/6/13.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLImgTextView.h"

@interface ZLImgTextView ()



@property (nonatomic, strong) CALayer *bottomLayer; //
@end

@implementation ZLImgTextView

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
        self.isEmpty = YES;
        self.backgroundColor = [UIColor whiteColor];
        _bottomLayer = [CALayer layer];
        _bottomLayer.backgroundColor = lightColor.CGColor;
        [self.layer addSublayer:_bottomLayer];
        
        _imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_imgBtn setBackgroundImage:image(@"addGoodsImg") forState:UIControlStateNormal];
        [self addSubview:_imgBtn];
        [_imgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(dis(20));
            make.left.equalTo(self).offset(dis(20));
            make.size.mas_equalTo(kSize(100, 100));
        }];
        _desView = [[ZLDescribeView alloc] init];
        [self addSubview:_desView];
        [_desView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imgBtn.mas_bottom).offset(dis(20));
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, dis(80)));
        }];
    }
    return self;
}
- (void)layoutSubviews {
   _bottomLayer.frame = CGRectMake(15, self.frame.size.height-0.3, kScreenWidth-30, 0.3);
}
@end
