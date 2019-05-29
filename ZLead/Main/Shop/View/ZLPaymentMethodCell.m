//
//  ZLPaymentMethodCell.m
//  ZLead
//
//  Created by dmy on 2019/5/28.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLPaymentMethodCell.h"

@interface ZLPaymentMethodCell ()
@property (nonatomic, strong) UIImageView *pMethodIcon;
@property (nonatomic, strong) UILabel *pMethodNameLabel;
@property (nonatomic, strong) UIImageView *markImageView;
@end

@implementation ZLPaymentMethodCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupViews {
    self.pMethodIcon = [[UIImageView alloc] initWithFrame:kRect(15, 15, 22, 22)];
    [self addSubview:self.pMethodIcon];
    
    self.pMethodNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.pMethodIcon.right + 9, 0, dis(200), dis(51))];
    self.pMethodNameLabel.font = kFont14;
    self.pMethodNameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    [self addSubview:self.pMethodNameLabel];
    
    self.markImageView = [[UIImageView alloc] initWithFrame:kRect(346, 21, 13, 9)];
    [self addSubview:self.markImageView];
    
    self.bottomSeparator.frame = CGRectMake(dis(15), dis(51) - 0.5, dis(360), 0.5);
}

- (void)setupData:(id)dataModel {
    self.pMethodNameLabel.text = @"支付宝收款";
}

+ (CGFloat)heightForCell {
    return dis(51);
}

@end
