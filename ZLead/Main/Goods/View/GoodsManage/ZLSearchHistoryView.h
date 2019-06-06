//
//  ZLSearchHistoryView.h
//  ZLead
//
//  Created by qzwh on 2019/5/31.
//  Copyright © 2019年 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol SearchTagDelegate <NSObject>

@optional
- (void)deleteData;

- (void)handleSelectTag:(NSString *)keyword;

@end

@interface ZLSearchHistoryView : UIView

@property (nonatomic, weak)id<SearchTagDelegate> delegate;
@property (nonatomic, copy)NSArray *tags;

@end

NS_ASSUME_NONNULL_END
