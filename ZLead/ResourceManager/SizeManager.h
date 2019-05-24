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
#define kScreenWith  [UIScreen mainScreen].bounds.size.width
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
/** 适配 */
#define ks [UIScreen mainScreen].bounds.size.width/375.0
/** 正常字体大小 */
#define kFontNormal [UIFont systemFontOfSize:16*ks]
/** 字体大小适配 */
#define kFont(size) [UIFont systemFontOfSize:size*ks]
/** 宽高、距离适配 */
#define s(distance) distance*ks

#endif /* SizeManager_h */
