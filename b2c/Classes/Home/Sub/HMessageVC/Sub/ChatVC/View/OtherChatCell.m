//
//  OtherChatCell.m
//  b2c
//
//  Created by wangyuanfei on 16/8/1.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "OtherChatCell.h"

#import "XMPPMessageArchiving_Message_CoreDataObject.h"
#import "GDTextAttachment.h"
#import "NSString+Hash.h"
#import "CaculateManager.h"
#import "GDXmppStreamManager.h"
#import "GDPicturnPreview.h"

@interface OtherChatCell ()

@property(nonatomic,weak)UIImageView * otherIconView ;

@property(nonatomic,weak)UILabel * otherContentLabel ;
@property(nonatomic,weak)UIImageView * otherContentBackView ;


@property(nonatomic,weak)UIImageView * imgFileView ;
@end


@implementation OtherChatCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor= BackgroundGray ;
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        
        UIImageView * otherIconView = [[UIImageView alloc]init];
        //        otherIconView.backgroundColor=randomColor;
        self.otherIconView=otherIconView;
        [self.contentView addSubview:otherIconView];
        
        
        
        UIImageView * otherContentBackView = [[UIImageView alloc]init];
        otherContentBackView.userInteractionEnabled = YES ;
        otherContentBackView.image = [UIImage imageNamed:@"bg_icon_aa"];
        //        otherContentBackView.backgroundColor=[UIColor colorWithRed:100/255.0 green:200/255.0 blue:223/255.0 alpha:0.5];
        self.otherContentBackView=otherContentBackView;
        [self.contentView addSubview:self.otherContentBackView];
        
        
        
        UILabel * otherContentLabel = [[UILabel alloc]init];
        otherContentLabel.numberOfLines=0;
        otherContentLabel.font = [UIFont systemFontOfSize:15];
        otherContentLabel.textColor = MainTextColor;
        self.otherContentLabel = otherContentLabel;
        [self.contentView addSubview:otherContentLabel];
        
        
        UIImageView *  imgFileView = [[UIImageView alloc] init];
        self.imgFileView = imgFileView ;
        [self.contentView  addSubview:imgFileView];
        imgFileView.userInteractionEnabled = YES ;

        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(picureTap)];
        [imgFileView addGestureRecognizer:tap];
        
        
        
        //        UILabel * msgTime = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 19, 200)];
        //        [self.contentView  addSubview:msgTime];
        //        self.msgTime = msgTime;
        //        msgTime.textAlignment = NSTextAlignmentCenter;
        //        msgTime.backgroundColor = randomColor;
        //        msgTime.textColor = SubTextColor;
        
        //        self.otherIconView.image=[UIImage imageNamed:@"bg_franchise"];
        
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
        //            make.bottom.equalTo(self.otherContentLabel).offset(20);
        //            make.left.equalTo(self);
        //            make.right.equalTo(self);
        //        }];
        
        
        
        
        
    }
    return self;
}
-(void)picureTap
{
    NSLog(@"_%d_%@",__LINE__,@"点点点");
    GDPicturnPreview * preview = [[GDPicturnPreview alloc] init];
    NSLog(@"_%d_%@",__LINE__,self.imgPath);
    preview.filePath = self.imgPath ;
    [preview showInView:self];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    if ([self.chatMessageModel.body hasPrefix:@"img:"]|| [self.chatMessageModel.body hasPrefix:@"Img:"]||[self.chatMessageModel.body hasPrefix:@"IMG:"]) {
        self.imgFileView.hidden = NO ;
        self.textLabel.hidden = YES ;
        self.imgFileView.backgroundColor = [UIColor clearColor];
        
        
        CGFloat margin = 10 ;
        self.otherIconView.frame  = CGRectMake(margin, margin, 30, 30);
        
        CGFloat realWidth = self.imgFileWidth +20;
        CGFloat realHeight = self.imgFileHeight + 20 ;
        CGFloat imgFileX = CGRectGetMaxX(self.otherIconView.frame) + 25 ;
        CGFloat imgFileY = CGRectGetMinY(self.otherIconView.frame) ;
        self.imgFileView.frame = CGRectMake(imgFileX, imgFileY, self.imgFileWidth, self.imgFileHeight);
        
        //    CGFloat H =
        self.otherContentBackView.frame = CGRectMake(CGRectGetMinX(self.imgFileView.frame)  - 13, CGRectGetMinY(self.imgFileView.frame) - 10, self.imgFileWidth + margin*2, self.imgFileHeight + margin * 2 ) ;
    }else{
        self.imgFileView.hidden = YES ;
        self.textLabel.hidden = NO  ;
        CGFloat margin = 10 ;
        self.otherIconView.frame  = CGRectMake(margin, margin, 30, 30);
        CGFloat labelX = CGRectGetMaxX(self.otherIconView.frame) + 25 ;
        CGFloat labelY =  CGRectGetMinY(self.otherIconView.frame) ;
        
        CGFloat realWidth = [self.chatMessageModel.body stringSizeWithFont:15].width +20;
        CGFloat labelW = screenW - labelX - 24 ;
        CGFloat H = [CaculateManager caculateRowHeightWithString:self.chatMessageModel.body fontSize:15 lineNum:0 maxWidth:labelW itemMargin:0 topHeight:0 bottomHeight:0 topMargin:10 bottomMargin:10] ;
        if (realWidth<labelW) {
            labelW = realWidth;
            H+=14 ;
        }else{
            H+=38;
        }
        //    NSAttributedString * str = [self.chatMessageModel.body dealStrWithLabelFont:[UIFont systemFontOfSize:15]];
        
        //    CGFloat H =
        self.otherContentLabel.frame = CGRectMake(labelX,labelY,labelW, H );
        self.otherContentBackView.frame = CGRectMake(CGRectGetMinX(self.otherContentLabel.frame) - 19, CGRectGetMinY(self.otherContentLabel.frame), labelW + margin*2 +10, H  ) ;
    }
}

