//
//  SizeManager.h
//  ZLead
//
//  Created by 董建伟 on 2019/5/22.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#ifndef SizeManager_h
#define SizeManager_h

/** 屏幕宽度 */
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
/** 屏幕高度 */
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height
/** 屏幕尺寸 */
#define kScreenSize  [UIScreen mainScreen].bounds.size

#define IS_IPHONE_X [[UIScreen mainScreen] bounds].size.width >=375.0f && [[UIScreen mainScreen] bounds].size.height >=812.0f&& IS_IPHONE

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
/** 底部安全高度 */
#define kSafeHeight (IS_IPHONE_X?(34):(0))
/** 状态栏和导航栏总高度 */
#define kNavBarHeight   (IS_IPHONE_X?(88):(64))

/** tabbar高度 */
#define kTabBarHeight   (IS_IPHONE_X?(83):(49))

/** 状态栏和导航栏总高度 */
#define kStatusBarHeight   (IS_IPHONE_X?(44):(20))

/** 适配比例 */
#define kp [UIScreen mainScreen].bounds.size.width/375.0
/** 距离、长度 */
#define dis(s) s*kp
/** 坐标 */
#define kRect(x,y,w,h) CGRectMake(x*kp, y*kp, w*kp, h*kp)
/** size */
#define kSize(w,h) CGSizeMake(w*kp, h*kp)
/** 正常字体大小 */
#define kFont18 [UIFont systemFontOfSize:18]
#define kFont17 [UIFont systemFontOfSize:17]
#define kFont16 [UIFont systemFontOfSize:16]
#define kFont15 [UIFont systemFontOfSize:15]
#define kFont14 [UIFont systemFontOfSize:14]
#define kBoldFont14 [UIFont boldSystemFontOfSize:14]
#define kFont13 [UIFont systemFontOfSize:13]
#define kFont12 [UIFont systemFontOfSize:12]
#define kFont11 [UIFont systemFontOfSize:11]
#define kFont10 [UIFont systemFontOfSize:10]

#endif /* SizeManager_h */
