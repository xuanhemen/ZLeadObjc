//
//  ZLSearchHistoryView.m
//  ZLead
//
//  Created by qzwh on 2019/5/31.
//  Copyright © 2019年 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLSearchHistoryView.h"


@interface ZLSearchHistoryView ()

@property (nonatomic, strong)UILabel *titleLbl;
@property (nonatomic, strong)UIButton *deleteBtn;

@end

@implementation ZLSearchHistoryView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.titleLbl];
        self.titleLbl.frame = CGRectMake(15, 15, 80, 20);
        
        [self addSubview:self.deleteBtn];
        self.deleteBtn.frame = CGRectMake(frame.size.width - 30, 15, 14, 14);
    }
    return self;
}

- (void)setTags:(NSArray *)tags {
    _tags = tags;
    CGFloat marginX = 10;
    CGFloat marginY = 12;
    CGFloat height = 25;
    UIButton * markBtn;
    for (int i = 0; i < _tags.count; i++) {
        CGFloat width =  [self calculateString:_tags[i] Width:12] + 20;
        UIButton * tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (!markBtn) {
            tagBtn.frame = CGRectMake(15, 50, width, height);
        } else {
            if (markBtn.frame.origin.x + markBtn.frame.size.width + marginX + width + marginX > kScreenWidth) {
                tagBtn.frame = CGRectMake(marginX, markBtn.frame.origin.y + markBtn.frame.size.height + marginY, width, height);
            }else{
                tagBtn.frame = CGRectMake(markBtn.frame.origin.x + markBtn.frame.size.width + marginX, markBtn.frame.origin.y, width, height);
            }
        }
        [tagBtn setTitle:_tags[i] forState:UIControlStateNormal];
        tagBtn.titleLabel.font = kFont12;
        tagBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        tagBtn.backgroundColor = [UIColor colorWithHexString:@"#F4F4F4"];
        [tagBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        [self makeCornerRadius:height/2 borderColor:[UIColor colorWithHexString:@"#F4F4F4"] layer:tagBtn.layer borderWidth:.5];
        markBtn = tagBtn;
        
        [tagBtn addTarget:self action:@selector(clickTo:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:markBtn];
    }
    CGRect rect = self.frame;
    rect.size.height = markBtn.frame.origin.y + markBtn.frame.size.height + marginY;
    self.frame = rect;
}

#pragma mark - action
- (void)clickTo:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(handleSelectTag:)]) {
        [self.delegate handleSelectTag:sender.titleLabel.text];
    }
}

- (void)deleteBtnClicked {
    if ([self.delegate respondsToSelector:@selector(deleteData)]) {
        [self.delegate deleteData];
    }
}

#pragma mark - lazy load
- (UILabel *)titleLbl {
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.text = @"历史记录";
        _titleLbl.textColor = [UIColor zl_textColor];
        _titleLbl.font = [UIFont boldSystemFontOfSize:14];
    }
    return _titleLbl;
}

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setImage:[UIImage imageNamed:@"icon_search_delete"] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

#pragma mark - private
- (void)makeCornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor layer:(CALayer *)layer borderWidth:(CGFloat)borderWidth {
    layer.cornerRadius = radius;
    layer.masksToBounds = YES;
    layer.borderColor = borderColor.CGColor;
    layer.borderWidth = borderWidth;
}

- (CGFloat)calculateString:(NSString *)str Width:(NSInteger)font {
    CGSize size = [str boundingRectWithSize:CGSizeMake(kScreenWidth - 40, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil].size;
    return size.width;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

