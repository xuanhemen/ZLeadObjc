//
//  ZLInputView.h
//  ZLead
//
//  Created by 董建伟 on 2019/5/25.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
#import "ZLLoginViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZLInputView : UIView

@property (nonatomic, strong) CustomTextField *userField; // 用户名

@property (nonatomic, strong) CustomTextField *pwField; // 密码

@property (nonatomic, strong) UIButton *rightBtnView; // 密码右视图

- (instancetype)initWithFrame:(CGRect)frame viewModel:(ZLLoginViewModel *)viewModel;
/** 根据登录方式不同，改变自身样式 当isSelected是YES时为账号密码登录，反之为验证码登录*/
-(void)changeStyle:(BOOL)isSelected;
@end

NS_ASSUME_NONNULL_END
