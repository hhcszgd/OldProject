
//
//  ChooseAddressCell.m
//  b2c
//
//  Created by wangyuanfei on 16/5/22.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "ChooseAddressCell.h"
#import "AMCellModel.h"

@interface ChooseAddressCell()

/** 上部控件容器视图 */
@property(nonatomic,weak)UIView * topContainerView ;
/** 展示姓名和联系方式的label */
@property(nonatomic,weak)UILabel * namePhoneLabel ;
/** 是否是默认地址的标志 */
@property(nonatomic,weak)UILabel * defaultTag ;
/** 高度动态变化的详细地址 */
@property(nonatomic,weak)UILabel * areaLabel ;
/** 底部分割线 */
@property(nonatomic,weak)UIView * bottomLine ;
/** 垂直分割线 */
@property(nonatomic,weak)UIView * verticalLine ;
/** 选择按钮 */
@property(nonatomic,strong)UIButton * chooseButton ;

@end

@implementation ChooseAddressCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor=[UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
        [self setupSubviews];
        
        //        [self layoutMySubview];
    }
    return self;
}

-(void)setupSubviews
{
    //    UIView * topContainerView = [[UIView alloc]init];
    //    self.topContainerView=topContainerView;
    //    //    self.topContainerView.backgroundColor=randomColor;
    //    [self.contentView addSubview:self.topContainerView];
    //姓名 电话
    UILabel * namePhoneLabel = [[UILabel alloc]init];
    self.namePhoneLabel=namePhoneLabel;
    self.namePhoneLabel.font=[UIFont systemFontOfSize:15*SCALE];
    [self.contentView addSubview:self.namePhoneLabel];
    //默认地址标识
    UILabel * defaultTag = [[UILabel alloc]init];
    self.defaultTag= defaultTag;
    [self.contentView addSubview:self.defaultTag];
    self.defaultTag.text=@"默认地址";
    self.defaultTag.font=[UIFont systemFontOfSize:12*SCALE];
    self.defaultTag.textColor=[UIColor redColor];
    //地址
    UILabel * areaLabel = [[UILabel alloc]init];
    self.areaLabel = areaLabel;
    self.areaLabel.font=[UIFont systemFontOfSize:15*SCALE];
    //    self.areaLabel.backgroundColor=randomColor;
    self.areaLabel.textColor=[UIColor grayColor];
    [self.contentView addSubview:self.areaLabel];
    self.areaLabel.numberOfLines=3;
    //底部分割线
    UIView * bottomLine = [[UIView alloc]init];
    self.bottomLine= bottomLine;
    self.bottomLine.backgroundColor=BackgroundGray;
    [self.contentView addSubview:self.bottomLine];
    
    //垂直分割线
    UIView * verticalLine = [[UIView alloc]init ] ;
    self.verticalLine = verticalLine;
    self.verticalLine.backgroundColor=BackgroundGray;
    [self.contentView addSubview:verticalLine];
    //选择按钮
    UIButton * chooseButton = [[UIButton alloc]init ] ;
    self.chooseButton= chooseButton;
    
    [self.contentView addSubview:chooseButton];
    [chooseButton setImage:[UIImage imageNamed:@"btn_round_nor"] forState:UIControlStateNormal];
    [chooseButton setImage:[UIImage imageNamed:@"btn_round_sel"] forState:UIControlStateSelected];
    chooseButton.userInteractionEnabled=NO;
    //    self.chooseButton.backgroundColor=randomColor;
}

