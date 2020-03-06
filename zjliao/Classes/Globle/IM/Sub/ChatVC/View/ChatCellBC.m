//
//  ChatCell.m
//  TTmall
//
//  Created by wangyuanfei on 16/1/21.
//  Copyright © 2016年 Footway tech. All rights reserved.
//
/**
 @property(nonatomic,copy)NSString * txtContent ;
 @property(nonatomic,strong)UIImage * meIcon ;
 @property(nonatomic,strong)UIImage * otherIcon ;
 */
#import "ChatCellBC.h"
#import "ChatModel.h"
#import "GDTextAttachment.h"
#import "XMPPMessageArchiving_Message_CoreDataObject.h"
#import <SDWebImage/SDWebImage-umbrella.h>
#import <SDWebImage/SDWebImageManager.h>
@interface ChatCellBC()

@end

@implementation ChatCellBC

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.maxWidth = [UIScreen mainScreen].bounds.size.width / 3 ;
        self.maxHeight =  self.maxWidth ;
        self.imgFileWidth = self.maxWidth ;
        self.imgFileHeight = self.maxHeight ;
    }
    return  self ;
}
/** 解析属性字符串 */
-(NSAttributedString*)dealTheStr:(NSString*)str labelFont:(UIFont*)font{
    NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:@"/[a-zA-Z]+;" options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSArray * matches = [regex matchesInString:str options:0 range:NSMakeRange(0, str.length)];
    NSMutableAttributedString * attM = [[NSMutableAttributedString alloc]init];
    /** 就这一个地方用 , 就不用三方框架了 , 自己写吧, */
    if (matches.count>0) {
        for (int i = 0 ; i< matches.count; i++) {
            NSTextCheckingResult * result = matches[i];
            NSString * imgName = [str substringWithRange:result.range];
            /** 获取图片名 */
            imgName=  [imgName stringByReplacingOccurrencesOfString:@"/" withString:@""];
            imgName= [imgName stringByReplacingOccurrencesOfString:@";" withString:@""];
            
            /** 创建富文本 */
            GDTextAttachment * tachment = [[GDTextAttachment alloc]init];
            NSString * imgname = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"Resource" ofType:@"bundle"]] pathForResource:imgName ofType:@"gif" inDirectory:@"face_img"];
            UIImage* gif = [UIImage sd_animatedGIFNamed:imgname];
            //            tachment.image = [UIImage imageWithContentsOfFile:gotResourceInSubBundle(imgName, @"gif", @"face_img")];
            tachment.image = gif;
            tachment.bounds = CGRectMake(0, -4, self.textLabel.font.lineHeight, self.textLabel.font.lineHeight);
            NSAttributedString * imgStr = [NSAttributedString attributedStringWithAttachment:tachment];
            
            
            if (i==0) {//第一个
                if (result.range.location==0) {//第一个是表情
                }else{//第一个非表情
                    NSString * sub = [str substringWithRange:NSMakeRange(0, result.range.location)];
                    //                    LOG(@"_%@_%d_%@",[self class] , __LINE__,sub);
                    [attM appendAttributedString:  [ [NSAttributedString alloc] initWithString:sub]];
                }
                [attM appendAttributedString:imgStr];
                if (matches.count==1 && result.range.location + result.range.length < str.length) {
                    NSString * subsub = [str substringFromIndex:result.range.location + result.range.length];
                    [attM appendAttributedString:[ [NSAttributedString alloc] initWithString:subsub]];
                    NSLog(@"_%@_%d_%@",[self class] , __LINE__,subsub);
                }
            }else  if(i < matches.count-1){//中间
                
                NSTextCheckingResult * lastResult = matches[i-1];
                NSString * sub = [str substringWithRange:NSMakeRange(lastResult.range.location+lastResult.range.length, result.range.location-(lastResult.range.location+lastResult.range.length))];
                //                LOG(@"_%@_%d_%@",[self class] , __LINE__,sub);
                [attM appendAttributedString:  [ [NSAttributedString alloc] initWithString:sub]];
                [attM appendAttributedString:imgStr];
                //                    LOG(@"_%@_%d_%@",[self class] , __LINE__,sub);
                
                
                
            }else{
                NSTextCheckingResult * lastResult = matches[i-1];
                NSString * sub = [str substringWithRange:NSMakeRange(lastResult.range.location+lastResult.range.length, result.range.location-(lastResult.range.location+lastResult.range.length))];
                [attM appendAttributedString:  [ [NSAttributedString alloc] initWithString:sub]];
                [attM appendAttributedString:imgStr];
                //                LOG(@"_%@_%d_%@",[self class] , __LINE__,sub);
                if (result.range.location + result.range.length < str.length) {//最后一个是文本
                    NSString * subsub = [str substringFromIndex:result.range.location + result.range.length];
                    [attM appendAttributedString:[ [NSAttributedString alloc] initWithString:subsub]];
                    NSLog(@"_%@_%d_%@",[self class] , __LINE__,subsub);
                }else{//最后一个是表情
                    
                }
                
            }
            
        }
        
    }else {
        NSMutableAttributedString * returnstr  = [[NSMutableAttributedString alloc]initWithString:str] ;
        [returnstr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, returnstr.length)];
        return returnstr;
        
    }
    
    
    
    
    [attM addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attM.length)];
    return attM;
    
    //        return  [[NSMutableAttributedString alloc]initWithString:str];
}

