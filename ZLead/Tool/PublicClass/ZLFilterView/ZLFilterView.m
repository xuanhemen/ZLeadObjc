//
//  ZLFilterView.m
//  ZLead
//
//  Created by dmy on 2019/6/5.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLFilterView.h"
#import "ZLFilterItemCell.h"
#import "ZLFilterSectionHeaderView.h"
#import "ZLFilterSectionFooterView.h"
#import "ZLFilterDataModel.h"
#import "ZLClassifyItemModel.h"

/** 按钮类型 */
typedef NS_ENUM (NSUInteger,ZLMenuButtonType) {
    /** 确定 */
    ZLMenuButtonTypeSure = 1,
    /** 重置 */
    ZLMenuButtonTypeReset,
};


#define weakself(self)  __weak __typeof(self) weakSelf = self

// ScreenWidth & kScreenHeight
#define kZLScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kZLScreenHeight [UIScreen mainScreen].bounds.size.height

#define iPhoneXRAndXSMAX (kZLScreenWidth == 414.f && kZLScreenHeight == 896.f ? YES : NO)
// iPhoneX
#define iPhoneXAndXS (kZLScreenWidth == 375.f && kZLScreenHeight == 812.f ? YES : NO)
#define kZLSafeAreaBottomHeight ((iPhoneXAndXS || iPhoneXRAndXSMAX) ?34 : 0)
// StatusbarH + NavigationH
#define kZLSafeAreaTopHeight ((iPhoneXAndXS || iPhoneXRAndXSMAX) ? 88.f : 64.f)

// KeyWindow
#define kKeyWindow [UIApplication sharedApplication].keyWindow

// AutoSize
#define kAutoWithSize(r) r*kScreenWidth / 375.0
#define kFont(size) kAutoWithSize(size)

#define kAutoHeightSize(r) r*kScreenHeight / 667.0

#define kFilterButtonHeight dis(50)
#define kFilterButtonWidth 44


@interface ZLFilterView () <UICollectionViewDelegate, UICollectionViewDataSource, ZLFilterItemCellDelegate, ZLFilterSectionHeaderViewDelegate, ZLFilterSectionFooterViewDelegate>
/** 筛选器 */
@property (nonatomic, strong) UICollectionView *filter;
@property (nonatomic, strong) UICollectionViewFlowLayout *filterFlowLayout;
/** 重置 */
@property (nonatomic, strong) UIButton *resetButton;
/** 确定 */
@property (nonatomic, strong) UIButton *sureButton;
/** 遮罩 */
@property (nonatomic, strong) UIControl *filterCover;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, assign) BOOL isShow;

@property (nonatomic, strong) FilterViewBlock filterViewBlock;

@property (nonatomic, strong) ZLFilterDataModel *filterDataModel;

@property (nonatomic, assign) ZLFilterViewPushDirection pushDirection;

@end

@implementation ZLFilterView
+ (instancetype)createFilterViewWidthConfiguration: (ZLFilterDataModel *)configuration
                                     pushDirection:(ZLFilterViewPushDirection )pushDirection
                                  filterViewBlock: (FilterViewBlock)filterViewBlock {
    ZLFilterView *dropMenu = [[ZLFilterView alloc]initWithFrame:CGRectMake(0,0, kZLScreenWidth, kZLScreenHeight)];
    dropMenu.filterViewBlock = filterViewBlock;
    dropMenu.filterDataModel = configuration;
    dropMenu.pushDirection = pushDirection;
    [dropMenu setupFilterView];
    return dropMenu;
}

- (void)setupFilterView {
    self.durationTime = 0.3;
    [kKeyWindow addSubview:self];
    [self addSubview:self.filterCover];
    [self.filterCover addSubview:self.filter];
    [self.filterCover addSubview:self.bottomView];
    [self.filterCover addSubview:self.sureButton];
    [self.filterCover addSubview:self.resetButton];
}

#pragma mark - 懒加载

