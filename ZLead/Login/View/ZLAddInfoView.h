//
//  ZLAddInfoView.h
//  ZLead
//
//  Created by 董建伟 on 2019/5/30.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLAddInfoView : UIView


@property (nonatomic, strong) UITextField *nameField; // 店铺名称输入框

@property (nonatomic, strong) UILabel *areaLable; // 省市区

@property (nonatomic, strong) UITextField *addressField; // 地址输入框
@end

NS_ASSUME_NONNULL_END
