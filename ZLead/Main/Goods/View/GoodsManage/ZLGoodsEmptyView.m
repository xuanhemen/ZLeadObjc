//
//  ZLGoodsEmptyView.m
//  ZLead
//
//  Created by dmy on 2019/6/10.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLGoodsEmptyView.h"
@interface ZLGoodsEmptyView ()
@property (nonatomic, strong) UIImageView *emptyImageView;
@property (nonatomic, strong) UILabel *emptyLabel;
@property (nonatomic, strong) UIButton *operateButton;
@end

@implementation ZLGoodsEmptyView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.emptyImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width - dis(125))/2, dis(125), dis(125), dis(125))];
    [self addSubview:self.emptyImageView];
    
    self.emptyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.emptyImageView.bottom + dis(8), self.width, dis(20))];
    self.emptyLabel.textAlignment = NSTextAlignmentCenter;
    self.emptyLabel.font = kFont13;
    self.emptyLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    self.emptyLabel.text = @"还没有任何上架商品哦";
    [self addSubview:self.emptyLabel];
    
    self.operateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.operateButton.frame = CGRectMake((self.width - dis(100))/2, self.emptyLabel.bottom + dis(13), dis(100), dis(34));
    self.operateButton.backgroundColor = [UIColor zl_mainColor];
    [self.operateButton setTitle:@"添加商品" forState:UIControlStateNormal];
    self.operateButton.titleLabel.font = kFont13;
    self.operateButton.layer.cornerRadius = dis(17);
    [self.operateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:self.operateButton];
}

@end
