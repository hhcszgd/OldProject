//
//  HLaoCellComposeView.m
//  b2c
//
//  Created by wangyuanfei on 16/4/15.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HLaoCellComposeView.h"
#import "HCellBaseComposeView.h"

#import "HCellComposeModel.h"


@interface HLaoCellComposeView()
@property(nonatomic,weak)HCellBaseComposeView * leftContainer ;
@property(nonatomic,weak)HCellBaseComposeView * rightContainer ;
@property(nonatomic,weak)UIImageView * midLine ;
////////////////////
@property(nonatomic,weak)UILabel * price ;
@property(nonatomic,weak)UILabel * shopName  ;
@property(nonatomic,weak)UILabel * time ;

@property(nonatomic,weak)UILabel * limit ;
@property(nonatomic,weak)UILabel * getLabel ;
@property(nonatomic,weak)UIButton * getClick ;
@property(nonatomic,strong)CAShapeLayer * midLineLayer ;
@end

@implementation HLaoCellComposeView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        HCellBaseComposeView *  rightContainer = [[HCellBaseComposeView alloc]init];
        self.rightContainer =  rightContainer ;
        [self addSubview:self.rightContainer];
//        self.rightContainer.backgroundColor=randomColor;
        
        
        HCellBaseComposeView * leftContainer = [[HCellBaseComposeView alloc]init];
        [leftContainer addTarget:self action:@selector(composeClick:) forControlEvents:UIControlEventTouchUpInside];
        self.leftContainer = leftContainer ;
        [self addSubview:self.leftContainer];
        self.leftContainer.backgroundColor=[self.rightContainer.backgroundColor colorWithAlphaComponent:0.7];
        
//        UIImageView * midLine = [[UIImageView alloc]init];
//        self.midLine = midLine;
//        [self addSubview:self.midLine];
//        self.midLine.backgroundColor =
        
        
        
        
        /**
         left->
         @property(nonatomic,weak)UILabel * price ;
         @property(nonatomic,weak)UILabel * shopName  ;
         @property(nonatomic,weak)UILabel * time ;
         right->
         @property(nonatomic,weak)UILabel * limit ;
         @property(nonatomic,weak)UILabel * getLabel ;
         @property(nonatomic,weak)UIButton * getClick ;
         */
        
        UILabel * price =[[UILabel alloc]init];
        price.textColor = [UIColor whiteColor];
        price.textAlignment = NSTextAlignmentCenter;
        self.price = price;
        [self.leftContainer addSubview:self.price];
//        self.price.backgroundColor=  randomColor;
        
        UILabel * shopName =[[UILabel alloc]init] ;
        shopName.font = [UIFont systemFontOfSize:12*SCALE];
        self.shopName = shopName;
        shopName.textColor = [UIColor whiteColor];
        [self.leftContainer addSubview:self.shopName];
//        self.shopName.backgroundColor=  randomColor;
        shopName.textAlignment = NSTextAlignmentCenter;
        
        
        UILabel * time =[[UILabel alloc]init];
        self.time = time;
        time.font = [UIFont systemFontOfSize:9*SCALE];
        time.textColor = [UIColor whiteColor];
        [self.leftContainer addSubview:self.time];
//        self.time.backgroundColor=  randomColor;
        time.textAlignment = NSTextAlignmentCenter;
        
        UILabel * limit =[[UILabel alloc]init];
        self.limit = limit;
        limit.font = [UIFont systemFontOfSize:11*SCALE];
        limit.textColor = [UIColor whiteColor];
        limit.numberOfLines = 2;
        [self.rightContainer addSubview:self.limit];
//        self.limit.backgroundColor=  randomColor;
        limit.textAlignment = NSTextAlignmentCenter;
        
        
        UILabel * getLabel =[[UILabel alloc]init];
        self.getLabel = getLabel;
        getLabel.textColor = [UIColor whiteColor];
        [self.rightContainer addSubview:self.getLabel];
