//
//  ZLGoodsListCell.m
//  ZLead
//
//  Created by qzwh on 2019/5/30.
//  Copyright © 2019年 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLGoodsListCell.h"
#import "ZLGoodsModel.h"

@interface ZLGoodsListCell ()

@property (nonatomic, strong)UIButton *selectBtn;

@property (nonatomic, strong)UIImageView *topicImgView;
@property (nonatomic, strong)UILabel *topicLbl;
/** 价格 */
@property (nonatomic, strong)UILabel *priceLbl;
/** 成本 */
@property (nonatomic, strong)UILabel *costLbl;
/** 库存 */
@property (nonatomic, strong)UILabel *stockLbl;
/** 销量 */
@property (nonatomic, strong)UILabel *salesLbl;
/** 编辑按钮 */
@property (nonatomic, strong)UIButton *editBtn;

@property (nonatomic, strong)ZLGoodsModel *goodsModel;
@end

@implementation ZLGoodsListCell

+ (ZLGoodsListCell *)listCellWithTableView:(UITableView *)tableView {
    static NSString *cellId = @"goodsListCellId";
    ZLGoodsListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[ZLGoodsListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_equalTo(19);
    }];
    self.selectBtn.hidden = YES;
    [self.topicImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(dis(15));
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_equalTo(dis(120));
    }];
    self.topicLbl.text = @"绿林钢卷尺 3米5米7.5米10米加厚盒尺木工高精度测量工具米…";
    [self.topicLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topicImgView.mas_right).offset(dis(10));
        make.right.equalTo(self.contentView).offset(-dis(15));
        make.top.equalTo(self.topicImgView).offset(dis(10));
    }];
    
    [self.stockLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topicLbl);
        make.bottom.equalTo(self.topicImgView).offset(-dis(16));
    }];
    
    [self.salesLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.stockLbl);
        make.left.equalTo(self.stockLbl.mas_right).offset(dis(10));
    }];
    
    [self.priceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topicLbl);
        make.bottom.equalTo(self.stockLbl.mas_top).offset(-dis(10));
    }];
    
    [self.costLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLbl.mas_right).offset(dis(10));
        make.centerY.equalTo(self.priceLbl);
    }];
    
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-dis(15));
        make.bottom.equalTo(self.stockLbl);
        make.width.height.mas_equalTo(14);
    }];
    
    [self layoutIfNeeded];
}

- (void)setAllowEdit:(BOOL)allowEdit {
    if (_allowEdit != allowEdit) {
        _allowEdit = allowEdit;
    }
    self.selectBtn.hidden = !allowEdit;
    
    [self.topicImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (allowEdit) {
            make.left.equalTo(self.selectBtn.mas_right).offset(10);
        }else {
            make.left.equalTo(self.contentView).offset(15);
        }
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_equalTo(dis(120));
    }];
    
    [self layoutIfNeeded];
}

- (void)setupData:(ZLGoodsModel *)goodsModel {
    _goodsModel = goodsModel;
}

#pragma mark - lazy load
- (UIButton *)selectBtn {
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setImage:[UIImage imageNamed:@"goods-selected-normal"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"goods-selected-highlight"] forState:UIControlStateSelected];
        [_selectBtn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_selectBtn];
    }
    return _selectBtn;
}

- (UIImageView *)topicImgView {
    if (!_topicImgView) {
        _topicImgView = [[UIImageView alloc] init];
        _topicImgView.backgroundColor = [UIColor zl_bgColor];
        [self.contentView addSubview:_topicImgView];
    }
    return _topicImgView;
}

- (UILabel *)topicLbl {
    if (!_topicLbl) {
        _topicLbl = [[UILabel alloc] init];
        _topicLbl.numberOfLines = 2;
        _topicLbl.textColor = [UIColor zl_textColor];
        _topicLbl.font = kFont14;
        [self.contentView addSubview:_topicLbl];
    }
    return _topicLbl;
}

- (UILabel *)priceLbl {
    if (!_priceLbl) {
        _priceLbl = [[UILabel alloc] init];
        _priceLbl.textColor = [UIColor zl_mainColor];
        _priceLbl.font = [UIFont boldSystemFontOfSize:18];
        [self.contentView addSubview:_priceLbl];
        [_priceLbl setAttributedText:[self attributedStringWithStr:@"￥28.6"]];
    }
    return _priceLbl;
}

- (UILabel *)costLbl {
    if (!_costLbl) {
        _costLbl = [[UILabel alloc] init];
        _costLbl.text = @"成本：20.5起";
        _costLbl.textColor = [UIColor colorWithHexString:@"#999999"];
        _costLbl.font = kFont12;
        [self.contentView addSubview:_costLbl];
    }
    return _costLbl;
}

- (UILabel *)stockLbl {
    if (!_stockLbl) {
        _stockLbl = [[UILabel alloc] init];
        _stockLbl.text = @"库存：999+";
        _stockLbl.textColor = [UIColor colorWithHexString:@"#999999"];
        _stockLbl.font = kFont12;
        [self.contentView addSubview:_stockLbl];
    }
    return _stockLbl;
}

- (UILabel *)salesLbl {
    if (!_salesLbl) {
        _salesLbl = [[UILabel alloc] init];
        _salesLbl.text = @"月销：999+";
        _salesLbl.textColor = [UIColor colorWithHexString:@"#999999"];
        _salesLbl.font = kFont12;
        [self.contentView addSubview:_salesLbl];
    }
    return _salesLbl;
}

- (UIButton *)editBtn {
    if (!_editBtn) {
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editBtn setImage:[UIImage imageNamed:@"goods-edit"] forState:UIControlStateNormal];
        [self.contentView addSubview:_editBtn];
    }
    return _editBtn;
}

#pragma mark - private
- (NSAttributedString *)attributedStringWithStr:(NSString *)str {
    NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithString:str];
    [mStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(0, 1)];
    
    return mStr;
}

#pragma mark - UIButton Actions

- (void)selectBtnAction:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (self.selectedButtonBlock) {
        self.selectedButtonBlock(self.goodsModel.isSelected);
    }
}

@end
