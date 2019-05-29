//
//  ZLGoodsBillView.m
//  ZLead
//
//  Created by dmy on 2019/5/28.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLGoodsBillView.h"
#import "ZLGoodsBillCell.h"

@interface ZLGoodsBillView ()
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *calculateButton;
@end

@implementation ZLGoodsBillView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.billTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWith, kScreenHeight - (dis(50) + kSafeHeight - kNavBarHeight)) style:UITableViewStylePlain];
    self.billTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.billTableView.backgroundColor = [UIColor clearColor];
    [self.billTableView registerClass:[ZLGoodsBillCell class] forCellReuseIdentifier:@"ZLGoodsBillCell"];
    [self addSubview:self.billTableView];
    
    [self createBottomView];
}

- (void)createBottomView {
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    self.bottomView.frame = CGRectMake(0, kScreenHeight - dis(51) - kSafeHeight,kScreenWith, dis(51) + kSafeHeight);
    self.bottomView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    [self addSubview:self.bottomView];
    
    self.calculateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.calculateButton setTitle:@"去结算" forState:UIControlStateNormal];
    [self.calculateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.calculateButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.calculateButton.frame = kRect(269,5,96,41);
    self.calculateButton.backgroundColor = [UIColor colorWithHexString:@"#FFB223"];
    self.calculateButton.layer.cornerRadius = 24;
    [self.bottomView addSubview:self.calculateButton];
}

//#pragma mark - UIButton Actions
//
//- (void)allSelectedButtonAction:(UIButton *)allSelectedBtn {
//    allSelectedBtn.selected = !allSelectedBtn.selected;
//    if (self.allSelectedBlock) {
//        self.allSelectedBlock(allSelectedBtn.isSelected);
//    }
//}

@end
