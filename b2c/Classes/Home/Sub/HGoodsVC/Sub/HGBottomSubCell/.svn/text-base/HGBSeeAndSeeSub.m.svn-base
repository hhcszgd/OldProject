//
//  HGBSeeAndSeeSub.m
//  b2c
//
//  Created by 0 on 16/5/14.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HGBSeeAndSeeSub.h"
@interface HGBSeeAndSeeSub()
@property(nonatomic,weak)UILabel * descrip ;
@property(nonatomic,weak)UILabel * price ;
@property(nonatomic,weak)UIImageView * productImage ;
@property(nonatomic,weak)UILabel * saldCount ;

@property (nonatomic, strong) HGoodsBottomSubModel *seeModel;
@end
@implementation HGBSeeAndSeeSub

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        
        UILabel * descrip = [[UILabel alloc]init];
        descrip.textColor = [UIColor colorWithRed:51/256.0 green:51/256.0 blue:51/256.5 alpha:1];
        descrip.font = [UIFont systemFontOfSize:12*SCALE];
        [self addSubview:descrip];
        self.descrip=descrip;
        descrip.numberOfLines=2 ;
        //                descrip.backgroundColor=randomColor;
        
        UILabel * price = [[UILabel alloc]init];
        price.font = [UIFont systemFontOfSize:12*SCALE];
        
        [self addSubview:price];
        self.price=price;
        price.textColor=[UIColor colorWithRed:233/256.0 green:85/256.0 blue:19/256.5 alpha:1];
        
        
        UIImageView * productImage = [[UIImageView alloc]init];
        [self addSubview:productImage];
        self.productImage=productImage;
        //        productImage.backgroundColor=randomColor;
        
        //        UIView *whiteLine  = [[UIView alloc]init];
        //        [self addSubview:whiteLine ];
        //        self.whiteLine =whiteLine ;
        //        whiteLine.backgroundColor=[UIColor clearColor];
        
        
        //        seldCount.backgroundColor=[UIColor colorWithRed:250/255.0 green:40/255.0 blue:40/255.0 alpha:0.7];
#pragma layout
        
        //        CGFloat lineH = 3 ;
        //        CGFloat composeW = (screenW - 3 )/2 ;
        //        CGFloat imageH = composeW;
        
        /*
         [productImage mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.left.right.equalTo(self);
         make.height.equalTo(@(imageH));
         }];
         
         
         [descrip mas_makeConstraints:^(MASConstraintMaker *make) {
         make.right.equalTo(self);
         make.left.equalTo(productImage).offset(10);
         make.top.equalTo(productImage.mas_bottom);
         }];
         descrip.text = @"dja;lskdhfolkajsdlhj[oaisdlkfjasdfaso;diyfpoaskjdf;lasjdkf";
         
         
         
         
         //        [whiteLine mas_makeConstraints:^(MASConstraintMaker *make) {
         //            make.bottom.left.right.equalTo(self);
         //            make.height.equalTo(@(lineH));
         //        }];
         
         [price mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(descrip);
         make.top.equalTo(descrip.mas_bottom);
         make.right.equalTo(self);
         make.bottom.equalTo(self);
         }];
         price.text = @"¥1211";
         
         //        [action mas_makeConstraints:^(MASConstraintMaker *make) {
         //            make.top.left.bottom.right.equalTo(self);
         //        }];
         
         
         [ticket mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.bottom.right.equalTo(productImage);
         make.height.equalTo(@(30));
         }];
         ticket.text = @"  买一送一啊";
         */
    }
    return self;
}


-(UILabel * )saldCount{
    if(_saldCount==nil){
        
        UILabel * saldCount = [[UILabel alloc]init];
        saldCount.textAlignment=NSTextAlignmentRight;
        saldCount.font = [UIFont systemFontOfSize:11*SCALE];
        [self addSubview:saldCount];
        _saldCount=saldCount;
        
        _saldCount.textColor = SubTextColor;
        _saldCount.hidden=YES;
    }
    return _saldCount;
}
//TODO
-(void)layoutSubviews{
    [super layoutSubviews];
    
    /**
     @property(nonatomic,weak)UIImageView * productImage ;
     @property(nonatomic,weak)UILabel * descrip ;
     @property(nonatomic,weak)UILabel * price ;
     */
    CGSize txtSize = [self.seeModel.full_name stringSizeWithFont:12*SCALE];
    CGFloat productImageX = 0 ;
    CGFloat productImageY = 0 ;
    CGFloat productImageW = self.bounds.size.width ;
    CGFloat productImageH = self.bounds.size.width ;
    self.productImage.frame = CGRectMake(productImageX, productImageY, productImageW, productImageH);
    
    CGFloat descripX = 8*SCALE ;
    CGFloat descripY = CGRectGetMaxY(self.productImage.frame)+10*SCALE ;
    CGFloat descripW = self.bounds.size.width-8*2 ;
    CGFloat descripH = txtSize.height*2 ;
    self.descrip.frame = CGRectMake(descripX, descripY  ,descripW,descripH);
    
    CGFloat priceX = 8*SCALE ;
    CGFloat priceY =  CGRectGetMaxY(self.descrip.frame)+8*SCALE ;
    CGFloat priceW =(self.descrip.bounds.size.width-priceX*2)/2 ;//改
    CGFloat priceH =  13*SCALE ;
    self.price.frame = CGRectMake(priceX,priceY,priceW,priceH);
    if (self.descrip.text.length>1) {
        self.backgroundColor=[UIColor whiteColor];
    }
    
    if (self.seeModel.sales_month.length>0) {
        self.saldCount.hidden=NO;
    }else{
        self.saldCount.hidden=YES;
    }
    
    CGFloat marginToRight = 8 ;
    
    CGFloat saldCountX = CGRectGetMaxX(self.price.frame) ;
    CGFloat saldCountY = priceY ;
    //    CGFloat saldCountW = priceW ;
    CGFloat saldCountW = self.bounds.size.width - saldCountX - marginToRight ;
    
    
    CGFloat saldCountH = priceH ;
    self.saldCount.frame = CGRectMake(saldCountX, saldCountY, saldCountW, saldCountH);
}
- (void)setSubModel:(HGoodsBottomSubModel *)subModel{
    //保存一次model
    self.seeModel = subModel;
    if (subModel.full_name.length == 0) {
        self.descrip.text = subModel.short_name;
    }else{
        self.descrip.text=subModel.full_name;
    }
    
    self.price.text = [NSString stringWithFormat:@"¥ %@", dealPrice(subModel.price)];
    //        self.ticket.text = composeModel.ticket;
    //  model.action ;
    [self.productImage sd_setImageWithURL:ImageUrlWithString(subModel.img) placeholderImage:nil options:SDWebImageCacheMemoryOnly];
    subModel.sales_month = @"44";
    if (subModel.sales_month.length>0) {
        self.saldCount.text =[NSString stringWithFormat:@"月销%@", subModel.sales_month];
    }
}



@end
