//
//  RemindView.m
//  Demo
//
//  Created by 董建伟 on 2019/4/3.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "RemindView.h"
#import <objc/runtime.h>
@interface RemindView ()
/** 提醒label */
@property(nonatomic,strong)UILabel * textLabel;
/**attributeDic*/
@property(nonatomic,strong)NSMutableDictionary * attributeDic;

@end
@implementation RemindView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

static RemindView *_remindView = nil;

+(void)showWithTitle:(NSString *)string
{
    if (!_remindView) {
        _remindView = [[RemindView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    [_remindView initDataWithString:string];
    [[UIApplication sharedApplication].keyWindow addSubview:_remindView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_remindView removeFromSuperview];
        _remindView = nil;
    });
}
+(void)showWithTitle:(NSString *)string duration:(NSTimeInterval)seconds{
    if (!_remindView) {
        _remindView = [[RemindView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    [_remindView initDataWithString:string];
    
    [[UIApplication sharedApplication].keyWindow addSubview:_remindView];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:_remindView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_remindView removeFromSuperview];
        
    });
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        self.textLabel.hidden = NO;
    }
    return self;
    
}
-(void)initDataWithString:(NSString *)string{
    NSMutableAttributedString *str = [self getAttributeStrWithStr:string];
    self.textLabel.attributedText = str;
}
-(UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.layer.masksToBounds = YES;
        _textLabel.layer.cornerRadius = 5;
        _textLabel.backgroundColor = [UIColor blackColor];
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.textLabel];
    
    }
    return _textLabel;
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize size = [_textLabel.text sizeWithAttributes:_attributeDic];
    _textLabel.bounds = CGRectMake(0, 0, MIN(size.width+30, [UIScreen mainScreen].bounds.size.width-60), 40);
    self.textLabel.center = CGPointMake(UIScreen.mainScreen.bounds.size.width/2, UIScreen.mainScreen.bounds.size.height/2);
}
-(NSMutableAttributedString *)getAttributeStrWithStr:(NSString *)string{
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:string];
    _attributeDic = [NSMutableDictionary dictionary];
    _attributeDic[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    _attributeDic[NSKernAttributeName] = @(1.5);
    [attributeStr addAttributes:_attributeDic range:NSMakeRange(0, string.length)];
    // NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    // paragraphStyle.lineSpacing = 5;       //字间距5
    // paragraphStyle.alignment = NSTextAlignmentCenter;   //对齐方式为居中对齐
    // _attributeDic[NSParagraphStyleAttributeName] = paragraphStyle;
    return attributeStr;
}
@end
