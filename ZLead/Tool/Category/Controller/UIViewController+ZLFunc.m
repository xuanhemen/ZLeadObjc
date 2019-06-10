//
//  UIViewController+ZLFunc.m
//  ZLead
//
//  Created by 董建伟 on 2019/6/9.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "UIViewController+ZLFunc.h"

@implementation UIViewController (ZLFunc)

//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Class class = [self class];
//        SEL originalSelector = @selector(viewWillAppear:);
//        SEL swizzledSelector = @selector(myViewWillAppear:);
//        
//        Method originalMethod = class_getInstanceMethod(class,originalSelector);
//        Method swizzledMethod = class_getInstanceMethod(class,swizzledSelector);
//        
//        //judge the method named  swizzledMethod is already existed.
//        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
//        // if swizzledMethod is already existed.
//        if (didAddMethod) {
//            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
//        }
//        else {
//            method_exchangeImplementations(originalMethod, swizzledMethod);
//        }
//    });
//}
//- (void)myViewWillAppear:(BOOL)animated {
//    
//    [self myViewWillAppear:animated];
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:[UIColor blackColor]}];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
//}
@end
