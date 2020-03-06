//
//  COrderGooditemCell.m
//  b2c
//
//  Created by 0 on 16/5/24.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "COrderGooditemCell.h"
#import "SpecSubItemsModel.h"
@interface COrderGooditemCell()
/**商品图片*/
@property (nonatomic, strong) UIImageView *goodsImage;
/**商品描述*/
@property (nonatomic, strong) UILabel *goodsdescribe;
/**商品规格*/
@property (nonatomic, strong) UILabel *goodsSpec;
/**商品数量*/
@property (nonatomic, strong) UILabel *numLabel;
/**商品价格*/
@property (nonatomic, strong) UILabel *goodsPrice;
@property (nonatomic, assign) BOOL isEnd;

@end
@implementation COrderGooditemCell
- (UIImageView *)goodsImage{
    if (_goodsImage == nil) {
        _goodsImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_goodsImage];
        _goodsImage.layer.borderColor = [[UIColor colorWithHexString:@"999999"] CGColor];
        _goodsImage.layer.borderWidth = 1;
    }
    return _goodsImage;
}
- (UILabel *)goodsdescribe{
    if (_goodsdescribe == nil) {
        _goodsdescribe = [[UILabel alloc] init];
        [self.contentView addSubview:_goodsdescribe];
        [_goodsdescribe configmentfont:[UIFont systemFontOfSize:15 *zkqScale] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@""];
        
        [_goodsdescribe setNumberOfLines:2];
        
    }
    return _goodsdescribe;
}
- (UILabel *)goodsSpec{
    if (_goodsSpec == nil) {
        _goodsSpec = [[UILabel alloc] init];
        [self.contentView addSubview:_goodsSpec];
        [_goodsSpec configmentfont:[UIFont systemFontOfSize:13 *zkqScale] textColor:[UIColor colorWithHexString:@"999999"] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@""];
        [_goodsSpec setNumberOfLines:2];
        
    }
    return _goodsSpec;
}
- (UILabel *)goodsPrice{
    if (_goodsPrice == nil) {
        _goodsPrice = [[UILabel alloc] init];
        [self.contentView addSubview:_goodsPrice];
        [_goodsPrice sizeToFit];
    }
    return _goodsPrice;
}
- (UILabel *)numLabel{
    if (_numLabel == nil) {
        _numLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_numLabel];
        [_numLabel configmentfont:[UIFont systemFontOfSize:13 *zkqScale] textColor:[UIColor colorWithHexString:@"999999"] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@""];
        [_numLabel sizeToFit];
    }
    return _numLabel;
}
- (UIView *)separator{
    if (_separator == nil) {
        _separator = [[UIView alloc] init];
        [self.contentView addSubview:_separator];
        _separator.backgroundColor = BackgroundGray;
    }
    return _separator;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        
    }
    return self;
}
- (void)setGoodsModel:(COrderGoodSubModel *)goodsModel{
    NSURL *imageUrl = ImageUrlWithString(goodsModel.img);
    [self.goodsImage sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"accountBiiMap"] options:SDWebImageCacheMemoryOnly];
    self.goodsdescribe.text = goodsModel.short_name;
    NSString *price = [NSString stringWithFormat:@"￥%@",dealPrice(goodsModel.price)];
    NSMutableAttributedString *attributePrice = [[NSMutableAttributedString alloc] initWithString:price];
    [attributePrice addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13 *zkqScale],NSFontAttributeName,THEMECOLOR,NSForegroundColorAttributeName, nil] range:NSMakeRange(0, 1)];
    [attributePrice addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16 *zkqScale],NSFontAttributeName,THEMECOLOR,NSForegroundColorAttributeName, nil] range:NSMakeRange(1, price.length - 1)];
    self.goodsPrice.attributedText = attributePrice;
    self.numLabel.text = [NSString stringWithFormat:@"X%@",goodsModel.num];
    
    [self.goodsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.width.equalTo(@(80));
        make.height.equalTo(@(80));
    }];
    
    [self.goodsdescribe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsImage.mas_right).offset(10);
        make.top.equalTo(self.goodsImage.mas_top).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    [self.goodsSpec mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsImage.mas_right).offset(10);
        make.top.equalTo(self.goodsdescribe.mas_bottom).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    /**拼接规格字符串*/
    NSString *spec = @"";
    if (goodsModel.sub_items && (goodsModel.sub_items.count > 0)) {
        
        for (SpecSubItemsModel *specModel in goodsModel.sub_items) {
            spec = [spec stringByAppendingFormat:@"%@:%@ ",specModel.spec_name,specModel.spec_val];
        }
    }else{
        spec = @"";
    }
    
    self.goodsSpec.text = spec;
    //计算高度判断是以哪一个为约束
    CGSize describeSize = [self.goodsdescribe.text sizeWithFont:self.goodsdescribe.font MaxSize:CGSizeMake(screenW - 110, MAXFLOAT)];
    CGSize specSize = [self.goodsSpec.text sizeWithFont:self.goodsSpec.font MaxSize:CGSizeMake(screenW - 110, MAXFLOAT)];
    CGSize priceSize = [self.goodsPrice.text sizeWithFont:self.goodsPrice.font MaxSize:CGSizeMake(screenW - 110, MAXFLOAT)];
     CGFloat textHeight = 10 + describeSize.height +3 + 10 + specSize.height + 10 + priceSize.height;
    if (textHeight < 100) {
        [self.goodsPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.goodsImage.mas_right).offset(10);
            make.bottom.equalTo(self.goodsImage.mas_bottom).offset(0);
        }];
        [self.separator mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.goodsImage.mas_bottom).offset(10);
            if (self.isEnd) {
                make.height.equalTo(@(10));
                make.left.equalTo(self.contentView.mas_left).offset(0);
                make.width.equalTo(@(screenW));
            }else{
                make.height.equalTo(@(1));
                make.left.equalTo(self.contentView.mas_left).offset(10);
                make.width.equalTo(@(screenW - 10));
            }
            make.right.equalTo(self.contentView.mas_right).offset(0);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
            
        }];
        
    }else{
        [self.goodsPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.goodsImage.mas_right).offset(10);
            make.top.equalTo(self.goodsSpec.mas_bottom).offset(10);
        }];
        
        [self.separator mas_updateConstraints:^(MASConstraintMaker *make) {
            if (self.isEnd) {
                make.height.equalTo(@(10));
                make.left.equalTo(self.contentView.mas_left).offset(0);
                make.width.equalTo(@(screenW));
                
            }else{
                make.height.equalTo(@(1));
                make.left.equalTo(self.contentView.mas_left).offset(10);
                make.width.equalTo(@(screenW - 10));
                
            }
            make.top.equalTo(self.goodsPrice.mas_bottom).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(0);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
            
        }];
    }
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.centerY.equalTo(self.goodsPrice);
    }];
    

    
}

- (void)layoutSubviews{
    
}
- (void)setIsEndCell:(BOOL)isEndCell{
    self.isEnd = isEndCell;
}



@end
