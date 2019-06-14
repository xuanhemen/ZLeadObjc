//
//  ZLAddGoodsViewModel.m
//  ZLead
//
//  Created by 董建伟 on 2019/6/6.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLAddGoodsViewModel.h"
#import "ZLAddGoodsCell.h"
#import "ZLFilterView.h"
#import "ZLFilterDataModel.h"
#import "ZLClassifyItemModel.h"
#import "ZLBrandVC.h"
#import "ZLUnitVC.h"
#import "WHActionSheet.h"
#import "ZLAddSpecificateVC.h"
#import "ZLMoreSpeVC.h"
#import "ZLAddImgTextVC.h"
@interface ZLAddGoodsViewModel ()<WHActionSheetDelegate>

@property (nonatomic, strong) ZLFilterView *filterView;
@property (nonatomic, assign) BOOL showFilter;
@property (nonatomic, strong) ZLFilterDataModel *filterDataModel;
@property (nonatomic, strong) UIViewController *seleVC; // 中间变量

@property (nonatomic, strong) NSMutableDictionary *paraDic; // 无规格参数
@property (nonatomic, strong) NSMutableArray *detailArr; // 详细信息数据源


@end
@implementation ZLAddGoodsViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.brandEvent = [RACSubject subject];
        self.unitEvent = [RACSubject subject];
        self.addlistView = [RACSubject subject];
        self.changeSpeEvent = [RACSubject subject];
        self.isAdd = @"未设置";
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataArr count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.dataArr objectAtIndex:section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZLAddGoodsCell *cell = [[ZLAddGoodsCell alloc] init];
    cell.titleLb.text = [[self.dataArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if (indexPath.section==0) {
        if (indexPath.row<=2) {
            cell.contentLb.text = @"未设置";
        }else{
            cell.textField.hidden = NO;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        if (indexPath.row==3) {
            cell.markLb.hidden = YES;
        }
    }
    if (indexPath.section==1) {
        
        if (indexPath.row==0) {
            cell.contentLb.text = @"未设置";
            cell.markLb.hidden = YES;
        }else{
           RAC(cell.contentLb,text) = [RACObserve(self, isAdd) map:^id _Nullable(id  _Nullable value) {
                cell.contentLb.text = value;
                return [value description];
            }];
            cell.markLb.hidden = NO;
        }
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZLAddGoodsCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        if (indexPath.row==0) { //分类
            [self classificationButtonAction:cell.contentLb];
        }else if (indexPath.row==1){ //品牌
            [self.brandEvent sendNext:cell.contentLb];
            
        }else if (indexPath.row==2){
            [self.unitEvent sendNext:cell.contentLb];
        }
    }else if (indexPath.section==1) {
        if (indexPath.row==0) { //跳转到图文简介
            ZLAddImgTextVC *vc = [[ZLAddImgTextVC alloc] init];
            [self.seleVC.navigationController pushViewController:vc animated:YES];
            
        }else if (indexPath.row==1){
            if ([self.isAdd isEqualToString:@"多规格"]) {
                ZLMoreSpeVC *vc = [[ZLMoreSpeVC alloc] init];
                [self.seleVC.navigationController pushViewController:vc animated:YES];
                return;
            }
            if ([self.isAdd isEqualToString:@"无规格"]) {
                ZLAddSpecificateVC *vc = [[ZLAddSpecificateVC alloc] init];
                vc.passParams = ^(NSMutableDictionary * _Nonnull param) {
                    DLog(@"参数%@",param);
                    self.paraDic = param;
                    [self.addlistView sendNext:param];
                };
                [self.seleVC.navigationController pushViewController:vc animated:YES];
                return;
            }
            WHActionSheet *sheetView = [[WHActionSheet alloc] initWithTitle:@"" sheetTitles:@[@"无规格",@"多规格"] cancleBtnTitle:@"取消" sheetStyle:WHActionSheetDefault delegate:self];
            [sheetView show];
            
        }
    }
}
- (void)actionSheet:(WHActionSheet *)actionSheet clickButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==0) {
        ZLAddSpecificateVC *vc = [[ZLAddSpecificateVC alloc] init];
        vc.passParams = ^(NSMutableDictionary * _Nonnull param) {
            DLog(@"参数%@",param);
            self.paraDic = param;
            [self.addlistView sendNext:param];
        };
        [self.seleVC.navigationController pushViewController:vc animated:YES];
    }else if (buttonIndex==1) {
        ZLMoreSpeVC *vc = [[ZLMoreSpeVC alloc] init];
        [self.seleVC.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark - 跳转
-(void)jumpFromController:(UIViewController *)vc {
    _seleVC = vc;
    [self.brandEvent subscribeNext:^(id  _Nullable x) { //选择品牌
        UILabel *lable = x;
        ZLBrandVC *vc = [[ZLBrandVC alloc] init];
        vc.selecItem = ^(NSString * _Nonnull title) {
            lable.text = title;
        };
        [self.seleVC.navigationController pushViewController:vc animated:YES];
    }];
    [self.unitEvent subscribeNext:^(id  _Nullable x) { //选择单位
        UILabel *lable = x;
        ZLUnitVC *vc = [[ZLUnitVC alloc] init];
        vc.selecItem = ^(NSString * _Nonnull title) {
            lable.text = title;
        };
        [self.seleVC.navigationController pushViewController:vc animated:YES];
    }];
    [self.changeSpeEvent subscribeNext:^(id  _Nullable x) {
        ZLAddSpecificateVC *vc = [[ZLAddSpecificateVC alloc] init];
        vc.infoDic = self.paraDic;
        DLog(@"参数的%@",vc.infoDic);
        vc.passParams = ^(NSMutableDictionary * _Nonnull param) {
            DLog(@"参数%@",param);
            [self.addlistView sendNext:param];
        };
        [self.seleVC.navigationController pushViewController:vc animated:YES];
    }];
}
- (void)classificationButtonAction:(UILabel *)label {
    if (!self.showFilter) {
        [self.filterView dismiss];
        self.filterDataModel  = [[ZLFilterDataModel alloc] init];
        NSArray *sectionTitles = @[@"分类", @"一级分类", @"二级分类"];
        NSMutableArray *allItems = [[NSMutableArray alloc] init];
        for (NSInteger section = 0; section < 3; section ++) {
            ZLFilterDataModel *filterDataModel  = [[ZLFilterDataModel alloc] init];
            filterDataModel.sectionName = [sectionTitles objectAtIndex:section];
            filterDataModel.indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
            NSMutableArray *items = [[NSMutableArray alloc] init];
            for (NSInteger i = 0; i < 10; i++) {
                ZLClassifyItemModel *itemModel = [[ZLClassifyItemModel alloc] init];
                itemModel.classifyId = [NSString stringWithFormat:@"%@", @(i + 1)];
                itemModel.title = [NSString stringWithFormat:@"分类%@", @(i)];
                [items addObject:itemModel];
            }
            filterDataModel.dataList = items;
            [allItems addObject:filterDataModel];
        }
        self.filterDataModel.dataList = allItems;
        self.filterView = [ZLFilterView createFilterViewWidthConfiguration:self.filterDataModel pushDirection:ZLFilterViewPushDirectionFromRight filterViewBlock:^(NSString * _Nonnull firstClassify, NSString * _Nonnull secondClassify, NSString * _Nonnull thirdClassify) {
            label.text = thirdClassify;
        }];
        
        self.filterView.durationTime = 0.5;
        [self.filterView show];
    } else {
        [self.filterView dismiss];
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = [UIColor zl_bgColor];
    UIView *whiteView = [[UIView alloc] init];
    whiteView.backgroundColor = [UIColor whiteColor];
    [headView addSubview:whiteView];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(dis(20), 0, 0, 0));
    }];
    UILabel *titleLb = [[UILabel alloc] init];
    if (section==0) {
        titleLb.text = @"基本信息";
    }else{
        titleLb.text = @"详细信息";
    }
    titleLb.font = [UIFont boldSystemFontOfSize:15];
    titleLb.textColor = hex(@"#666666");
    [whiteView addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(whiteView);
        make.left.equalTo(whiteView).offset(dis(15));
    }];
    return headView;
}
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
        NSArray *baseInfoArr = @[@"分类",@"品牌",@"单位",@"自定义编码",@"型号"];
        _detailArr = [NSMutableArray arrayWithObjects:@"图文简介",@"添加规格", nil];
        [_dataArr addObject:baseInfoArr];
        [_dataArr addObject:_detailArr];
    }
    return _dataArr;
}
@end