-(void)setMyClient:(COSClient *)myClient{
    super.myClient = myClient ;
}
-(void)setChatMessageModel:(XMPPMessageArchiving_Message_CoreDataObject *)chatMessageModel{
    _chatMessageModel  = chatMessageModel;
    
    NSData *avatordata = [[GDXmppStreamManager ShareXMPPManager].xmppvcardavatarModule photoDataForJID:chatMessageModel.bareJid];
    UIImage * image  = [UIImage imageWithData:avatordata];
     NSLog(@"_%d_%@",__LINE__,chatMessageModel.bareJid.user);
    if ([chatMessageModel.bareJid.user isEqualToString:@"kefu"]) {
        self.otherIconView.image = [UIImage imageNamed:@"bg_icon_im"];
    }else{
    
        if (image) {
            
            self.otherIconView.image = image;
        }else{
            self.otherIconView.image = [UIImage imageNamed:@"bg_nohead"];
        }
    }
    
    if (chatMessageModel.body.length>0) {
        
        if ([chatMessageModel.body hasPrefix:@"img:"]) {
            NSString * imgUrlStr = [chatMessageModel.body stringByReplacingCharactersInRange:NSMakeRange(0, 4) withString:@""];
            NSURLComponents * urlComponents = [NSURLComponents componentsWithString:imgUrlStr ];
            NSArray * queryItems =  urlComponents.queryItems;
            
            CGFloat  width = self.maxWidth ;
            CGFloat height = self.maxHeight ;
            for (NSURLQueryItem * item  in queryItems) {
                NSString * key = item.name ;
                NSString * value = item.value ;
                if (key &&[key isEqualToString:@"width"]) {
                    if (value ) {
                        width = [value floatValue];
                        //self.imgFileWidth  = [value floatValue];
                    }
                }
                if (key && [key isEqualToString:@"height"]) {
                    if (value) {
                        height = [value floatValue];
                        // self.imgFileHeight  = [value floatValue];
                    }
                }
            }
            if (width >= height) {
                if (width > self.maxWidth) {
                    self.imgFileWidth = self.maxWidth;
                    self.imgFileHeight = height/width*self.maxWidth;
                }else{
                    self.imgFileWidth = width;
                    self.imgFileHeight = height;
                }
            }else{
                if (height > self.maxHeight) {
                    if (height > self.maxHeight) {
                        self.imgFileHeight = self.maxHeight;
                        self.imgFileWidth = self.imgFileHeight * width / height;
                    }else{
                        self.imgFileHeight = height;
                        self.imgFileWidth = width;
                    }
                }
            }
            if ([imgUrlStr containsString:@"?"]) {
                NSRange  range = [imgUrlStr rangeOfString:@"?"];
                imgUrlStr = [imgUrlStr substringToIndex:range.location];
                
            }
            NSString * imgPath = [self doloadImgSavePathForURL:imgUrlStr toUserName:chatMessageModel.bareJid.user];
            self.imgPath = imgPath ;
            UIImage * img = [UIImage imageWithContentsOfFile:imgPath];
            if (img) {            //本地取到了图片
                
                NSLog(@"_%d_%@",__LINE__,@"本地取到了图片");
                self.imgFileView.image = img ;
            }else{//取不到就下载图片
                NSLog(@"_%d_%@",__LINE__,@"没取到 , 去下载吧");
                [self downloadFileWithURLStr:imgUrlStr];
                
            }
            
            self.otherContentLabel.attributedText =  nil ;

        }else{
            self.otherContentLabel.attributedText = [chatMessageModel.body dealStrWithLabelFont: self.textLabel.font];
        //        self.otherContentLabel.attributedText = [self  dealTheStr:chatMessageModel.body labelFont:self.otherContentLabel.font];
        //        self.otherContentLabel.attributedText = [self  dealTheStr:chatMessageModel.body];
        }
    }
    
    
}