- (UIView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.05].CGColor;
        _bottomView.layer.shadowOffset = CGSizeMake(0,-4);
        _bottomView.layer.shadowOpacity = 1;
        _bottomView.layer.shadowRadius = 4;
        _bottomView.frame = CGRectMake(self.filter.frame.origin.x, self.filter.frame.size.height + self.filter.frame.origin.y + kFilterButtonHeight,self.filter.frame.size.width , kZLSafeAreaBottomHeight);
    }
    return _bottomView;
}

- (UIControl *)filterCover {
    if (_filterCover == nil) {
        _filterCover = [[UIControl alloc] init];
        if (self.pushDirection == ZLFilterViewPushDirectionFromLeft) {
            _filterCover.frame = CGRectMake(-kZLScreenWidth, 0, kZLScreenWidth, kZLScreenHeight);
        } else {
            _filterCover.frame = CGRectMake(kZLScreenWidth, 0, kZLScreenWidth, kZLScreenHeight);
        }
        
        [_filterCover addTarget:self action:@selector(clickControl) forControlEvents:UIControlEventTouchUpInside];
        _filterCover.backgroundColor = [UIColor clearColor];
    }
    return _filterCover;
}

- (UIButton *)resetButton {
    if (_resetButton == nil) {
        _resetButton = [[UIButton alloc]init];
        _resetButton.frame = CGRectMake(self.filter.frame.origin.x, self.filter.frame.size.height, self.filter.frame.size.width * 0.5, kFilterButtonHeight);
        _resetButton.backgroundColor = [UIColor whiteColor];
        [_resetButton setTitle:@"取消" forState:UIControlStateNormal];
        [_resetButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_resetButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        _resetButton.tag = ZLMenuButtonTypeReset;
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor lightGrayColor];
        line.alpha = .1;
        line.frame = CGRectMake(0, 0, _resetButton.frame.size.width, 1);
        [_resetButton addSubview:line];
        _resetButton.alpha = 0;
    }
    return _resetButton;
}

