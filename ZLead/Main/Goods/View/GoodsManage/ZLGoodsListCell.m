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
@property (nonatomic, strong)UIImageView *topImageView;
@property (nonatomic, strong)UIImageView *topicImgView;
@property (nonatomic, strong)UILabel *topicLbl;
/** 门店价格 */
@property (nonatomic, strong)UILabel *offlinePriceLbl;
/** 网店价格 */
@property (nonatomic, strong)UILabel *onlinePriceLbl;
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
    
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topicImgView.mas_left);
        make.top.equalTo(self.topicImgView.mas_top);
        make.width.height.mas_equalTo(dis(20));
    }];
    self.topicLbl.text = @"绿林钢卷尺 3米5米7.5米10米加厚盒尺木工高精度测量工具米…";
    [self.topicLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topicImgView.mas_right).offset(dis(10));
        make.right.equalTo(self.contentView).offset(-dis(15));
        make.top.equalTo(self.topicImgView).offset(dis(8));
    }];
    
    [self.stockLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topicLbl);
        make.bottom.equalTo(self.topicImgView).offset(-dis(6));
    }];
    
    [self.salesLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.stockLbl);
        make.left.equalTo(self.stockLbl.mas_right).offset(dis(10));
        make.width.lessThanOrEqualTo(@(dis(100)));
    }];
    
    [self.offlinePriceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topicLbl);
        make.bottom.equalTo(self.stockLbl.mas_top).offset(-dis(10));
        make.width.lessThanOrEqualTo(@(dis(100)));
    }];
    
    [self.onlinePriceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topicLbl);
        make.bottom.equalTo(self.offlinePriceLbl.mas_top).offset(-dis(10));
        make.width.lessThanOrEqualTo(@(dis(200)));
    }];
    
    [self.costLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.offlinePriceLbl.mas_right).offset(dis(10));
        make.centerY.equalTo(self.offlinePriceLbl);
        make.width.lessThanOrEqualTo(@(dis(100)));
    }];
    
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-dis(15));
        make.bottom.equalTo(self.stockLbl.mas_top);
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
//    self.topicLbl.text =
    self.stockLbl.text = [NSString stringWithFormat:@"库存：%@", @(goodsModel.goodsNum)];
    self.selectBtn.selected = _goodsModel.isSelected;
    self.topImageView.hidden = !_goodsModel.top;
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

- (UIImageView *)topImageView {
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc] init];
        _topImageView.backgroundColor = [UIColor zl_mainColor];
        _topImageView.hidden = YES;
        [self.contentView addSubview:_topImageView];
    }
    return _topImageView;
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

- (UILabel *)onlinePriceLbl {
    if (!_onlinePriceLbl) {
        _onlinePriceLbl = [[UILabel alloc] init];
        _onlinePriceLbl.textColor = [UIColor zl_mainColor];
        _onlinePriceLbl.font = [UIFont boldSystemFontOfSize:18];
        [self.contentView addSubview:_onlinePriceLbl];
        [_onlinePriceLbl setAttributedText:[self attributedStringWithStr:@"网店价 ¥28.6"]];
    }
    return _onlinePriceLbl;
}

- (UILabel *)offlinePriceLbl {
    if (!_offlinePriceLbl) {
        _offlinePriceLbl = [[UILabel alloc] init];
        _offlinePriceLbl.textColor = [UIColor colorWithHexString:@"#999999"];
        _offlinePriceLbl.font = kFont12;
        _offlinePriceLbl.text = @"门店价: ¥27.10";
        [self.contentView addSubview:_offlinePriceLbl];
    }
    return _offlinePriceLbl;
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
    [mStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:NSMakeRange(0, 5)];
    
    return mStr;
}

#pragma mark - UIButton Actions

- (void)selectBtnAction:(UIButton *)btn {
    btn.selected = !btn.selected;
    self.goodsModel.isSelected = btn.selected; 
    if (self.selectedButtonBlock) {
        self.selectedButtonBlock(self.goodsModel.isSelected);
    }
}

@end
