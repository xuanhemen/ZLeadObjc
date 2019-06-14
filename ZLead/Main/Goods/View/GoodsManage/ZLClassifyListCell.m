//
//  ZLClassifyListCell.m
//  ZLead
//
//  Created by dmy on 2019/6/6.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLClassifyListCell.h"
#import "ZLClassifyItemModel.h"

@interface ZLClassifyListCell ()
@property (nonatomic, strong) UILabel *classifyNameLabel;
@property (nonatomic, strong) UIButton *editButton;
@property (nonatomic, strong) UIButton *delButton;
@property (nonatomic, strong) ZLClassifyItemModel *classifyItemModel;
@end

@implementation ZLClassifyListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
        self.bottomSeparator.frame = CGRectMake(0, dis(50) - 1, kScreenWidth, 1);
    }
    return self;
}

- (void)setupViews {
    self.classifyNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(dis(15), 0, dis(260), dis(50))];
    self.classifyNameLabel.font = kFont14;
    self.classifyNameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    self.classifyNameLabel.text = @"分类名称";
    [self addSubview:self.classifyNameLabel];
    
    self.delButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.delButton.frame = CGRectMake(dis(334), 0, dis(26), dis(50));
    self.delButton.titleLabel.font = kFont13;
    [self.delButton setTitleColor:[UIColor colorWithHexString:@"#3B88FF"] forState:UIControlStateNormal];
    [self.delButton setTitle:@"删除" forState:UIControlStateNormal];
    [self.delButton sizeToFit];
    self.delButton.height = dis(50);
    [self.delButton addTarget:self action:@selector(delButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.delButton];
    
    self.editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.editButton.frame = CGRectMake(dis(293), 0, dis(26), dis(50));
    self.editButton.titleLabel.font = kFont13;
    [self.editButton setTitleColor:[UIColor colorWithHexString:@"#3B88FF"] forState:UIControlStateNormal];
    [self.editButton setTitle:@"编辑" forState:UIControlStateNormal];
    [self.editButton sizeToFit];
    self.editButton.height = dis(50);
    [self.editButton addTarget:self action:@selector(editButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.editButton];
}

- (void)setupData:(ZLClassifyItemModel *)dataModel {
    self.classifyItemModel = dataModel;
}

- (void)delButtonAction {
    if (self.delGoodsClassifyBlock) {
        self.delGoodsClassifyBlock(self.classifyItemModel, self);
    }
}

- (void)editButtonAction {
    if (self.editGoodsClassifyBlock) {
        self.editGoodsClassifyBlock(self.classifyItemModel, self);
    }
}

@end
