//
//  MyInputAccessoryView.m
//  b2c
//
//  Created by wangyuanfei on 6/17/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "MyInputAccessoryView.h"

@interface MyInputAccessoryView ()
@property(nonatomic,weak)UIButton * gobackButton ;
@property(nonatomic,weak)UILabel * titLabel ;
@property(nonatomic,weak)UIView * passwordContainer ;
@property(nonatomic,weak)UIButton * forgetButton ;

@end

@implementation MyInputAccessoryView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel * titLabel = [[UILabel alloc]init];
        titLabel.textColor = MainTextColor;
        titLabel.textAlignment = NSTextAlignmentCenter;
        titLabel.text = @"请输入六位数字的支付密码";
        titLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:titLabel];
        self.titLabel = titLabel;
        
        
        UIButton * gobackButton = [[UIButton alloc]init];
        [gobackButton setImage:[UIImage imageNamed:@"header_leftbtn_nor"] forState:UIControlStateNormal ];
        self.gobackButton = gobackButton;
        

        
#pragma  暂时把返回按钮隐藏了
        gobackButton.hidden = YES;
        [self addSubview:gobackButton];
        
        UIView * passwordContainer = [[UIView alloc]init];
        self.passwordContainer = passwordContainer;
//        passwordContainer.backgroundColor = randomColor;
        [self addSubview:passwordContainer];
        
        for (int i = 0 ; i<6; i++) {
            UILabel * label = [[UILabel alloc]init];
            label.layer.borderWidth=0.5;
            label.layer.borderColor=[UIColor lightGrayColor].CGColor;
            label.textAlignment=NSTextAlignmentCenter;
            [passwordContainer addSubview:label];
//            label.backgroundColor = randomColor;
        }
        
        
        UIButton * forgetButton = [[UIButton alloc]init];
        [self addSubview:forgetButton];
        [forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
        [forgetButton addTarget:self action:@selector(performFindPayPassword:) forControlEvents:UIControlEventTouchUpInside];
        [forgetButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        forgetButton.titleLabel.font = [UIFont systemFontOfSize:12];
        forgetButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.forgetButton = forgetButton;
//        forgetButton.backgroundColor = randomColor;
        
        
    }
    return self;
}
-(void)performFindPayPassword:(UIButton*)sender
{
    if ([self.InputAccessoryViewDelegate respondsToSelector:@selector(forgetPasswordActionWithAccessoryView:)]) {
        [self.InputAccessoryViewDelegate forgetPasswordActionWithAccessoryView:self];
    }
}
-(void)trendsChangeInputViewWithLength:(NSUInteger)length
{
    if (length==0) {
        for (int i = 0 ; i< self.passwordContainer.subviews.count; i++) {
            UILabel * sub = self.passwordContainer.subviews[i];
            sub.text = @"";
            }
    }else{
        for (int i = 0 ; i< self.passwordContainer.subviews.count; i++) {
            UILabel * sub = self.passwordContainer.subviews[i];
            if (i<length) {
                sub.text=@"*";
            }else{
                sub.text = @"";
            }
        }
    }
    
    
//    for (int i = 0 ; i< self.passwordContainer.subviews.count; i++) {
//        UILabel * sub = self.passwordContainer.subviews[i];
//        if (length==0) {
//            sub.text = @"";
//            return;
//        }
//        if (i>length) {
//            sub.text = @"";
//        }else{
//            sub.text = @"*";
//        }
//    }
}

-(void)deleteInputFromIndex:(NSInteger)index
{
    for (NSInteger i = index; i<6; i++) {
        UILabel * lab =self.passwordContainer.subviews[i];
        lab.text = @"";
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.gobackButton.frame = CGRectMake(10, 0, 44, 40*SCALE);
    self.titLabel.frame = CGRectMake(0, 0, self.bounds.size.width, 44*SCALE);
    self.passwordContainer.frame = CGRectMake(10, CGRectGetMaxY(self.titLabel.frame), self.bounds.size.width - 10*2, 44*SCALE);
    CGFloat forgetW = 111 ;
    self.forgetButton.frame = CGRectMake(self.bounds.size.width - 10 -forgetW,CGRectGetMaxY(self.passwordContainer.frame), forgetW, 44*SCALE);
//    CGFloat subW = (self.passwordContainer.bounds.size.width -(self.passwordContainer.subviews.count+1)*1)/self.passwordContainer.subviews.count;
    CGFloat subW = self.passwordContainer.bounds.size.width/self.passwordContainer.subviews.count;
    
    for (int  i = 0 ; i<self.passwordContainer.subviews.count ; i++) {
        UILabel * sub = self.passwordContainer.subviews[i];
//        sub.frame = CGRectMake(i*subW, 0, subW+1, self.passwordContainer.bounds.size.height);

        sub.frame = CGRectMake(i*subW, 0, subW+1, self.passwordContainer.bounds.size.height);
        sub.layer.borderColor = SubTextColor.CGColor;
        sub.layer.borderWidth = 1 ;
        sub.layer.masksToBounds  = YES;
    }
    
    
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
