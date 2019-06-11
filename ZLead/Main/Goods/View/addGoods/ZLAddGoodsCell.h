//
//  ZLAddGoodsCell.h
//  ZLead
//
//  Created by 董建伟 on 2019/6/10.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLAddGoodsCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLb; // title

@property (nonatomic, strong) UILabel *markLb; // 是否是必填项

@property (nonatomic, strong) UILabel *contentLb; // 选择的内容

@property (nonatomic, strong) UITextField *textField; // 需要填写的内容
@end

NS_ASSUME_NONNULL_END
