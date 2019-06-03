//
//  ZLOrderManageVC.m
//  ZLead
//
//  Created by dmy on 2019/5/27.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLOrderManageVC.h"
#import "ZLOrderListVC.h"
#import "ZLOrderManageView.h"
#import "ZLOrderListCell.h"
#import "ZLSegmentTitleView.h"
#import "ZLScrollContentView.h"

@interface ZLOrderManageVC () <ZLSegmentTitleViewDelegate, ZLScrollContentViewDelegate>
@property (nonatomic, strong) ZLOrderManageView *orderManageView;
@end

@implementation ZLOrderManageVC

- (void)loadView {
    self.orderManageView = [[ZLOrderManageView alloc] init];
    self.view = _orderManageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"订单管理";
    [self config];
    [self initTitleData:@[@"全部", @"待发货", @"已发货", @"待支付", @"已完成", @"已取消"]];
}

- (void)initTitleData:(NSArray *)titles {
    self.orderManageView.titleView.segmentTitles = titles;
    NSMutableArray *vcs = [[NSMutableArray alloc] init];
    for (int i = 0; i < titles.count; i ++) {
        ZLOrderListVC *orderListVC = [[ZLOrderListVC alloc] init];
        [vcs addObject:orderListVC];
    }
    [self.orderManageView.contentView reloadViewWithChildVcs:vcs parentVC:self];
    self.orderManageView.titleView.selectedIndex = 0;
    self.orderManageView.contentView.currentIndex = 0;
}

- (void)config {
    self.orderManageView.titleView.delegate = self;
    self.orderManageView.contentView.delegate = self;
//    self.orderManageView.orderListTableView.delegate = self;
//    self.orderManageView.orderListTableView.dataSource = self;
}

//#pragma mark - UITableViewDelegate & UITableViewDataSource
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 3;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return [ZLOrderListCell heightForCell];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    ZLBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLOrderListCell"];
//    [cell setupData:nil];
//    return cell;
//}

#pragma mark - PNSegmentTitleViewDelegate

- (void)segmentTitleView:(ZLSegmentTitleView *)segmentView selectedIndex:(NSInteger)selectedIndex lastSelectedIndex:(NSInteger)lastSelectedIndex{
    self.orderManageView.contentView.currentIndex = selectedIndex;
    self.orderManageView.titleView.selectedIndex = selectedIndex;
}

- (void)contentViewDidScroll:(ZLScrollContentView *)contentView fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(float)progress{
    
}

- (void)contentViewDidEndDecelerating:(ZLScrollContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex{
    self.orderManageView.contentView.currentIndex = endIndex;
    self.orderManageView.titleView.selectedIndex = endIndex;
}

@end
