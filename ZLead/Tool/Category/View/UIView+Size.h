//
//  UIView+Size.h
//  ZLead
//
//  Created by dmy on 2019/5/27.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Size)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;


- (NSString *)frameStr;
- (CGFloat)bottom; // 底部 设置底部的前提是有高度
- (CGFloat)left;   // 最左
- (CGFloat)right;  // 最右
- (CGFloat)top;    // 顶部
- (CGFloat)middleX; // 中点x
- (CGFloat)middleY; // 中点y

/* 截图 */
- (UIImage *)captureImage;
/*获取touches的point*/
- (CGPoint)pointWithTouches:(NSSet *)touches;

@end