- (UIButton *)sureButton {
    if (_sureButton == nil) {
        _sureButton = [[UIButton alloc] init];
        if (self.pushDirection == ZLFilterViewPushDirectionFromLeft) {
            _sureButton.frame = CGRectMake(self.filter.frame.size.width * 0.5, self.filter.frame.size.height, self.filter.frame.size.width * 0.5, kFilterButtonHeight);
        } else {
            _sureButton.frame = CGRectMake(kZLScreenWidth - self.filter.frame.size.width * 0.5, self.filter.frame.size.height, self.filter.frame.size.width * 0.5, kFilterButtonHeight);
        }
        
        _sureButton.backgroundColor = [UIColor colorWithHexString:@"#FFB32A"];
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sureButton.tag = ZLMenuButtonTypeSure;
        [_sureButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        _sureButton.alpha = 0;
    }
    return _sureButton;
}

- (UICollectionViewFlowLayout *)filterFlowLayout {
    if (_filterFlowLayout == nil) {
        _filterFlowLayout = [[UICollectionViewFlowLayout alloc]init];
        _filterFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _filterFlowLayout.minimumLineSpacing = 10.01f;
        _filterFlowLayout.minimumInteritemSpacing = 10.01f;
    }
    return _filterFlowLayout;
}

- (UICollectionView *)filter {
    if (_filter == nil) {
        CGRect filterFrame = CGRectZero;
        if (self.pushDirection == ZLFilterViewPushDirectionFromLeft) {
            filterFrame = CGRectMake(0, 0, kZLScreenWidth * 0.9, kZLScreenHeight - kFilterButtonHeight - kZLSafeAreaBottomHeight);
        } else {
            filterFrame = CGRectMake(kZLScreenWidth * 0.1, 0, kZLScreenWidth * 0.9, kZLScreenHeight - kFilterButtonHeight - kZLSafeAreaBottomHeight);
        }
        _filter = [[UICollectionView alloc]initWithFrame:filterFrame collectionViewLayout:self.filterFlowLayout];
        _filter.delegate = self;
        _filter.dataSource = self;
        _filter.contentInset = UIEdgeInsetsMake(20, 10, 0, 10);
        _filter.backgroundColor = [UIColor whiteColor];
        [_filter registerClass:[ZLFilterItemCell class] forCellWithReuseIdentifier:@"ZLFilterItemCellID"];
        [_filter registerClass:[ZLFilterSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ZLFilterSectionHeaderViewID"];
        [_filter registerClass:[ZLFilterSectionFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"ZLFilterSectionFooterViewID"];
    }
    return _filter;
}

#pragma mark - 显示

- (void)show {
    [self.filter reloadData];
    self.sureButton.alpha = 0;
    self.resetButton.alpha = 0;
    [self.layer setOpacity:1];
    [self dismiss];
    [kKeyWindow addSubview:self.filterCover];
    [self.filterCover addSubview:self.filter];
    if (self.pushDirection == ZLFilterViewPushDirectionFromLeft) {
        self.filter.frame = CGRectMake(0, 0, kZLScreenWidth * 0.9, kZLScreenHeight - kFilterButtonHeight - kZLSafeAreaBottomHeight);
        self.sureButton.frame = CGRectMake(self.filter.frame.size.width * 0.5, CGRectGetMaxY(self.filter.frame), self.filter.width * 0.5, kFilterButtonHeight);
    } else {
        self.filter.frame = CGRectMake(kZLScreenWidth * 0.1, 0, kZLScreenWidth * 0.9, kZLScreenHeight - kFilterButtonHeight - kZLSafeAreaBottomHeight);
        self.sureButton.frame = CGRectMake(self.filter.frame.size.width * 0.5 +kZLScreenWidth * 0.1 , CGRectGetMaxY(self.filter.frame), self.filter.width * 0.5, kFilterButtonHeight);
    }
    
    [self.filterCover addSubview:self.sureButton];
    [self.filterCover addSubview:self.resetButton];
    self.resetButton.frame = CGRectMake(self.filter.x, self.filter.frame.size.height, self.filter.width * 0.5, kFilterButtonHeight);
    self.sureButton.alpha = 1;
    self.resetButton.alpha = 1;
    
    [UIView animateWithDuration:self.durationTime animations:^{
        self.filterCover.frame = CGRectMake(0, 0, kZLScreenWidth, kZLScreenHeight);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.filterCover.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:102.0/255];
        } completion:^(BOOL finished) {
            self.isShow = YES;
        }];
    }];
}

#pragma mark - 消失

- (void)dismiss {
    self.filterCover.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:self.durationTime animations:^{
        if (self.pushDirection == ZLFilterViewPushDirectionFromLeft) {
            self.filterCover.frame = CGRectMake(- kZLScreenWidth, 0, kZLScreenWidth, kZLScreenHeight);
        } else {
            self.filterCover.frame = CGRectMake(kZLScreenWidth, 0, kZLScreenWidth, kZLScreenHeight);
        }
        
    } completion:^(BOOL finished) {
         [self.layer setOpacity:0.0];
        self.isShow = NO;
    }];
}

- (void)closeMenu {
    [self.filter removeFromSuperview];
    [self.filterCover removeFromSuperview];
    [self.sureButton removeFromSuperview];
    [self.resetButton removeFromSuperview];
}

- (void)clickControl {
    [self resetMenuStatus];
}

/** 重置menu 状态 */
- (void)resetMenuStatus {
    for (ZLFilterDataModel *filterDataModel in self.filterDataModel.dataList) {
        filterDataModel.isUnflod = NO;
    }
    [self.filter reloadData];
    [self dismiss];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self resetMenuStatus];
}


#pragma mark - UIButton Actions

- (void)clickButton:(UIButton *)sender {
    [self dismiss];
}

