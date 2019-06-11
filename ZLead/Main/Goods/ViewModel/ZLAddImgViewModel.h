//
//  ZLAddImgViewModel.h
//  ZLead
//
//  Created by 董建伟 on 2019/6/10.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QBImagePickerController/QBImagePickerController.h>
NS_ASSUME_NONNULL_BEGIN

@interface ZLAddImgViewModel : NSObject<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDataSourcePrefetching,QBImagePickerControllerDelegate>

@property (nonatomic, strong) NSMutableArray *imgArr; // 图片数组

@property (nonatomic, strong) RACSubject *addImgEvent; // 添加图片

@property (nonatomic, strong) RACSubject *refreshImgEvent; // 从相册选中照片之后，去刷新视图


/** 负责跳转 */
-(void)jumpFromController:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
