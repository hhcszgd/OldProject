//
//  ChatCell.h
//  TTmall
//
//  Created by wangyuanfei on 16/1/21.
//  Copyright © 2016年 Footway tech. All rights reserved.
/**
 聊天内容的cell
 
 */

#import <UIKit/UIKit.h>
#import "COSTask.h"
#import "COSClient.h"
#import "HttpClient.h"
@interface ChatCellBC : UITableViewCell

/** 解析属性字符串 */
-(NSAttributedString*)dealTheStr:(NSString*)str labelFont:(UIFont*)font;
@property(nonatomic,assign)CGFloat   maxWidth ;
@property(nonatomic,assign)CGFloat  maxHeight ;

@property(nonatomic,strong)COSClient * myClient ;
@property(nonatomic,strong)HttpClient * client ;
@property(nonatomic,assign)CGFloat  imgFileWidth ;
@property(nonatomic,assign)CGFloat  imgFileHeight ;
@property(nonatomic,copy)NSString * imgPath ;
//下载的图片保存到沙盒
- (NSString *)doloadImgSavePathForURL:(NSString *)url toUserName:(NSString *)toUserName;
//相册的图片保存到沙盒

- (NSString *)photoSavePathForURL:(NSURL *)url toUserName:(NSString *)toUserName;

@end






//#import <UIKit/UIKit.h>
//@class ChatModel;
//@class XMPPMessageArchiving_Message_CoreDataObject;
//@interface ChatCellBC : UITableViewCell
////@property(nonatomic,strong)ChatModel * chatModel ;
//@property(nonatomic,strong)XMPPMessageArchiving_Message_CoreDataObject * chatMessageModel ;
//@property(nonatomic,strong)UIImage * leftImg ;
//@property(nonatomic,strong)UIImage * rightImg ;
////@property(nonatomic,copy)NSString * txtContent ;
////@property(nonatomic,strong)UIImage * icon ;
////@property(nonatomic,assign)BOOL  isMe ;
////@property(nonatomic,strong)UIImage * imgContent ;
//@end






































////
////  ChatCell.h
////  TTmall
////
////  Created by wangyuanfei on 16/1/21.
////  Copyright © 2016年 Footway tech. All rights reserved.
///**
// 聊天内容的cell
// 
// */
//
//#import <UIKit/UIKit.h>
//@class ChatModel;
//@class XMPPMessageArchiving_Message_CoreDataObject;
//@interface ChatCellBC : UITableViewCell
////@property(nonatomic,strong)ChatModel * chatModel ;
//@property(nonatomic,strong)XMPPMessageArchiving_Message_CoreDataObject * chatMessageModel ;
//@property(nonatomic,strong)UIImage * leftImg ;
//@property(nonatomic,strong)UIImage * rightImg ;
////@property(nonatomic,copy)NSString * txtContent ;
////@property(nonatomic,strong)UIImage * icon ;
////@property(nonatomic,assign)BOOL  isMe ;
////@property(nonatomic,strong)UIImage * imgContent ;
//@end
