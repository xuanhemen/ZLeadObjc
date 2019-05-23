//
//  ZLEmptyDataView.h
//  Demo
//
//  Created by 董建伟 on 2019/4/9.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,ZLEmptyViewType){
    ZLEmptyViewTypeListNoData = 0,
    ZLEmptyViewTypeNormalNoData,
    ZLEmptyViewTypeLoadFailure
};
@interface ZLEmptyDataView : UIView


@property(nonatomic,assign)ZLEmptyViewType emptyType;

+(void)showEmptyViewType:(ZLEmptyViewType)type;

@end

NS_ASSUME_NONNULL_END
