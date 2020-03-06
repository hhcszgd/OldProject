//
//  ChatMsgCell.m
//  b2c
//
//  Created by wangyuanfei on 6/28/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "ChatMsgCell.h"

#import "ChatMsgBackView.h"

@interface ChatMsgCell ()
@property(nonatomic,weak)UIImageView * iconImgView ;
@property(nonatomic,weak)UILabel * timeLabel ;
@property(nonatomic,weak)UILabel * titleLabel ;
@property(nonatomic,weak)ChatMsgBackView * msgBackView ;

@end

@implementation ChatMsgCell




-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView * iconImgView = [[UIImageView alloc]init];
        self.iconImgView = iconImgView;
        [self.contentView  addSubview:iconImgView];
        
//        UILabel * timeLabel = [[UILabel alloc]init];
        UILabel * titleLabel = [[UILabel alloc]init];
        self.titleLabel = titleLabel;
        [self.contentView addSubview:titleLabel];
        
        ChatMsgBackView * msgBackView = [[ChatMsgBackView alloc]init];
        self.msgBackView   =  msgBackView;
        [self.contentView addSubview:msgBackView];
    }
    return  self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.iconImgView.frame = CGRectMake(10, 0, 88, 88);
    CGFloat titleLabelX = CGRectGetMaxX(self.iconImgView.frame)+10;
    CGFloat titleLabelY =CGRectGetMinY(self.iconImgView.frame)+10;
    CGFloat titleLabelW = self.bounds.size.width-titleLabelX-10;
    CGFloat titleLabelH = 32 ;
    self.titleLabel.frame = CGRectMake(titleLabelX,titleLabelY , titleLabelW , titleLabelH);
    
//    self.msgBackView.frame = CGRectMake(CGRectGetMidX(self.titleLabel.frame),CGRectGetMaxY(self.titleLabel.frame), <#CGFloat height#>)
}


-(void)setMessageModel:(ChatMsgModel *)messageModel{
    _messageModel = messageModel;
    self.iconImgView.image  =  [UIImage imageNamed:messageModel.userIcon];
    self.titleLabel.text = messageModel.title;
    self.msgBackView.messageModel = messageModel;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
