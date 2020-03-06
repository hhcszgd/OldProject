//
//  LaoStoryTabCell.m
//  b2c
//
//  Created by wangyuanfei on 16/4/22.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "LaoStoryTabCell.h"
#import "ActionBaseView.h"
#import "LaoStoryCellModel.h"

@interface LaoStoryTabCell ()
@property(nonatomic,weak)UIView * container ;
@property(nonatomic,weak)ActionBaseView * topContainer ;
@property(nonatomic,weak)ActionBaseView * bottomContainer ;
@property(nonatomic,weak)UIView * midLine ;
@property(nonatomic,weak)UIView * bottomLine ;
////////////////////////////////////////////
//@property(nonatomic,weak)UIImageView * shopIconImageView ;
@property(nonatomic,weak)UIButton * shopIconImageView ;

@property(nonatomic,weak)UILabel * shopNameLabel ;
@property(nonatomic,weak)UIImageView * bitImageView ;
@property(nonatomic,weak)UILabel * longTitleLabel ;
@property(nonatomic,weak)UILabel * more ;

@end

@implementation LaoStoryTabCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle=0;
        self.backgroundColor = BackgroundGray;
        UIView * container = [[UIView alloc]init];
        self.container = container;
        container.backgroundColor = [UIColor whiteColor];
        //        container.layer.shadowColor = [UIColor blackColor].CGColor;
        //        container.layer.shadowOffset = CGSizeMake(6, 6);
        //        container.layer.shadowOpacity=0.4;
        [self.contentView addSubview:container];
        
        
        ActionBaseView * topContainer = [[ActionBaseView alloc]init];
        //        [topContainer addTarget:self action:@selector(gotoShop:) forControlEvents:UIControlEventTouchUpInside];
        self.topContainer = topContainer;
        [self.container addSubview:self.topContainer];
        //        topContainer.backgroundColor = randomColor;
        
        UIView  * midLine = [[UIView alloc]init];
        self.midLine = midLine;
        midLine.backgroundColor = BackgroundGray;
        [self.topContainer addSubview:midLine];
        
        ActionBaseView * bottomContainer = [[ActionBaseView alloc]init];
        [bottomContainer addTarget:self action:@selector(gotoDetail:) forControlEvents:UIControlEventTouchUpInside];
        self.bottomContainer = bottomContainer;
        [self.container addSubview:bottomContainer];
        //        self.bottomContainer.backgroundColor=randomColor;
        
        UIView * bottomLine = [[UIView alloc]init];
        self.bottomLine = bottomLine;
        [self.contentView addSubview:bottomLine];
        bottomLine.backgroundColor = [UIColor clearColor];
        ///////////////////////////////////////////////////////////////////////////////////////////
        
        //         UIImageView * shopIconImageView =[[UIImageView alloc]init];
        //        shopIconImageView.backgroundColor= BackgroundGray;
        //        self.shopIconImageView = shopIconImageView;
        //        [self.topContainer addSubview:shopIconImageView];
        //        shopIconImageView.layer.cornerRadius = 5 ;
        //        shopIconImageView.layer.masksToBounds = YES;
        UIButton * shopIconImageView =[[UIButton alloc]init];
        shopIconImageView.backgroundColor= BackgroundGray;
        self.shopIconImageView = shopIconImageView;
        [self.topContainer addSubview:shopIconImageView];
        shopIconImageView.layer.cornerRadius = 5 ;
        shopIconImageView.layer.masksToBounds = YES;
        [shopIconImageView addTarget:self action:@selector(gotoShop:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UILabel * shopNameLabel =[[UILabel alloc]init];
        self.shopNameLabel = shopNameLabel;
        shopNameLabel.font = [UIFont systemFontOfSize:14*SCALE];
        [self.topContainer addSubview:shopNameLabel];
        
        UIImageView * bitImageView =[[UIImageView alloc]init];
        self.bitImageView = bitImageView;
        bitImageView.backgroundColor = BackgroundGray;
        [self.bottomContainer addSubview:bitImageView];
        
        UILabel * longTitleLabel =[[UILabel alloc]init];
        longTitleLabel.textColor = MainTextColor;
        longTitleLabel.font =[UIFont systemFontOfSize:12];
        self.longTitleLabel = longTitleLabel;
        longTitleLabel.numberOfLines = 10000 ;
//        longTitleLabel.textAlignment =  
//        longTitleLabel.backgroundColor = randomColor;
        [self.bottomContainer addSubview:longTitleLabel];
        
        UILabel * more  = [[UILabel alloc]init];
        self.more = more;
        more.text = @"查看详情";
        more.font = [UIFont systemFontOfSize:12];
        [self.bottomContainer addSubview:more];
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat margin = 20 ;
    
    CGFloat bottomLineW = self.bounds.size.width ;
    CGFloat bottomLineH = margin ;
    CGFloat bottomLineX = 0 ;
    CGFloat bottomLineY = self.bounds.size.height-bottomLineH;
    self.bottomLine.frame = CGRectMake(bottomLineX, bottomLineY, bottomLineW, bottomLineH);
    
    
    CGFloat containerX = margin ;
    CGFloat containerY = 0 ;
    CGFloat containerH = self.bounds.size.height - bottomLineH ;
    CGFloat containerW = (self.bounds.size.width - margin*2) ;
    self.container.frame = CGRectMake(containerX, containerY, containerW, containerH);
    
    CGFloat topContainerH = 66*SCALE ;
    CGFloat topContainerW = self.container.bounds.size.width ;
    CGFloat topContainerX = 0 ;
    CGFloat topContainerY = 0 ;
    self.topContainer.frame = CGRectMake(topContainerX, topContainerY, topContainerW, topContainerH);
    CGFloat bottomContainerW = self.container.bounds.size.width ;
    CGFloat bottomContainerH = self.container.bounds.size.height - topContainerH ;
    CGFloat bottomContainerX = 0 ;
    CGFloat bottomContainerY = self.topContainer.bounds.size.height ;
    self.bottomContainer.frame = CGRectMake(bottomContainerX, bottomContainerY, bottomContainerW, bottomContainerH);
//    self.bottomContainer.backgroundColor = randomColor;
    //////////////////////////////////////////////////////////////////////////////////////////
    
    CGFloat moreW = 66 ;
    CGFloat moreH = 22 ;
    CGFloat moreX = self.bottomContainer.bounds.size.width - moreW - margin ;
    CGFloat moreY = self.bottomContainer.bounds.size.height  -moreH - margin/3 ;
    self.more.frame = CGRectMake(moreX , moreY, moreW, moreH);
    
    
    CGFloat midLineW =  self.topContainer.bounds.size.width - margin;
    CGFloat midLineH = 1 ;
    CGFloat midLineX = margin ;
    CGFloat midLineY = self.topContainer.bounds.size.height - midLineH ;
    self.midLine.frame = CGRectMake(midLineX, midLineY, midLineW, midLineH);
    
    CGFloat shopIconW = 88 ;
    CGFloat shopIconH = shopIconW*0.5 ;
    CGFloat shopIconX = margin;
    CGFloat shopIconY = (self.topContainer.bounds.size.height - shopIconH)/2  ;
    self.shopIconImageView.frame = CGRectMake(shopIconX, shopIconY, shopIconW, shopIconH);
    
    CGFloat shopNameX = CGRectGetMaxX(self.shopIconImageView.frame) + margin/2 ;
    CGFloat shopNameY = 0 ;
    CGFloat shopNameW = self.topContainer.bounds.size.width  - shopIconW*2 ;
    CGFloat shopNameH = self.topContainer.bounds.size.height ;
    self.shopNameLabel.frame = CGRectMake(shopNameX, shopNameY, shopNameW, shopNameH);
    
//    CGFloat bitImageX = margin ;
    CGFloat bitImageY = 0 ;
    CGFloat bitImageW = (self.bottomContainer.bounds.size.width-margin*2) ;
//    CGFloat bitImageH = bitImageW/3; ;
//    self.bitImageView.frame = CGRectMake(bitImageX, bitImageY, bitImageW, bitImageH);
    
    CGFloat longTitleX =margin ;
    CGFloat longTitleY =  bitImageY ;
    CGFloat longTitleW = bitImageW ;
    
    CGFloat longTitleH = CGRectGetMinY(self.more.frame) -margin  ;
    if ([self.longTitleLabel.text sizeWithFont:self.longTitleLabel.font MaxSize:CGSizeMake(longTitleW, CGFLOAT_MAX)].height > longTitleH ) {
        longTitleH =CGRectGetMinY(self.more.frame) -margin  ;
    }else{
        longTitleH =[self.longTitleLabel.text sizeWithFont:self.longTitleLabel.font MaxSize:CGSizeMake(longTitleW, CGFLOAT_MAX)].height  ;
    }
    longTitleH = longTitleH  +3 ;
    self.longTitleLabel.frame = CGRectMake(longTitleX, longTitleY, longTitleW, longTitleH);
}

-(void)setLaoStoryCellModel:(LaoStoryCellModel *)laoStoryCellModel{
    _laoStoryCellModel = laoStoryCellModel;
    //    laoStoryCellModel.shopLogo = [NSString stringWithFormat:@"201602/duchutian/tb1lhqklpxxxxatxpxxxxxxxxxx_!!0-item_pic.jpg"];
    //    laoStoryCellModel.shopName = laoStoryCellModel.title;
    //    laoStoryCellModel.longTitle = @"无妄想时，一心是一佛国；有妄想时，一心是一地狱。众生造作妄想，以心生心，故常在地狱。菩萨观察妄想，不以心生心，故常在佛国。若不以心生心，则心心入空，念念归静，从一佛国至一佛国。若以心生心，则心心不静，念念归动，从一地狱历一地狱。若一念心起，则有善恶二业，有天堂地狱。";
    //    laoStoryCellModel.bigIcon = @"http://img.hb.aicdn.com/ffbc75cefb96a57beda2e0f01964725e2a82f44030088-L0VU4g_fw658";
    
    
    /**
     @property(nonatomic,weak)UIImageView * shopIconImageView ;
     @property(nonatomic,weak)UILabel * shopNameLabel ;
     @property(nonatomic,weak)UIImageView * bitImageView ;
     @property(nonatomic,weak)UILabel * longTitleLabel ;
     */
    [self.shopIconImageView sd_setImageWithURL:ImageUrlWithString(laoStoryCellModel.shopLogo) forState:UIControlStateNormal placeholderImage:nil  options:SDWebImageCacheMemoryOnly];
//    [self.shopIconImageView sd_setImageWithURL:ImageUrlWithString(laoStoryCellModel.shopLogo) forState:UIControlStateNormal];
    //    [self.shopIconImageView sd_setImageWithURL:ImageUrlWithString(laoStoryCellModel.shopLogo) placeholderImage:nil options: SDWebImageCacheMemoryOnly];
    //    [self.bitImageView sd_setImageWithURL:[NSURL URLWithString:laoStoryCellModel.bigIcon] placeholderImage:nil options:SDWebImageLowPriority | SDWebImageCacheMemoryOnly];
    [self.bitImageView sd_setImageWithURL:ImageUrlWithString(laoStoryCellModel.bigIcon) placeholderImage:nil options:SDWebImageLowPriority | SDWebImageCacheMemoryOnly];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,laoStoryCellModel.longTitle);
    self.shopNameLabel.text = laoStoryCellModel.shopName;
    self.longTitleLabel.text = [NSString stringWithFormat:@"        %@",laoStoryCellModel.longTitle];
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)gotoShop:(ActionBaseView*)sender
{
    if ([self.delegate respondsToSelector:@selector(skipInLaoStoryTabCell:WithComposeModel:)]) {
        /**
         #import "HShopVC.h"
         */
        self.laoStoryCellModel.actionKey = @"HShopVC";
        self.laoStoryCellModel.title = self.laoStoryCellModel.actionKey;
        //        self.laoStoryCellModel.keyParamete = @{@"paramete":self.laoStoryCellModel.shopID};
        LOG(@"_%@_%d_%@",[self class] , __LINE__,self.laoStoryCellModel.shopID);
        if (self.laoStoryCellModel.shopID.length>0) {
            self.laoStoryCellModel.keyParamete = @{@"paramete":self.laoStoryCellModel.shopID};
        }
        NSLog(@"%@, %d ,%@",[self class],__LINE__,self.laoStoryCellModel.shopID);

        [self.delegate skipInLaoStoryTabCell:self WithComposeModel:self.laoStoryCellModel];
    }
    LOG_METHOD
}
-(void)gotoDetail:(ActionBaseView*)sender
{
    if ([self.delegate respondsToSelector:@selector(skipInLaoStoryTabCell:WithComposeModel:)]) {
        
        self.laoStoryCellModel.actionKey = @"HStoryVC";
        self.laoStoryCellModel.title = self.laoStoryCellModel.actionKey;
        if (self.laoStoryCellModel.url.length>0) {
            
            self.laoStoryCellModel.keyParamete = @{@"paramete":self.laoStoryCellModel.url};
        }
        [self.delegate skipInLaoStoryTabCell:self WithComposeModel:self.laoStoryCellModel];
    }
    LOG_METHOD
}











