#pragma mark - collectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section  {
    if (section == 1 || section == 2) {
        return CGSizeMake(kZLScreenWidth * 0.8, dis(38));
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    ZLFilterDataModel *currentfilterDataModel = [self.filterDataModel.dataList objectAtIndex:section];
    if (section != 0) {
        return CGSizeMake(kZLScreenWidth * 0.8, [ZLFilterSectionHeaderView heightForFilterSectionHeaderView:currentfilterDataModel.selectedClassifyItemModel]);
    }
    return CGSizeMake(kZLScreenWidth * 0.8, dis(44));
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader] && self.filter == collectionView) {
        ZLFilterSectionHeaderView *header  = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ZLFilterSectionHeaderViewID" forIndexPath:indexPath];
        ZLFilterDataModel *currentfilterDataModel = [self.filterDataModel.dataList objectAtIndex:indexPath.section];
        header.filterDataModel = currentfilterDataModel;
        header.delegate = self;
        return header;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter] && self.filter == collectionView) {
         ZLFilterSectionFooterView *footer  = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ZLFilterSectionFooterViewID" forIndexPath:indexPath];
        ZLFilterDataModel *currentfilterDataModel = [self.filterDataModel.dataList objectAtIndex:indexPath.section];
        footer.filterDataModel = currentfilterDataModel;
        footer.delegate = self;
        return footer;
    } else {
        return [UICollectionReusableView new];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(dis(97.0), dis(32.0));
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.filterDataModel.dataList.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    ZLFilterDataModel *filterDataModel = [self.filterDataModel.dataList objectAtIndex:section];
    return filterDataModel.isUnflod ? filterDataModel.dataList.count : ((filterDataModel.dataList.count < 9) ? filterDataModel.dataList.count : 9);
}

#pragma mark - collectionView item

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZLFilterItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZLFilterItemCellID" forIndexPath:indexPath];
    cell.delegate = self;
    [cell setClassifyItemModel:[((ZLFilterDataModel *)[self.filterDataModel.dataList objectAtIndex:indexPath.section]).dataList objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - ZLFilterItemCellDelegate

- (void)selectedFilterItem:(ZLFilterItemCell *)item classifyItemModel:(ZLClassifyItemModel *)classifyItemModel {
    NSIndexPath *indexPath = [self.filter indexPathForCell:item];
    ZLFilterDataModel *filterDataModel = [self.filterDataModel.dataList objectAtIndex:indexPath.section];
    for (ZLClassifyItemModel *itemModel in filterDataModel.dataList) {
        if (itemModel.classifyId == filterDataModel.selectedClassifyItemModel.classifyId) {
            itemModel.isSelected = NO;
        } else if (itemModel.classifyId == classifyItemModel.classifyId) {
            itemModel.isSelected = YES;
        }
    }
    filterDataModel.selectedClassifyItemModel = classifyItemModel;
    [self.filter reloadData];
}

#pragma mark - ZLFilterSectionHeaderViewDelegate

- (void)cancelSelectedClassify:(ZLFilterSectionHeaderView *)header filterDataModel:(ZLFilterDataModel *)filterDataModel {
    NSIndexPath *indexPath = filterDataModel.indexPath;
    ZLFilterDataModel *currentfilterDataModel = [self.filterDataModel.dataList objectAtIndex:indexPath.section];
    for (ZLClassifyItemModel *itemModel in currentfilterDataModel.dataList) {
        if (itemModel.classifyId == currentfilterDataModel.selectedClassifyItemModel.classifyId) {
            itemModel.isSelected = NO;
        }
    }
     currentfilterDataModel.selectedClassifyItemModel = nil;
    [self.filter reloadData];
}

#pragma mark - ZLFilterSectionFooterViewDelegate

- (void)filterSectionFooterView:(ZLFilterSectionFooterView *)footer isUnfold:(BOOL)isUnfold filterDataModel:(ZLFilterDataModel *)filterDataModel {
    NSIndexPath *indexPath = filterDataModel.indexPath;
    ZLFilterDataModel *currentfilterDataModel = [self.filterDataModel.dataList objectAtIndex:indexPath.section];
    currentfilterDataModel.isUnflod = isUnfold;
    [self.filter reloadData];
}


@end