//        self.getLabel.backgroundColor=  randomColor;
        getLabel.textAlignment = NSTextAlignmentCenter;
        
        
        UIButton * getClick =[[UIButton alloc]init];
        self.getClick = getClick;
        [self.rightContainer addSubview:self.getClick];
        [getClick addTarget:self action:@selector(composeClick) forControlEvents:UIControlEventTouchUpInside];
        [getClick setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [getClick.titleLabel setFont:[UIFont systemFontOfSize:12*SCALE]];
        
        self.getClick.backgroundColor = [UIColor colorWithRed:251/256.0 green:195/256.0 blue:33/256.0 alpha:1];

        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat rightH = self.bounds.size.height;
    CGFloat rightW = rightH;
    
    CGFloat leftH = rightH;
    CGFloat leftW = self.bounds.size.width - rightW;
    CGFloat leftX = 0 ;
    CGFloat leftY = 0 ;
    
    CGFloat rightX = leftW;
    CGFloat rightY = 0 ;
    self.leftContainer.frame = CGRectMake(leftX, leftY, leftW, leftH);
    self.rightContainer.frame = CGRectMake(rightX, rightY, rightW, rightH);
//    self.midLine.bounds = CGRectMake(0, 0, 1, leftH);
//    self.midLine.center = CGPointMake(leftW, leftH/2);
    self.midLineLayer.position = CGPointMake(leftW, leftH/2);
    ////////////////////////////////
//    self.price.bounds= CGRectMake(0, 0, <#CGFloat width#>, <#CGFloat height#>)
//    NSUInteger  temp = 50;
//    NSString *contentStr = [NSString stringWithFormat:@"¥ %ld",temp];
    NSString * showDiscount_price = [self.composeModel.discount_price convertToYuan];
     NSString *contentStr = [NSString stringWithFormat:@"¥ %@",showDiscount_price];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:contentStr];
    NSString * ss = [contentStr substringFromIndex:1];
    NSRange rr = [contentStr rangeOfString:ss];
//    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:rr];
    [str addAttribute:NSKernAttributeName
               value:@(-(5*SCALE))
               range:NSMakeRange(0, 1)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:30*SCALE] range:rr];
    self.price.attributedText=str;
    self.price.frame = CGRectMake(0, 0, self.leftContainer.bounds.size.width, self.leftContainer.bounds.size.height/2);
   
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,[self.composeModel.start_time formatterDateString]);
    NSString * startTime =[self.composeModel.start_time formatterDateString];
    NSString * endTime = [self.composeModel.end_time formatterDateString];

    
    self.shopName.text=self.composeModel.title;
    self.shopName.frame = CGRectMake(0, CGRectGetMaxY(self.price.frame), self.leftContainer.bounds.size.width, self.leftContainer.bounds.size.height/4);
    
    
    
    self.time.text = [NSString stringWithFormat:@"%@-%@",startTime,endTime];
    self.time.frame = CGRectMake(0, CGRectGetMaxY(self.shopName.frame), self.leftContainer.bounds.size.width, self.leftContainer.bounds.size.height/4);
    
//    NSInteger limitPrice = 100 ;
//    self.limit.text = [NSString stringWithFormat:@"满%ld\n即可使用",limitPrice];

    NSString * showFull_price = [self.composeModel.full_price convertToYuan];
    self.limit.text = [NSString stringWithFormat:@"满%@\n即可使用",showFull_price];
    
    self.limit.frame = CGRectMake(0, 0, self.rightContainer.bounds.size.width, self.rightContainer.bounds.size.height/5*3);
    
    NSString * clickTitle = @"点击领取";
    [self.getClick setTitle:clickTitle forState:UIControlStateNormal];
    CGFloat getClickW = 60*SCALE ;
    CGFloat getClickH = 21*SCALE ;
    CGFloat getClickX = (self.rightContainer.bounds.size.width-getClickW)/2;
    self.getClick.frame = CGRectMake(getClickX, CGRectGetMaxY(self.limit.frame), getClickW, getClickH);
    self.getClick.layer.cornerRadius = self.getClick.bounds.size.height/2;
    self.getClick.layer.masksToBounds = YES;
}
-(void)setComposeModel:(HCellComposeModel *)composeModel{
    [super setComposeModel:composeModel];
//    [self.midLine sd_setImageWithURL:[NSURL URLWithString:composeModel.imgStr] placeholderImage:nil options:SDWebImageCacheMemoryOnly];

//    [self.midLine sd_setImageWithURL:ImageUrlWithString(composeModel.imgStr) placeholderImage:nil options:SDWebImageCacheMemoryOnly];
    //    composeModel.keyParamete=@{@"paramete":composeModel.ID};
    self.leftContainer.composeModel = composeModel;
    if ([composeModel.discount_price integerValue]<5000) {//单位是分
        self.leftContainer.backgroundColor = [UIColor colorWithHexString:@"56e4ad"];
        self.rightContainer.backgroundColor = [UIColor colorWithHexString:@"09c97f"];
    }else if ([composeModel.discount_price integerValue]<10000){
        self.leftContainer.backgroundColor = [UIColor colorWithHexString:@"58c2ff"];
        self.rightContainer.backgroundColor = [UIColor colorWithHexString:@"318bf0"];
    }else if ([composeModel.discount_price integerValue]<50000){
        self.leftContainer.backgroundColor = [UIColor colorWithHexString:@"ff6767"];
        self.rightContainer.backgroundColor = [UIColor colorWithHexString:@"ed3b3b"];
    }else{
        self.leftContainer.backgroundColor = [UIColor colorWithHexString:@"c664ff"];
        self.rightContainer.backgroundColor = [UIColor colorWithHexString:@"9d31f0"];
    }
    
    
//    self.leftContainer.backgroundColor = [UIColor blackColor];
    

}

