//
//  ZLEmptyDataView.m
//  Demo
//
//  Created by 董建伟 on 2019/4/9.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLEmptyDataView.h"

@interface ZLEmptyDataView ()
/** 图片 */
@property(nonatomic,strong)UIImageView * imgView;
/** 提醒文字 */
@property(nonatomic,strong)UILabel * textLabel;

@end
@implementation ZLEmptyDataView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
static ZLEmptyDataView *_emptyView = nil;

+(void)showEmptyViewType:(ZLEmptyViewType)type{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _emptyView = [[ZLEmptyDataView alloc] init];
        _emptyView.frame = CGRectMake(0, kNavBarHeight, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height-kNavBarHeight);
    });
    [_emptyView setEmptyViewStyle:type];
    [[UIApplication sharedApplication].keyWindow addSubview:_emptyView];
    
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        [self addSubview:self.imgView];
        [self addSubview:self.textLabel];
    }
    return self;
}
-(void)setEmptyViewStyle:(ZLEmptyViewType)type{
    switch (type) {
        case ZLEmptyViewTypeListNoData:
            self.imgView.image = [UIImage imageNamed:@"tableNoData"];
            self.textLabel.text = @"暂无数据";
            break;
        case ZLEmptyViewTypeNormalNoData:
            self.imgView.image = [UIImage imageNamed:@""];
            self.textLabel.text = @"暂无数据";
            break;
        case ZLEmptyViewTypeLoadFailure:
            self.imgView.image = [UIImage imageNamed:@""];
            self.textLabel.text = @"暂无数据";
            break;
            
        default:
            self.imgView.image = [UIImage imageNamed:@""];
            self.textLabel.text = @"暂无数据";
            break;
    }
}
-(void)layoutSubviews{
    UIImage *img = [UIImage imageNamed:@"tableNoData"];
    CGFloat width = img.size.width;
    CGFloat height = img.size.width;
    self.imgView.center = CGPointMake(UIScreen.mainScreen.bounds.size.width/2, (UIScreen.mainScreen.bounds.size.height-kNavBarHeight)/2);
    self.imgView.bounds = CGRectMake(0, 0, 2*width/3, 2*height/3);
}
-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
    }
    return _imgView;
    
}
-(UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.textColor = [UIColor grayColor];
    }
    return _textLabel;
}
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *view = [super hitTest:point withEvent:event];
    if (view == self) {
        return nil;
    }
    return view;
}
@end
