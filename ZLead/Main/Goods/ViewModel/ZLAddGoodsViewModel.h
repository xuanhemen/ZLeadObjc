//
//  ZLAddGoodsViewModel.h
//  ZLead
//
//  Created by 董建伟 on 2019/6/6.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLAddGoodsViewModel : NSObject<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) NSMutableArray *dataArr; // 数据源

@property (nonatomic, strong) RACSubject *brandEvent; // 选择品牌

@property (nonatomic, strong) RACSubject *unitEvent; // 选择单位

@property (nonatomic, strong) RACSubject *addlistView; // 添加规格后，生成底部表视图

@property (nonatomic, strong) RACSubject *changeSpeEvent; // 调整规格

@property (nonatomic, copy) NSString *isAdd; // 标识是否添加了规格

/** 负责跳转 */
-(void)jumpFromController:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
