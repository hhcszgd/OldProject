//
//  MessageCenterCell.m
//  b2c
//
//  Created by wangyuanfei on 16/5/10.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "MessageCenterCell.h"
#import "GDXmppStreamManager.h"
#import "MessageCenterCellModel.h"
#import "XMPPMessageArchiving_Contact_CoreDataObject.h"
#import "NSObject+Scale.h"
#import "NSString+StrSize.h"
#import <SDWebImage/SDWebImage-umbrella.h>
#import <XMPPFramework/XMPPvCardTempModule.h>
#import <XMPPFramework/XMPPvCardTemp.h>
#import <XMPPFramework/XMPPvCardAvatarModule.h>
#import <XMPPFramework/XMPPRosterCoreDataStorage.h>
#import <XMPPFramework/XMPPMessageArchivingCoreDataStorage.h>
@interface MessageCenterCell ()

/** 图片url */
@property(nonatomic,weak)UIImageView * imgView ;

/** 主标题 */
@property(nonatomic,weak)UILabel    * mainTitleLabel ;
/** 子标题 */
@property(nonatomic,weak)UILabel * subTitleLabel ;
/** 附加标题 */
@property(nonatomic,weak)UILabel * additionLabel ;
/** 分割线 */
@property(nonatomic,weak)UIView * topLine  ;

@end