//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.selectionStyle=0;
//        self.backgroundColor = BackgroundGray;
//        UIView * container = [[UIView alloc]init];
//        self.container = container;
//        container.backgroundColor = [UIColor whiteColor];
//        //        container.layer.shadowColor = [UIColor blackColor].CGColor;
//        //        container.layer.shadowOffset = CGSizeMake(6, 6);
//        //        container.layer.shadowOpacity=0.4;
//        [self.contentView addSubview:container];
//        
//        
//        ActionBaseView * topContainer = [[ActionBaseView alloc]init];
//        //        [topContainer addTarget:self action:@selector(gotoShop:) forControlEvents:UIControlEventTouchUpInside];
//        self.topContainer = topContainer;
//        [self.container addSubview:self.topContainer];
//        //        topContainer.backgroundColor = randomColor;
//        
//        UIView  * midLine = [[UIView alloc]init];
//        self.midLine = midLine;
//        midLine.backgroundColor = BackgroundGray;
//        [self.topContainer addSubview:midLine];
//        
//        ActionBaseView * bottomContainer = [[ActionBaseView alloc]init];
//        [bottomContainer addTarget:self action:@selector(gotoDetail:) forControlEvents:UIControlEventTouchUpInside];
//        self.bottomContainer = bottomContainer;
//        [self.container addSubview:bottomContainer];
//        //        self.bottomContainer.backgroundColor=randomColor;
//        
//        UIView * bottomLine = [[UIView alloc]init];
//        self.bottomLine = bottomLine;
//        [self.contentView addSubview:bottomLine];
//        bottomLine.backgroundColor = [UIColor clearColor];
//        ///////////////////////////////////////////////////////////////////////////////////////////
//        
//        //         UIImageView * shopIconImageView =[[UIImageView alloc]init];
//        //        shopIconImageView.backgroundColor= BackgroundGray;
//        //        self.shopIconImageView = shopIconImageView;
//        //        [self.topContainer addSubview:shopIconImageView];
//        //        shopIconImageView.layer.cornerRadius = 5 ;
//        //        shopIconImageView.layer.masksToBounds = YES;
//        UIButton * shopIconImageView =[[UIButton alloc]init];
//        shopIconImageView.backgroundColor= BackgroundGray;
//        self.shopIconImageView = shopIconImageView;
//        [self.topContainer addSubview:shopIconImageView];
//        shopIconImageView.layer.cornerRadius = 5 ;
//        shopIconImageView.layer.masksToBounds = YES;
//        [shopIconImageView addTarget:self action:@selector(gotoShop:) forControlEvents:UIControlEventTouchUpInside];
//        
//        
//        UILabel * shopNameLabel =[[UILabel alloc]init];
//        self.shopNameLabel = shopNameLabel;
//        [self.topContainer addSubview:shopNameLabel];
//        
//        UIImageView * bitImageView =[[UIImageView alloc]init];
//        self.bitImageView = bitImageView;
//        bitImageView.backgroundColor = BackgroundGray;
//        [self.bottomContainer addSubview:bitImageView];
//        
//        UILabel * longTitleLabel =[[UILabel alloc]init];
//        longTitleLabel.textColor = MainTextColor;
//        longTitleLabel.font =[UIFont systemFontOfSize:12];
//        self.longTitleLabel = longTitleLabel;
//        longTitleLabel.numberOfLines = 13 ;
//        [self.bottomContainer addSubview:longTitleLabel];
//        
//        UILabel * more  = [[UILabel alloc]init];
//        self.more = more;
//        more.text = @"查看详情";
//        more.font = [UIFont systemFontOfSize:12];
//        [self.bottomContainer addSubview:more];
//        
//    }
//    return self;
//}
//
//-(void)layoutSubviews{
//    [super layoutSubviews];
//    CGFloat margin = 20 ;
//    
//    CGFloat bottomLineW = self.bounds.size.width ;
//    CGFloat bottomLineH = margin ;
//    CGFloat bottomLineX = 0 ;
//    CGFloat bottomLineY = self.bounds.size.height-bottomLineH;
//    self.bottomLine.frame = CGRectMake(bottomLineX, bottomLineY, bottomLineW, bottomLineH);
//    
//    
//    CGFloat containerX = margin ;
//    CGFloat containerY = 0 ;
//    CGFloat containerH = self.bounds.size.height - bottomLineH ;
//    CGFloat containerW = (self.bounds.size.width - margin*2) ;
//    self.container.frame = CGRectMake(containerX, containerY, containerW, containerH);
//    
//    CGFloat topContainerH = 66*SCALE ;
//    CGFloat topContainerW = self.container.bounds.size.width ;
//    CGFloat topContainerX = 0 ;
//    CGFloat topContainerY = 0 ;
//    self.topContainer.frame = CGRectMake(topContainerX, topContainerY, topContainerW, topContainerH);
//    CGFloat bottomContainerW = self.container.bounds.size.width ;
//    CGFloat bottomContainerH = self.container.bounds.size.height - topContainerH ;
//    CGFloat bottomContainerX = 0 ;
//    CGFloat bottomContainerY = self.topContainer.bounds.size.height ;
//    self.bottomContainer.frame = CGRectMake(bottomContainerX, bottomContainerY, bottomContainerW, bottomContainerH);
//    //////////////////////////////////////////////////////////////////////////////////////////
//    
//    CGFloat moreW = 66 ;
//    CGFloat moreH = 22 ;
//    CGFloat moreX = self.bottomContainer.bounds.size.width - moreW - margin ;
//    CGFloat moreY = self.bottomContainer.bounds.size.height  -moreH - margin/3 ;
//    self.more.frame = CGRectMake(moreX , moreY, moreW, moreH);
//    
//    
//    CGFloat midLineW =  self.topContainer.bounds.size.width - margin;
//    CGFloat midLineH = 1 ;
//    CGFloat midLineX = margin ;
//    CGFloat midLineY = self.topContainer.bounds.size.height - midLineH ;
//    self.midLine.frame = CGRectMake(midLineX, midLineY, midLineW, midLineH);
//    
//    CGFloat shopIconW = 44 ;
//    CGFloat shopIconH = shopIconW ;
//    CGFloat shopIconX = margin;
//    CGFloat shopIconY = (self.topContainer.bounds.size.height - shopIconH)/2  ;
//    self.shopIconImageView.frame = CGRectMake(shopIconX, shopIconY, shopIconW, shopIconH);
//    
//    CGFloat shopNameX = CGRectGetMaxX(self.shopIconImageView.frame) + margin ;
//    CGFloat shopNameY = 0 ;
//    CGFloat shopNameW = self.topContainer.bounds.size.width  - shopIconW*2 ;
//    CGFloat shopNameH = self.topContainer.bounds.size.height ;
//    self.shopNameLabel.frame = CGRectMake(shopNameX, shopNameY, shopNameW, shopNameH);
//    
//    CGFloat bitImageX = margin ;
//    CGFloat bitImageY = margin/2 ;
//    CGFloat bitImageW = (self.bottomContainer.bounds.size.width-margin*2) ;
//    CGFloat bitImageH = bitImageW/3; ;
//    self.bitImageView.frame = CGRectMake(bitImageX, bitImageY, bitImageW, bitImageH);
//    
//    CGFloat longTitleX =margin ;
//    CGFloat longTitleY =  CGRectGetMaxY(self.bitImageView.frame) +margin ;
//    CGFloat longTitleW = bitImageW ;
//    CGFloat longTitleH = CGRectGetMinY(self.more.frame) - CGRectGetMaxY(self.bitImageView.frame) -margin  ;
//    self.longTitleLabel.frame = CGRectMake(longTitleX, longTitleY, longTitleW, longTitleH);
//}
//
//-(void)setLaoStoryCellModel:(LaoStoryCellModel *)laoStoryCellModel{
//    _laoStoryCellModel = laoStoryCellModel;
//    //    laoStoryCellModel.shopLogo = [NSString stringWithFormat:@"201602/duchutian/tb1lhqklpxxxxatxpxxxxxxxxxx_!!0-item_pic.jpg"];
//    //    laoStoryCellModel.shopName = laoStoryCellModel.title;
//    //    laoStoryCellModel.longTitle = @"无妄想时，一心是一佛国；有妄想时，一心是一地狱。众生造作妄想，以心生心，故常在地狱。菩萨观察妄想，不以心生心，故常在佛国。若不以心生心，则心心入空，念念归静，从一佛国至一佛国。若以心生心，则心心不静，念念归动，从一地狱历一地狱。若一念心起，则有善恶二业，有天堂地狱。";
//    //    laoStoryCellModel.bigIcon = @"http://img.hb.aicdn.com/ffbc75cefb96a57beda2e0f01964725e2a82f44030088-L0VU4g_fw658";
//    
//    
//    /**
//     @property(nonatomic,weak)UIImageView * shopIconImageView ;
//     @property(nonatomic,weak)UILabel * shopNameLabel ;
//     @property(nonatomic,weak)UIImageView * bitImageView ;
//     @property(nonatomic,weak)UILabel * longTitleLabel ;
//     */
//    
//    [self.shopIconImageView sd_setImageWithURL:ImageUrlWithString(laoStoryCellModel.shopLogo) forState:UIControlStateNormal];
//    //    [self.shopIconImageView sd_setImageWithURL:ImageUrlWithString(laoStoryCellModel.shopLogo) placeholderImage:nil options: SDWebImageCacheMemoryOnly];
//    //    [self.bitImageView sd_setImageWithURL:[NSURL URLWithString:laoStoryCellModel.bigIcon] placeholderImage:nil options:SDWebImageLowPriority | SDWebImageCacheMemoryOnly];
//    [self.bitImageView sd_setImageWithURL:ImageUrlWithString(laoStoryCellModel.bigIcon) placeholderImage:nil options:SDWebImageLowPriority | SDWebImageCacheMemoryOnly];
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,laoStoryCellModel.longTitle);
//    self.shopNameLabel.text = laoStoryCellModel.shopName;
//    self.longTitleLabel.text = [NSString stringWithFormat:@"        %@",laoStoryCellModel.longTitle];
//    
//}
//
//
//
//- (void)awakeFromNib {
//    // Initialization code
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//    
//    // Configure the view for the selected state
//}
//-(void)gotoShop:(ActionBaseView*)sender
//{
//    if ([self.delegate respondsToSelector:@selector(skipInLaoStoryTabCell:WithComposeModel:)]) {
//        /**
//         #import "HShopVC.h"
//         */
//        self.laoStoryCellModel.actionKey = @"HShopVC";
//        self.laoStoryCellModel.title = self.laoStoryCellModel.actionKey;
//        //        self.laoStoryCellModel.keyParamete = @{@"paramete":self.laoStoryCellModel.shopID};
//        if (self.laoStoryCellModel.shopID.length>0) {
//            
//            self.laoStoryCellModel.keyParamete = @{@"paramete":self.laoStoryCellModel.shopID};
//        }
//        [self.delegate skipInLaoStoryTabCell:self WithComposeModel:self.laoStoryCellModel];
//    }
//    LOG_METHOD
//}
//-(void)gotoDetail:(ActionBaseView*)sender
//{
//    if ([self.delegate respondsToSelector:@selector(skipInLaoStoryTabCell:WithComposeModel:)]) {
//        
//        self.laoStoryCellModel.actionKey = @"HStoryVC";
//        self.laoStoryCellModel.title = self.laoStoryCellModel.actionKey;
//        if (self.laoStoryCellModel.url.length>0) {
//            
//            self.laoStoryCellModel.keyParamete = @{@"paramete":self.laoStoryCellModel.url};
//        }
//        [self.delegate skipInLaoStoryTabCell:self WithComposeModel:self.laoStoryCellModel];
//    }
//    LOG_METHOD
//}
@end
