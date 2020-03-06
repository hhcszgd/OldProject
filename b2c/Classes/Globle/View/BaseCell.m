//
//  BaseCell.m
//  b2c
//
//  Created by wangyuanfei on 3/25/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "BaseCell.h"
#import "ActionBaseView.h"
@interface BaseCell ()
@property(nonatomic,weak)ActionBaseView * actionView ;
@end

@implementation BaseCell
/*

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        ActionBaseView * actionView = [[ActionBaseView alloc]init];
////        actionView.backgroundColor=randomColor;
//        self.actionView = actionView;
////        self.actionView.model = 单个商品或者店铺的模型;
//        [self.actionView addTarget:self action:@selector(clik:) forControlEvents:UIControlEventTouchUpInside];
////        [self.actionView addTarget:self andSel:@selector(clik:)];
//        [self.contentView addSubview:self.actionView];

    }
    return self;
}

-(ActionBaseView * )actionView{
    if(_actionView==nil){
        ActionBaseView * actionView =  [[ActionBaseView alloc]init];
        [actionView addTarget:self action:@selector(clik:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.actionView];
        _actionView =actionView;
    }
    return _actionView;
}

-(void)clik:(ActionBaseView*)sender
{
    if ([self.delegate respondsToSelector:@selector(baseCell:modelOfDidSelectCell:)]) {
        [self.delegate baseCell:self modelOfDidSelectCell:@"TheModel"];//theModel待定
    }else{
    
        LOG(@"_%@_%d_ 请实现方法%@传递模型",[self class] , __LINE__,@"(baseCell:modelOfDidSelectCell:)")
    }
}


- (void)awakeFromNib {
    // Initialization code
}
//-(void)layoutSubviews{
//    [super layoutSubviews];
//    self.actionView.frame=self.bounds;
//
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
*/
@end
