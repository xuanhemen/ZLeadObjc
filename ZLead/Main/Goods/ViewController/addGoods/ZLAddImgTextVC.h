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


@property (nonatomic, copy) void (^passImgtext)(NSArray *imgArr,NSDictionary *textDic); // 参数回调
@end

NS_ASSUME_NONNULL_END