-(void)downloadFileWithURLStr:(NSString*)urlStr
{
    NSString * imageUrlStr =  urlStr ;
    //NSString * imageUrlStr = @"http://zhijielao-1252811222.file.myqcloud.com/b61a5df76bfb8ae8cdf2b66c1e49329b.jpeg";
    //    if (urlStr.length==0) {
    //        UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"错误" message:@"urlisnull" delegate:nil cancelButtonTitle:@"sure" otherButtonTitles:nil, nil];
    //        [a show];
    //        return;
    //    }
    
    COSObjectGetTask *cm = [[COSObjectGetTask alloc] initWithUrl:imageUrlStr];
    __weak __typeof__(self) weakSelf = self;
    
    self.myClient.completionHandler = ^(COSTaskRsp *resp, NSDictionary *context){
        __strong __typeof__(weakSelf) strongSelf = weakSelf;
        
        COSGetObjectTaskRsp *rsp = (COSGetObjectTaskRsp *)resp;
        NSLog(@"腾讯云文件下载成功context  = %@",context);
        NSLog(@"_%d_%d",__LINE__,rsp.retCode);
        NSLog(@"_%d_%@",__LINE__,rsp.descMsg);
        NSLog(@"_%d_%@",__LINE__,rsp.data);
        
        NSString * savePath =  [strongSelf doloadImgSavePathForURL:imageUrlStr toUserName:strongSelf.chatMessageModel.bareJid.user];
        [rsp.object writeToFile:savePath atomically:YES];
        UIImage * img = [UIImage imageWithData:rsp.object];
        strongSelf.imgFileView.image = img;
        
        
    };
    
    self.myClient.downloadProgressHandler = ^(int64_t receiveLength,int64_t contentLength){
        NSLog(@"_%d_%lld_%lld",__LINE__,receiveLength , contentLength);
        //        imgUrl.text = [NSString stringWithFormat:@"receiveLength =%ld,contentLength%ld",(long)receiveLength,(long)contentLength];;
        
    };
    [self.myClient getObject:cm];
}

