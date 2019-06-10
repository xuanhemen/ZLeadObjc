//
//  ZLAddClassifyNameVC.m
//  ZLead
//
//  Created by dmy on 2019/6/10.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLAddClassifyNameVC.h"

@interface ZLAddClassifyNameVC ()
@property (nonatomic, strong) UITextField *classifyNameTF;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *numLabel;
@end

@implementation ZLAddClassifyNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNav];
    [self setupViews];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

#pragma mark - Config NavigationBar

- (void)configNav {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(0, 0, 19, 19);
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, dis(200), 30)];
    titleLabel.text = @"添加分类名称";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor colorWithHexString:@"#202020"];
    titleLabel.lineBreakMode = NSLineBreakByTruncatingHead;
    titleLabel.font = [UIFont systemFontOfSize:17];
    self.navigationItem.titleView = titleLabel;
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveButton setTitleColor:[UIColor zl_mainColor] forState:UIControlStateNormal];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    saveButton.titleLabel.font = kFont15;
    saveButton.frame = CGRectMake(0, 0, 19, 19);
    [saveButton addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:saveButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - Views

- (void)setupViews {
    self.view.backgroundColor = [UIColor whiteColor];
    self.classifyNameTF = [[UITextField alloc] initWithFrame:CGRectMake(dis(32), kNavBarHeight +  dis(34), dis(315), dis(30))];
    self.classifyNameTF.placeholder = @"请输入您的分类名称";
    self.classifyNameTF.font = kFont15;
    [self.view addSubview:self.classifyNameTF];
    
    self.line = [[UIView alloc] initWithFrame:CGRectMake(dis(32), self.classifyNameTF.bottom + dis(10), dis(315), 1)];
    self.line.backgroundColor = [UIColor colorWithHexString:@"#E2E2E2"];
    [self.view addSubview:self.line];
    
    self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(dis(290), self.line.bottom + dis(10), dis(55), dis(15))];
    self.numLabel.font = kFont12;
    self.numLabel.textColor = [UIColor colorWithHexString:@"#CCCCCC"];
    self.numLabel.textAlignment = NSTextAlignmentRight;
    self.numLabel.text = @"0/30";
    [self.view addSubview:self.numLabel];
}

#pragma mark - UIButton Actions

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveButtonAction:(UIButton *)button {
    [self.classifyNameTF resignFirstResponder];
    if (self.classifyNameTF.text.length <= 0) {
        [self showMsg:@"请输入您的分类名称"];
    }
}

#pragma mark - Private Method

- (void)keyboardHide:(UITapGestureRecognizer *)ges {
    [self.view endEditing:YES];
}




@end
