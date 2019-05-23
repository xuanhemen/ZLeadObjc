//
//  RemindView.h
//  Demo
//
//  Created by 董建伟 on 2019/4/3.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RemindView : UIView

/**展示提醒框,默认两秒之后消失*/
+(void)showWithTitle:(NSString *)string;
/**展示提醒框,可设置持续时间*/
+(void)showWithTitle:(NSString *)string duration:(NSTimeInterval)seconds;
@end

NS_ASSUME_NONNULL_END
