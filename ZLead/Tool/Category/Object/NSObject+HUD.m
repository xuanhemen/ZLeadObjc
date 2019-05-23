//
//  NSObject+HUD.m
//  ZLead
//
//  Created by 董建伟 on 2019/5/23.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "NSObject+HUD.h"
#import "SVProgressHUD.h"
#import "RemindView.h"
@implementation NSObject (HUD)

/**展示HUD*/
-(void)showHUD{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"正在加载..."];
    
}
/**移除HUD*/
-(void)dismissHUD{
    [SVProgressHUD dismiss];
}
/**
 *展示信息
 -(void)showMessage:(NSString *)msg{
 [SVProgressHUD showImage:[UIImage imageNamed:@""] status:msg];
 [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
 [SVProgressHUD dismissWithDelay:2];
 }
 */

-(void)showMsg:(NSString *)msg{
    [RemindView showWithTitle:msg];
}
-(void)showMsg:(NSString *)msg duration:(NSTimeInterval)time{
    [RemindView showWithTitle:msg duration:time];
}
@end
