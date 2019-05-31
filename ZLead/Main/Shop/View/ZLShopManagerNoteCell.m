//
//  ZLShopManagerNoteCell.m
//  ZLead
//
//  Created by dmy on 2019/5/25.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLShopManagerNoteCell.h"
#define kZLShopManagerNoteCellHeight dis(101)

@implementation ZLShopManagerNoteCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupViews {
    
    kWeakSelf(weakSelf)
    
    UIView *containerView = [[UIView alloc] init];
    containerView.backgroundColor = [UIColor whiteColor];
    containerView.layer.backgroundColor = [UIColor whiteColor].CGColor;
    containerView.layer.cornerRadius = 4;
    containerView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.05].CGColor;
    containerView.layer.shadowOffset = CGSizeMake(0,0);
    containerView.layer.shadowOpacity = 1;
    containerView.layer.shadowRadius = 4;
    [self addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(dis(15));
        make.right.equalTo(weakSelf).offset(dis(-15));
        make.height.mas_equalTo(dis(87));
        make.top.equalTo(weakSelf).offset(dis(7));
    }];
    
    NSArray *contents = @[@{@"title":@"店长须知",@"des":@"关于开店的教程", @"icon":@"shop-note"}, @{@"title":@"关于我们",@"des":@"直链网相关介绍", @"icon":@"shop-about"}];
    CGFloat actionButtonWidth = (kScreenWidth - dis(30))/2;
    for (int i = 0; i < contents.count; i ++) {
        UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        menuButton.tag = 1000 + i;
        [menuButton addTarget:self action:@selector(menuButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [containerView addSubview:menuButton];
        if (i == 0) {
            [menuButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(containerView.mas_left);
                make.width.mas_equalTo(actionButtonWidth);
                make.height.mas_equalTo(dis(87));
                make.top.equalTo(containerView.mas_top);
            }];
        } else {
            [menuButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(containerView.mas_left).offset(actionButtonWidth);
                make.width.mas_equalTo(actionButtonWidth);
                make.height.mas_equalTo(dis(87));
                make.top.equalTo(containerView.mas_top);
            }];
        }


        UILabel *managerNoteLabel = [[UILabel alloc] init];
        managerNoteLabel.text = [[contents objectAtIndex:i] objectForKey:@"title"];
        managerNoteLabel.font = [UIFont boldSystemFontOfSize:15];
        [menuButton addSubview:managerNoteLabel];

        [managerNoteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(menuButton.mas_left).offset(dis(20));
            make.width.mas_equalTo(dis(150));
            make.height.mas_equalTo(dis(21));
            make.top.equalTo(menuButton.mas_top).offset(dis(23));
        }];

        UILabel *courseLabel = [[UILabel alloc] init];
        courseLabel.textColor = [UIColor colorWithHexString:@"#747682"];
        courseLabel.text =  [[contents objectAtIndex:i] objectForKey:@"des"];
        courseLabel.font = [UIFont systemFontOfSize:12];
        [menuButton addSubview:courseLabel];
        [courseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(managerNoteLabel.mas_left);
            make.width.mas_equalTo(dis(150));
            make.height.mas_equalTo(dis(17));
            make.top.equalTo(managerNoteLabel.mas_bottom).offset(dis(7));
        }];

        UIImageView *noteIcon = [[UIImageView alloc] init];
        noteIcon.image = [UIImage imageNamed:[[contents objectAtIndex:i] objectForKey:@"icon"]];
        noteIcon.backgroundColor = [UIColor redColor];
        [menuButton addSubview:noteIcon];
        [noteIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(menuButton.mas_left).offset(dis(120));
            make.width.mas_equalTo(dis(36));
            make.height.mas_equalTo(dis(36));
            make.top.equalTo(menuButton.mas_top).offset(dis(25));
        }];
    }
    
    UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(actionButtonWidth, dis(19), 0.5, dis(50))];
    separatorView.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
    [containerView addSubview:separatorView];
}

+ (CGFloat)heightForCell {
    return kZLShopManagerNoteCellHeight;
}

#pragma mark - UIButton Actions

- (void)menuButtonAction:(UIButton *)menuButton {
    if (menuButton.tag - 1000 == 0) {
        if (self.shopManagerActionBlock) {
            self.shopManagerActionBlock();
        }
    } else {
        if (self.aboutUsActionBlock) {
            self.aboutUsActionBlock();
        }
    }
}
@end
