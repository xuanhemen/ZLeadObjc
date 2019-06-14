//
//  ZLAddImgViewModel.m
//  ZLead
//
//  Created by 董建伟 on 2019/6/10.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLAddImgViewModel.h"
#import "ZLAddImgCollectionViewCell.h"
#import "ZLDescribeView.h"


#define itemWidth (kScreenWidth-10)/3

@interface ZLAddImgViewModel ()

@property (nonatomic, strong) UIViewController *seleVC; // 中间变量

@end

@implementation ZLAddImgViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.addImgEvent = [RACSubject subject];
        self.refreshImgEvent = [RACSubject subject];
    }
    return self;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.imgArr count];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(itemWidth, itemWidth);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLAddImgCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"img" forIndexPath:indexPath];
    cell.imgView.image = [self.imgArr objectAtIndex:indexPath.row];
    return cell;
}
/** foot的尺寸*/
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(kScreenWidth, (200-itemWidth));
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView * footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer" forIndexPath:indexPath];
    footView.backgroundColor = [UIColor lightGrayColor];
    ZLDescribeView *view = [[ZLDescribeView alloc] init];
    view.frame = CGRectMake(0, 0, kScreenWidth, (200-itemWidth));
    [footView addSubview:view];
    return footView;
}

- (void)collectionView:(UICollectionView *)collectionView prefetchItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==_imgArr.count-1) {
        [self.addImgEvent sendNext:indexPath];

    }
}
- (NSMutableArray *)imgArr {
    if (!_imgArr) {
        _imgArr = [NSMutableArray array];
        UIImage *img = image(@"addGoodsImg");
        [_imgArr addObject:img];
    }
    return _imgArr;
}
-(void)jumpFromController:(UIViewController *)vc {
    _seleVC = vc;
    [self.addImgEvent subscribeNext:^(id  _Nullable x) { //添加拍照或从相册中选择
        [self popSheetView];
    }];
}
- (void)popSheetView {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"请选择添加方式" preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self goPhotoLibrary];  //跳到相册
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    [alertController addAction:archiveAction];
    
    [self.seleVC presentViewController:alertController animated:YES completion:nil];
}
/** 跳转到相册 */
- (void)goPhotoLibrary {
    
    QBImagePickerController *imagePickerController =[QBImagePickerController new];
    imagePickerController.delegate = self;
    imagePickerController.allowsMultipleSelection = YES;
    //imagePickerController.prompt = @"请选择图像!";//在界面上方显示文字“请选择图像!”
    imagePickerController.showsNumberOfSelectedAssets = YES;//在界面下方显示已经选择图像的数量
    imagePickerController.numberOfColumnsInPortrait = 4;//竖屏模式下一行显示4张图像
    imagePickerController.numberOfColumnsInLandscape = 7;//横屏模式下一行显示7张图像
    imagePickerController.maximumNumberOfSelection = 9;
    
    [self.seleVC presentViewController:imagePickerController animated:YES completion:nil];
}
#pragma mark-选取图片
- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets {
    
    for (PHAsset *set in assets) {
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        
        [[PHImageManager defaultManager] requestImageForAsset:set targetSize:[UIScreen mainScreen].bounds.size contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage *result, NSDictionary *info) { //相册中点击完成，把图片插到数据源中
            //设置图片
            [self.imgArr insertObject:result atIndex:[self.imgArr count]-1];
            NSNumber *count = [NSNumber numberWithInteger:[self.imgArr count]];
            [self.refreshImgEvent sendNext:count]; //去刷新图片视图
            
        }];
    }
    
    [_seleVC dismissViewControllerAnimated:YES completion:nil];
}
/** 点击取消 */
- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController {
    [_seleVC dismissViewControllerAnimated:YES completion:nil];
}
- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didDeselectAsset:(PHAsset *)asset{
    DLog(@"取消选中");
}
- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didSelectAsset:(PHAsset *)asset{
    DLog(@"选中");
}
- (BOOL)qb_imagePickerController:(QBImagePickerController *)imagePickerController shouldSelectAsset:(PHAsset *)asset{
    
    NSInteger max = 5-[self.imgArr count]+1;
    if (imagePickerController.selectedAssets.count >= max) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"最多可选择%d张图片", 5] preferredStyle:UIAlertControllerStyleAlert];

        [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil]];
        [imagePickerController presentViewController:alert animated:YES completion:nil];
        return NO;
    }
    
    return YES;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    
//    [self.imageArr insertObject:image atIndex:[self.imageArr count]-1];
//    [self dismissViewControllerAnimated:YES completion:nil];
//    
//    [self.collectionView reloadData];
    
}
@end
