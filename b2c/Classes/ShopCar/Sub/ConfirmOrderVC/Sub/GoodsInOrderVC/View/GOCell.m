//
//  GOCell.m
//  b2c
//
//  Created by wangyuanfei on 16/5/17.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "GOCell.h"
#import "GOCellModel.h"
@interface GOCell ()
//@property(nonatomic,weak)UIView * container ;
@property(nonatomic,weak)UIView * bottomLine ;
@property(nonatomic,weak)UIImageView * imgView ;
@property(nonatomic,weak)UILabel * descripLabel ;
@property(nonatomic,weak)UILabel * attributeLabel ;
@property(nonatomic,weak)UILabel * priceLabel ;
@property(nonatomic,weak)UILabel * countLabel ;

@end

@implementation GOCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.userInteractionEnabled = NO ;
        UIView * bottomLine =[[UIView alloc]init];
        self.bottomLine = bottomLine;
        [self.contentView addSubview:bottomLine];
        bottomLine.backgroundColor = BackgroundGray;
        
//        UIView * container = [[UIView alloc]init];
//        self.container = container;
//        [self.contentView addSubview:container];
//        []
        
        UIImageView * imgView= [[UIImageView alloc]init] ;
        self.imgView  = imgView ;
        [self.contentView addSubview:imgView];
        
        
        UILabel * descripLabel  = [[UILabel alloc]init] ;
        self.descripLabel = descripLabel;
        descripLabel.textColor = MainTextColor;
        descripLabel.font  =  [UIFont systemFontOfSize:14];
        descripLabel.numberOfLines = 2 ;
        [self.contentView addSubview:descripLabel];
        
        
        UILabel * attributeLabel = [[UILabel alloc]init]  ;
        self.attributeLabel = attributeLabel;
//        attributeLabel.backgroundColor  = randomColor;
        attributeLabel.textColor = SubTextColor;
        attributeLabel.font  =  [UIFont systemFontOfSize:11];
       [self.contentView addSubview:attributeLabel];
        
        
        UILabel * priceLabel = [[UILabel alloc]init]  ;
        self.priceLabel = priceLabel ;
        priceLabel.textColor = SubTextColor;
        priceLabel.font  =  [UIFont systemFontOfSize:11];
        priceLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:priceLabel];
        priceLabel.textAlignment = NSTextAlignmentLeft;
        
        
        UILabel * countLabel = [[UILabel alloc]init] ;
        self.countLabel = countLabel;
        countLabel.font = [UIFont systemFontOfSize:11];
        countLabel.textColor = MainTextColor;
        countLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:countLabel];
        
        
        
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat margin = 10 ;
    
    CGFloat imgViewW = 79 ;
    CGFloat imgViewH = imgViewW ;
    CGFloat imgViewX = margin ;
    CGFloat imgViewY = (self.bounds.size.height-imgViewH)/2 ;
    self.imgView.frame = CGRectMake(imgViewX, imgViewY, imgViewW, imgViewH);
    
    
    
    CGFloat descripX = CGRectGetMaxX(self.imgView.frame) + margin ;
    CGFloat descripY = CGRectGetMinY(self.imgView.frame) ;
    CGFloat descripW = self.bounds.size.width - margin*2 - descripX ;
    CGSize descripSize = [self.descripLabel.text sizeWithFont:self.descripLabel.font MaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat descripH = self.descripLabel.font.lineHeight *2 ;
    if (descripSize.width >descripW) {
        descripH = self.descripLabel.font.lineHeight *2 ;
    }else{
        descripH = self.descripLabel.font.lineHeight ;
    }
    self.descripLabel.frame = CGRectMake(descripX, descripY, descripW, descripH);
    
    CGFloat priceW = descripW ;
    CGFloat priceH = self.priceLabel.font.lineHeight ;
    CGFloat priceX = descripX ;
    CGFloat priceY = CGRectGetMaxY(self.imgView.frame) - priceH ;
    self.priceLabel.frame = CGRectMake(priceX, priceY, priceW, priceH);
    
    
    
    CGFloat attributeW = descripW ;
    CGFloat attributeH = self.attributeLabel.font.lineHeight + 3*SCALE ;
    CGFloat attributeX = descripX ;
    CGFloat attributeY = CGRectGetMaxY(self.descripLabel.frame); ;
    self.attributeLabel.frame = CGRectMake(attributeX, attributeY, attributeW, attributeH);
    

    
    CGFloat countW = descripW ;
    CGFloat countH = self.countLabel.font.lineHeight ;
    CGFloat countX = priceX ;
    CGFloat countY = priceY ;
    self.countLabel.frame = CGRectMake(countX,countY, countW, countH);
    
    CGFloat bottomW = self.bounds.size.width  - descripX ;
    CGFloat bottomH = 2 ;
    CGFloat bottomX = descripX ;
    CGFloat bottomY = self.bounds.size.height - bottomH ;
    self.bottomLine.frame = CGRectMake(bottomX, bottomY, bottomW, bottomH);

}

-(void)setCellModel:(GOCellModel *)cellModel{
    _cellModel = cellModel;
    self.bottomLine.hidden = cellModel.hiddenBottomLine;
//    [self.imgView sd_setImageWithURL:[NSURL URLWithString:cellModel.img] placeholderImage:nil options:SDWebImageCacheMemoryOnly];
    [self.imgView sd_setImageWithURL: ImageUrlWithString(cellModel.img) placeholderImage:nil options:SDWebImageCacheMemoryOnly];
    
    self.countLabel.text = [NSString stringWithFormat:@"x%@",cellModel.number];
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",cellModel.shop_price];

    self.descripLabel.text = cellModel.title;
//    self.attributeLabel.text = cellModel.attribute;
#pragma mark 给属性规格赋死值
//    self.attributeLabel.text = @"商品规格显示处 , 下一版实现";
    NSString * specStr = [[NSMutableString alloc]init];
    
    for (SpecModel * spec in cellModel.sub_items) {
        if (spec.spec_val.length>0) {
            specStr = [specStr stringByAppendingString:[NSString stringWithFormat:@"%@:%@ ",spec.spec_name,spec.spec_val]];
        }
    }if (specStr.length>0) {
        self.attributeLabel.text = specStr.copy;
    }

    
}
@end