-(void)composeClick:(HCellBaseComposeView*)sender
{
    if (sender.composeModel) {
#pragma mark 控制器初始化时所需参数(这里是指优惠券id)
        if (!self.composeModel.ID) return;
        sender.composeModel.keyParamete = @{
                                            @"paramete":sender.composeModel.ID
                                            };
        NSDictionary * pragma = @{
                                  @"HCellComposeViewModel":sender.composeModel
                                  };
        [[NSNotificationCenter defaultCenter] postNotificationName:@"HCellComposeViewClick" object:nil userInfo:pragma];
    }
}

-(void)composeClick{    [self composeClick:self.leftContainer];}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
// LOG(@"_%@_%d_%@",[self class] , __LINE__,@"点点");
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(CAShapeLayer * )midLineLayer{
    if(_midLineLayer==nil){
        ///////////////画虚线////////////
        CAShapeLayer * layer = [self gotlayerWithSize:CGSizeMake(2,self.bounds.size.height) ] ;
//        layer.position = CGPointMake(backView.bounds.size.width/2  , backView.bounds.size.height);//相当于center
        _midLineLayer = layer;
        [self.layer addSublayer:layer];
    }
    return _midLineLayer;
}
/** 返回一条虚线 , size是虚线的宽高 */
-(CAShapeLayer*)gotlayerWithSize:(CGSize)size
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    //    shapeLayer.backgroundColor = [UIColor redColor].CGColor;
    [shapeLayer setBounds:CGRectMake(0, 0, size.width, size.height)];
    //    [shapeLayer setPosition:self.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    // 设置虚线颜色;
    [shapeLayer setStrokeColor:[[UIColor whiteColor] CGColor]];
    // 3.0f设置整条虚线的宽度
    [shapeLayer setLineJoin:kCALineJoinRound];
    // 两个参数分别是 每一小段线的宽度 间距
    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    shapeLayer.lineCap = @"round";
    //    CGPathMoveToPoint(path, NULL, 0, 0);
    if (size.height >size.width) {
        [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:size.width],[NSNumber numberWithInt:size.width*2],nil]];
        [shapeLayer setLineWidth:size.width];
        CGPathMoveToPoint(path, NULL, size.width/2, 0);
        CGPathAddLineToPoint(path, NULL, size.width/2,size.height);
    }else{
        [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:size.height],[NSNumber numberWithInt:size.height*2],nil]];
        [shapeLayer setLineWidth:size.height];
        
        CGPathMoveToPoint(path, NULL, 0, size.height/2);
        CGPathAddLineToPoint(path, NULL, size.width,size.height/2);
    }
    //    CGPathMoveToPoint(path, NULL, 0, 89);
    //    CGPathAddLineToPoint(path, NULL, 320,89);
    //     Setup the path CGMutablePathRef path = CGPathCreateMutable(); // 0,10代表初始坐标的x，y
    // 320,10代表初始坐标的x，y CGPathMoveToPoint(path, NULL, 0, 10);
    //    CGPathAddLineToPoint(path, NULL, 320,10);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    return shapeLayer;
}

@end
