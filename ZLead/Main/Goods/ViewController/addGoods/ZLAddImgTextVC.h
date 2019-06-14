//
//  ZLAddImgTextVC.h
//  ZLead
//
//  Created by 董建伟 on 2019/6/13.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLBaseViewController.h"
#import <QBImagePickerController/QBImagePickerController.h>
NS_ASSUME_NONNULL_BEGIN

@interface ZLAddImgTextVC : ZLBaseViewController


@property (nonatomic, copy) void (^setImg)(UIImage *img); // <#annotation#> 
@end

NS_ASSUME_NONNULL_END
