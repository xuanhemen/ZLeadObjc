//
//  ZLAddClassifyNameVC.m
//  ZLead
//
//  Created by dmy on 2019/6/10.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLAddClassifyNameVC.h"

#define kMaxLength 30

@interface ZLAddClassifyNameVC ()<UITextFieldDelegate>
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
    self.classifyNameTF.delegate = self;
    [self.view addSubview:self.classifyNameTF];
    [self.classifyNameTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
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

#pragma mark - UITextField Method

- (void)textFieldDidChange:(UITextField *)textField {
    if(kMaxLength <= 0){
        return;
    }
    NSString *text = textField.text;
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    if (!position){
        if (text.length > kMaxLength) {
            NSRange rangeIndex = [text rangeOfComposedCharacterSequenceAtIndex:kMaxLength];
            if (rangeIndex.length == 1) {
                textField.text = [text substringToIndex:kMaxLength];
            } else {
                if(kMaxLength == 1) {
                    textField.text = @"";
                } else {
                    NSRange rangeRange = [text rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, kMaxLength - 1 )];
                    textField.text = [text substringWithRange:rangeRange];
                }
            }
        }
    }
    self.numLabel.text = [NSString stringWithFormat:@"%@/30", @(textField.text.length)];
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
    
    [[NetManager sharedInstance] addShopGoodsClass:@"1" classifyName:self.classifyNameTF.text parentId:@"0" sucess:^{
        
    } fail:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark - Private Method

- (void)keyboardHide:(UITapGestureRecognizer *)ges {
    [self.view endEditing:YES];
}


#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if(kMaxLength <= 0){
        return YES;
    }
    UITextRange *selectedRange = [textField markedTextRange];//高亮选择的字
    UITextPosition *startPos = [textField positionFromPosition:selectedRange.start offset:0];
    UITextPosition *endPos = [textField positionFromPosition:selectedRange.end offset:0];
    NSInteger markLength = [textField offsetFromPosition:startPos toPosition:endPos];
    
    NSInteger confirmlength =  textField.text.length - markLength - range.length;//已经确认输入的字符长度
    if(confirmlength >= kMaxLength) {
        return NO;
    }
    
    NSInteger allowMaxMarkLength = [self allowMaxMarkLength:kMaxLength - confirmlength];
    if(markLength > allowMaxMarkLength ){// && string.length > 0){
        return NO;
    }
    return YES;
}

#pragma mark - Private Method
/**
 主要是用于中文输入的场景，可根据需要自定义
 剩余的允许输入的字数较少时，限制拼音字符的输入，提升体验
 */
- (NSInteger)allowMaxMarkLength:(NSInteger)remainLength {
    NSInteger length = 0;
    if(remainLength > 2){
        length = NSIntegerMax;
    } else if (remainLength > 0){
        length = remainLength * 6;  //一个中文对应的拼音一般不超过6个
    }
    return length;
}


@end
