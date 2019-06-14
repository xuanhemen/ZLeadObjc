//
//  ZLAddSpeCell.m
//  ZLead
//
//  Created by 董建伟 on 2019/6/11.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLAddSpeCell.h"

@implementation ZLAddSpeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLb];
        [self addSubview:self.markLb];
        [self addSubview:self.textField];
    }
    return self;
}
- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.textColor = normalColor;
        _titleLb.font = kFont14;
        [self addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(dis(15));
            make.centerY.equalTo(self);
        }];
    }
    return _titleLb;
}
- (UILabel *)markLb {
    if (!_markLb) {
        _markLb = [[UILabel alloc] init];
        _markLb.text = @"*";
        _markLb.textColor = [UIColor redColor];
        _markLb.font = kFont14;
        [self addSubview:_markLb];
        [_markLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLb.mas_right).offset(dis(5));
            make.centerY.equalTo(self);
        }];
    }
    return _markLb;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.tintColor = [UIColor lightGrayColor];
        _textField.placeholder = @"￥";
        _textField.keyboardType = UIKeyboardTypeDecimalPad;
        _textField.adjustsFontSizeToFitWidth = YES;
        _textField.font = [UIFont boldSystemFontOfSize:14];
        [self addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-dis(15));
            make.centerY.equalTo(self);
           
            
        }];
    }
    return _textField;
}
@end