//下载的图片保存到沙盒
- (NSString *)doloadImgSavePathForURL:(NSString *)url toUserName:(NSString *)toUserName
{
    NSString * path = [NSString stringWithFormat:@"Library/Caches/xmppPhoto/%@/",toUserName];
    
    NSString *resourceCacheDir = [NSHomeDirectory() stringByAppendingPathComponent:path];
    if (![[NSFileManager defaultManager] fileExistsAtPath:resourceCacheDir]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:resourceCacheDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString * photoSavePath = [resourceCacheDir stringByAppendingPathComponent:url.lastPathComponent];
    
    return  photoSavePath ;
}
//相册的图片保存到沙盒

- (NSString *)photoSavePathForURL:(NSURL *)url toUserName:(NSString *)toUserName
{
    NSString * path = [NSString stringWithFormat:@"Library/Caches/xmppPhoto/%@/",toUserName];
    
    
    NSString *photoSavePath = nil;
    NSString *urlString = [url absoluteString];//assets-library://asset/asset.JPG?id=B8AF65AA-213B-484B-96F3-CAD73D1DE1F0&ext=JPG
    NSDate * date = [NSDate date];
    NSTimeInterval time =  date.timeIntervalSince1970;
    NSString * theFileName = [NSString stringWithFormat:@"%ld",(NSInteger)time];
    
    //    NSURLComponents * components = [NSURLComponents componentsWithString:urlString];
    //    NSArray * queryItems =  components.queryItems;
    //    for (NSURLQueryItem * item  in queryItems) {
    //        if ([item.name isEqualToString:@"id"]) {
    //            theFileName = [NSString stringWithFormat:@"%@%f",item.value,time];//id当做文件名
    //        }
    //    }
    //    if (!theFileName) {
    //        theFileName = [NSString stringWithFormat:@"%f",time];
    //    }
    //    NSLog(@"_%d_%@",__LINE__,urlString);
    //    NSString * fileNameMD5Str = [theFileName  md5String];//文件名
    NSString *resourceCacheDir = [NSHomeDirectory() stringByAppendingPathComponent:path];
    if (![[NSFileManager defaultManager] fileExistsAtPath:resourceCacheDir]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:resourceCacheDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    photoSavePath = [resourceCacheDir stringByAppendingPathComponent:theFileName];
    NSLog(@"_%d_%@",__LINE__,photoSavePath);
    NSLog(@"_%d_%@",__LINE__,@"asdfaskdf");
    return [photoSavePath stringByAppendingString:@".jpeg"];
    
}


@end























//
//
////
////  ChatCell.m
////  TTmall
////
////  Created by wangyuanfei on 16/1/21.
////  Copyright © 2016年 Footway tech. All rights reserved.
////
///**
// @property(nonatomic,copy)NSString * txtContent ;
// @property(nonatomic,strong)UIImage * meIcon ;
// @property(nonatomic,strong)UIImage * otherIcon ;
// */
//#import "ChatCellBC.h"
//#import "ChatModel.h"
//#import "GDTextAttachment.h"
//#import "XMPPMessageArchiving_Message_CoreDataObject.h"
//@interface ChatCellBC()
//@property(nonatomic,assign)BOOL  isMe ;
//@property(nonatomic,weak)UIImageView * meIconView ;
//@property(nonatomic,weak)UIImageView * otherIconView ;
////@property(nonatomic,weak)UIButton * meContentLabel ;
//
//@property(nonatomic,weak)UILabel * meContentLabel ;
//@property(nonatomic,weak)UILabel * otherContentLabel ;
//@property(nonatomic,weak)UIImageView * meContentBackView ;
//@property(nonatomic,weak)UIImageView * otherContentBackView ;
//@property(nonatomic,weak)UIImageView * meImageView ;
//@property(nonatomic,weak)UILabel * msgTime ;
//@end
//
//@implementation ChatCellBC
//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.backgroundColor= BackgroundGray ;
//        self.selectionStyle=UITableViewCellSelectionStyleNone;
//        UIImageView * meIconView = [[UIImageView alloc]init];
//        //        meIconView.backgroundColor=randomColor;
//        self.meIconView=meIconView;
//        [self.contentView addSubview:meIconView];
//
//
//        UIImageView * otherIconView = [[UIImageView alloc]init];
//        //        otherIconView.backgroundColor=randomColor;
//        self.otherIconView=otherIconView;
//        [self.contentView addSubview:otherIconView];
//
//
//        UIImageView * meContentBackView = [[UIImageView alloc]init];
//        meContentBackView.image=[UIImage imageNamed:@"bg_icon_ss"];
//        //        meContentBackView.backgroundColor=[UIColor colorWithRed:94/255.0 green:254/255.0 blue:123/255.0 alpha:0.5];
//        self.meContentBackView=meContentBackView;
//        [self.contentView addSubview:self.meContentBackView];
//
//
//        UIImageView * otherContentBackView = [[UIImageView alloc]init];
//        otherContentBackView.image = [UIImage imageNamed:@"bg_icon_aa"];
//        //        otherContentBackView.backgroundColor=[UIColor colorWithRed:100/255.0 green:200/255.0 blue:223/255.0 alpha:0.5];
//        self.otherContentBackView=otherContentBackView;
//        [self.contentView addSubview:self.otherContentBackView];
//
//        //
//        //        UILabel * meContentLabel = [[UILabel alloc]init];
//        //        meContentLabel.numberOfLines=0;
//        //        self.meContentLabel = meContentLabel;
//        //        [self.contentView addSubview:meContentLabel];
//        //
//
//
//        UILabel * meContentLabel = [[UILabel alloc]init];
//        //        [meContentLabel setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
//        meContentLabel.textColor = [UIColor purpleColor];
//        meContentLabel.numberOfLines=0;
//        //        meContentLabel.numberOfLines=0;
//        self.meContentLabel = meContentLabel;
//        [self.contentView addSubview:meContentLabel];
//
//
//
//        UILabel * otherContentLabel = [[UILabel alloc]init];
//        otherContentLabel.numberOfLines=0;
//        otherContentLabel.textColor = MainTextColor;
//        self.otherContentLabel = otherContentLabel;
//        [self.contentView addSubview:otherContentLabel];
//
//
//        //        UILabel * msgTime = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 19, 200)];
//        //        [self.contentView  addSubview:msgTime];
//        //        self.msgTime = msgTime;
//        //        msgTime.textAlignment = NSTextAlignmentCenter;
//        //        msgTime.backgroundColor = randomColor;
//        //        msgTime.textColor = SubTextColor;
//
//
//    }
//    return self;
//}
//- (void)awakeFromNib {
//    // Initialization code
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}
//
//-(void)setIsMe:(BOOL)isMe{
//    _isMe=isMe;
//
//    self.meIconView.image=[UIImage imageNamed:@"bg_collocation"];
//    if (isMe) {
//        //我的布局
//        //        [self.meIconView removeConstraints:self.meIconView.constraints];
//        //        [self.contentLabel removeConstraints:self.contentLabel.constraints];
//        //        [self.contentBackView removeConstraints:self.contentBackView.constraints];
//        //        [self.contentView removeConstraints:self.contentView.constraints];
//
//
//
//        [self.meIconView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.contentView).offset(-10);
//            make.top.equalTo(self.contentView).offset(10);
//            make.width.height.equalTo(@(30));
//        }];
//
//
//        [self.meContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.meIconView.mas_left).offset(-20);
//            make.top.equalTo(self.meIconView).offset(10);
//            make.left.greaterThanOrEqualTo(self.contentView).offset(24);
//
//        }];
//
//        [self.meContentBackView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.left.equalTo(self.meContentLabel).offset(-10);
//            make.right.bottom.equalTo(self.meContentLabel).offset(10);
//        }];
//
//        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.meContentBackView).offset(10);
//            make.left.right.equalTo(self);
//        }];
//
//        [self.msgTime mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.equalTo(@(screenW/2));
//            make.height.equalTo(@(20));
//            make.bottom.equalTo(self.meContentBackView.mas_top);
//            make.centerX.equalTo(self.contentView.mas_centerX);
//        }];
//
//    }else{
//
//#pragma mark         别人的布局
//        self.otherIconView.image=[UIImage imageNamed:@"bg_franchise"];
//
//        [self.otherIconView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.contentView).offset(10);
//            make.top.equalTo(self.contentView).offset(10);
//            make.width.height.equalTo(@(30));
//        }];
//
//        [self.otherContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.otherIconView.mas_right).offset(25);
//            make.top.equalTo(self.otherIconView).offset(10);
//            //            make.right.equalTo(self.contentView).offset(-70);
//            make.right.lessThanOrEqualTo(self.contentView).offset(-24);
//        }];
//
//        [self.otherContentBackView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.otherContentLabel).offset(-10);
//            make.left.equalTo(self.otherContentLabel).offset(-19);
//            make.bottom.right.equalTo(self.otherContentLabel).offset(10);
//        }];
//
//        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.otherContentBackView).offset(10);
//            make.left.equalTo(self);
//            make.right.equalTo(self);
//        }];
//
//
//        [self.msgTime mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.equalTo(@(screenW/2));
//            make.height.equalTo(@(20));
//            make.bottom.equalTo(self.otherContentBackView.mas_top);
//            make.centerX.equalTo(self.contentView.mas_centerX);
//        }];
//
//    }
//
//
//
//}
//
//-(void)setChatMessageModel:(XMPPMessageArchiving_Message_CoreDataObject *)chatMessageModel{
//    _chatMessageModel  = chatMessageModel;
//
//    //    LOG(@"_%@_%d_--------------==========-----------%d",[self class] , __LINE__,chatMessageModel.isComposing);
//    //    LOG(@"_%@_%d_%@",[self class] , __LINE__,[chatMessageModel.timestamp.description formatterDateStringToMinute]);
//    self.isMe=chatMessageModel.isOutgoing;
//    if (self.isMe) {
//        self.otherIconView.hidden=YES;
//        self.otherContentLabel.hidden=YES;
//        self.otherContentBackView.hidden=YES;
//        self.meIconView.hidden=NO;
//        self.meContentLabel.hidden=NO;
//        self.meContentBackView.hidden=NO;
//        //        self.meIconView.image=chatModel.icon;
//        if (chatMessageModel.body.length>0) {
//
//            //            [self.meContentLabel setTitle:chatMessageModel.body forState:UIControlStateNormal ];
//            self.meContentLabel.attributedText = [self  dealTheStr:chatMessageModel.body];
//        }
//        //        if (chatModel.meImage) {
//        //            UIImage * img = chatModel.meImage;
//        //            CGSize size = img.size;
//        //            CGFloat w = 64 ;
//        //            CGFloat h = w * size.height /size.width;
//        //            [self.meContentLabel setImage:chatModel.meImage forState:UIControlStateNormal];
//        //            [self.meContentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//        //                make.width.equalTo(@(w));
//        //                make.height.equalTo(@(h));
//        //            }];
//        //        }
//        //        NSString * time = [chatMessageModel.timestamp.description formatterDateStringToMinute];
//        //        LOG(@"_%@_%d_%@",[self class] , __LINE__,time);
//        //        LOG(@"_%@_%d_%@",[self class] , __LINE__,self.msgTime);
//        //        if (time) {
//        //            self.msgTime.hidden = NO ;
//        //            self.msgTime.text = time;
//        //        }else{
//        //            self.msgTime.hidden = YES;
//        //        }
//        //
//
//    }else{
//        self.otherIconView.hidden=NO;
//        self.otherContentLabel.hidden=NO;
//        self.otherContentBackView.hidden=NO;
//        self.meIconView.hidden=YES;
//        self.meContentLabel.hidden=YES;
//        self.meContentBackView.hidden=YES;
//        //    self.otherIconView.image=chatModel.icon;
//        //        self.otherContentLabel.text=chatMessageModel.body;
//        self.otherContentLabel.attributedText = [self dealTheStr:chatMessageModel.body  ];
//
//        //        NSString * time = [chatMessageModel.timestamp.description formatterDateStringToMinute];
//        //        LOG(@"_%@_%d_%@",[self class] , __LINE__,time);
//        //        LOG(@"_%@_%d_%@",[self class] , __LINE__,self.msgTime);
//        //        if (time) {
//        //            self.msgTime.hidden = NO ;
//        //            self.msgTime.text = time;
//        //        }else{
//        //            self.msgTime.hidden = YES;
//        //        }
//
//    }
//
//
//
//}
//
//
///** 解析属性字符串 */
//-(NSAttributedString*)dealTheStr:(NSString*)str
//{
//    NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:@"/[a-zA-Z]+;" options:NSRegularExpressionCaseInsensitive error:nil];
//
//    NSArray * matches = [regex matchesInString:str options:0 range:NSMakeRange(0, str.length)];
//    NSMutableAttributedString * attM = [[NSMutableAttributedString alloc]init];
//    /** 就这一个地方用 , 就不用三方框架了 , 自己写吧, */
//    if (matches.count>0) {
//        for (int i = 0 ; i< matches.count; i++) {
//            NSTextCheckingResult * result = matches[i];
//            NSString * imgName = [str substringWithRange:result.range];
//            /** 获取图片名 */
//            imgName=  [imgName stringByReplacingOccurrencesOfString:@"/" withString:@""];
//            imgName= [imgName stringByReplacingOccurrencesOfString:@";" withString:@""];
//
//            /** 创建富文本 */
//            GDTextAttachment * tachment = [[GDTextAttachment alloc]init];
//            UIImage* gif = [UIImage sd_animatedGIFNamed:gotResourceInSubBundle(imgName, @"gif", @"face_img")];
//            //            tachment.image = [UIImage imageWithContentsOfFile:gotResourceInSubBundle(imgName, @"gif", @"face_img")];
//            tachment.image = gif;
//            tachment.bounds = CGRectMake(0, -4, self.textLabel.font.lineHeight, self.textLabel.font.lineHeight);
//            NSAttributedString * imgStr = [NSAttributedString attributedStringWithAttachment:tachment];
//
//
//            if (i==0) {//第一个
//                if (result.range.location==0) {//第一个是表情
//                }else{//第一个非表情
//                    NSString * sub = [str substringWithRange:NSMakeRange(0, result.range.location)];
//                    //                    LOG(@"_%@_%d_%@",[self class] , __LINE__,sub);
//                    [attM appendAttributedString:  [ [NSAttributedString alloc] initWithString:sub]];
//                }
//                [attM appendAttributedString:imgStr];
//                if (matches.count==1 && result.range.location + result.range.length < str.length) {
//                    NSString * subsub = [str substringFromIndex:result.range.location + result.range.length];
//                    [attM appendAttributedString:[ [NSAttributedString alloc] initWithString:subsub]];
//                    LOG(@"_%@_%d_%@",[self class] , __LINE__,subsub);
//                }
//            }else  if(i < matches.count-1){//中间
//
//                NSTextCheckingResult * lastResult = matches[i-1];
//                NSString * sub = [str substringWithRange:NSMakeRange(lastResult.range.location+lastResult.range.length, result.range.location-(lastResult.range.location+lastResult.range.length))];
//                //                LOG(@"_%@_%d_%@",[self class] , __LINE__,sub);
//                [attM appendAttributedString:  [ [NSAttributedString alloc] initWithString:sub]];
//                [attM appendAttributedString:imgStr];
//                //                    LOG(@"_%@_%d_%@",[self class] , __LINE__,sub);
//
//
//
//            }else{
//                NSTextCheckingResult * lastResult = matches[i-1];
//                NSString * sub = [str substringWithRange:NSMakeRange(lastResult.range.location+lastResult.range.length, result.range.location-(lastResult.range.location+lastResult.range.length))];
//                [attM appendAttributedString:  [ [NSAttributedString alloc] initWithString:sub]];
//                [attM appendAttributedString:imgStr];
//                //                LOG(@"_%@_%d_%@",[self class] , __LINE__,sub);
//                if (result.range.location + result.range.length < str.length) {//最后一个是文本
//                    NSString * subsub = [str substringFromIndex:result.range.location + result.range.length];
//                    [attM appendAttributedString:[ [NSAttributedString alloc] initWithString:subsub]];
//                    LOG(@"_%@_%d_%@",[self class] , __LINE__,subsub);
//                }else{//最后一个是表情
//
//                }
//
//            }
//
//        }
//
//    }else {
//        NSMutableAttributedString * returnstr  = [[NSMutableAttributedString alloc]initWithString:str] ;
//        [returnstr addAttribute:NSFontAttributeName value:self.meContentLabel.font range:NSMakeRange(0, returnstr.length)];
//        return returnstr;
//
//    }
//
//
//
//
//    [attM addAttribute:NSFontAttributeName value:self.meContentLabel.font range:NSMakeRange(0, attM.length)];
//    return attM;
//
//    //    return  [[NSMutableAttributedString alloc]initWithString:str];
//}
//
//
//-(void)setLeftImg:(UIImage *)leftImg{
//    _leftImg = leftImg;
//    //    LOG(@"_%@_%d_%@",[self class] , __LINE__,leftImg);
//    if (leftImg) {
//
//        self.otherIconView.image = leftImg;
//    }else{
//        self.otherIconView.image = [UIImage imageNamed:@"bg_nohead"];
//    }
//}
//-(void)setRightImg:(UIImage *)rightImg{
//    _rightImg = rightImg;
//    //    LOG(@"_%@_%d_%@",[self class] , __LINE__,rightImg);
//    if (rightImg) {
//        self.meIconView.image = rightImg;
//    }else{
//        self.meIconView.image = [UIImage imageNamed:@"bg_nohead"];
//    }
//}
////-(void)setChatModel:(ChatModel *)chatModel{
////    _chatModel=chatModel;
////    self.isMe=chatModel.isMe;
////    if (self.isMe) {
////        self.otherIconView.hidden=YES;
////        self.otherContentLabel.hidden=YES;
////        self.otherContentBackView.hidden=YES;
////        self.meIconView.hidden=NO;
////        self.meContentLabel.hidden=NO;
////        self.meContentBackView.hidden=NO;
//////        self.meIconView.image=chatModel.icon;
////        if (chatModel.txtContent.length>0) {
////
//////            [self.meContentLabel setTitle:chatModel.txtContent forState:UIControlStateNormal ];
////            self.meContentLabel.text = chatModel.txtContent;
////        }
////        if (chatModel.meImage) {
////            UIImage * img = chatModel.meImage;
////            CGSize size = img.size;
////            CGFloat w = 64 ;
////            CGFloat h = w * size.height /size.width;
//////            [self.meContentLabel setImage:chatModel.meImage forState:UIControlStateNormal];
////            self.meIconView.image = chatModel.meImage;
////            [self.meContentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
////                make.width.equalTo(@(w));
////                make.height.equalTo(@(h));
////            }];
////        }
////
////
////    }else{
////        self.otherIconView.hidden=NO;
////        self.otherContentLabel.hidden=NO;
////        self.otherContentBackView.hidden=NO;
////        self.meIconView.hidden=YES;
////        self.meContentLabel.hidden=YES;
////        self.meContentBackView.hidden=YES;
//////    self.otherIconView.image=chatModel.icon;
////    self.otherContentLabel.text=chatModel.txtContent;
////
////
////    }
////}
////-(void)layoutSubviews{
////    [super layoutSubviews];
////    if (self.msgTime.text) {
////        self.msgTime.hidden = NO;
////    }else{
////        self.msgTime.hidden = YES ;
////    }
////
////}
//
//@end






















































////
////  ChatCell.m
////  TTmall
////
////  Created by wangyuanfei on 16/1/21.
////  Copyright © 2016年 Footway tech. All rights reserved.
////
///**
// @property(nonatomic,copy)NSString * txtContent ;
// @property(nonatomic,strong)UIImage * meIcon ;
// @property(nonatomic,strong)UIImage * otherIcon ;
// */
//#import "ChatCellBC.h"
//#import "ChatModel.h"
//#import "GDTextAttachment.h"
//#import "XMPPMessageArchiving_Message_CoreDataObject.h"
//@interface ChatCellBC()
//@property(nonatomic,assign)BOOL  isMe ;
//@property(nonatomic,weak)UIImageView * meIconView ;
//@property(nonatomic,weak)UIImageView * otherIconView ;
////@property(nonatomic,weak)UIButton * meContentLabel ;
//
//@property(nonatomic,weak)UILabel * meContentLabel ;
//@property(nonatomic,weak)UILabel * otherContentLabel ;
//@property(nonatomic,weak)UIImageView * meContentBackView ;
//@property(nonatomic,weak)UIImageView * otherContentBackView ;
//@property(nonatomic,weak)UIImageView * meImageView ;
//@property(nonatomic,weak)UILabel * msgTime ;
//@end
//
//@implementation ChatCellBC
//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.backgroundColor= BackgroundGray ;
//        self.selectionStyle=UITableViewCellSelectionStyleNone;
//        UIImageView * meIconView = [[UIImageView alloc]init];
////        meIconView.backgroundColor=randomColor;
//        self.meIconView=meIconView;
//        [self.contentView addSubview:meIconView];
//        
//        
//        UIImageView * otherIconView = [[UIImageView alloc]init];
////        otherIconView.backgroundColor=randomColor;
//        self.otherIconView=otherIconView;
//        [self.contentView addSubview:otherIconView];
//        
//        
//        UIImageView * meContentBackView = [[UIImageView alloc]init];
//        meContentBackView.image=[UIImage imageNamed:@"bg_icon_ss"];
////        meContentBackView.backgroundColor=[UIColor colorWithRed:94/255.0 green:254/255.0 blue:123/255.0 alpha:0.5];
//        self.meContentBackView=meContentBackView;
//        [self.contentView addSubview:self.meContentBackView];
//        
//        
//        UIImageView * otherContentBackView = [[UIImageView alloc]init];
//        otherContentBackView.image = [UIImage imageNamed:@"bg_icon_aa"];
////        otherContentBackView.backgroundColor=[UIColor colorWithRed:100/255.0 green:200/255.0 blue:223/255.0 alpha:0.5];
//        self.otherContentBackView=otherContentBackView;
//        [self.contentView addSubview:self.otherContentBackView];
//        
////        
////        UILabel * meContentLabel = [[UILabel alloc]init];
////        meContentLabel.numberOfLines=0;
////        self.meContentLabel = meContentLabel;
////        [self.contentView addSubview:meContentLabel];
////        
//
//        
//        UILabel * meContentLabel = [[UILabel alloc]init];
////        [meContentLabel setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
//        meContentLabel.textColor = [UIColor purpleColor];
//        meContentLabel.numberOfLines=0;
////        meContentLabel.numberOfLines=0;
//        self.meContentLabel = meContentLabel;
//        [self.contentView addSubview:meContentLabel];
//        
//        
//        
//        UILabel * otherContentLabel = [[UILabel alloc]init];
//        otherContentLabel.numberOfLines=0;
//        otherContentLabel.textColor = MainTextColor;
//        self.otherContentLabel = otherContentLabel;
//        [self.contentView addSubview:otherContentLabel];
//        
//        
////        UILabel * msgTime = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 19, 200)];
////        [self.contentView  addSubview:msgTime];
////        self.msgTime = msgTime;
////        msgTime.textAlignment = NSTextAlignmentCenter;
////        msgTime.backgroundColor = randomColor;
////        msgTime.textColor = SubTextColor;
//        
//
//    }
//    return self;
//}
//- (void)awakeFromNib {
//    // Initialization code
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}
//
//-(void)setIsMe:(BOOL)isMe{
//    _isMe=isMe;
//    
//    self.meIconView.image=[UIImage imageNamed:@"bg_collocation"];
//    if (isMe) {
//        //我的布局
////        [self.meIconView removeConstraints:self.meIconView.constraints];
////        [self.contentLabel removeConstraints:self.contentLabel.constraints];
////        [self.contentBackView removeConstraints:self.contentBackView.constraints];
////        [self.contentView removeConstraints:self.contentView.constraints];
//        
//        
//        
//        [self.meIconView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.contentView).offset(-10);
//            make.top.equalTo(self.contentView).offset(10);
//            make.width.height.equalTo(@(30));
//        }];
//        
//        
//        [self.meContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.meIconView.mas_left).offset(-20);
//            make.top.equalTo(self.meIconView).offset(10);
//            make.left.greaterThanOrEqualTo(self.contentView).offset(24);
//            
//        }];
//        
//        [self.meContentBackView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.left.equalTo(self.meContentLabel).offset(-10);
//            make.right.bottom.equalTo(self.meContentLabel).offset(10);
//        }];
//
//        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.meContentBackView).offset(10);
//            make.left.right.equalTo(self);
//        }];
//        
//        [self.msgTime mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.equalTo(@(screenW/2));
//            make.height.equalTo(@(20));
//            make.bottom.equalTo(self.meContentBackView.mas_top);
//            make.centerX.equalTo(self.contentView.mas_centerX);
//        }];
//        
//    }else{
//
//#pragma mark         别人的布局
//        self.otherIconView.image=[UIImage imageNamed:@"bg_franchise"];
//        
//        [self.otherIconView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.contentView).offset(10);
//            make.top.equalTo(self.contentView).offset(10);
//            make.width.height.equalTo(@(30));
//        }];
//        
//        [self.otherContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.otherIconView.mas_right).offset(25);
//            make.top.equalTo(self.otherIconView).offset(10);
//            //            make.right.equalTo(self.contentView).offset(-70);
//            make.right.lessThanOrEqualTo(self.contentView).offset(-24);
//        }];
//        
//        [self.otherContentBackView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.otherContentLabel).offset(-10);
//            make.left.equalTo(self.otherContentLabel).offset(-19);
//            make.bottom.right.equalTo(self.otherContentLabel).offset(10);
//        }];
//        
//        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.otherContentBackView).offset(10);
//            make.left.equalTo(self);
//            make.right.equalTo(self);
//        }];
//        
//        
//        [self.msgTime mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.equalTo(@(screenW/2));
//            make.height.equalTo(@(20));
//            make.bottom.equalTo(self.otherContentBackView.mas_top);
//            make.centerX.equalTo(self.contentView.mas_centerX);
//        }];
//        
//    }
//    
//    
//
//}
//
//-(void)setChatMessageModel:(XMPPMessageArchiving_Message_CoreDataObject *)chatMessageModel{
//    _chatMessageModel  = chatMessageModel;
//    
////    LOG(@"_%@_%d_--------------==========-----------%d",[self class] , __LINE__,chatMessageModel.isComposing);
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,[chatMessageModel.timestamp.description formatterDateStringToMinute]);
//    self.isMe=chatMessageModel.isOutgoing;
//    if (self.isMe) {
//        self.otherIconView.hidden=YES;
//        self.otherContentLabel.hidden=YES;
//        self.otherContentBackView.hidden=YES;
//        self.meIconView.hidden=NO;
//        self.meContentLabel.hidden=NO;
//        self.meContentBackView.hidden=NO;
//        //        self.meIconView.image=chatModel.icon;
//        if (chatMessageModel.body.length>0) {
//            
////            [self.meContentLabel setTitle:chatMessageModel.body forState:UIControlStateNormal ];
//            self.meContentLabel.attributedText = [self  dealTheStr:chatMessageModel.body];
//        }
////        if (chatModel.meImage) {
////            UIImage * img = chatModel.meImage;
////            CGSize size = img.size;
////            CGFloat w = 64 ;
////            CGFloat h = w * size.height /size.width;
////            [self.meContentLabel setImage:chatModel.meImage forState:UIControlStateNormal];
////            [self.meContentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
////                make.width.equalTo(@(w));
////                make.height.equalTo(@(h));
////            }];
////        }
////        NSString * time = [chatMessageModel.timestamp.description formatterDateStringToMinute];
////        LOG(@"_%@_%d_%@",[self class] , __LINE__,time);
////        LOG(@"_%@_%d_%@",[self class] , __LINE__,self.msgTime);
////        if (time) {
////            self.msgTime.hidden = NO ;
////            self.msgTime.text = time;
////        }else{
////            self.msgTime.hidden = YES;
////        }
////
//        
//    }else{
//        self.otherIconView.hidden=NO;
//        self.otherContentLabel.hidden=NO;
//        self.otherContentBackView.hidden=NO;
//        self.meIconView.hidden=YES;
//        self.meContentLabel.hidden=YES;
//        self.meContentBackView.hidden=YES;
//        //    self.otherIconView.image=chatModel.icon;
////        self.otherContentLabel.text=chatMessageModel.body;
//        self.otherContentLabel.attributedText = [self dealTheStr:chatMessageModel.body  ];
//
////        NSString * time = [chatMessageModel.timestamp.description formatterDateStringToMinute];
////        LOG(@"_%@_%d_%@",[self class] , __LINE__,time);
////        LOG(@"_%@_%d_%@",[self class] , __LINE__,self.msgTime);
////        if (time) {
////            self.msgTime.hidden = NO ;
////            self.msgTime.text = time;
////        }else{
////            self.msgTime.hidden = YES;
////        }
//    
//    }
//
//
//
//}
//
//
///** 解析属性字符串 */
//-(NSAttributedString*)dealTheStr:(NSString*)str
//{
//    NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:@"/[a-zA-Z]+;" options:NSRegularExpressionCaseInsensitive error:nil];
//    
//    NSArray * matches = [regex matchesInString:str options:0 range:NSMakeRange(0, str.length)];
//    NSMutableAttributedString * attM = [[NSMutableAttributedString alloc]init];
//    /** 就这一个地方用 , 就不用三方框架了 , 自己写吧, */
//    if (matches.count>0) {
//        for (int i = 0 ; i< matches.count; i++) {
//            NSTextCheckingResult * result = matches[i];
//            NSString * imgName = [str substringWithRange:result.range];
//            /** 获取图片名 */
//            imgName=  [imgName stringByReplacingOccurrencesOfString:@"/" withString:@""];
//            imgName= [imgName stringByReplacingOccurrencesOfString:@";" withString:@""];
//            
//            /** 创建富文本 */
//            GDTextAttachment * tachment = [[GDTextAttachment alloc]init];
//            UIImage* gif = [UIImage sd_animatedGIFNamed:gotResourceInSubBundle(imgName, @"gif", @"face_img")];
////            tachment.image = [UIImage imageWithContentsOfFile:gotResourceInSubBundle(imgName, @"gif", @"face_img")];
//            tachment.image = gif;
//            tachment.bounds = CGRectMake(0, -4, self.textLabel.font.lineHeight, self.textLabel.font.lineHeight);
//            NSAttributedString * imgStr = [NSAttributedString attributedStringWithAttachment:tachment];
//            
//            
//            if (i==0) {//第一个
//                if (result.range.location==0) {//第一个是表情
//                }else{//第一个非表情
//                    NSString * sub = [str substringWithRange:NSMakeRange(0, result.range.location)];
////                    LOG(@"_%@_%d_%@",[self class] , __LINE__,sub);
//                    [attM appendAttributedString:  [ [NSAttributedString alloc] initWithString:sub]];
//                }
//                [attM appendAttributedString:imgStr];
//                if (matches.count==1 && result.range.location + result.range.length < str.length) {
//                    NSString * subsub = [str substringFromIndex:result.range.location + result.range.length];
//                    [attM appendAttributedString:[ [NSAttributedString alloc] initWithString:subsub]];
//                    LOG(@"_%@_%d_%@",[self class] , __LINE__,subsub);
//                }
//            }else  if(i < matches.count-1){//中间
//
//                    NSTextCheckingResult * lastResult = matches[i-1];
//                    NSString * sub = [str substringWithRange:NSMakeRange(lastResult.range.location+lastResult.range.length, result.range.location-(lastResult.range.location+lastResult.range.length))];
////                LOG(@"_%@_%d_%@",[self class] , __LINE__,sub);
//                    [attM appendAttributedString:  [ [NSAttributedString alloc] initWithString:sub]];
//                    [attM appendAttributedString:imgStr];
////                    LOG(@"_%@_%d_%@",[self class] , __LINE__,sub);
//                
//                
//
//            }else{
//                NSTextCheckingResult * lastResult = matches[i-1];
//                NSString * sub = [str substringWithRange:NSMakeRange(lastResult.range.location+lastResult.range.length, result.range.location-(lastResult.range.location+lastResult.range.length))];
//                [attM appendAttributedString:  [ [NSAttributedString alloc] initWithString:sub]];
//                [attM appendAttributedString:imgStr];
////                LOG(@"_%@_%d_%@",[self class] , __LINE__,sub);
//                if (result.range.location + result.range.length < str.length) {//最后一个是文本
//                    NSString * subsub = [str substringFromIndex:result.range.location + result.range.length];
//                    [attM appendAttributedString:[ [NSAttributedString alloc] initWithString:subsub]];
//                    LOG(@"_%@_%d_%@",[self class] , __LINE__,subsub);
//                }else{//最后一个是表情
//
//                }
//            
//            }
//
//        }
//        
//    }else {
//        NSMutableAttributedString * returnstr  = [[NSMutableAttributedString alloc]initWithString:str] ;
//        [returnstr addAttribute:NSFontAttributeName value:self.meContentLabel.font range:NSMakeRange(0, returnstr.length)];
//        return returnstr;
//        
//    }
//    
//    
//    
//    
//    [attM addAttribute:NSFontAttributeName value:self.meContentLabel.font range:NSMakeRange(0, attM.length)];
//    return attM;
//    
////    return  [[NSMutableAttributedString alloc]initWithString:str];
//}
//
//
//-(void)setLeftImg:(UIImage *)leftImg{
//    _leftImg = leftImg;
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,leftImg);
//    if (leftImg) {
//        
//        self.otherIconView.image = leftImg;
//    }else{
//        self.otherIconView.image = [UIImage imageNamed:@"bg_nohead"];
//    }
//}
//-(void)setRightImg:(UIImage *)rightImg{
//    _rightImg = rightImg;
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,rightImg);
//    if (rightImg) {
//        self.meIconView.image = rightImg;
//    }else{
//        self.meIconView.image = [UIImage imageNamed:@"bg_nohead"];
//    }
//}
////-(void)setChatModel:(ChatModel *)chatModel{
////    _chatModel=chatModel;
////    self.isMe=chatModel.isMe;
////    if (self.isMe) {
////        self.otherIconView.hidden=YES;
////        self.otherContentLabel.hidden=YES;
////        self.otherContentBackView.hidden=YES;
////        self.meIconView.hidden=NO;
////        self.meContentLabel.hidden=NO;
////        self.meContentBackView.hidden=NO;
//////        self.meIconView.image=chatModel.icon;
////        if (chatModel.txtContent.length>0) {
////            
//////            [self.meContentLabel setTitle:chatModel.txtContent forState:UIControlStateNormal ];
////            self.meContentLabel.text = chatModel.txtContent;
////        }
////        if (chatModel.meImage) {
////            UIImage * img = chatModel.meImage;
////            CGSize size = img.size;
////            CGFloat w = 64 ;
////            CGFloat h = w * size.height /size.width;
//////            [self.meContentLabel setImage:chatModel.meImage forState:UIControlStateNormal];
////            self.meIconView.image = chatModel.meImage;
////            [self.meContentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
////                make.width.equalTo(@(w));
////                make.height.equalTo(@(h));
////            }];
////        }
////
////        
////    }else{
////        self.otherIconView.hidden=NO;
////        self.otherContentLabel.hidden=NO;
////        self.otherContentBackView.hidden=NO;
////        self.meIconView.hidden=YES;
////        self.meContentLabel.hidden=YES;
////        self.meContentBackView.hidden=YES;
//////    self.otherIconView.image=chatModel.icon;
////    self.otherContentLabel.text=chatModel.txtContent;
////        
////        
////    }
////}
////-(void)layoutSubviews{
////    [super layoutSubviews];
////    if (self.msgTime.text) {
////        self.msgTime.hidden = NO;
////    }else{
////        self.msgTime.hidden = YES ;
////    }
////
////}
//
//@end
