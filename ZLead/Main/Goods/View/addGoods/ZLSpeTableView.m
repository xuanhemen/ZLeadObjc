//
//  ZLSpeTableView.m
//  ZLead
//
//  Created by 董建伟 on 2019/6/12.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLSpeTableView.h"

@implementation ZLSpeTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame param:(NSDictionary *)params viewModel:(ZLAddGoodsViewModel *)viewModel {
    self = [super initWithFrame:frame];
    if (self) {
        
        NSInteger counts = params.count;
        self.backgroundColor = [UIColor whiteColor];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"调整规格" forState:UIControlStateNormal];
        [btn setTitleColor:normalColor forState:UIControlStateNormal];
        btn.frame = CGRectMake(dis(15), 0, kScreenWidth-dis(30), 50*kp);
        btn.titleLabel.font = kFont14;
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [viewModel.changeSpeEvent sendNext:x];
        }];
        [self addSubview:btn];
        
        UIImageView *arrowsView = [[UIImageView alloc] initWithImage:image(@"icon_jump")];
        [btn addSubview:arrowsView];
        [arrowsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(btn);
            make.right.equalTo(btn);
        }];
        
        UIView *backView = [[UIView alloc] init];
        backView.backgroundColor = [UIColor whiteColor];
        backView.layer.borderWidth = 0.2;
        backView.layer.borderColor = lightColor.CGColor;
        [self addSubview:backView];
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(dis(50));
            make.left.equalTo(self).offset(15);
            make.size.mas_equalTo(kSize(kScreenWidth-30, dis(50)*counts));
        }];
        NSArray *titleArr;
        NSArray *titleKey;
        if (counts==4) {
            titleArr = @[@"网店售价",@"门店售价",@"成本价",@"库存"];
            titleKey = @[@"wdsj",@"mdsj",@"cbj",@"kc"];
        }else if (counts==3) {
            titleArr = @[@"网店售价",@"门店售价",@"库存"];
            titleKey = @[@"wdsj",@"mdsj",@"kc"];
        }
        for (int i =0; i<2; i++) {
            for (int j =0; j<counts; j++) {
                UILabel *label = [[UILabel alloc] init];
                if (i==0) {
                     label.text = titleArr[j];
                }else{
                    NSString *key = titleKey[j];
                    if (![key isEqualToString:@"kc"]) {
                        label.text = [params[key] stringByAppendingFormat:@" %@",@"￥"];
                    }else{
                        label.text = params[key];
                    }
                   
                }
                label.textColor = normalColor;
                label.font = kFont13;
                label.textAlignment = NSTextAlignmentCenter;
                label.layer.borderWidth = 0.2;
                label.layer.borderColor = lightColor.CGColor;
                label.frame = CGRectMake(0+(kScreenWidth-30)/2*i, 50*j, (kScreenWidth-30)/2, dis(50));
                [backView addSubview:label];
            }
        }
        
    }
    return self;
}
@end
