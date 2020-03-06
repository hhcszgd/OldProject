//
//  HCBaseCell.m
//  b2c
//
//  Created by wangyuanfei on 16/8/8.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HCBaseCell.h"
#import "HCellBaseComposeView.h"
@implementation HCBaseCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return self;
}
-(void)composeClick:(HCellBaseComposeView*)sender
{
    if (sender.composeModel) {
        NSDictionary * pragma = @{
                                  @"CountrysideCellComposeViewModel":sender.composeModel
                                  };
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CountrysideCellComposeViewClick" object:nil userInfo:pragma];//点击个体自产里面的组件的通知
    }
    LOG(@"_%@_%d_%@",[self class] , __LINE__,sender.composeModel.actionKey)
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