-(void)setAddressModel:(AMCellModel *)addressModel{
    _addressModel = addressModel;
    NSString * userNameStr = addressModel.username.copy;
    if (userNameStr.length>8) {
        userNameStr = [userNameStr substringToIndex:8];
        userNameStr = [userNameStr stringByAppendingString:@"..."];
    }
    self.namePhoneLabel.text = [NSString stringWithFormat:@"%@ %@",userNameStr,addressModel.mobile];
    
//    self.areaLabel.text = [NSString stringWithFormat:@"%@ %@" , addressModel.area , addressModel.address];
    if ([addressModel.area containsString:@"亚洲中国"] ) {//国内先隐藏洲和国
        self.areaLabel.text=[NSString stringWithFormat:@"%@ %@",[addressModel.area stringByReplacingOccurrencesOfString:@"亚洲中国" withString:@""] ,addressModel.address];
    }else if([addressModel.area containsString:@"亚洲 中国"]){
         self.areaLabel.text =[NSString stringWithFormat:@"%@ %@",[addressModel.area stringByReplacingOccurrencesOfString:@"亚洲 中国" withString:@""] ,addressModel.address];
    } else{
        self.areaLabel.text = [NSString stringWithFormat:@"%@ %@" , addressModel.area , addressModel.address];
    }

    self.defaultTag.hidden=!addressModel.isDefaultAddress;
    
    self.chooseButton.selected  = addressModel.isSelected;
    //    [self setNeedsDisplay];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self layoutMySubview];
    
    
}
-(void)layoutMySubview
{
    //    [self removeConstraintWithView:self.contentView];
    //    [self removeConstraintWithView:self.topContainerView];
    //    [self removeConstraintWithView:self.namePhoneLabel];
    //    [self removeConstraintWithView:self.defaultTag];
    //    [self removeConstraintWithView:self.areaLabel];
    //    [self removeConstraintWithView:self.chooseButton];
    //    [self removeConstraintWithView:self.bottomLine];
    //    [self removeConstraintWithView:self.verticalLine];
    //    [self removeConstraintWithView:self];
    CGFloat margin = 10 ;
    CGFloat rightW = 60 *SCALE ;
    CGFloat leftW = screenW - rightW; //剩余宽度
    CGFloat defaultTagW = 0 ;
    defaultTagW = [self.defaultTag.text  sizeWithFont:self.defaultTag.font MaxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)].width;
    CGFloat namePhoneW = leftW - margin*3 - defaultTagW;
    CGFloat areaLabelW =  leftW - 2*margin;
    self.areaLabel.numberOfLines = 0 ;
    
    //    CGFloat arealabelMaxWidth = screenW - rightW - - margin * 2 ;
    CGFloat topHeight =40 ;
    //    CGFloat  bottomHeight=0 ;
    //    CGFloat  topMargin=0;
    //    CGFloat  bottomMargin=2;
    
    
    
    CGSize areaSize = [self.areaLabel.text sizeWithFont:[UIFont systemFontOfSize:15.5*SCALE] MaxSize:CGSizeMake(areaLabelW, MAXFLOAT)];
    self.namePhoneLabel.frame = CGRectMake(margin, 0, namePhoneW, topHeight);
    //    [self.namePhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(self.contentView).offset(margin);
    //        make.top.equalTo(self.contentView).offset(margin);
    //        make.width.equalTo(@(namePhoneW));
    //        make.height.equalTo(@(self.namePhoneLabel.font.lineHeight));
    //    }];
    self.defaultTag.frame = CGRectMake(CGRectGetMaxX(self.namePhoneLabel.frame)+margin/3, 0, defaultTagW, 30);
    //    [self.defaultTag mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(self.namePhoneLabel.mas_right).offset(margin/2);
    //        make.top.equalTo(self.namePhoneLabel);
    //        make.width.equalTo(@(defaultTagW));
    //        make.height.equalTo(@(self.namePhoneLabel.font.lineHeight));
    //    }];
    
    
    self.areaLabel.frame = CGRectMake(margin, CGRectGetMaxY(self.namePhoneLabel.frame), areaLabelW, areaSize.height);
    //    [self.areaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(self.namePhoneLabel);
    //        make.top.equalTo(self.namePhoneLabel.mas_bottom);
    //        make.width.equalTo(@(areaLabelW));
    //        make.height.equalTo(@(areaSize.height+20));
    //    }];
    
    
    
    
    
    
    self.bottomLine.frame = CGRectMake(0, self.bounds.size.height-2, self.bounds.size.width, 2);
    //    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(self.contentView);
    //        make.top.equalTo(self.areaLabel.mas_bottom).offset(0);
    //        make.width.equalTo(@(screenW));
    //        make.height.equalTo(@2);
    //    }];
    //    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.right.equalTo(self);
    //        make.bottom.equalTo(self.bottomLine.mas_bottom);
    //    }];
    //
    CGFloat verticalLineH = self.bounds.size.height - margin * 2 ;
    self.verticalLine.frame = CGRectMake(CGRectGetMaxX(self.areaLabel.frame), margin, 1, verticalLineH);
    //    [self.verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.width.equalTo(@1);
    //        make.top.equalTo(self.namePhoneLabel);
    //        make.centerX.equalTo(self.defaultTag.mas_right).offset(margin-1);
    //        make.centerY.equalTo(self.contentView.mas_centerY);
    //    }];
    //
    self.chooseButton.frame = CGRectMake(CGRectGetMaxX(self.verticalLine.frame), 0, rightW+margin, self.bounds.size.height);
    //    [self.chooseButton mas_makeConstraints:^(MASConstraintMaker *make) {
    ////        make.left.equalTo(self.verticalLine.mas_right);
    ////        make.top.right.bottom.equalTo(self.contentView);
    //
    //        make.top.equalTo(self.namePhoneLabel);
    //        make.bottom.equalTo(self.areaLabel);
    //        make.left.equalTo(self.verticalLine.mas_right).offset(2);
    ////        make.right.equalTo(self.contentView);
    //        make.width.equalTo(@(rightW));
    //    }];
    
    
    
}
-(void)removeConstraintWithView:(UIView*)view
{
    NSArray * constaint = view.constraints;
    [view removeConstraints:constaint];
}
@end







































