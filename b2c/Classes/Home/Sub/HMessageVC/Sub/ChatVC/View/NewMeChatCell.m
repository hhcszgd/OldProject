//
//  NewMeChatCell.m
//  b2c
//
//  Created by WY on 17/3/13.
//  Copyright © 2017年 www.16lao.com. All rights reserved.
//

#import "NewMeChatCell.h"
#import "GDMessage.h"
#import "GDTextAttachment.h"
#import "GDXmppStreamManager.h"
#import "NSString+Hash.h"
#import "CaculateManager.h"
#import "GDPicturnPreview.h"

@interface NewMeChatCell ()

@property(nonatomic,weak)UIImageView * meIconView ;

@property(nonatomic,weak)UILabel * meContentLabel ;

@property(nonatomic,weak)UIImageView * meContentBackView ;

@property(nonatomic,weak)UIImageView * imgFileView ;

@end

@implementation NewMeChatCell


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
        UIImageView * meIconView = [[UIImageView alloc]init];
        //        meIconView.backgroundColor=randomColor;
        self.meIconView=meIconView;
        [self.contentView addSubview:meIconView];
        
        
        UIImageView * meContentBackView = [[UIImageView alloc]init];
        meContentBackView.userInteractionEnabled = YES ;
        meContentBackView.image=[UIImage imageNamed:@"bg_icon_ss"];
        //        meContentBackView.backgroundColor=[UIColor colorWithRed:94/255.0 green:254/255.0 blue:123/255.0 alpha:0.5];
        self.meContentBackView=meContentBackView;
        [self.contentView addSubview:self.meContentBackView];
        
        
        
        UILabel * meContentLabel = [[UILabel alloc]init];
        meContentLabel.font= [UIFont systemFontOfSize:15];
        //        [meContentLabel setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        meContentLabel.textColor = [UIColor purpleColor];
        meContentLabel.numberOfLines=0;
        //        meContentLabel.numberOfLines=0;
        self.meContentLabel = meContentLabel;
        [self.contentView addSubview:meContentLabel];
        
        UIImageView *  imgFileView = [[UIImageView alloc] init];
        self.imgFileView = imgFileView ;
        [self.contentView  addSubview:imgFileView];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(picureTap)];
        [imgFileView addGestureRecognizer:tap];
        imgFileView.userInteractionEnabled = YES ;
        
        
        
        
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
        //            make.bottom.equalTo(self.meContentLabel).offset(20);
        //            make.left.right.equalTo(self);
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
-(void)tests
{
    CGSize titleSize = [@"dslkf" sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(222, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
//    GDlog(@"%@",self.chatMessageModel.body)
    if ([self.chatMessageModel.body hasPrefix:@"img:"] || [self.chatMessageModel.body hasPrefix:@"Img:"] || [self.chatMessageModel.body hasPrefix:@"IMG:"]) {
        self.imgFileView.hidden = NO ;
        self.textLabel.hidden = YES ;
        self.imgFileView.backgroundColor = [UIColor clearColor];
        
        
        CGFloat margin = 10 ;
        self.meIconView.frame  = CGRectMake(self.bounds.size.width- 30 - margin, margin, 30, 30);
        
        CGFloat realWidth = self.imgFileWidth +20;
        CGFloat realHeight = self.imgFileHeight + 20 ;
        CGFloat imgFileX = CGRectGetMinX(self.meIconView.frame)-margin * 1.7 - self.imgFileWidth ;
        CGFloat imgFileY = CGRectGetMinY(self.meIconView.frame) ;
        self.imgFileView.frame = CGRectMake(imgFileX, imgFileY, self.imgFileWidth, self.imgFileHeight);
        
        //    CGFloat H =
        self.meContentBackView.frame = CGRectMake(CGRectGetMinX(self.imgFileView.frame)  - 8, CGRectGetMinY(self.imgFileView.frame) - 10, self.imgFileWidth + margin*2, self.imgFileHeight + margin * 2 ) ;
    }else{
        self.imgFileView.hidden = YES ;
        self.textLabel.hidden = NO  ;
        CGFloat margin = 10 ;
        self.meIconView.frame  = CGRectMake(self.bounds.size.width- 30 - margin, margin, 30, 30);
        CGFloat labelY =  CGRectGetMinY(self.meIconView.frame) ;
        
        CGFloat realWidth = [self.chatMessageModel.body stringSizeWithFont:15].width +20;
        CGFloat labelX = 24 ;
        CGFloat labelW = CGRectGetMinX(self.meIconView.frame) - 30 - margin * 1.3;
        CGFloat H = [CaculateManager caculateRowHeightWithString:self.chatMessageModel.body fontSize:15 lineNum:0 maxWidth:labelW itemMargin:0 topHeight:0 bottomHeight:0 topMargin:10 bottomMargin:10] ;
        if (realWidth<labelW) {
            labelW = realWidth;
            H+=14 ;
        }else{
            H+=38;
        }
        labelX =  CGRectGetMinX(self.meIconView.frame)-margin - labelW;
        //    CGFloat H =
        self.meContentLabel.frame = CGRectMake(labelX,labelY,labelW, H);
        self.meContentBackView.frame = CGRectMake(CGRectGetMinX(self.meContentLabel.frame) - 16, CGRectGetMinY(self.meContentLabel.frame), labelW + margin*2, H) ;
    }
    
}

-(void)setMyClient:(COSClient *)myClient{
    super.myClient = myClient ;
}
-(void)setChatMessageModel:(GDMessage *)chatMessageModel {
    _chatMessageModel  = chatMessageModel;

        self.meIconView.image = [UIImage imageNamed:@"bg_nohead"];
    
    if (chatMessageModel.body.length>0) {
        //图片的message  body 示例 : img:http://zhijielao-1252811222.file.myqcloud.com/20170215020041.JPEG?width=434&hegiht=200
        if ([chatMessageModel.body hasPrefix:@"img:"] || [chatMessageModel.body hasPrefix:@"Img:"]|| [chatMessageModel.body hasPrefix:@"IMG:"]) {
            self.imgFileView.hidden = NO ;
            self.textLabel.hidden = YES ;
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
            NSString * imgPath = [self doloadImgSavePathForURL:imgUrlStr toUserName:chatMessageModel.otherAccount];
            self.imgPath = imgPath ;
            UIImage * img = [UIImage imageWithContentsOfFile:imgPath];
            if (img) {            //本地取到了图片
                
                NSLog(@"_%d_%@",__LINE__,@"本地取到了图片");
                self.imgFileView.image = img ;
            }else{//取不到就下载图片
                NSLog(@"_%d_%@",__LINE__,@"没取到 , 去下载吧");
                [self downloadFileWithURLStr:imgUrlStr];
                
            }
            self.meContentLabel.attributedText =  nil ;
        }else{
            self.meContentLabel.attributedText = [chatMessageModel.body dealStrWithLabelFont: self.textLabel.font];
            self.imgFileView.hidden = YES ;
            self.textLabel.hidden = NO ;
        }
        //           self.meContentLabel.attributedText = [self dealTheStr:chatMessageModel.body labelFont: self.textLabel.font];
        //                        self.meContentLabel.attributedText = [self  dealTheStr:chatMessageModel.body];
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
        
        NSString * savePath =  [strongSelf doloadImgSavePathForURL:imageUrlStr toUserName:strongSelf.chatMessageModel.otherAccount];
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

@end
