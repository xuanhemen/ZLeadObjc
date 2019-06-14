//
//  ZLAddSpeCell.h
//  ZLead
//
//  Created by 董建伟 on 2019/6/11.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLAddSpeCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLb; // title
@property (nonatomic, strong) UILabel *markLb; // 是否必填
@property (nonatomic, strong) UITextField *textField; // 库存

@end

NS_ASSUME_NONNULL_END