////
////  ChooseAddressCell.m
////  b2c
////
////  Created by wangyuanfei on 16/5/22.
////  Copyright © 2016年 www.16lao.com. All rights reserved.
////
//
//#import "ChooseAddressCell.h"
//#import "AMCellModel.h"
//
//@interface ChooseAddressCell()
//
///** 上部控件容器视图 */
//@property(nonatomic,weak)UIView * topContainerView ;
///** 展示姓名和联系方式的label */
//@property(nonatomic,weak)UILabel * namePhoneLabel ;
///** 是否是默认地址的标志 */
//@property(nonatomic,weak)UILabel * defaultTag ;
///** 高度动态变化的详细地址 */
//@property(nonatomic,weak)UILabel * areaLabel ;
///** 底部分割线 */
//@property(nonatomic,weak)UIView * bottomLine ;
///** 垂直分割线 */
//@property(nonatomic,weak)UIView * verticalLine ;
///** 选择按钮 */
//@property(nonatomic,strong)UIButton * chooseButton ;
//
//@end
//
//@implementation ChooseAddressCell
//
//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.backgroundColor=[UIColor whiteColor];
//        self.selectionStyle = UITableViewCellSelectionStyleNone ;
//        [self setupSubviews];
//        
////        [self layoutMySubview];
//    }
//    return self;
//}
//
//-(void)setupSubviews
//{
////    UIView * topContainerView = [[UIView alloc]init];
////    self.topContainerView=topContainerView;
////    //    self.topContainerView.backgroundColor=randomColor;
////    [self.contentView addSubview:self.topContainerView];
//    //姓名 电话
//    UILabel * namePhoneLabel = [[UILabel alloc]init];
//    self.namePhoneLabel=namePhoneLabel;
//    self.namePhoneLabel.font=[UIFont systemFontOfSize:15*SCALE];
//    [self.contentView addSubview:self.namePhoneLabel];
//    //默认地址标识
//    UILabel * defaultTag = [[UILabel alloc]init];
//    self.defaultTag= defaultTag;
//    [self.contentView addSubview:self.defaultTag];
//    self.defaultTag.text=@"默认地址";
//    self.defaultTag.font=[UIFont systemFontOfSize:12*SCALE];
//    self.defaultTag.textColor=[UIColor redColor];
//    //地址
//    UILabel * areaLabel = [[UILabel alloc]init];
//    self.areaLabel = areaLabel;
//    self.areaLabel.font=[UIFont systemFontOfSize:15*SCALE];
//    //    self.areaLabel.backgroundColor=randomColor;
//    self.areaLabel.textColor=[UIColor grayColor];
//    [self.contentView addSubview:self.areaLabel];
//    self.areaLabel.numberOfLines=3;
//    //底部分割线
//    UIView * bottomLine = [[UIView alloc]init];
//    self.bottomLine= bottomLine;
//    self.bottomLine.backgroundColor=BackgroundGray;
//    [self.contentView addSubview:self.bottomLine];
//    
//    //垂直分割线
//    UIView * verticalLine = [[UIView alloc]init ] ;
//    self.verticalLine = verticalLine;
//    self.verticalLine.backgroundColor=BackgroundGray;
//    [self.contentView addSubview:verticalLine];
//    //选择按钮
//    UIButton * chooseButton = [[UIButton alloc]init ] ;
//    self.chooseButton= chooseButton;
//    
//    [self.contentView addSubview:chooseButton];
//    [chooseButton setImage:[UIImage imageNamed:@"btn_round_nor"] forState:UIControlStateNormal];
//    [chooseButton setImage:[UIImage imageNamed:@"btn_round_sel"] forState:UIControlStateSelected];
//    chooseButton.userInteractionEnabled=NO;
////    self.chooseButton.backgroundColor=randomColor;
//}
//
//-(void)setAddressModel:(AMCellModel *)addressModel{
//    _addressModel = addressModel;
//    NSString * userNameStr = addressModel.username.copy;
//    if (userNameStr.length>8) {
//        userNameStr = [userNameStr substringToIndex:8];
//        userNameStr = [userNameStr stringByAppendingString:@"..."];
//    }
//    self.namePhoneLabel.text = [NSString stringWithFormat:@"%@ %@",userNameStr,addressModel.mobile];
//
//    self.areaLabel.text = [NSString stringWithFormat:@"%@ %@" , addressModel.area , addressModel.address];
//    self.defaultTag.hidden=!addressModel.isDefaultAddress;
//    
//    [self layoutMySubview];
//    self.chooseButton.selected  = addressModel.isSelected;
////    [self setNeedsDisplay];
//}
//-(void)layoutMySubview
//{
//    [self removeConstraintWithView:self.contentView];
//    [self removeConstraintWithView:self.topContainerView];
//    [self removeConstraintWithView:self.namePhoneLabel];
//    [self removeConstraintWithView:self.defaultTag];
//    [self removeConstraintWithView:self.areaLabel];
//    [self removeConstraintWithView:self.chooseButton];
//    [self removeConstraintWithView:self.bottomLine];
//    [self removeConstraintWithView:self.verticalLine];
//    [self removeConstraintWithView:self];
//    CGFloat margin = 10 ;
//    CGFloat rightW = 60 *SCALE ;
//    CGFloat leftW = screenW - rightW; //剩余宽度
//    CGFloat defaultTagW = 0 ;
//    defaultTagW = [self.defaultTag.text  sizeWithFont:self.defaultTag.font MaxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)].width;
//    CGFloat namePhoneW = leftW - margin*3 - defaultTagW;
//    CGFloat areaLabelW =  leftW - 2*margin;
//    self.areaLabel.numberOfLines = 0 ;
//    
//    CGSize areaSize = [self.areaLabel.text sizeWithFont:self.areaLabel.font MaxSize:CGSizeMake(areaLabelW, MAXFLOAT)];
//    
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.areaLabel.text);
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,NSStringFromCGSize(areaSize));
//    [self.namePhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView).offset(margin);
//        make.top.equalTo(self.contentView).offset(margin);
//        make.width.equalTo(@(namePhoneW));
//        make.height.equalTo(@(self.namePhoneLabel.font.lineHeight));
//    }];
//    [self.defaultTag mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.namePhoneLabel.mas_right).offset(margin/2);
//        make.top.equalTo(self.namePhoneLabel);
//        make.width.equalTo(@(defaultTagW));
//        make.height.equalTo(@(self.namePhoneLabel.font.lineHeight));
//    }];
//    [self.areaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.namePhoneLabel);
//        make.top.equalTo(self.namePhoneLabel.mas_bottom);
//        make.width.equalTo(@(areaLabelW));
//        make.height.equalTo(@(areaSize.height+20));
//    }];
//    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView);
//        make.top.equalTo(self.areaLabel.mas_bottom).offset(0);
//        make.width.equalTo(@(screenW));
//        make.height.equalTo(@2);
//    }];
//    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self);
//        make.bottom.equalTo(self.bottomLine.mas_bottom);
//    }];
//
//    [self.verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(@1);
//        make.top.equalTo(self.namePhoneLabel);
//        make.centerX.equalTo(self.defaultTag.mas_right).offset(margin-1);
//        make.centerY.equalTo(self.contentView.mas_centerY);
//    }];
//    
//    [self.chooseButton mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.left.equalTo(self.verticalLine.mas_right);
////        make.top.right.bottom.equalTo(self.contentView);
//
//        make.top.equalTo(self.namePhoneLabel);
//        make.bottom.equalTo(self.areaLabel);
//        make.left.equalTo(self.verticalLine.mas_right).offset(2);
////        make.right.equalTo(self.contentView);
//        make.width.equalTo(@(rightW));
//    }];
//    
//    
//
//}
//-(void)removeConstraintWithView:(UIView*)view
//{
//    NSArray * constaint = view.constraints;
//    [view removeConstraints:constaint];
//}
//@end
