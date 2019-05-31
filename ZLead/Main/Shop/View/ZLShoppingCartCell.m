//
//  ZLShoppingCartCell.m
//  ZLead
//
//  Created by dmy on 2019/5/28.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLShoppingCartCell.h"
#import "ZLShopGoodsModel.h"

@interface ZLShoppingCartCell ()
@property (nonatomic,strong) ZLShopGoodsModel *shopGoodsModel;
@end

@implementation ZLShoppingCartCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupViews {
    self.shoppingCartView = [[ZLShoppingCartView alloc] initWithFrame:kRect(15, 5, 345, 164)];
//    [self.shoppingCartView setSubviewsFrame:YES];
    kWeakSelf(weakSelf);
    self.shoppingCartView.minusButtonBlock = ^{
        if (weakSelf.delegate) {
            [weakSelf.delegate numButtonClick:weakSelf isAdd:NO];
        }
    };
    self.shoppingCartView.addButtonBlock = ^{
        if (weakSelf.delegate) {
            [weakSelf.delegate numButtonClick:weakSelf isAdd:YES];
        }
    };
    self.shoppingCartView.selectedButtonBlock = ^(BOOL isSelected) {
        if (weakSelf.delegate) {
            [weakSelf.delegate selectedButtonClick:weakSelf isSelected:isSelected];
        }
    };
//    self.shoppingCartView.goodsNumTF.delegate = weakSelf.delegate;
    [self addSubview:self.shoppingCartView];
}

- (void)setupData:(ZLShopGoodsModel *)goodsModel {
    [self.shoppingCartView setupData:goodsModel];
}

+ (CGFloat)heightForCell {
    return dis(174);
}

@end
