//
//  GeneralTableViewDelegate.m
//  Demo
//
//  Created by 董建伟 on 2019/4/4.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "GeneralTableViewDelegate.h"

@implementation GeneralTableViewDelegate

-(void)configDelegateWithArray:(NSArray *)array cell:(UITableViewCell *(^)(UITableView *,NSIndexPath *))cell selecedCell:(void (^)(NSIndexPath *)) selectedBlock{
    self.dataArr = array;
    self.createCell = cell;
    self.selecBlock = selectedBlock;
   
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = self.createCell(tableView,indexPath);
    return cell;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.style == UITableViewStylePlain) {
        return [self.dataArr count];
    }
    return !self.secRow?:self.secRow(section);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selecBlock(indexPath);
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView.style == UITableViewStylePlain) {
        return 1;
    }
    return [self.dataArr count];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView.style == UITableViewStylePlain) {
        return nil;
    }
    return self.secView(section);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
@end
