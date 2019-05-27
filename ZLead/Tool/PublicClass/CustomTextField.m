//
//  CustomTextField.m
//  MOS
//
//  Created by 董建伟 on 2017/5/22.
//  Copyright © 2017年 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.textColor = [UIColor grayColor];
        self.borderStyle = UITextBorderStyleNone;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.tintColor = lightColor;
        
    }
    return self;
}
- (CGRect)caretRectForPosition:(UITextPosition *)position
{
    CGRect originalRect = [super caretRectForPosition:position];
    originalRect.origin.y = originalRect.origin.y+2;
    originalRect.size.height = self.font.lineHeight-2;
    originalRect.size.width = 2;
    
    return originalRect;
}
//控制placeHolder的位置，左右缩20
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    CGRect inset = kRect(bounds.origin.x+40, (bounds.origin.y+20), bounds.size.width, bounds.size.height);
    return inset;
}
//控制显示文本的位置
-(CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect inset = kRect(bounds.origin.x+35, bounds.origin.y, bounds.size.width, bounds.size.height);
    return inset;
}
//控制编辑文本的位置
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect inset = kRect(bounds.origin.x +35, bounds.origin.y, bounds.size.width, bounds.size.height);
    return inset;
}
//控制左视图位置
- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect inset = kRect(bounds.origin.x, (bounds.origin.y+20),17, 20);
    return inset;
}
- (CGRect)rightViewRectForBounds:(CGRect)bounds
{
    CGRect inset = kRect(bounds.size.width-90, (bounds.origin.y+10),100,40);
    return inset;
}
- (void)drawPlaceholderInRect:(CGRect)rect
{
    [[UIColor orangeColor] set];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSForegroundColorAttributeName] = lightColor;
    attrs[NSFontAttributeName] = kFont16;
    [self.placeholder drawInRect:rect withAttributes:attrs];
}
-(void)drawRect:(CGRect)rect{
    CALayer *bottomLayer = [CALayer layer];
    bottomLayer.backgroundColor = [UIColor grayColor].CGColor;
    bottomLayer.frame = CGRectMake(0, rect.size.height-0.3, rect.size.width, 0.3);
    [self.layer addSublayer:bottomLayer];
}
@end
