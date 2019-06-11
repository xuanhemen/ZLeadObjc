//
//  ZLAddGoodsImgView.m
//  ZLead
//
//  Created by 董建伟 on 2019/6/10.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLAddGoodsImgView.h"
#import "ZLAddImgCollectionViewCell.h"
@implementation ZLAddGoodsImgView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame viewModel:(ZLAddImgViewModel *)viewModel {
    self = [super initWithFrame:frame collectionViewLayout:[self flowLayout]];
    if (self) {
        /** 配置视图 */
        [self configurationView];
        /** 用viewModel初始化 */
        [self initWithViewModel:viewModel];
    }
    return self;
    
}
- (void)initWithViewModel:(ZLAddImgViewModel *)viewModel{
    self.delegate = viewModel;
    self.dataSource = viewModel;
    self.prefetchDataSource = viewModel;
    [viewModel.refreshImgEvent subscribeNext:^(id  _Nullable x) {
        [self reloadData];
    }];
}
-(void)configurationView{
    self.backgroundColor = [UIColor whiteColor];
    [self registerClass:[ZLAddImgCollectionViewCell class] forCellWithReuseIdentifier:@"img"];
    [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer"];
    
}

-(UICollectionViewFlowLayout *)flowLayout{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 1;
    return flowLayout;
}
- (UIViewController *)viewController {
    
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController *)nextResponder;
            
        }
        
    }
    
    return nil;
    
}
@end
