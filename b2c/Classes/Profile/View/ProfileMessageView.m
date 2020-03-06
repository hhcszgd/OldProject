//
//  ProfileMessageView.m
//  b2c
//
//  Created by wangyuanfei on 4/10/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "ProfileMessageView.h"

@interface ProfileMessageView ()
@property(nonatomic,weak)UIImageView * messageImageView ;
@property(nonatomic,weak)UILabel * messageCountLabel ;
@end


@implementation ProfileMessageView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        UIImageView * messageImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_news_light"]];
        self.messageImageView = messageImageView;
        [self addSubview: self.messageImageView];
        
        UILabel * messageCountLabel = [[UILabel alloc]init];
        self.messageCountLabel = messageCountLabel ;
        [self addSubview:self.messageCountLabel];
        self.messageCountLabel.backgroundColor = [UIColor whiteColor];
        self.messageCountLabel.textColor = [UIColor redColor];
        self.messageCountLabel.font = [UIFont systemFontOfSize:10*SCALE];
        self.messageCountLabel.textAlignment = NSTextAlignmentCenter;

    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.messageImageView.frame  = self.bounds;
    CGSize messageLabelSize = [self.messageCountLabel.text stringSizeWithFont:11*SCALE];
    CGFloat messageLabelW = messageLabelSize.width;
    CGFloat messageLabelH = messageLabelSize.height;
    if (messageLabelW<messageLabelH) {
        messageLabelW = messageLabelH;
    }
    CGFloat messageLabelCenterX = self.bounds.size.width;
    CGFloat messageLabelCenterY = 0;
    self.messageCountLabel.bounds = CGRectMake(0, 0, messageLabelW, messageLabelH);
    self.messageCountLabel.center=CGPointMake(messageLabelCenterX, messageLabelCenterY);
    self.messageCountLabel.layer.cornerRadius  = messageLabelW*0.5 ;
    self.messageCountLabel.layer.masksToBounds = YES;

}

-(void)setMessageCount:(NSInteger)messageCount{
    _messageCount=messageCount;
    if (messageCount>0 && messageCount<10) {
        self.messageCountLabel.hidden = NO;
        self.messageCountLabel.text=[NSString stringWithFormat:@"%ld",messageCount];
    }else if (messageCount >10 || messageCount ==10){
        self.messageCountLabel.hidden = NO;
        self.messageCountLabel.text=[NSString stringWithFormat:@"9+"];
    }else{
        self.messageCountLabel.hidden = YES;
    }
}
@end
