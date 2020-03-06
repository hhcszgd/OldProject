//
//  MyCell.m
//  1223test
//
//  Created by WY on 15/12/23.
//  Copyright © 2015年 WY. All rights reserved.
//

#import "SearchCell.h"
@interface SearchCell()

@end
@implementation SearchCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutUI];
        self.backgroundColor = BackgroundGray;
    }
    return self;
}
-(void)layoutUI
{
    [self.contentView addSubview:self.lbl];
}
-(void)layoutSubviews{
    self.lbl.frame = self.bounds;
    
    self.lbl.layer.cornerRadius = self.bounds.size.height/2 ;
    self.lbl.clipsToBounds = YES ;

//    self.lbl.backgroundColor = [UIColor greenColor];
}

-(UILabel * )lbl{
    if(_lbl==nil){
        _lbl = [[UILabel alloc]init];
        _lbl.numberOfLines = 1 ;
        _lbl.font = [UIFont systemFontOfSize:14*SCALE];
        _lbl.textAlignment = NSTextAlignmentCenter;
        _lbl.textColor= SubTextColor;
        _lbl.layer.borderWidth=1.0;
        _lbl.layer.borderColor=[UIColor colorWithRed:234/256.0 green:234/256.0 blue:234/256.0 alpha:1].CGColor;
        _lbl.textAlignment = NSTextAlignmentCenter;
        _lbl.backgroundColor = [UIColor whiteColor];
        _lbl.lineBreakMode =  NSLineBreakByTruncatingMiddle;
//        [_lbl.layer set]
    }
    return _lbl;
}

-(void)setTitle:(NSString *)title{
    _title = title.copy;
    LOG(@"_%@_%d_%@",[self class] , __LINE__,title);
    if ([_title containsString:@"\r"]) {
       _title= [_title stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    }
    if ([_title containsString:@"\n"]) {
        _title= [_title stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    }
    if ([_title containsString:@"\t"]) {
       _title=  [_title stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    }
    if (_title) {
        self.lbl.text = _title;
}else{
        _title = @"猜你喜欢";
    }
}
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [super touchesBegan:touches withEvent:event];
//}

@end
