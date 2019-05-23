//
//  NSObject+HUD.h
//  ZLead
//
//  Created by 董建伟 on 2019/5/23.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (HUD)

/**展示HUD*/
-(void)showHUD;
/**移除HUD*/
-(void)dismissHUD;
/**显示信息,默认两秒之后消失*/
-(void)showMsg:(NSString *)msg;
/**展示提醒框,可设置持续时间*/
-(void)showMsg:(NSString *)msg duration:(NSTimeInterval)time;
/**根据SVP封装
 -(void)showMessage:(NSString *)msg;
 */

@end

NS_ASSUME_NONNULL_END
