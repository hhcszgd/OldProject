//
//  HGBSeeAndSeeCell.m
//  b2c
//
//  Created by 0 on 16/5/14.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HGBSeeAndSeeCell.h"
#import "HGBSeeAndSeeSub.h"


@interface HGBSeeAndSeeCell()
@property (nonatomic, strong) HGBSeeAndSeeSub *contennerViewL;
@property (nonatomic, strong) HGBSeeAndSeeSub *contennerViewR;
@property (nonatomic, strong) NSArray *saveModel;

@end
@implementation HGBSeeAndSeeCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self layoutContennerView];
    }
    return self;
}

-(void)layoutContennerView
{
    
    CGFloat margin = 5 ;
    CGFloat conposeW = (screenW - margin*6 )/2 ;
    HGBSeeAndSeeSub * contennerViewL = [[HGBSeeAndSeeSub alloc]init];
    [contennerViewL addTarget:self action:@selector(composeClick:) forControlEvents:UIControlEventTouchUpInside];
    self.contennerViewL = contennerViewL;
    //    self.contennerViewL.backgroundColor = randomColor;
    [self.contentView addSubview: self.contennerViewL];
    [self.contennerViewL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(margin);
        make.left.equalTo(self.contentView).offset(margin*2);
        make.height.equalTo(@(243*SCALE));
        
        make.width.equalTo(@(conposeW));
    }];
    //    [self.contennerViewL.btn setImage:[UIImage imageNamed:@"zuidapai_02"] forState:UIControlStateNormal];
    
    HGBSeeAndSeeSub * contennerViewR = [[HGBSeeAndSeeSub alloc]init];
    self.contennerViewR =contennerViewR;
    [contennerViewR addTarget:self action:@selector(composeClick:) forControlEvents:UIControlEventTouchUpInside];//父类有
    //    self.contennerViewR.backgroundColor = randomColor;
    [self.contentView addSubview: self.contennerViewR];
    [self.contennerViewR mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contennerViewL.mas_right).offset(margin*2);
        make.top.equalTo(self.contennerViewL);
        make.height.equalTo(self.contennerViewL);
        make.width.equalTo(@(conposeW));
    }];
    //    [self.contennerViewR.btn setImage:[UIImage imageNamed:@"zuidapai_02"] forState:UIControlStateNormal];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contennerViewL).offset(margin);
        make.right.equalTo(self);
        make.left.equalTo(self);
    }];
    
}
- (void)setDataArr:(NSArray *)dataArr{
    self.contennerViewL.subModel = [dataArr firstObject];
    self.contennerViewR.subModel = [dataArr lastObject];
    self.saveModel = dataArr;
}

- (void)composeClick:(HGBSeeAndSeeSub *)actionView{
    HGoodsBottomSubModel *model = nil;
    if ([actionView isEqual: self.contennerViewL]) {
        model = [self.saveModel firstObject];
    }
    if ([actionView isEqual:self.contennerViewR]) {
        model = [self.saveModel lastObject];
    }
    
    NSDictionary *paramate = @{@"paramate":model.good_id};
    model.keyParamete = paramate;
    if ([self.delegate respondsToSelector:@selector(clickActionToGoodsDetailVCWithModel:)]) {
        [self.delegate performSelector:@selector(clickActionToGoodsDetailVCWithModel:) withObject:model];
    }
}








@end
