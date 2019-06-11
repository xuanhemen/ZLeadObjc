//
//  ZLAddGoodsImgView.h
//  ZLead
//
//  Created by 董建伟 on 2019/6/10.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLAddImgViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZLAddGoodsImgView : UICollectionView

- (instancetype)initWithFrame:(CGRect)frame viewModel:(ZLAddImgViewModel *)viewModel;
@end

NS_ASSUME_NONNULL_END
