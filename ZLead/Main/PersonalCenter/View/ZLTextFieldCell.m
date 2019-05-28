//
//  ZLTextFieldCell.m
//  ZLead
//
//  Created by qzwh on 2019/5/28.
//  Copyright © 2019年 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLTextFieldCell.h"

@interface ZLTextFieldCell ()

@property (nonatomic, strong)UILabel *topicLbl;
@property (nonatomic, strong)UITextField *textField;

@end

@implementation ZLTextFieldCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)setup {
    
}

#pragma mark - lazy load
- (UILabel *)topicLbl {
    if (!_topicLbl) {
        _topicLbl = [[UILabel alloc] init];
        _topicLbl.font = kFont14;
        [self.contentView addSubview:_topicLbl];
    }
    return _topicLbl;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.font = kFont14;
        [self.contentView addSubview:_textField];
    }
    return _textField;
}

@end