//-(void)setIconImg:(UIImage *)iconImg{
//    _iconImg = iconImg;
//    self.otherIconView.image = iconImg;
//
//}

/** 解析属性字符串(抽到父类) */
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
//        [returnstr addAttribute:NSFontAttributeName value:self.otherContentLabel.font range:NSMakeRange(0, returnstr.length)];
//        return returnstr;
//
//    }
//
//    
//    
//    
//    [attM addAttribute:NSFontAttributeName value:self.otherContentLabel.font range:NSMakeRange(0, attM.length)];
//    return attM;
//    
////        return  [[NSMutableAttributedString alloc]initWithString:str];
//}

@end
























































////
////  OtherChatCell.m
////  b2c
////
////  Created by wangyuanfei on 16/8/1.
////  Copyright © 2016年 www.16lao.com. All rights reserved.
////
//
//#import "OtherChatCell.h"
//
//#import "XMPPMessageArchiving_Message_CoreDataObject.h"
//#import "GDTextAttachment.h"
//
//#import "GDXmppStreamManager.h"
//@interface OtherChatCell ()
//
//@property(nonatomic,weak)UIImageView * otherIconView ;
//
//@property(nonatomic,weak)UILabel * otherContentLabel ;
//@property(nonatomic,weak)UIImageView * otherContentBackView ;
//@end
//
//
//@implementation OtherChatCell
//
//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}
//
//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//                self.backgroundColor= BackgroundGray ;
//        self.selectionStyle=UITableViewCellSelectionStyleNone;
//
//        
//        UIImageView * otherIconView = [[UIImageView alloc]init];
//        //        otherIconView.backgroundColor=randomColor;
//        self.otherIconView=otherIconView;
//        [self.contentView addSubview:otherIconView];
//        
//        
//        
//        UIImageView * otherContentBackView = [[UIImageView alloc]init];
//        otherContentBackView.image = [UIImage imageNamed:@"bg_icon_aa"];
//        //        otherContentBackView.backgroundColor=[UIColor colorWithRed:100/255.0 green:200/255.0 blue:223/255.0 alpha:0.5];
//        self.otherContentBackView=otherContentBackView;
//        [self.contentView addSubview:self.otherContentBackView];
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
////        self.otherIconView.image=[UIImage imageNamed:@"bg_franchise"];
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
//            make.bottom.equalTo(self.otherContentLabel).offset(20);
//            make.left.equalTo(self);
//            make.right.equalTo(self);
//        }];
//        
//        
//
//
//        
//    }
//    return self;
//}
//
//
//-(void)setChatMessageModel:(XMPPMessageArchiving_Message_CoreDataObject *)chatMessageModel{
//    _chatMessageModel  = chatMessageModel;
//
//    NSData *avatordata = [[GDXmppStreamManager ShareXMPPManager].xmppvcardavatarModule photoDataForJID:chatMessageModel.bareJid];
//    UIImage * image  = [UIImage imageWithData:avatordata];
//    if (image) {
//        
//        self.otherIconView.image = image;
//    }else{
//        self.otherIconView.image = [UIImage imageNamed:@"bg_nohead"];
//    }
//    
//    if (chatMessageModel.body.length>0) {
//        self.otherContentLabel.attributedText = [self  dealTheStr:chatMessageModel.body];
//    }
//    
//    
//}
//
////-(void)setIconImg:(UIImage *)iconImg{
////    _iconImg = iconImg;
////    self.otherIconView.image = iconImg;
////
////}
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
//        [returnstr addAttribute:NSFontAttributeName value:self.otherContentLabel.font range:NSMakeRange(0, returnstr.length)];
//        return returnstr;
//        
//    }
//    
//    
//    
//    
//    [attM addAttribute:NSFontAttributeName value:self.otherContentLabel.font range:NSMakeRange(0, attM.length)];
//    return attM;
//    
////        return  [[NSMutableAttributedString alloc]initWithString:str];
//}
//
//@end
