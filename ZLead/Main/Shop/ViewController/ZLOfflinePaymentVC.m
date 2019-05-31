//
//  ZLOfflinePaymentVC.m
//  ZLead
//
//  Created by dmy on 2019/5/27.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLOfflinePaymentVC.h"
#import "ZLPaymentMethodCell.h"
#import "ZLPaymentMethodSectionHeaderView.h"
#import "ZLPaymentMethodModel.h"

@interface ZLOfflinePaymentVC ()<UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>
@property (nonatomic, strong) UITableView *paymentTableView;
@property (nonatomic, strong) UIView *tableViewHeaderView;
@property (nonatomic, strong) UITextField *amountTextField;
@property (nonatomic, strong) UITextView *paymentNoteTextView;
@property (nonatomic, strong) UILabel *notePlaceholderLabel;
@property (nonatomic, strong) UIButton *createPayQRCodeButton;
@property (nonatomic, strong) NSMutableArray *payMethodList;
@end

@implementation ZLOfflinePaymentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"线下支付";
    [self.view addSubview:self.paymentTableView];
    [self.view addSubview:self.createPayQRCodeButton];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    [self setupData];
}

#pragma mark - Views

- (UITableView *)paymentTableView {
    if (!_paymentTableView) {
        _paymentTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _paymentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _paymentTableView.delegate = self;
        _paymentTableView.dataSource = self;
        [_paymentTableView registerClass:[ZLPaymentMethodCell class] forCellReuseIdentifier:@"ZLPaymentMethodCell"];
        _paymentTableView.backgroundColor = [UIColor clearColor];
        _paymentTableView.backgroundView = nil;
        _paymentTableView.tableHeaderView = self.tableViewHeaderView;
        _paymentTableView.scrollEnabled = NO;
    }
    return _paymentTableView;
}

- (UITextView *)paymentNoteTextView {
    if (!_paymentNoteTextView) {
        _paymentNoteTextView = [[UITextView alloc] initWithFrame:CGRectZero];
    }
    return _paymentNoteTextView;
}

- (UITextField *)amountTextField {
    if (!_amountTextField) {
        _amountTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _amountTextField.font = kFont14;
        _amountTextField.placeholder = @"请输入金额";
    }
    return _amountTextField;
}

- (UILabel *)notePlaceholderLabel {
    if (!_notePlaceholderLabel) {
        _notePlaceholderLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _notePlaceholderLabel.font = kFont14;
        _notePlaceholderLabel.text = @"请输入备注内容";
        _notePlaceholderLabel.textColor = [UIColor colorWithHexString:@"#CCCCCC"];
    }
    return _notePlaceholderLabel;
}

- (UIView *)tableViewHeaderView {
    if (!_tableViewHeaderView) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, dis(187))];
        headerView.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
        
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, dis(10), kScreenWidth, dis(177))];
        containerView.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:containerView];
        
        UILabel *amountLabel = [[UILabel alloc] initWithFrame:kRect(15, 0, 80, 41)];
        amountLabel.font = kFont15;
        amountLabel.text = @"收款金额";
        amountLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [containerView addSubview:amountLabel];
        
        UILabel *moneySymbolLabel = [[UILabel alloc] initWithFrame:kRect(267, 0, 20, 41)];
        moneySymbolLabel.font = kFont15;
        moneySymbolLabel.text = @"¥";
        moneySymbolLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [containerView addSubview:moneySymbolLabel];
        
        self.amountTextField.frame = kRect(280,0, 80, 41);
        [containerView addSubview:self.amountTextField];
        
        UIView *sLine = [[UIView alloc] initWithFrame:CGRectMake(dis(15), dis(41) - 0.5, dis(360), 0.5)];
        sLine.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
        [containerView addSubview:sLine];
        
        UILabel *noteLabel = [[UILabel alloc] initWithFrame:kRect(15, 50, 80, 21)];
        noteLabel.font = kFont15;
        noteLabel.text = @"收款备注";
        noteLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [containerView addSubview:noteLabel];
        
        [containerView addSubview:self.paymentNoteTextView];
        self.paymentNoteTextView.frame = kRect(14, 77, 345, 100);
        self.paymentNoteTextView.delegate = self;
        
        self.notePlaceholderLabel.frame = kRect(15, 82, 345, 20);
        [containerView addSubview:self.notePlaceholderLabel];
        

        self.tableViewHeaderView = headerView;
    }
    return _tableViewHeaderView;
}

- (UIButton *)createPayQRCodeButton {
    if (!_createPayQRCodeButton) {
        _createPayQRCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _createPayQRCodeButton.backgroundColor = [UIColor colorWithHexString:@"#FFB223"];
        _createPayQRCodeButton.layer.cornerRadius = dis(45)/2;
        [_createPayQRCodeButton setTitle:@"生成收款码" forState:UIControlStateNormal];
        [_createPayQRCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _createPayQRCodeButton.frame = CGRectMake(dis(15), kScreenHeight - dis(70) - kSafeHeight, dis(345), dis(45));
        [_createPayQRCodeButton addTarget:self action:@selector(createPayQRCodeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _createPayQRCodeButton;
}

#pragma mark - init Data

- (NSMutableArray *)payMethodList {
    if (!_payMethodList) {
        NSMutableArray *payMethodList = [[NSMutableArray alloc] initWithCapacity:0];
        self.payMethodList = payMethodList;
    }
    return _payMethodList;
}

#pragma mark - SetupData

- (void)setupData {
    NSArray *pays = @[@"现金支付", @"支付宝支付", @"微信支付"];
    for (int i = 0; i < pays.count; i++) {
        ZLPaymentMethodModel *payModel = [[ZLPaymentMethodModel alloc] init];
        payModel.name = [pays objectAtIndex:i];
        [self.payMethodList addObject:payModel];
    }
}

#pragma mark - Private Method

- (void)keyboardHide:(UITapGestureRecognizer *)ges {
    [self.view endEditing:YES];
}

#pragma mark - UIButton Actions

- (void)createPayQRCodeButtonAction {
    
}

#pragma mark - UITextViewdDelegate

- (void)textViewDidChange:(UITextView *)textView {
    if (!self.paymentNoteTextView.text.length) {
        self.notePlaceholderLabel.alpha = 1;
    }else{
        self.notePlaceholderLabel.alpha = 0;
    }
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZLPaymentMethodCell heightForCell];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZLBaseCell *cell= [tableView dequeueReusableCellWithIdentifier:@"ZLPaymentMethodCell"];
    __weak typeof (ZLBaseCell) *weakCell = cell;
    kWeakSelf(weakSelf);
    [cell setupData:[self.payMethodList objectAtIndex:indexPath.row]];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        ZLPaymentMethodSectionHeaderView *headerView = [[ZLPaymentMethodSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, dis(53))];
        return headerView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return dis(53);
    }
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    ZLPaymentMethodCell *paymentMethodCell = [tableView cellForRowAtIndexPath:indexPath];
//    ZLPaymentMethodModel *payModel = self.payMethodList[indexPath.row];
//    payModel.isSelected = !payModel.isSelected;
//    [paymentMethodCell setupData:payModel];
    for (int i = 0; i < self.payMethodList.count; i++) {
        ZLPaymentMethodModel *payModel = [self.payMethodList objectAtIndex:i];
        payModel.isSelected = (indexPath.row == i) ? YES : NO;
    }
    [tableView reloadSections:[[NSIndexSet alloc] initWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
