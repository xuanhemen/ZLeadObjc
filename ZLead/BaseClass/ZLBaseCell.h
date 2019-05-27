//
//  ZLBaseCell.h
//  ZLead
//
//  Created by dmy on 2019/5/25.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLBaseCell : UITableViewCell
- (void)setupData:(id)dataModel;
+ (CGFloat)heightForCell;
@end

NS_ASSUME_NONNULL_END
