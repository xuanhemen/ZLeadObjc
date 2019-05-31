//
//  ZLGoodsBillCell.m
//  ZLead
//
//  Created by dmy on 2019/5/28.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLGoodsBillCell.h"
#import "ZLShoppingCartView.h"
#import "ZLShopGoodsModel.h"

@interface ZLGoodsBillCell ()

@end

@implementation ZLGoodsBillCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    [super setupViews];
    self.shoppingCartView.frame = kRect(0, 0, 375, 156);
    [self.shoppingCartView setSubviewsFrame:NO];
    self.bottomSeparator.frame = CGRectMake(0, dis(156) - 0.5, kScreenWidth, 0.5);
    [self bringSubviewToFront:self.bottomSeparator];
}

+ (CGFloat)heightForCell {
    return dis(156);
}

@end
