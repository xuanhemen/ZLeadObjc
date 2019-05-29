//
//  ZLGoodsTypeSelectedView.m
//  ZLead
//
//  Created by dmy on 2019/5/28.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLGoodsTypeSelectedView.h"

@interface ZLGoodsTypeSelectedView () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UILabel *currentSelectedTypeLabel;
@property (nonatomic, strong) UITableView *firstTypeTableView;
@property (nonatomic, strong) UITableView *secondTypeTableView;
@property (nonatomic, strong) UITableView *thirdTypeTableView;
@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIButton *maskView;
@property (nonatomic, assign) BOOL isHiddenMenu;
@end

@implementation ZLGoodsTypeSelectedView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.isHiddenMenu = YES;
    UIButton *showMenuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    showMenuButton.frame = kRect(345, 10, 20, 20);
    [showMenuButton setImage:[UIImage imageNamed:@"shop-arrow-down"] forState:UIControlStateNormal];
    [showMenuButton addTarget:self action:@selector(showMenuButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:showMenuButton];
    
    self.currentSelectedTypeLabel = [[UILabel alloc] initWithFrame:kRect(10, 0, 333, 42)];
    self.currentSelectedTypeLabel.font = [UIFont systemFontOfSize:14];
    self.currentSelectedTypeLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    self.currentSelectedTypeLabel.text = @"全部";
    self.currentSelectedTypeLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.currentSelectedTypeLabel];
    
    self.maskView = [UIButton buttonWithType:UIButtonTypeCustom];
    self.maskView.frame = CGRectMake(0, dis(42), kScreenWith, kScreenHeight - dis(84) - kNavBarHeight);
    self.maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    self.maskView.hidden = YES;
    [self.maskView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.maskView];
    
    self.containerView = [[UIView alloc] initWithFrame:kRect(0, 42, 375, 356)];
    self.containerView.backgroundColor = [UIColor whiteColor];
    self.containerView.hidden = YES;
    [self addSubview:self.containerView];
    
    self.firstTypeTableView = [[UITableView alloc] initWithFrame:kRect(0, 0, 119, 285) style:UITableViewStylePlain];
    self.firstTypeTableView.delegate = self;
    self.firstTypeTableView.dataSource = self;
    [self.firstTypeTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"category"];
    self.firstTypeTableView.showsVerticalScrollIndicator = NO;
    [self.containerView addSubview:self.firstTypeTableView];

    self.secondTypeTableView = [[UITableView alloc] initWithFrame:kRect(119, 0, 114, 285) style:UITableViewStylePlain];
    self.secondTypeTableView.delegate = self;
    self.secondTypeTableView.dataSource = self;
    [self.secondTypeTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"category"];
    self.secondTypeTableView.showsVerticalScrollIndicator = NO;
    [self.containerView addSubview:self.secondTypeTableView];

    self.thirdTypeTableView = [[UITableView alloc] initWithFrame:kRect(233, 0, 142, 285) style:UITableViewStylePlain];
    self.thirdTypeTableView.delegate = self;
    self.thirdTypeTableView.dataSource = self;
    [self.thirdTypeTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"category"];
    self.thirdTypeTableView.showsVerticalScrollIndicator = NO;
    [self.containerView addSubview:self.thirdTypeTableView];
    
    [self setupBottonView];
}

- (void)setupBottonView {
    self.bottomView = [[UIView alloc] init];
    self.bottomView.frame = kRect(0, 285,375,71);
    self.bottomView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    self.bottomView.layer.shadowColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0].CGColor;
    self.bottomView.layer.shadowOffset = CGSizeMake(0,-0.5);
    self.bottomView.layer.shadowOpacity = 1;
    self.bottomView.layer.shadowRadius = 0;
    [self.containerView addSubview:self.bottomView];
    
    UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    resetButton.frame = kRect(15, 15, 159, 40);
    resetButton.layer.borderColor = [UIColor colorWithRed:255/255.0 green:178/255.0 blue:35/255.0 alpha:1.0].CGColor;
    resetButton.layer.borderWidth = 1;
    resetButton.layer.cornerRadius = dis(20);
    [resetButton setTitle:@"重置" forState:UIControlStateNormal];
    [resetButton setTitleColor:[UIColor colorWithHexString:@"#FFB223"] forState:UIControlStateNormal];
    resetButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [resetButton addTarget:self action:@selector(resetButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:resetButton];
    
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.frame = kRect(201, 15, 159, 40);
    sureButton.layer.cornerRadius = dis(20);
    sureButton.backgroundColor = [UIColor colorWithHexString:@"#FFB223"];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [sureButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:sureButton];
}

- (void)dismiss {
    self.isHiddenMenu = YES;
    self.containerView.hidden = YES;
    self.maskView.hidden = YES;
    self.height = dis(41);
}

#pragma mark - UIButton Actions

- (void)showMenuButtonAction:(UIButton *)showMenuButton {
    self.isHiddenMenu = !self.isHiddenMenu;
    self.containerView.hidden = self.isHiddenMenu;
    self.maskView.hidden = self.isHiddenMenu;
    if (!self.isHiddenMenu) {
        self.height = dis(398);
    } else {
       self.height = dis(41);
    }
}

- (void)resetButtonAction:(UIButton *)resetButton {
    [self dismiss];
    if (self.resetButtonBlock) {
        self.resetButtonBlock();
    }
    self.currentSelectedTypeLabel.text = @"全部";
}

- (void)sureButtonAction:(UIButton *)resetButton {
    [self dismiss];
    if (self.sureButtonBlock) {
        self.sureButtonBlock(@"一级分类", @"二级分类", @"三级分类");
    }
    self.currentSelectedTypeLabel.text = [NSString stringWithFormat:@"%@/%@/%@", @"一级分类", @"二级分类", @"三级分类"];
}


#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return dis(48);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"category";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.text = @"分类";
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
