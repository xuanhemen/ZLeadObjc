//
//  ZLPerHeaderView.h
//  ZLead
//
//  Created by qzwh on 2019/5/27.
//  Copyright © 2019年 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLPerHeaderView : UIView

/** <#注释#> */
@property (nonatomic, copy)void (^msgBlock)(void);

@end

NS_ASSUME_NONNULL_END
