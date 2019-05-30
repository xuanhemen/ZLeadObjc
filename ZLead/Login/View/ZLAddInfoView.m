//
//  ZLAddInfoView.m
//  ZLead
//
//  Created by 董建伟 on 2019/5/30.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLAddInfoView.h"

@implementation ZLAddInfoView

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
    UILabel *title = [[UILabel alloc] init];
    title.text = @"店铺名称";
    title.font = [UIFont boldSystemFontOfSize:18];
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(dis(100));
        make.left.equalTo(self.view).offset(dis(30));
    }];
}
@end