@implementation MessageCenterCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView * imgView = [[UIImageView alloc]init];
        self.imgView = imgView;
        [self.contentView  addSubview:imgView];
        
        UILabel * mainTItleLabel = [[UILabel alloc]init];
        mainTItleLabel.font = [UIFont systemFontOfSize:14*self.scaleHeight];
        mainTItleLabel.textColor = [UIColor colorWithRed:51/256.0 green:51/256.0 blue:51/256.0 alpha:1];
        self.mainTitleLabel = mainTItleLabel;
        [self.contentView addSubview:mainTItleLabel];
        
        
        
        UILabel * subTitleLabel = [[UILabel alloc]init];
        self.subTitleLabel = subTitleLabel;
        [self.contentView addSubview:subTitleLabel];
        subTitleLabel.font = [UIFont systemFontOfSize:12*self.scaleHeight];
        subTitleLabel.textColor =     [UIColor colorWithRed:153/256.0 green:153/256.0 blue:153/256.0 alpha:1];
        
        
        UILabel * additionLabel = [[UILabel alloc]init];
        additionLabel.textAlignment = NSTextAlignmentRight;
        self.additionLabel=additionLabel;
        [self.contentView addSubview:additionLabel];
        additionLabel.font = [UIFont systemFontOfSize:12*self.scaleHeight];
        additionLabel.textColor =     [UIColor colorWithRed:153/256.0 green:153/256.0 blue:153/256.0 alpha:1];
        
        
        UIView * topLine = [[UIView alloc]init];
        topLine.backgroundColor = [UIColor colorWithRed:244/256.0 green:244/256.0 blue:244/256.0 alpha:1];
        [self.contentView addSubview:topLine];
        self.topLine = topLine;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.topLine.frame  = CGRectMake(0, 0, self.bounds.size.width, 1);
    
    
    CGFloat horizontalMargin = 10 ;
    CGFloat verticalMargin = 4 ;
    CGFloat imgH = self.bounds.size.height - verticalMargin*2 ;
    CGFloat imgW = imgH;
    self.imgView.frame = CGRectMake(horizontalMargin, verticalMargin, imgW, imgH);

    //除除图片以外的剩余宽度
    CGFloat leftWidth  = self.bounds.size.width  - CGRectGetMaxX(self.imgView.frame);
    CGSize  subTitleLabelSize = [self.subTitleLabel.text sizeWithFont:self.subTitleLabel.font MaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGSize  mainTitleLabelSize = [self.mainTitleLabel.text sizeWithFont:self.mainTitleLabel.font MaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    
    
    if (self.subTitleLabel.text.length>0) {
        
        CGFloat mainW = leftWidth/2 ;
        CGFloat mainH = mainTitleLabelSize.height +verticalMargin;
        CGFloat mainX = CGRectGetMaxX(self.imgView.frame)+horizontalMargin ;
//        CGFloat mainY = CGRectGetMinY(self.imgView.frame) ;
        CGFloat mainY = CGRectGetMinY(self.imgView.frame) + verticalMargin ;

        
        
        self.mainTitleLabel.frame = CGRectMake(mainX    , mainY,mainW,mainH);
        
        CGFloat subW = leftWidth/2 ;
        CGFloat subH = subTitleLabelSize.height +verticalMargin;
        CGFloat subX = CGRectGetMaxX(self.imgView.frame)+horizontalMargin ;
//        CGFloat subY = CGRectGetMaxY(self.imgView.frame) - subH ;
        CGFloat subY = CGRectGetMaxY(self.imgView.frame) - subH  - verticalMargin;
        self.subTitleLabel.frame = CGRectMake(subX, subY, subW, subH);
    }else{
        
        CGFloat mainW = leftWidth/2 ;
        CGFloat mainH = subTitleLabelSize.height +verticalMargin*2;
        CGFloat mainX = CGRectGetMaxX(self.imgView.frame)+horizontalMargin ;
        CGFloat mainY = (self.bounds.size.height - mainH)/2 ;
        self.mainTitleLabel.frame = CGRectMake(mainX    , mainY,mainW,mainH);
    
    }

    CGSize  additionLabelSize = [self.additionLabel.text sizeWithFont:self.additionLabel.font MaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];

    CGFloat additionW = leftWidth/2-horizontalMargin*2 ;
    CGFloat additionH = additionLabelSize.height+verticalMargin ;
    CGFloat additionX = CGRectGetMaxX(self.mainTitleLabel.frame) ;
    CGFloat additionY = CGRectGetMidY(self.mainTitleLabel.frame) -additionH/2 ;
    self.additionLabel.frame = CGRectMake(additionX, additionY, additionW, additionH);
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setCustomCellModel:(NSDictionary *)customCellModel{
    _customCellModel = customCellModel;
    if ([customCellModel isKindOfClass:[NSDictionary class]]) {
        
        
        
        NSString * user = customCellModel[@"other_account"];
        NSString * body = customCellModel[@"last_message"];
        NSString * time = customCellModel[@"time_stamp"];
        if (user.length>0 && ![user isEqualToString:@"null"]) {
            self.mainTitleLabel.text = user;
        }else{
            if ([user isEqualToString:@"kefu"]) {
                self.mainTitleLabel.text =  @"直接捞客服" ;
            }else{
                if ([user hasPrefix:@"z~"]) {
                    self.mainTitleLabel.text = [user stringByReplacingOccurrencesOfString:@"z~" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, 2)];
                }else{
                    self.mainTitleLabel.text = user;
                }
            }
        }
        self.subTitleLabel.text = body;
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setLocale:[NSLocale currentLocale] ];
        
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        self.additionLabel.text =   [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:time.floatValue]];
        
        
        
        if ([user isEqualToString:@"kefu"]) {
            self.imgView.image = [UIImage imageNamed:@"bg_icon_im"];
        }else{
            
            self.imgView.image = [UIImage imageNamed:@"bg_nohead"];
        }
        
        
        
        //        XMPPvCardTempModule * card =[[XMPPvCardTempModule alloc]init];
        //        [card fetchvCardTempForJID:contact.bareJid];
        //        LOG(@"_%@_%d_%@",[self class] , __LINE__,card);
        //        LOG(@"_%@_%d_%@",[self class] , __LINE__,card.);
    }else if ([customCellModel isKindOfClass:[NSString class]]){
        NSString * str = (NSString*)customCellModel;
        if ([str isEqualToString:@"商城公告"]) {
            self.imgView.image = [UIImage imageNamed:@"icon_shang"];
        }else if ([str isEqualToString:@"物流信息"]){
            self.imgView.image = [UIImage imageNamed:@"bg_icon_wu"];
        }else if ([str isEqualToString:@"促销"]){
            self.imgView.image = [UIImage imageNamed:@"icon_activity_msg"];
        }else if ([str isEqualToString:@"活动"]){
            self.imgView.image = [UIImage imageNamed:@"icon_promotion"];
        }
        self.mainTitleLabel.text = str;
        
    }
}

