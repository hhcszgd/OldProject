//
//  SCGoodsCell.m
//  b2c
//
//  Created by wangyuanfei on 16/4/19.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//
#import "GoodsCountContainer.h"

#import "SCGoodsCell.h"

#import "SVCGoods.h"

@interface SCGoodsCell ()
/** cell顶部分割线(要加长版的) */
@property(nonatomic,weak)UIView * topLine ;
/** 分割线以外的子空间的容器 */
@property(nonatomic,weak)UIView * container ;
/** 除选择按钮外的右侧的子空间的容器,可点击进入商品详情 */
@property(nonatomic,weak)UIView * rightContainer ;

/** 选择按钮 */
@property(nonatomic,weak)UIButton * chooseGoosButton ;
/** 选择按钮的放大点击按钮 */
@property(nonatomic,weak)UIButton * chooseGoosButtonPlus ;
/** 产品图片*/
@property(nonatomic,weak)UIImageView * goodsImageView ;
/** 产品标题 */
@property(nonatomic,weak)UILabel * titleLabel ;
/** 商品规格(颜色'尺寸) */
@property(nonatomic,weak)UILabel * specLabel ;
/** 价格 */
@property(nonatomic,weak)UILabel * priceLabel ;
/** 产品数量子控件容器*/

@property(nonatomic,weak)GoodsCountContainer * goodsCountContainer ;
/** 商品个数 */
@property(nonatomic,weak)UILabel   * numberLabel ;
/** 数量加号按钮 */
@property(nonatomic,weak)UIButton * addButton ;
/** 加号按钮的放大点击按钮 */
@property(nonatomic,weak)UIButton * addButtonPlus ;
/** 数量减号按钮 临时需求*/
@property(nonatomic,weak)UIButton * minusButton ;
/** 减号按钮的放大点击按钮 */
@property(nonatomic,weak)UIButton * minusButtonPlus ;
/** 赠品logo */
@property(nonatomic,weak)UILabel * giftLogo ;
/** 赠品标题 */
@property(nonatomic,weak)UILabel * giftTitleLabel ;

/** tempCorver */
@property(nonatomic,weak)ActionBaseView * tempCorver ;

@end

@implementation SCGoodsCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        /** cell顶部分割线(要加长版的) */
        UIView * topLine =[[UIView alloc]init];
        self.topLine = topLine;
        topLine.backgroundColor = BackgroundGray;
        [self.contentView addSubview:topLine];
        
        
        /** 分割线以外的子空间的容器 */
        UIView * container =[[UIView alloc]init];
        self.container = container;
//        container.backgroundColor = randomColor;
        [self.contentView addSubview:container];
        
        /** 不得已添加的吸收点击的遮盖 */
        ActionBaseView * tempCorver = [[ActionBaseView alloc]init];
        self.tempCorver = tempCorver;
        [self.container addSubview:tempCorver];
        
        /** 除选择按钮外的右侧的子空间的容器,可点击进入商品详情 */
       UIView * rightContainer =[[UIView alloc]init];
//        [rightContainer addTarget:self action:@selector(gotoGoodsDetail:) forControlEvents:UIControlEventTouchUpInside  ];
//        rightContainer.userInteractionEnabled=NO;
        self.rightContainer = rightContainer;
