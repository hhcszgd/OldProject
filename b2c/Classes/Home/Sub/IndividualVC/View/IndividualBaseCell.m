//
//  IndividualBaseCell.m
//  b2c
//
//  Created by wangyuanfei on 16/5/5.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "IndividualBaseCell.h"
#import "HCellBaseComposeView.h"
@implementation IndividualBaseCell

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
                                  @"IndividualCellComposeViewModel":sender.composeModel
                                  };
        [[NSNotificationCenter defaultCenter] postNotificationName:@"IndividualCellComposeViewClick" object:nil userInfo:pragma];//点击个体自产里面的组件的通知
    }
        LOG(@"_%@_%d_%@",[self class] , __LINE__,sender.composeModel.actionKey)
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
