//
//  NetManager+ZLShopAPI.m
//  ZLead
//
//  Created by dmy on 2019/6/3.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "NetManager+ZLShopAPI.h"
#import "ZLShopModel.h"

@implementation NetManager (ZLShopAPI)
- (void)getShopListWithUserId:(NSString *)userId
                       sucess:(successBlock)sucess
                         fail:(failWithErrorBlock)fail {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"userId"] = userId;
    [[NetManager sharedInstance] postRequestWithPath:ZLURL_GetShopsByUserId parameters:dict sueccessful:^(id  _Nonnull responseObject) {
        NSMutableArray *shopList = [[NSMutableArray alloc] init];
        for (NSDictionary *companyDic in responseObject[@"zlwCompanyList"]) {
            for (NSDictionary *shopDic in companyDic[@"zlwShopList"]) {
                ZLShopModel *shopModel = [ZLShopModel  mj_objectWithKeyValues:shopDic];
                [shopList addObject:shopModel];
            }
        }
        
        sucess(shopList, shopList.count);
    } fail:^(NSError * _Nonnull error) {
        fail(error);
    }];
    
}
@end
