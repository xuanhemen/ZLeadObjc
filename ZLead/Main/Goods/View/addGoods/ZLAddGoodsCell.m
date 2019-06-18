//
//  ZLAddGoodsCell.m
//  ZLead
//
//  Created by 董建伟 on 2019/6/10.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLAddGoodsCell.h"

@implementation ZLAddGoodsCell

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
        //self.accessoryView = [[UIImageView alloc] initWithImage:image(@"icon_jump")];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self addSubview:self.titleLb];
        [self addSubview:self.markLb];
        
    }
    return self;
}
- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = kFont14;
        _titleLb.textColor = hex(@"#333333");
        [self addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(dis(15));
        }];
    }
    return _titleLb;
}
- (UILabel *)markLb {
    if (!_markLb) {
        _markLb = [[UILabel alloc] init];
        _markLb.text = @"*";
        _markLb.textColor = [UIColor redColor];
        _markLb.font = kFont16;
        [self addSubview:_markLb];
        [_markLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.titleLb.mas_right).offset(dis(5));
        }];
    }
    return _markLb;
}
- (UILabel *)contentLb {
    if (!_contentLb) {
        _contentLb = [[UILabel alloc] init];
        _contentLb.font = kFont14;
        _contentLb.textColor = lightColor;
        [self addSubview:_contentLb];
        [_contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-dis(40));
        }];
    }
    return _contentLb;
}
- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.font = kFont14;
        _textField.textColor = normalColor;
        _textField.placeholder = @"未设置";
        _textField.enabled = NO;
        _textField.textAlignment = NSTextAlignmentRight;
        [self addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-dis(30));
        }];
    }
    return _textField;
}
@end
