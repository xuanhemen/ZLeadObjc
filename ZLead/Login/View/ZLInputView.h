//
//  ZLInputView.h
//  ZLead
//
//  Created by 董建伟 on 2019/5/25.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZLInputView : UIView

@property (nonatomic, strong) CustomTextField *userField; // 用户名

@property (nonatomic, strong) CustomTextField *pwField; // 密码
@end

NS_ASSUME_NONNULL_END