-(void)setCellModel:(MessageCenterCellModel *)cellModel{
    _cellModel = cellModel;//oc特殊对待
    [self.imgView sd_setImageWithURL: [NSURL URLWithString:[NSString stringWithFormat:@"https://i0.zjlao.com/%@",cellModel.imgStr]]
 placeholderImage:nil options:SDWebImageCacheMemoryOnly];

    self.mainTitleLabel.text = cellModel.title ;
    self.subTitleLabel.text = cellModel.content;
    self.additionLabel.text = cellModel.pubtime;
}

-(void)setContact:(XMPPMessageArchiving_Contact_CoreDataObject *)contact{
    _contact = contact;
    if ([contact isKindOfClass:[XMPPMessageArchiving_Contact_CoreDataObject class]]) {

//       XMPPUserCoreDataStorageObject * user =  [[XMPPRosterCoreDataStorage sharedInstance] userForJID:contact.bareJid xmppStream:[GDXmppStreamManager ShareXMPPManager].XmppStream managedObjectContext:nil];
//         NSLog(@"\n\n\n\n\n未读消息数量_%d_%@",__LINE__,user.unreadMessages);

        XMPPvCardTemp * vcard = [[GDXmppStreamManager ShareXMPPManager].xmppvcardtempModule vCardTempForJID:contact.bareJid shouldFetch:YES];
        if (vcard.nickname.length>0 && ![vcard.nickname isEqualToString:@"null"]) {
            self.mainTitleLabel.text = vcard.nickname;
        }else{
            if ([contact.bareJid.user isEqualToString:@"kefu"]) {
                self.mainTitleLabel.text =  @"直接捞客服" ;
            }else{
//                self.mainTitleLabel.text = contact.bareJid.user;
                if ([contact.bareJid.user hasPrefix:@"z~"]) {
                    self.mainTitleLabel.text = [contact.bareJid.user stringByReplacingOccurrencesOfString:@"z~" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, 2)];
                }else{
                    self.mainTitleLabel.text = contact.bareJid.user;
                }

            }
        }
        self.subTitleLabel.text = contact.mostRecentMessageBody;
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setLocale:[NSLocale currentLocale] ];
        
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        self.additionLabel.text =   [dateFormatter stringFromDate:contact.mostRecentMessageTimestamp];
        
        NSData *avatordata = [[GDXmppStreamManager ShareXMPPManager].xmppvcardavatarModule photoDataForJID:contact.bareJid];
        UIImage * image  = [UIImage imageWithData:avatordata];
        
        if ([contact.bareJid.user isEqualToString:@"kefu"]) {
            self.imgView.image = [UIImage imageNamed:@"bg_icon_im"];
        }else{
            
            if (image) {
                
                self.imgView.image = image;
            }else{
                self.imgView.image = [UIImage imageNamed:@"bg_nohead"];
            }
        }
        
        

//        XMPPvCardTempModule * card =[[XMPPvCardTempModule alloc]init];
//        [card fetchvCardTempForJID:contact.bareJid];
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,card);
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,card.);
    }else if ([contact isKindOfClass:[NSString class]]){
        NSString * str = (NSString*)contact;
        if ([str isEqualToString:@"商城公告"]) {
            self.imgView.image = [UIImage imageNamed:@"icon_shang"];
        }else if ([str isEqualToString:@"物流信息"]){
            self.imgView.image = [UIImage imageNamed:@"bg_icon_wu"];
        }else if ([str isEqualToString:@"促销"]){
            self.imgView.image = [UIImage imageNamed:@"icon_activity_msg"];
        }else if ([str isEqualToString:@"活动"]){
            self.imgView.image = [UIImage imageNamed:@"icon_promotion"];
        }
        self.mainTitleLabel.text = str;

    }
   }
@end