//        rightContainer.backgroundColor  = BackgroundGray;
        [self.container addSubview:rightContainer];
        
        /** 选择按钮 */
        UIButton * chooseGoosButton = [[UIButton alloc]init] ;
        self.chooseGoosButton = chooseGoosButton;
        [chooseGoosButton addTarget:self action:@selector(chooseGoosButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.container addSubview:chooseGoosButton];
        [chooseGoosButton setImage:[UIImage imageNamed:@"btn_round_nor"] forState:UIControlStateNormal];
        [chooseGoosButton setImage:[UIImage imageNamed:@"btn_round_sel"] forState:UIControlStateSelected];
        
        /** 选择按钮的放大点击按钮 */
        UIButton * chooseGoosButtonPlus  =[[UIButton alloc]init];
        self.chooseGoosButtonPlus = chooseGoosButtonPlus;
        [self.container addSubview:chooseGoosButtonPlus];
        [self.chooseGoosButtonPlus addTarget:self action:@selector(chooseGoosButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        /** 产品图片*/
        UIImageView * goodsImageView =[[UIImageView alloc]init] ;
        self.goodsImageView = goodsImageView;
        goodsImageView.backgroundColor = BackgroundGray;
        [self.rightContainer addSubview:goodsImageView];
        
        
        /** 产品标题 */
        UILabel * titleLabel =[[UILabel alloc]init];
        self.titleLabel = titleLabel;
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.textColor = MainTextColor;
        titleLabel.numberOfLines = 2 ;
        [self.rightContainer addSubview:titleLabel];
        
        
        /** 商品规格(颜色'尺寸) */
        UILabel * specLabel =[[UILabel alloc]init];;
        self.specLabel = specLabel;
        specLabel.textColor = SubTextColor;
        specLabel.font = [UIFont systemFontOfSize:11];
        [self.rightContainer addSubview:specLabel];
        
        
        /** 价格 */
        UILabel * priceLabel =[[UILabel alloc]init];
        self.priceLabel=priceLabel;
        self.priceLabel.textAlignment = NSTextAlignmentRight;
//        priceLabel.backgroundColor  = randomColor;
        priceLabel.textColor = THEMECOLOR;
        priceLabel.font = [UIFont systemFontOfSize:11];
        [self.rightContainer addSubview:priceLabel];
        
        /** 产品数量子控件容器*/
        
        GoodsCountContainer * goodsCountContainer =[[GoodsCountContainer alloc]init];
        self.goodsCountContainer = goodsCountContainer;
        [self.rightContainer addSubview:goodsCountContainer];
        goodsCountContainer.layer.borderWidth=1 ;
        goodsCountContainer.layer.borderColor = [UIColor lightGrayColor].CGColor;
        goodsCountContainer.layer.cornerRadius = 5 ;
        goodsCountContainer.layer.masksToBounds = YES;
        
        /** 商品个数 */
        UILabel   * numberLabel =[[UILabel alloc]init];
        self.numberLabel=numberLabel;
        numberLabel.font=[UIFont systemFontOfSize:12];
        numberLabel.textAlignment = NSTextAlignmentCenter;
//        numberLabel.backgroundColor = randomColor;
        numberLabel.layer.borderWidth=1 ;
        numberLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self.goodsCountContainer addSubview:numberLabel];
        
        /** 数量加号按钮 */
        UIButton * addButton= [[UIButton alloc]init]  ;
        [addButton setImage:[UIImage imageNamed:@"bg_add_normal"] forState:UIControlStateNormal];
        [addButton setImage:[UIImage imageNamed:@"bg_add_disable"] forState:UIControlStateDisabled];
        self.addButton = addButton;
        [addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.goodsCountContainer addSubview:self.addButton];
        
        /** 数量加号按钮的放大区域 */
        UIButton * addButtonPlus = [[UIButton alloc]init];
//        [addButtonPlus setTitle:@"测试" forState:UIWindowLevelNormal];
//        addButtonPlus.backgroundColor = randomColor;
        [self.rightContainer addSubview:addButtonPlus];
        self.addButtonPlus = addButtonPlus;
        [addButtonPlus addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        /** 数量减号按钮 */
        UIButton * minusButton = [[UIButton alloc]init] ;
        [minusButton setImage:[UIImage imageNamed:@"but_minus_normal"] forState:UIControlStateNormal];
        [minusButton setImage:[UIImage imageNamed:@"but_minus_disable"] forState:UIControlStateDisabled];
        self.minusButton = minusButton;
        [minusButton addTarget:self action:@selector(minusButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [minusButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.goodsCountContainer addSubview:minusButton];
        goodsCountContainer.userInteractionEnabled = YES;
        
        /** 数量减号按钮的放大区域 */
        UIButton * minusButtonPlus = [[UIButton alloc]init];
//        minusButtonPlus.backgroundColor = randomColor;
        [self.rightContainer addSubview:minusButtonPlus];
        self.minusButtonPlus = minusButtonPlus;
        [minusButtonPlus addTarget:self action:@selector(minusButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        /** 赠品logo */
        UILabel * giftLogo =[[UILabel alloc]init];;
        self.giftLogo = giftLogo;
        [self.rightContainer addSubview:giftLogo];
        
        giftLogo.layer.borderWidth=1 ;
        giftLogo.layer.borderColor = THEMECOLOR.CGColor;
        giftLogo.layer.cornerRadius = 5 ;
        giftLogo.layer.masksToBounds = YES;
        giftLogo.font = [UIFont systemFontOfSize: 9.5];
        giftLogo.text = @"赠品" ;
        giftLogo.textColor = THEMECOLOR;
        giftLogo.textAlignment = NSTextAlignmentCenter;
        
        
        /** 赠品标题 */
        UILabel * giftTitleLabel =[[UILabel alloc]init];;
        self.giftTitleLabel = giftTitleLabel;
        giftTitleLabel.font = [UIFont systemFontOfSize:10];
        giftTitleLabel.textColor = [UIColor colorWithHexString:@"333333"];
        [self.rightContainer addSubview:giftTitleLabel];
        
        
    }
    return self;
}



-(void)setGoodsModel:(SVCGoods *)goodsModel{
    _goodsModel = goodsModel;
    self.chooseGoosButton.selected=goodsModel.goodsSelect;
    [self.goodsImageView sd_setImageWithURL:ImageUrlWithString(goodsModel.img) placeholderImage:nil options:SDWebImageCacheMemoryOnly];
    self.titleLabel.text=goodsModel.title;
//    if (goodsModel.spec.length>0) {
//        self.specLabel.hidden=NO;
//        self.specLabel.text = goodsModel.spec;
//    }else{
//        self.specLabel.hidden=YES;
//    }
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,goodsModel.sub_items);
    if (goodsModel.sub_items.count>0) {
        self.specLabel.hidden = NO;
        
        NSMutableString * strM = [NSMutableString string];
        for (SpecModel*specModel in goodsModel.sub_items) {
//            if (specModel.spec_val.length>0) {
               strM= [strM stringByAppendingString:[NSString stringWithFormat:@"%@:%@ ",specModel.spec_name,specModel.spec_val]].mutableCopy;
//            }
        }
        self.specLabel.text = strM.copy;
    }else{
        self.specLabel.hidden = YES;
    }
    
    if (goodsModel.number<1 || goodsModel.number==1) {
        self.minusButton.enabled =NO;
    }else{
        self.minusButton.enabled = YES;
    }
    
    
    
    
    NSInteger maxCount = 0 ;
    if ([goodsModel.sub_id integerValue] ==0) {
        maxCount = [goodsModel.stock integerValue];
    }else{
        maxCount = [goodsModel.sub_stock integerValue];
    }
    
    if (_goodsModel.number>maxCount || _goodsModel.number==maxCount) {
        _goodsModel.number = maxCount;
        self.addButton.enabled = NO ;
    }else{
        self.addButton.enabled = YES;
    }
    
//    if (goodsModel.number>maxCount || goodsModel.number==maxCount) {
//        self.addButton.enabled = NO;
//    }else{
//        
//    }
    //把价格的单位从分转成元
//    LOG(@"_%@_%d_单位是分%lu",[self class] , __LINE__,(unsigned long)goodsModel.shop_price);
    
    self.priceLabel.text = [NSString stringWithFormat:@"%@",goodsModel.showPrice];
//    self.priceLabel.text = [NSString stringWithFormat:@"%.02lf",goodsModel.price];
//    NSUInteger pointNum = goodsModel.shop_price%10;
//    if (pointNum==0) {
//        
//        if (goodsModel.shop_price%100==0) {
//                self.priceLabel.text  =[NSString stringWithFormat:@"¥%d",goodsModel.shop_price/100];
//        }else{
//            self.priceLabel.text  =[NSString stringWithFormat:@"¥%.01lf",goodsModel.shop_price/100.0];
//        }
//    }else{
//        self.priceLabel.text  =[NSString stringWithFormat:@"¥%.02lf",goodsModel.shop_price/100.0];
//    }
//    LOG(@"_%@_%d_单位是元%@",[self class] , __LINE__,self.priceLabel.text);

#pragma mark 临时本地调节价格 ,测试显示效果
//    self.priceLabel.text = @"¥123478.99";
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)goodsModel.number];

    goodsModel.giftGoodsID = 10 ;
    if (goodsModel.giftGoodsID>0) {
#pragma mark 赠品接口 , 说二期要改
        self.giftTitleLabel.hidden = YES;//隐藏掉
        self.giftLogo.hidden = YES;
        self.giftTitleLabel.text = @"这是赠品接口";
    }else{
        self.giftTitleLabel.hidden = YES;
        self.giftLogo.hidden = YES;
    }
    
}
/**
 代理方法
 */
-(void)chooseGoosButtonClick:(UIButton*)sender
{
    if ([self.SCGoodsCellDelegate respondsToSelector:@selector(chooseGoodsButtonClickInGoodsCell:)]) {
        [self.SCGoodsCellDelegate chooseGoodsButtonClickInGoodsCell:self ];
    }
}
//-(void)gotoGoodsDetail:(ShopCarBaseComposeView*)sender
//{
//    if ([self.SCGoodsCellDelegate respondsToSelector:@selector(gotoGoodsDetailInGoodsCell:)]) {
//        [self.SCGoodsCellDelegate gotoGoodsDetailInGoodsCell:self];
//    }
//}
-(void)minusButtonClick:(UIButton*)sender
{
    if ([self.SCGoodsCellDelegate respondsToSelector:@selector(minusButtonClickInGoodsCell:)]) {
        [self.SCGoodsCellDelegate minusButtonClickInGoodsCell:self];
    }
    

}
-(void)addButtonClick:(UIButton*)sender
{
    
    if ([self.SCGoodsCellDelegate respondsToSelector:@selector(addButtonClickInGoodsCell:)]) {
        [self.SCGoodsCellDelegate addButtonClickInGoodsCell:self];
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];

   
    self.topLine.frame = CGRectMake(0, 0, self.bounds.size.width*3, 2) ;
    
    self.container.frame = CGRectMake(0, CGRectGetMaxY(self.topLine.frame), self.bounds.size.width, self.bounds.size.height-self.topLine.bounds.size.height) ;
    
    self.tempCorver.frame = CGRectMake(0, 0, 30, self.container.bounds.size.height);
    CGFloat normalMargin = 10 ;
    CGFloat chooseGoodsButtonW = 16 ;
    CGFloat chooseGoodsButtonH =chooseGoodsButtonW;
    CGFloat chooseGoodsButtonX = 10;
    CGFloat chooseGoodsButtonY = (self.bounds.size.height - chooseGoodsButtonH)/2;
    self.chooseGoosButton.frame = CGRectMake(chooseGoodsButtonX, chooseGoodsButtonY, chooseGoodsButtonW,chooseGoodsButtonH);

    CGPoint chooseButtonPlusTargetCenter = [self.chooseGoosButton convertPoint:CGPointMake(self.chooseGoosButton.bounds.size.width/2, self.chooseGoosButton.bounds.size.height/2) toView:self.container];
    self.chooseGoosButtonPlus.bounds = CGRectMake(0, 0, chooseGoodsButtonW*2, chooseGoodsButtonH*2);
    self.chooseGoosButtonPlus.center = chooseButtonPlusTargetCenter;
    
    
    
    
    self.rightContainer.frame = CGRectMake(CGRectGetMaxX(self.chooseGoosButton.frame)+10, 0, self.bounds.size.width-CGRectGetMaxX(self.chooseGoosButton.frame)-10, self.container.bounds.size.height) ;
    
    CGFloat topMargin = 8 ;
    CGFloat goodsImageViewH = self.bounds.size.height - topMargin*2 ;
    CGFloat goodsImageViewW = goodsImageViewH;
    CGFloat goodsImageViewX = 0;//CGRectGetMaxX(self.chooseGoosButton.frame)+ normalMargin;
    CGFloat goodsImageViewY = topMargin;
    self.goodsImageView.frame = CGRectMake(goodsImageViewX, goodsImageViewY, goodsImageViewW, goodsImageViewH) ;

    CGFloat priceLabelW = 70*SCALE ;//待定
    CGSize  priceLabelSize = [self.priceLabel.text sizeWithFont:self.priceLabel.font MaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat priceLabelH = priceLabelSize.height ;
    CGFloat priceLabelX = self.rightContainer.bounds.size.width - priceLabelW- normalMargin ;
    CGFloat priceLabelY = CGRectGetMinY(self.goodsImageView.frame) ;
    
    self.priceLabel.frame = CGRectMake(priceLabelX, priceLabelY, priceLabelW, priceLabelH);
    CGFloat titleLabelX = CGRectGetMaxX(self.goodsImageView.frame)+normalMargin ;
    CGFloat titleLabelY = CGRectGetMinY(self.goodsImageView.frame) ;
    CGFloat titleLabelW = CGRectGetMinX(self.priceLabel.frame)-normalMargin-self.goodsImageView.bounds.size.width ;
    CGSize titSize = [self.titleLabel.text stringSizeWithFont:13];
    CGFloat titleLabelH = titSize.height*2+1 ;
    self.titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH) ;
    CGFloat specLabelX = CGRectGetMinX(self.titleLabel.frame) ;
    CGFloat specLabelY = CGRectGetMaxY(self.titleLabel.frame) ;
    CGFloat specLabelW = self.titleLabel.bounds.size.width ;
    CGFloat specLabelH = titSize.height ;
    self.specLabel.frame = CGRectMake(specLabelX, specLabelY, specLabelW, specLabelH) ;


    CGFloat goodsCountContainerW = 84*SCALE ;//待定
    CGFloat goodsCountContainerH =  24*SCALE;
    CGFloat goodsCountContainerX = self.rightContainer.bounds.size.width - goodsCountContainerW- normalMargin ;
    CGFloat goodsCountContainerY = CGRectGetMaxY(self.goodsImageView.frame) - goodsCountContainerH ;
    self.goodsCountContainer.frame = CGRectMake(goodsCountContainerX, goodsCountContainerY, goodsCountContainerW, goodsCountContainerH);

    CGFloat addH = self.goodsCountContainer.bounds.size.height;
    CGFloat addW = addH;
    
    self.numberLabel.frame = CGRectMake(addW, 0, self.goodsCountContainer.bounds.size.width-2*addW, addH);
//
    self.addButton.frame = CGRectMake(self.goodsCountContainer.bounds.size.width-addW, 0, addW, addH) ;
   
//
//    
    self.minusButton.frame =  CGRectMake(0, 0, addW, addH) ;;
//
    
    CGPoint addButtonPlusTargetCenter = [self.goodsCountContainer convertPoint:self.addButton.center toView:self.rightContainer];
    self.addButtonPlus.bounds = CGRectMake(0, 0, addW*1.7, addH*1.7);
    self.addButtonPlus.center = addButtonPlusTargetCenter;
    LOG(@"_%@_%d_%@",[self class] , __LINE__,NSStringFromCGPoint(self.addButton.center));
    LOG(@"_%@_%d_%@",[self class] , __LINE__,NSStringFromCGPoint(addButtonPlusTargetCenter));
    
    CGPoint minusButtonPlusTargetCenter = [self.goodsCountContainer convertPoint:self.minusButton.center toView:self.rightContainer];
    self.minusButtonPlus.bounds = CGRectMake(0, 0, addW*1.7, addH*1.7);
    self.minusButtonPlus.center = minusButtonPlusTargetCenter;
    
    
    CGSize giftLogoSize = [self.giftLogo.text sizeWithFont:self.giftLogo.font MaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat giftLogoW = giftLogoSize.width + 6;
    CGFloat giftLogoH = giftLogoSize.height ;
    CGFloat giftLogoX = CGRectGetMinX(self.titleLabel.frame) ;
    CGFloat giftLogoY = CGRectGetMaxY(self.goodsImageView.frame) - giftLogoH ;
    self.giftLogo.frame = CGRectMake(giftLogoX, giftLogoY, giftLogoW, giftLogoH) ;

    CGSize giftTitleSize = [self.giftTitleLabel.text sizeWithFont:self.giftTitleLabel.font MaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat giftTitleW =     CGRectGetMinX(self.goodsCountContainer.frame)-CGRectGetMaxX(self.giftLogo.frame) - 5 - 10 ;
    CGFloat giftTitleH = giftTitleSize.height;
    self.giftTitleLabel.bounds = CGRectMake(0, 0,giftTitleW ,giftTitleH ) ;
    self.giftTitleLabel.center = CGPointMake(CGRectGetMaxX(self.giftLogo.frame) + giftTitleW/2 + normalMargin, CGRectGetMidY(self.giftLogo.frame));
}


@end
