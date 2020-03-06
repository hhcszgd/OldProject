//
//  ChatVC.m
//  b2c
//
//  Created by wangyuanfei on 16/5/11.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "ChatVC.h"
#import <MJExtension/MJExtension.h>
//#import "Base64.h"
//#import "GCDAsyncSocket.h"
#import "ChatCellBC.h"
#import "MeChatCell.h"
#import "OtherChatCell.h"

#import "ChatModel.h"

//#import "PerformChatTool.h"
#import "NSString+Hash.h"

#import "NSObject+Scale.h"
/** xmpp开始 */
#import "GDXmppStreamManager.h"
#import "XMPPJID.h"

#import "TURNSocket.h"

#import "GDTextView.h"
#import "GDKeyBoard.h"
#import "GDTextAttachment.h"
/** xmpp结束 */
#import "XMPPMessage+XEP_0172.h"
#import "CaculateManager.h"

//#import "TestScrollViewProPerty.h"
#import <XMPPFramework/XMPPJID.h>

#import "XMPPFramework.h"
#import "XMPPvCardAvatarModule.h"
#import "XMPPAutoPing.h"
#import <MJExtension/MJExtension.h>
#import <MJExtension/MJExtension-umbrella.h>
#import <MJRefresh/UIView+MJExtension.h>
//这三个类可以答应连接过程的日志
//#import "DDLog.h"
//#import "DDTTYLogger.h"
//#import "XMPPLogging.h"
//#import "XMPPvCardAvatarModule.h"
//#import "XMPPAutoPing.h"
//#import "XMPPRosterCoreDataStorage.h"
//#import "XMPPvCardCoreDataStorage.h"
//#import "XMPPRoster.h"
//#import "XMPPMessageArchiving.h"
//#import "XMPPMessageArchivingCoreDataStorage.h"
//#import "CocoaLumberJack/DDLog.h"
#import "XMPPvCardAvatarModule.h"
#import "XMPPAutoPing.h"
#import "XMPPRosterCoreDataStorage.h"
#import "XMPPvCardCoreDataStorage.h"
#import "XMPPRoster.h"
#import "XMPPMessageArchiving.h"
#import "XMPPMessageArchivingCoreDataStorage.h"
#import "CocoaLumberJack/DDLog.h"
@class  XMPPSIFileTransfer;
#import "XMPPReconnect.h"

#import "XMPPvCardTemp.h"

#import "XMPPIncomingFileTransfer.h"
#import "XMPPOutgoingFileTransfer.h"



#import "zjlao-Swift.h"






@interface ChatVC ()<UITableViewDataSource,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate/*,UITextInputDelegate*/,UITextViewDelegate ,/** xmpp相关协议 */NSFetchedResultsControllerDelegate,XMPPRosterDelegate,XMPPvCardTempModuleDelegate,XMPPvCardAvatarDelegate>
{
    //    UILabel *contentLable;
    //    UITextView *imgUrl;
    UILabel *imgFileID;
    //    UIImageView *imageV;
    
    
    NSString *appId ;
    NSString *bucket ;
    NSString *dir  ;
    NSString *fileName;
    NSString *imgSavepath;
    int64_t currentTaskid;
    
    //    COSClient *myClient;
}
@property(nonatomic,strong)NSXMLParser * xml ;
@property (nonatomic,copy) NSString *sign;//腾讯云签名 , 待赋值


/** <#注释#> */
@property (nonatomic, strong) NSMutableArray *dataSources;/**数据源*/

//UI
/** 辅助键盘 */
@property(nonatomic,strong)UIView * inputView ;
/** 输入框 属于inputview的子空间 */
@property(nonatomic,weak)   GDTextView * textView ;//
/** 表情键盘 */
@property(nonatomic,strong)GDKeyBoard *  browKeyBoard ;
@property(nonatomic,strong)UIImagePickerController * picker ;
@property(nonatomic,assign)BOOL  isKeyboardShow ;
//@property(nonatomic,strong)PerformChatTool * chatTool ;

@property(nonatomic,assign)BOOL  needShowKeyboardAgain ;
//@property(nonatomic,copy)NSString * sessionID ;
//@property(nonatomic,strong)NSTimer * timer ;

/** xmpp开始 */
//查询请求控制器
@property (nonatomic ,strong)NSFetchedResultsController *fetchedresultscontroller;

@property (nonatomic , strong)NSArray *ChatsArrs;
@property(nonatomic,assign)CGFloat  keyboardHeight ;
@property(nonatomic,weak)UIButton * browButton ;//表情按钮
/** xmpp结束 */

@property(nonatomic,strong)COSClient * myClient ;
@property(nonatomic,strong)HttpClient * client ;
@end

@implementation ChatVC






-(CGFloat )scaleHeight{
    if ([UIScreen mainScreen].bounds.size.width>375.0) {
        return 1.104000;
    } else if ([UIScreen mainScreen].bounds.size.width<321) {
        return 0.853333;
    }else {
        return 1 ;
    }
}









#pragma mark UI
-(void)setupUI
{
    NSString * sourctPath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"Resource" ofType:@"bundle"]] pathForResource:@"cy" ofType:@"gif" inDirectory:@"face_img"];// gotResourceInSubBundle(@"cy", @"gif", @"face_img");
    NSLog(@"_%@_%d_%@",[self class] , __LINE__,sourctPath);
    self.automaticallyAdjustsScrollViewInsets  = NO;
    [self setupTableView];
    
    [self setupInputView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    if (self.ChatsArrs.count>0) {
        
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.ChatsArrs.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        
    }
    
}

#pragma mark tableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ChatsArrs.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    ChatCellBC * cell = [tableView dequeueReusableCellWithIdentifier:@"ChatCellBC"];
    //    if (!cell) {
    //        cell=[[ChatCellBC alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ChatCellBC"];
    //    }
    //    //    ChatModel * model = [[ChatModel alloc]init];
    //    //    model.txtContent = @"3";
    //    XMPPMessageArchiving_Message_CoreDataObject * message  = self.ChatsArrs[indexPath.row];
    //    //    XMPPMessageArchiving_Message_CoreDataObject , xmppmessage的父类
    //    //    model.txtContent = message.body;
    //    //    LOG(@"_%@_%d_%d",[self class] , __LINE__,message.isOutgoing);
    //    //注意,这里的头像有两个方向
    //    cell.chatMessageModel=message;
    //    if (message.isOutgoing) {
    //        //我发出去
    //        NSData *avatordata = [GDXmppStreamManager ShareXMPPManager].xmppvcardtempModule.myvCardTemp.photo;
    //
    //        UIImage * image = [UIImage imageWithData:avatordata];
    //        cell.rightImg = image;
    //
    //    }else
    //    {//别人发出去的
    //        NSData *avatordata = [[GDXmppStreamManager ShareXMPPManager].xmppvcardavatarModule photoDataForJID:self.UserJid];
    //        UIImage * image  = [UIImage imageWithData:avatordata];
    //        cell.leftImg = image;
    //    }
    //
    //    //    LOG(@"_%@_%d_%@",[self class] , __LINE__,message.bareJid.user);
    //    //    cell.chatMessageModel=message;
    //    //    NSString * result = [message.timestamp.description formatterDateStringToMinute];
    //    //    LOG(@"_%@_%d_%@",[self class] , __LINE__,result);
    //    return cell;
    
    
    XMPPMessageArchiving_Message_CoreDataObject * message  = self.ChatsArrs[indexPath.row];
    
    XMPPvCardTemp * vcard = [[GDXmppStreamManager ShareXMPPManager].xmppvcardtempModule vCardTempForJID:message.bareJid shouldFetch:YES];
    
    NSLog(@"_%@_%d_\n\n\n昵称啊昵称%@\n\n\n",[self class] , __LINE__,vcard.nickname);
    //注意,这里的头像有两个方向
    
    UITableViewCell * cell = nil ;
    if (message.isOutgoing) {
        //我发出去
        cell = [tableView dequeueReusableCellWithIdentifier:@"MeChatCell"];
        if (!cell) {
            cell=[[MeChatCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MeChatCell"];
        }
        OtherChatCell * me = (OtherChatCell*)cell ;
        me.myClient=self.myClient;

        me.chatMessageModel=message;
        //                LOG(@"_%@_%d_%@",[self class] , __LINE__,me);
        return me;
    }else  {//别人发出去的
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"OtherChatCell"];
        if (!cell) {
            cell=[[OtherChatCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OtherChatCell"];
        }
        OtherChatCell * other = (OtherChatCell*)cell ;
        other.myClient=self.myClient;

        other.chatMessageModel=message;
        //                LOG(@"_%@_%d_%@",[self class] , __LINE__,other);
        return other;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XMPPMessageArchiving_Message_CoreDataObject * message  = self.ChatsArrs[indexPath.row];
    //    NSAttributedString * str = [message.body dealStrWithLabelFont:[UIFont systemFontOfSize:15]];
    
    CGFloat margin = 10 ;
    CGFloat labelX = margin + 30 + 25 ;
    CGFloat labelW = [UIScreen mainScreen].bounds.size.width - labelX - 24 ;
    
    
    
    if ([message.body hasPrefix:@"img:"]||[message.body hasPrefix:@"Img:"]||[message.body hasPrefix:@"IMG:"] ) {
        
        NSString * imgUrlStr = [message.body stringByReplacingCharactersInRange:NSMakeRange(0, 4) withString:@""];
        NSURLComponents * urlComponents = [NSURLComponents componentsWithString:imgUrlStr ];
        NSArray * queryItems =  urlComponents.queryItems;
        CGFloat maxW = [UIScreen mainScreen].bounds.size.width /3 ;
        CGFloat maxH = maxW;
        CGFloat  width = maxW ;
        CGFloat height = maxH;
        
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
            if (width > maxW) {
                height = height/width*maxW;
                width = maxW;
            }else{
                //原尺寸
            }
        }else{
            if (height > maxH) {
                if (height > maxH) {
                    width = maxH * width / height;
                    height = maxH;
                }else{
                    //原尺寸
                }
            }
        }
        return  height + 40  ;//TODO返回图片的高度
        
    }else{
        
        CGFloat H = [CaculateManager caculateRowHeightWithString:message.body fontSize:15 lineNum:0 maxWidth:labelW itemMargin:0 topHeight:0 bottomHeight:0 topMargin:10 bottomMargin:30] ;
        return H + 44;
    }

    
}

#pragma mark tableViewDelegate
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    if (self.ChatsArrs.count>0) {
//        if ([self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] == self.tableView.visibleCells[0]){
//        NSMutableArray * arr = [ NSMutableArray arrayWithCapacity:10];
//        NSMutableArray * idxArr = [NSMutableArray arrayWithCapacity:10];
//        int a = self.i;
//        for ([self i]  ; self.i<40+a; self.i++) {
//            ChatModel * model = [[ChatModel alloc]init];
//
//            if (self.i%2==0) {
//                model.isMe=YES;
//            }else{
//                model.isMe=NO;
//            }
//            model.txtContent=[NSString stringWithFormat:@"%d",self.i];
//            [ arr addObject:model];
////            [self.ChatsArrs insertObject:model atIndex:0];
//            NSIndexPath * idx = [NSIndexPath indexPathForRow:self.i inSection:0];
//            [idxArr addObject:idx];
//        }
//        [self.tableView reloadData];
//        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:40 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];

//        }
//    }
//
//
//}
//拖动调整键盘
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"_%@_%d_%d",[self class] , __LINE__,self.isKeyboardShow);
    if (scrollView != self.tableView) {
        return;
    }
    if (self.isKeyboardShow) {
        [self.textView resignFirstResponder];
    }else{
        NSLog(@"_%@_%d_%@",[self class] , __LINE__,NSStringFromCGPoint(self.tableView.contentOffset));
        NSLog(@"_%@_%d_%@",[self class] , __LINE__,NSStringFromCGSize(self.tableView.contentSize));
        if (self.tableView.contentOffset.y+self.tableView.bounds.size.height>self.tableView.contentSize.height) {
            [self.textView becomeFirstResponder];
        }
    }
    NSLog(@"_%@_%d_%@",[self class] , __LINE__,self.textView.inputView);
    
}
#pragma mark textViewdelegate
//发送消息
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    
    if ([text isEqualToString:@"\n"]) {
        NSLog(@"_%@_%d_%lu",[self class] , __LINE__,(unsigned long)textView.text.length);
        //        ChatModel * model = [[ChatModel alloc]init];
        //        model.txtContent=[NSString stringWithFormat:@"%d",self.i++];
        //        [ self.ChatsArrs addObject:model];
        //        NSIndexPath * idx = [NSIndexPath indexPathForRow:self.ChatsArrs.count-1 inSection:0];
        //        model.txtContent=textView.text;
        //        [self.chatTool sendMessage:model.txtContent usersId:@"4" messageType:1];
        //        textView.text=@"";
        //        //        self.tableView.contentInset=UIEdgeInsetsMake(0, 0, 258+50, 0);
        NSString * elementID =  [[GDXmppStreamManager ShareXMPPManager].XmppStream generateUUID];
        XMPPMessage *message = [XMPPMessage messageWithType:@"chat" to:self.UserJid  elementID:elementID ];
        NSLog(@"_%d_%@",__LINE__,elementID);
        NSXMLElement *receipt = [NSXMLElement elementWithName:@"request" xmlns:@"urn:xmpp:receipts"];
        //        [receipt addAttributeWithName:@"id" stringValue:elementID];///////////////
        [message addChild:receipt];
        [message addBody:self.textView.sendStr];
        
        [[GDXmppStreamManager ShareXMPPManager].XmppStream sendElement:message];
        self.textView.text = nil ;
        //        [self.tableView reloadData];
        //        [self.tableView scrollToRowAtIndexPath:idx atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        return NO;
    }
    return YES;
}


#pragma mark 注释: 保存历史消息 , 待实现

#pragma mark customMethod

-(GDKeyBoard *)browKeyBoard{
    if (_browKeyBoard==nil) {
        CGFloat keyboardH = 0;
        if ([UIScreen mainScreen].bounds.size.width<321) {//4,5
            keyboardH = 216;
        }else if ([UIScreen mainScreen].bounds.size.width<321) {//6
            keyboardH = 226 ;
        }else if ([UIScreen mainScreen].bounds.size.width<376) {//6p
            keyboardH = 258 ;
        }else {
            keyboardH = 258 ;
        }
        GDKeyBoard * keyBoard =[[GDKeyBoard alloc]initWithFrame: CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,keyboardH )];
        NSMutableArray * bigArrm = [NSMutableArray new];
        NSString * path =  [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"Resource" ofType:@"bundle"]] pathForResource:@"brow" ofType: @"plist" inDirectory:@"face_img"];
//gotResourceInSubBundle(@"brow", @"plist", @"face_img");
        NSArray * littleArr = [NSArray arrayWithContentsOfFile:path];
        [bigArrm addObject:littleArr];
        keyBoard.allBrowNames = bigArrm;
        NSLog(@"_%@_%d_%@",[self class] , __LINE__,keyBoard.allBrowNames);
        _browKeyBoard = keyBoard;
    }
    return _browKeyBoard;
}

-(void)showBrow:(UIButton * ) sender
{
    
    if (self.isKeyboardShow) {//正常切换
        //        [self.textView resignFirstResponder];
        if (self.textView.inputView) {//切换到键盘
            self.textView.inputView = nil;
            //            [self.textView reloadInputViews];
            //            [self.textView becomeFirstResponder];
        }else{//切换到表情
            
            self.textView.inputView = self.browKeyBoard;
            //            [self.textView becomeFirstResponder];
        }
        
    }else{
        if (self.textView.inputView) {//切换到表情
            self.textView.inputView = self.browKeyBoard;
            //            [self.textView becomeFirstResponder];
        }else{//切换到键盘
            self.textView.inputView = nil;
            //            [self.textView becomeFirstResponder];
        }
        [self.textView becomeFirstResponder];
    }
    [self.textView reloadInputViews];
}
-(void)keyboardWillChanged:(NSNotification*)note
{
    if (self.textView.inputView) {//当前为表情键盘 , 按钮状态显示键盘
        self.browButton.selected = YES ;
    }else{//当前为键盘 , 按钮状态显示表情
        self.browButton.selected = NO ;
    }
}
-(void)keyboardWillHide:(NSNotification*)note
{
    self.isKeyboardShow=NO;
    double duration =  [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //    CGFloat keyboardHeight = keyboardFrame.size.height;
    
    [UIView animateWithDuration:duration animations:^{
        self.inputView.mj_y=[UIScreen mainScreen].bounds.size.height-self.inputView.bounds.size.height;
        [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        
    }];
    
    
}
-(void)keyboardDidHide:(NSNotification*)note
{
    
}
-(void)keyboardWillShow:(NSNotification*)note
{
    
    self.isKeyboardShow=YES;
    double duration =  [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = keyboardFrame.size.height;
    if (self.keyboardHeight==0) {
        self.keyboardHeight=keyboardHeight;
    }
    NSLog(@"_%@_%d_%@",[self class] , __LINE__,NSStringFromCGSize( self.tableView.contentSize ));
    NSLog(@"_%@_%d_%f",[self class] , __LINE__,keyboardHeight);
    
    [UIView animateWithDuration:duration animations:^{
        self.inputView.mj_y=[UIScreen mainScreen].bounds.size.height-keyboardHeight-self.inputView.bounds.size.height;
        [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, keyboardHeight, 0)];
        if (self.ChatsArrs.count>0) {
            
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.ChatsArrs.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
    }];
}
-(void)setupInputView
{
    
    UIView * inputView =[self gotInputView];
    self.inputView=inputView;
    [self.view addSubview:inputView];
}
-(void)setupTableView
{
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-56*self.scaleHeight-64)];
    [self.view addSubview:tableView];
    self.tableView=tableView;
    self.tableView.backgroundColor= [UIColor colorWithRed:244/256.0 green:244/256.0 blue:244/256.0 alpha:1];
    self.tableView.delegate = self;
    self.tableView.dataSource=self;
    //    self.tableView.estimatedRowHeight = 100.0;
    //    self.tableView.rowHeight=UITableViewAutomaticDimension;
    //    [self.tableView registerClass:[ChatCellBC class] forCellReuseIdentifier:@"ChatCellBC"];
    //    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.showsVerticalScrollIndicator=NO;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //    UIView * ffff = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 30)];
    //    self.tableView.tableFooterView =ffff;
    //    self.tableView.contentInset=UIEdgeInsetsMake(0, 0, 50, 0);
    
}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"内存警告")
//}
-(void)dealloc{
    NSLog(@"_%@_%d_%@",[self class] , __LINE__,@"dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self ];
    
}




-(UIView*)gotInputView
{
    /** 有表情按钮的 */
    CGFloat margin= 10 ;
    UIView * inputView = [[UIView alloc]initWithFrame: CGRectMake(0,  [UIScreen mainScreen].bounds.size.height-56*self.scaleHeight,  [UIScreen mainScreen].bounds.size.width, 56*self.scaleHeight)];
    
    inputView.backgroundColor= [UIColor whiteColor];
    
    //    picture.backgroundColor=randomColor;
    CGFloat browH =   inputView.bounds.size.height * 0.6;
    CGFloat browW =  browH ;
    CGFloat browX =  0 ;
    CGFloat browY =  inputView.bounds.size.height * 0.2 ;
    
    
    UIButton * brow = [[UIButton alloc]initWithFrame:CGRectMake(browX,browY,browW,browH)];
    self.browButton = brow;
    //    brow.imageEdgeInsets = UIEdgeInsetsMake(10*SCALE, 10*SCALE, 10*SCALE, 10*SCALE);
    //    brow.backgroundColor = randomColor;
    [inputView addSubview:brow];
    [brow setImage:[UIImage imageNamed:@"bg_icon_ff"] forState:UIControlStateNormal];
    [brow setImage:[UIImage imageNamed:@"bg_icon_ww"] forState:UIControlStateSelected];
    [brow addTarget:self action:@selector(showBrow:) forControlEvents:UIControlEventTouchUpInside];
    
    //    [brow setTitle:@"情" forState:UIControlStateNormal];
    //    [brow setTitle:@"盘" forState:UIControlStateSelected];
    
    CGFloat picX =  browW ;
    CGFloat picY =  browY ;
    CGFloat picH =   browH;
    CGFloat picW =  browW ;
    UIButton * picture = [[UIButton alloc]initWithFrame:CGRectMake(picX, picY,picW, picH)];
    //    picture.imageEdgeInsets = UIEdgeInsetsMake(10*SCALE, 10*SCALE, 10*SCALE, 10*SCALE);
    
    [inputView addSubview:picture];
    [picture setImage:[UIImage imageNamed:@"imgPicker"] forState:UIControlStateNormal];
    //    [picture setImage:[UIImage imageNamed:@"bg_electric"] forState:UIControlStateHighlighted];
    [picture addTarget:self action:@selector(gotPicture:) forControlEvents:UIControlEventTouchUpInside];
    
    
    CGFloat sendButtonH = browH ;
    CGFloat sendButtonW = browW ;
    CGFloat sendButtonX = [UIScreen mainScreen].bounds.size.width - sendButtonW ;
    CGFloat sendButtonY = browY ;
    UIButton * sendButton = [[UIButton alloc]initWithFrame:CGRectMake(sendButtonX,sendButtonY,sendButtonW,sendButtonH)];
    //    emoj.backgroundColor=randomColor;
    [sendButton setImage:[UIImage imageNamed:@"bg_icon_xx"] forState:UIControlStateNormal];
    //    sendButton.imageEdgeInsets = UIEdgeInsetsMake(10*SCALE, 10*SCALE, 10*SCALE, 10*SCALE);
    //    sendButton.backgroundColor = randomColor;
    //    [sendButton setImage:[UIImage imageNamed:@"bg_Production"] forState:UIControlStateDisabled];
    [sendButton addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
    
    [inputView addSubview:sendButton];
    CGFloat textviewW =  [UIScreen mainScreen].bounds.size.width -  sendButtonW - browW - picW;
    CGFloat textviewX = browW + picW ;
    CGFloat textviewY = margin*0.8;
    CGFloat textviewH = inputView.bounds.size.height - textviewY*2;
    GDTextView * textView = [[GDTextView alloc]initWithFrame:CGRectMake(textviewX,textviewY,textviewW,textviewH)];
    [inputView addSubview:textView];
    textView.backgroundColor = [UIColor colorWithRed:0.89 green:0.89 blue:0.89 alpha:1];
    self.textView = textView;
    textView.layer.borderColor=inputView.backgroundColor.CGColor;
    textView.layer.borderWidth=2;
    textView.layer.masksToBounds=YES;
    textView.layer.cornerRadius=13;
    textView.textContainerInset=UIEdgeInsetsMake(8, 10, 8, 5);
    textView.keyboardType=UIKeyboardTypeTwitter;
    textView.returnKeyType=UIReturnKeySend;
    //    textView.inputDelegate=self;
    textView.enablesReturnKeyAutomatically=YES;
    textView.delegate = self ;
    textView.showsVerticalScrollIndicator = NO ;
    return inputView;

    
    
    
    /** 先提一版没有表情按钮的 */
    //    CGFloat margin= 10 ;
    //    UIView * inputView = [[UIView alloc]initWithFrame: CGRectMake(0, screenH-50, screenW, 50)];
    //
    //    inputView.backgroundColor=[UIColor colorWithRed:0.89 green:0.89 blue:0.89 alpha:1];
    //
    //    CGFloat sendButtonW = 30 ;
    //    CGFloat sendButtonH = 30 ;
    //    CGFloat sendButtonX = screenW - margin - sendButtonW ;
    //    CGFloat sendButtonY = (inputView.bounds.size.height - sendButtonH)/2 ;
    //
    //    UIButton * sendButton = [[UIButton alloc]initWithFrame:CGRectMake(sendButtonX,sendButtonY,sendButtonW,sendButtonH)];
    //    //    emoj.backgroundColor=randomColor;
    //    [sendButton setImage:[UIImage imageNamed:@"btn_Top"] forState:UIControlStateNormal];
    //    [sendButton setImage:[UIImage imageNamed:@"bg_Production"] forState:UIControlStateDisabled];
    //    [sendButton addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
    //
    //    [inputView addSubview:sendButton];
    //    CGFloat textviewW = screenW - margin*2 -margin - sendButtonW  - margin;
    //    CGFloat textviewX = margin +margin;
    //    CGFloat textviewY = margin;
    //    CGFloat textviewH = inputView.bounds.size.height - textviewY*2;
    //    GDTextView * textView = [[GDTextView alloc]initWithFrame:CGRectMake(textviewX,textviewY,textviewW,textviewH)];
    //    [inputView addSubview:textView];
    //    self.textView = textView;
    //    textView.layer.borderColor=inputView.backgroundColor.CGColor;
    //    textView.layer.borderWidth=2;
    //    textView.layer.masksToBounds=YES;
    //    textView.layer.cornerRadius=13;
    //    textView.textContainerInset=UIEdgeInsetsMake(8, 10, 8, 5);
    //    textView.keyboardType=UIKeyboardTypeTwitter;
    //    textView.returnKeyType=UIReturnKeySend;
    //    textView.inputDelegate=self;
    //    textView.enablesReturnKeyAutomatically=YES;
    //    textView.delegate = self ;
    //    textView.showsVerticalScrollIndicator = NO ;
    //    return inputView;
    
}
-(void)sendMessage:(UIButton*)sender
{
    if (self.textView.text.length==0) {
        return;
    }
  
    /*
     
     XMPPMessage *msg = [XMPPMessage messageWithType:[message attributeStringValueForName:@"type"] to:message.from elementID:[self.XmppStream generateUUID]];
     //
     //        NSXMLElement *recieved = [NSXMLElement elementWithName:@"received" xmlns:@"urn:xmpp:receipts"];
     //        [recieved addAttributeWithName:@"id" stringValue:[message attributeStringValueForName:@"id"]];
     */
    NSString * elementID = [[GDXmppStreamManager ShareXMPPManager].XmppStream generateUUID] ;
    XMPPMessage *message = [XMPPMessage messageWithType:@"chat" to:self.UserJid elementID:elementID];
    NSString * temp =self.textView.sendStr;
    [message addBody:self.textView.sendStr];
    NSXMLElement *receipt = [NSXMLElement elementWithName:@"request" xmlns:@"urn:xmpp:receipts"];
    //    [receipt addAttributeWithName:@"id" stringValue:elementID];
    [message addChild:receipt];
    //<x xmlns='jabber:x:event'><offline/><delivered/><composing/></x>
    NSXMLElement *x = [NSXMLElement elementWithName:@"x" xmlns:@"jabber:x:event"];
    //    NSXMLElement * xid = [NSXMLElement elementWithName:@"id" objectValue:elementID];
    //    [x addChild:xid];
    //    [x addAttributeWithName:@"id" stringValue:elementID];
    NSXMLElement * offline = [[NSXMLElement alloc] initWithName:@"offline"];
    NSXMLElement * delivered = [[NSXMLElement alloc] initWithName:@"delivered"];
    NSXMLElement * composing = [[NSXMLElement alloc] initWithName:@"composing"];
    [x addChild:offline];
    [x addChild:delivered];
    [x addChild:composing];
    [message addChild:x];
    
    [[GDXmppStreamManager ShareXMPPManager].XmppStream sendElement:message];
    self.textView.text = nil ;
}
/**注销掉先
 -(UIView*)gotInputView
 {
 UIView * inputView = [[UIView alloc]initWithFrame: CGRectMake(0, screenH-50, screenW, 50)];
 
 inputView.backgroundColor=[UIColor lightGrayColor];
 UIButton * picture = [[UIButton alloc]initWithFrame:CGRectMake(10, inputView.bounds.size.height-10-30, 30, 30)];
 [inputView addSubview:picture];
 [picture setImage:[UIImage imageNamed:@"bg_female baby"] forState:UIControlStateNormal];
 [picture setImage:[UIImage imageNamed:@"bg_electric"] forState:UIControlStateHighlighted];
 [picture addTarget:self action:@selector(gotPicture:) forControlEvents:UIControlEventTouchUpInside];
 //    picture.backgroundColor=randomColor;
 UIButton * emoj = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(picture.frame)+10, CGRectGetMinY(picture.frame), 30, 30)];
 //    emoj.backgroundColor=randomColor;
 [emoj setImage:[UIImage imageNamed:@"bg_supermarket"] forState:UIControlStateNormal];
 [emoj setImage:[UIImage imageNamed:@"bg_Production"] forState:UIControlStateHighlighted];
 [emoj addTarget:self action:@selector(chooseEmoj:) forControlEvents:UIControlEventTouchUpInside];
 
 [inputView addSubview:emoj];
 
 UITextView * textView = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(emoj.frame)+10, 10, inputView.bounds.size.width-10-picture.bounds.size.width-10-emoj.bounds.size.width-10-10, inputView.bounds.size.height-20)];
 [inputView addSubview:textView];
 self.textView = textView;
 textView.layer.borderColor=[UIColor lightGrayColor].CGColor;
 textView.layer.borderWidth=2;
 textView.layer.masksToBounds=YES;
 textView.layer.cornerRadius=13;
 textView.textContainerInset=UIEdgeInsetsMake(8, 10, 8, 5);
 textView.keyboardType=UIKeyboardTypeTwitter;
 textView.returnKeyType=UIReturnKeySend;
 textView.inputDelegate=self;
 textView.enablesReturnKeyAutomatically=YES;
 textView.delegate = self ;
 return inputView;
 }
 
 **/


-(void)gotPicture:(UIButton *)sender
{
//    if (!self.sign) {
//        [[UserInfo shareUserInfo] gotTencentYunSuccess:^(ResponseObject *response) {
//            NSLog(@"_%d_%@",__LINE__,response.data);
//            if (response.data) {
//                self.sign = response.data;
//            }
//        } failure:^(NSError *error) {
//            NSLog(@"_%d_%@",__LINE__,error);
//        }];
//    }
     if (!self.sign) {
        [[NetworkManager shareManager] gotTencentYunSign:^(OriginalNetDataModel * _Nonnull resultModel) {
            if (resultModel.data) {
//                self.sign = resultModel.data;
                NSString * tempSign = (NSString*)resultModel.data;
                NSString* signEncode = [tempSign stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//
                self.sign = signEncode;
                [self creatDir];
            }
        } failure:^(NSError * _Nonnull error) {
            
        }];
    }

    
    
    
    
    
    
    
    
    UIAlertController * alertVC  =  [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * actionCamora = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //弹出系统相册
        UIImagePickerController *pickVC = [[UIImagePickerController alloc] init];
        //设置照片来源
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            
            pickVC.sourceType =  UIImagePickerControllerSourceTypeCamera;
            pickVC.delegate = self;
            [self presentViewController:pickVC animated:YES completion:nil];
        }else{
            [GDAlertView alert:@"摄像头不可用" image:nil  time:2 complateBlock:^{
                
            }];
//            AlertInVC(@"摄像头不可用");
        }
//        pickVC.allowsEditing=YES;
    }];
    UIAlertAction * actionAlbum = [UIAlertAction actionWithTitle:@"我的相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //弹出系统相册
        UIImagePickerController *pickVC = [[UIImagePickerController alloc] init];
        
        //设置照片来源
        pickVC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        pickVC.delegate = self;
//        pickVC.allowsEditing=YES;
        [self presentViewController:pickVC animated:YES completion:nil];
    }];
    UIAlertAction * actionCancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVC addAction:actionCamora];
    [alertVC addAction:actionAlbum];
    [alertVC addAction:actionCancle];
    [self presentViewController:alertVC animated:YES completion:nil];
    

    
    
    
    
    
    
    
    
    
    
    /*
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    //picker.allowsEditing=YES;
    //    picker.allowsImageEditing = YES ;
    self.picker=picker;
    picker.delegate = self;
    picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
     */
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo{
    //    ChatCell * cell = (ChatCell * ) [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.ChatsArrs.count-1 inSection:0]];
    //    ChatModel * model = [[ChatModel alloc]init];
    //    model.meImage=image;
    //    cell.chatModel=model;
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //    ChatCellBC * cell = (ChatCellBC * ) [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.ChatsArrs.count-1 inSection:0]];
    //    ChatModel * model = [[ChatModel alloc]init];
    //    [ self.ChatsArrs addObject:model];
    //    NSIndexPath * idx = [NSIndexPath indexPathForRow:self.ChatsArrs.count-1 inSection:0];
    //
    //    UIImage * image =    info[UIImagePickerControllerOriginalImage];
    //    model.meImage=image;
    //    cell.chatModel=model;
    //    [self.tableView reloadData];
    //    [self.tableView scrollToRowAtIndexPath:idx atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    NSURL *url  = [info objectForKey:UIImagePickerControllerReferenceURL];
    
    NSString *photoPath = [self photoSavePathForURL:url toUserName: self.UserJid.user];
    
    UIImage *orginalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    // UIImage *orginalImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    // NSString * pathWithJPEG = [photoPath stringByAppendingString:@".jpeg"];
    NSData *imageData = UIImageJPEGRepresentation(orginalImage, 0.5);
    [imageData writeToFile: photoPath atomically:YES];
    
    //imageV.image = orginalImage;
    //imgSavepath = photoPath;
    
    [self uploadFileMultipartWithPath:photoPath];

}

#pragma mark 注释: 创建目录

/**创建目录*/
-(void)creatDir
{
    NSString * tempDir = [Account shareAccount].name;
    NSString * sign = self.sign ; //待实现
    COSCreateDirCommand *cm = [[COSCreateDirCommand alloc] initWithDir:tempDir
                                                                bucket:bucket
                                                                  sign:sign
                                                             attribute:@"attr" ];
    //    cm.directory = dir;
    //    cm.bucket = bucket;
    //    cm.sign = _sign;
    //    cm.attrs = @"dirTest";
    //    __weak UITextView *temp = imgUrl;
    __weak __typeof(self)weakSelf = self;
    
    self.myClient.completionHandler = ^(COSTaskRsp *resp, NSDictionary *context){
        //        UITextView *strong = temp;
        COSCreatDirTaskRsp *rsp = (COSCreatDirTaskRsp *)resp;
        
        /**
         blk_t blk = ^() {
         }
         */
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        
        /*
         // 任务描述代码，为retCode >= 0时标示成功，为负数表示为失败 /
         @property (nonatomic, assign)    int                    retCode;
         // 任务描述信息 /
         @property (nonatomic, strong)    NSString               *descMsg;
         
         @property (nonatomic, strong)    NSDictionary           *data;
         //成功后，后台返回文件数/
         @property (nonatomic, strong)    NSDictionary           *fileData;
         */
        NSLog(@"👉[%@][%d]❌%d❌" , [strongSelf class] , __LINE__ ,rsp.retCode);
        NSLog(@"👉[%@][%d]❌%@❌" , [strongSelf class] , __LINE__ ,rsp.descMsg);
        NSLog(@"👉[%@][%d]❌%@❌" , [strongSelf class] , __LINE__ ,rsp.data);
        NSLog(@"👉[%@][%d]❌%@❌" , [strongSelf class] , __LINE__ ,rsp.fileData);
        if (rsp.retCode >= 0  || rsp.retCode == - 178 ) {//创建成功 , 引用self时注意循环引用 , 用weak self
            dir = [Account shareAccount].name;
            //            strong.text = [NSString stringWithFormat:@"创建目录%@ :%@",dir,rsp.descMsg];
        }else{//创建失败
            //            strong.text = [NSString stringWithFormat:@"创建目录%@ :%@",dir,rsp.descMsg];;
        }
    };
    [self.myClient createDir:cm];
}

#pragma mark 注释: uploadMethod
-(void)uploadFileMultipartWithPath:(NSString *)path
{
    //    fileName = [NSString stringWithFormat:@"a%lld",fileName];
    //    COSObjectMultipartPutTask *task = [[COSObjectMultipartPutTask alloc] init];
    COSObjectPutTask *task = [[COSObjectPutTask alloc] init];
    /**
     参数名称       类型      是否必填        说明
     dir        NSString *	是       目录路径（相对于bucket的路径）
     bucket     NSString *	是       目录所属 bucket 名称
     sign       NSString *	是       签名
     attrs      NSString *	否       用户自定义属性
     */
    
    NSLog(@"-send---taskId---%lld",task.taskId);
    NSLog(@"_%d_%@",__LINE__,path);
    NSLog(@"_%d_%@",__LINE__,path.lastPathComponent);
    task.multipartUpload = YES;
    currentTaskid = task.taskId;
    
    task.filePath = path;
    task.fileName = path.lastPathComponent;
    task.bucket = bucket;//必填
    //task.attrs = @"customAttribute";
    if (dir) {
        task.directory = [NSString stringWithFormat:@"imfile/%@",dir];// dir ;
    }else{
        NSLog(@"👉[%@][%d]❌%@❌" , [self class] , __LINE__ ,@"路径创建失败");
    }
//    task.directory = dir;//必填
    task.insertOnly = YES;
    task.sign = self.sign;//必填
    //call back
    //    __weak UITextView *temp = imgUrl;
    __weak __typeof__(self) weakSelf = self;
    self.myClient.completionHandler = ^(COSTaskRsp *resp, NSDictionary *context){////处理上传结果回调,成功或者失败
        COSObjectUploadTaskRsp *rsp = (COSObjectUploadTaskRsp *)resp;
        //        UITextView *strong = temp;
        __strong __typeof__(weakSelf) strongSelf = weakSelf;
        
        if (rsp.retCode >= 0  && [rsp.sourceURL  containsString:@"http"]) {///** 任务描述代码，为retCode >= 0时标示成功，为负数表示为失败 */
            //            strong.text = rsp.sourceURL;
            NSString * elementID =  [[GDXmppStreamManager ShareXMPPManager].XmppStream generateUUID];
            XMPPMessage *message = [XMPPMessage messageWithType:@"chat" to:strongSelf.UserJid  elementID:elementID ];
            NSLog(@"_%d_%@",__LINE__,elementID);
            NSXMLElement *receipt = [NSXMLElement elementWithName:@"request" xmlns:@"urn:xmpp:receipts"];
            //        [receipt addAttributeWithName:@"tp" stringValue:@""];
            [receipt addAttributeWithName:@"id" stringValue:elementID];///////////////
            [message addChild:receipt];
            UIImage * img = [UIImage imageWithContentsOfFile:path] ;
            NSLog(@"_%d_%@",__LINE__,NSStringFromCGSize(img.size));
            
            NSString * targetURL = rsp.sourceURL;
            if ([targetURL containsString:@"/imfile/"]) {
                NSRange imfileRange = [targetURL rangeOfString:@"/imfile/"];
                targetURL = [targetURL substringFromIndex:imfileRange.location];
            }
            targetURL = [NSString stringWithFormat:@"https://i0.zjlao.com%@",targetURL];
            [message addBody:[NSString stringWithFormat:@"img:%@?width=%f&height=%f",targetURL,img.size.width > 0 ? img.size.width : [UIScreen mainScreen].bounds.size.width / 3  , img.size.height > 0 ? img.size.height :  [UIScreen mainScreen].bounds.size.width / 3]];
            
            [[GDXmppStreamManager ShareXMPPManager].XmppStream sendElement:message];
            NSLog(@"腾讯云文件上传成功context  = %@",context);
            NSLog(@"_%d_%d",__LINE__,rsp.retCode);
            NSLog(@"上传成功后文件链接为:  %@",rsp.sourceURL);
            NSLog(@"_%d_%@",__LINE__,rsp.descMsg);
            NSLog(@"_%d_%@",__LINE__,rsp.acessURL);
            NSLog(@"_%d_%@",__LINE__,rsp.httpsURL);
            NSLog(@"_%d_%@",__LINE__,rsp.data);
            
            
        }else{//上传失败
            //            strong.text = rsp.descMsg;
            NSLog(@"腾讯云文件上传失败context  = %@",context);
            [GDAlertView alert:@"图片发送失败\n请重试" image:nil time:2 complateBlock:^{
                
            }];
//            [[UserInfo shareUserInfo] gotTencentYunSuccess:^(ResponseObject *response) {
//                NSLog(@"_%d_%@",__LINE__,response.data);
//                if (response.data) {
//                    strongSelf.sign = response.data;
//                }
//            } failure:^(NSError *error) {
//                NSLog(@"_%d_%@",__LINE__,error);
//            }];
            [[NetworkManager shareManager] gotTencentYunSign:^(OriginalNetDataModel * _Nonnull resultModel) {
                if (resultModel.data) {
//                    strongSelf.sign = resultModel.data;
                    NSString * tempSign = (NSString*)resultModel.data;
                    NSString* signEncode = [tempSign stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//
                    strongSelf.sign = signEncode;
                    [strongSelf creatDir];
                }
            } failure:^(NSError * _Nonnull error) {
                
            }];
            NSLog(@"_%d_%@",__LINE__,resp.descMsg);
            NSLog(@"_%d_%d",__LINE__,resp.retCode);
        }
    };
    
    self.myClient.progressHandler = ^(int64_t bytesWritten,int64_t totalBytesWritten,int64_t totalBytesExpectedToWrite){//进度条展示TODO
        NSLog(@"_%d_上传进度 bytesWritten:%lld_totalBytesWritten:%lld_totalBytesExpectedToWrite:%lld",__LINE__,bytesWritten , totalBytesWritten , totalBytesExpectedToWrite);
        //        UITextView *strong = temp;
        //        strong.text = [NSString stringWithFormat:@"进度展示：bytesWritten %ld.totalBytesWritten %ld.totalBytesExpectedToWrite %ld",(long)bytesWritten,(long)totalBytesWritten,(long)totalBytesExpectedToWrite];
    };
    [self.myClient putObject:task];
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
    //    NSString *urlString = [url absoluteString];//assets-library://asset/asset.JPG?id=B8AF65AA-213B-484B-96F3-CAD73D1DE1F0&ext=JPG
    NSDate * date = [NSDate date];
    NSTimeInterval time =  date.timeIntervalSince1970;
    NSString * theFileName =  [NSString stringWithFormat:@"%ld",(NSInteger)time];
    
    
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
    //     NSLog(@"_%d_%@",__LINE__,urlString);
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

#pragma mark 注释: downLoadMethod
-(void)downloadFileWithURLStr:(NSString*)urlStr
{
    NSString * imageUrlStr = @"http://zhijielao-1252811222.file.myqcloud.com/b61a5df76bfb8ae8cdf2b66c1e49329b.jpeg";
    //    if (urlStr.length==0) {
    //        UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"错误" message:@"urlisnull" delegate:nil cancelButtonTitle:@"sure" otherButtonTitles:nil, nil];
    //        [a show];
    //        return;
    //    }
    
    COSObjectGetTask *cm = [[COSObjectGetTask alloc] initWithUrl:imageUrlStr];
    self.myClient.completionHandler = ^(COSTaskRsp *resp, NSDictionary *context){
        
        COSGetObjectTaskRsp *rsp = (COSGetObjectTaskRsp *)resp;
        NSLog(@"腾讯云文件下载成功context  = %@",context);
        NSLog(@"_%d_%d",__LINE__,rsp.retCode);
        NSLog(@"_%d_%@",__LINE__,rsp.descMsg);
        NSLog(@"_%d_%@",__LINE__,rsp.data);
        
        NSString * savePath =  [self doloadImgSavePathForURL:imageUrlStr toUserName:self.UserJid.user];
        
        NSString * imgUrl = nil ;
        imgUrl = [NSString stringWithFormat:@"下载retCode = %d retMsg= %@",rsp.retCode,rsp.descMsg];
        UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"文件大小" message:[NSString stringWithFormat:@"%lu B",(unsigned long)rsp.object.length] delegate:nil cancelButtonTitle:@"sure" otherButtonTitles:nil, nil];
        [a show];
        
    };
    
    self.myClient.downloadProgressHandler = ^(int64_t receiveLength,int64_t contentLength){
        NSLog(@"_%d_%lld_%lld",__LINE__,receiveLength , contentLength);
        //        imgUrl.text = [NSString stringWithFormat:@"receiveLength =%ld,contentLength%ld",(long)receiveLength,(long)contentLength];;
        
    };
    [self.myClient getObject:cm];
}

#pragma mark － 腾讯签名成功
-(void)getSignFinis:(NSString *)string
{
    if (string) {
        self.sign = string;
        NSLog(@"self.sign = %@",self.sign);
        //imgUrl.text =self.sign;
    }else{
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"警告" message:@"签名为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [al show];
    }
}
-(void)getSign
{
    //网络请求工具类
    self.client = [[HttpClient alloc] init];
    self.client.vc = self;
    //向自己的业务服务器请求 上传所需要的签名
    [self getUploadSign];
}
-(void)getUploadSign
{
    //NSString *url = [NSString stringWithFormat:@"http://203.195.194.28/cosv4/getsignv4.php?bucket=%@&service=video",bucket];
    //    NSString * url = [NSString stringWithFormat:@"http://192.168.5.30/cosAuth.php?bucket=%@&service=video",bucket];// @"http://192.168.5.30/cosAuth.php";
    NSString * url = [NSString stringWithFormat:@"http://192.168.5.30/cosAuth.php"];// @"http://192.168.5.30/cosAuth.php";
    [self.client getSignWithUrl:url callBack:@selector(getSignFinis:)];
}

-(void)navigationBack
{
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.tabBarItem.badgeValue = nil ;
    //    [[KeyVC shareKeyVC] popViewControllerAnimated:YES];
}
//-(void)changeTableViewContentInsetBottom:(CGFloat)bottom{
//     self.tableView.contentInset=UIEdgeInsetsMake(0, 0, bottom, 0);
//
//
//
//}


#pragma mark  //////////////////xmpp相关//////////////////////
-(NSArray *)ChatsArrs
{
    if (_ChatsArrs == nil) {
        _ChatsArrs = [NSArray array];
    }
    return _ChatsArrs;
}

-(NSFetchedResultsController *)fetchedresultscontroller
{
    if (_fetchedresultscontroller == nil) {
        
        NSFetchRequest *fetchrequest = [[NSFetchRequest alloc]init];
        //        [fetchrequest setFetchLimit:20];
        //从游离态中获取实体描述
        NSEntityDescription *entitys = [NSEntityDescription entityForName:@"XMPPMessageArchiving_Message_CoreDataObject" inManagedObjectContext:[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext];
        //设置实体描述
        fetchrequest.entity = entitys;
        
        
        //设置谓词(条件筛选)
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"bareJidStr = %@",self.UserJid.bare];
        fetchrequest.predicate = pre;
        //
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES];
        fetchrequest.sortDescriptors = @[sort];
        
        _fetchedresultscontroller = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchrequest managedObjectContext:[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext sectionNameKeyPath:nil cacheName:@"Message"];
        
        //设置代理
        _fetchedresultscontroller.delegate = self;
        /** 好友列表对象 */
        //        [[GDXmppStreamManager ShareXMPPManager].XmppRoster addDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    return _fetchedresultscontroller;
}
//-(void)setEditing:(BOOL)editing animated:(BOOL)animated{}
//代理 , 每当收到数据的时候回调用一次,发消息是 也 会自动调用  , 用来更新数据
-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES];
    
    self.ChatsArrs = [self.fetchedresultscontroller.fetchedObjects sortedArrayUsingDescriptors:@[sort]];
    //    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.ChatsArrs);
    [self.tableView reloadData];
    //    LOG(@"_%@_%d_%ld",[self class] , __LINE__,self.ChatsArrs.count);
    if (self.ChatsArrs.count > 1) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:self.ChatsArrs.count -1 inSection:0];
        [self.tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
}
-(void)tESAst
{
    // NSManagedObject
}
-(void)customDelete:(NSNotification*)note
{
    [self.textView deleteBackward];
    NSLog(@"_%@_%d_%@",[self class] , __LINE__,note);
}








-(void)inputBrow:(NSNotification*)note
{
    
    
    
    self.textView.font = [UIFont systemFontOfSize:14 ];
    NSLog(@"_%@_%d_/%@; %@",[self class] , __LINE__,note.userInfo[@"code"],note.userInfo[@"title"]);
    NSString * imgName = note.userInfo[@"code"];
    imgName=  [imgName stringByReplacingOccurrencesOfString:@";" withString:@""];
    imgName= [imgName stringByReplacingOccurrencesOfString:@"/" withString:@""];
    NSRange currentRange = self.textView.selectedRange;
    
    
    
    /** 用于展示 */
    NSMutableAttributedString * currentAttributStr = [[NSMutableAttributedString alloc]initWithAttributedString:self.textView.attributedText];
    GDTextAttachment * tachment = [[GDTextAttachment alloc]init];
    tachment.desc = [NSString stringWithFormat:@"/%@;",note.userInfo[@"code"]];
    NSString * imgPath =  [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"Resource" ofType:@"bundle"]] pathForResource:imgName ofType: @"gif" inDirectory:@"face_img"];
    tachment.image = [UIImage imageWithContentsOfFile:imgPath];
    tachment.bounds = CGRectMake(0, -4, self.textView.font.lineHeight, self.textView.font.lineHeight);
    NSAttributedString * showStr = [NSAttributedString attributedStringWithAttachment:tachment];
    
    /** 拼回去 */
    [currentAttributStr replaceCharactersInRange:currentRange withAttributedString:showStr];
    
    [currentAttributStr  addAttribute:NSFontAttributeName value:self.textView.font range:NSMakeRange(0, currentAttributStr.length)];
    
    //    /** 在这调一个方法 解析属性字符串 */
    //   NSAttributedString * result =  [self dealTheStr:currentAttributStr.string];
    
    self.textView.attributedText = currentAttributStr;
    
    /**把标也放回去 */
    self.textView.selectedRange = NSMakeRange(currentRange.location+showStr.length, 0);
    
    NSLog(@"_%@_%d_%@",[self class] , __LINE__,self.textView.attributedText);
    
    //    [self.textView.attributedText  enumerateAttribute:<#(nonnull NSString *)#> inRange:<#(NSRange)#> options:<#(NSAttributedStringEnumerationOptions)#> usingBlock:<#^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop)block#>]
    
    
    
}

-(NSAttributedString*)dealTheStr:(NSString*)str
{
    NSLog(@"_%@_%d_%@",[self class] , __LINE__,str);
    NSMutableAttributedString * mAttriStr = [[NSMutableAttributedString alloc]initWithString:str];
    
    NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:@"/[a-zA-Z]+;" options:NSRegularExpressionCaseInsensitive error:nil];
    NSLog(@"_%@_%d_%@",[self class] , __LINE__,mAttriStr);
    NSArray * matches = [regex matchesInString:str options:0 range:NSMakeRange(0, str.length)];
    NSLog(@"_%@_%d_%@",[self class] , __LINE__,matches);
    if (matches) {
        for (NSTextCheckingResult * result  in matches) {
            NSLog(@"_%@_%d_%@",[self class] , __LINE__,NSStringFromRange(result.range));
            /** 取出图片名 */
            NSString * imgName = [str substringWithRange:result.range];
            imgName=  [imgName stringByReplacingOccurrencesOfString:@";" withString:@""];
            imgName= [imgName stringByReplacingOccurrencesOfString:@"/" withString:@""];
            NSTextAttachment * tachment = [[NSTextAttachment alloc]init];
              NSString * imgPath =  [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"Resource" ofType:@"bundle"]] pathForResource:imgName ofType: @"gif" inDirectory:@"face_img"];
            tachment.image = [UIImage imageWithContentsOfFile:imgPath];//gotResourceInSubBundle(imgName, @"gif", @"face_img")];
            NSAttributedString * imgStr = [NSAttributedString attributedStringWithAttachment:tachment];
            [mAttriStr replaceCharactersInRange:result.range withAttributedString:imgStr];
            
            
            NSLog(@"_%@_%d_%@",[self class] , __LINE__,imgName);
        }
    }
    
    
    
    
    return mAttriStr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(customDelete:) name:@"CUSTOMDELETE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputBrow:) name:@"INPUTBROW" object:nil];
    //设置头像代理
    //    [[GDXmppStreamManager ShareXMPPManager].xmppvcardavatarModule addDelegate:self delegateQueue:dispatch_get_main_queue()];
     NSLog(@"_%d_%@",__LINE__,self.keyParamete);
    if (!self.UserJid) {
        self.UserJid = self.keyParamete[@"paramete"];
    }else{
     NSLog(@"_%d_%@",__LINE__,self.keyParamete);
    }
     NSLog(@"_%d_%@",__LINE__,self.UserJid.user);
    XMPPvCardTemp * vcard = [[GDXmppStreamManager ShareXMPPManager].xmppvcardtempModule vCardTempForJID:self.UserJid shouldFetch:YES];
    [[GDXmppStreamManager ShareXMPPManager].xmppvcardtempModule addDelegate:self  delegateQueue:dispatch_get_main_queue()];
    if (vcard.nickname.length>0 && ![vcard.nickname isEqualToString:@"null"]) {
        self.naviTitle =  vcard.nickname ;
        
    }else{
        if ([self.UserJid.user isEqualToString:@"kefu"]) {
            self.naviTitle =  @"直接捞客服" ;
        }else{
//            self.naviTitle = self.UserJid.user;
            if ([self.UserJid.user hasPrefix:@"z~"]) {
                self.naviTitle = [self.UserJid.user stringByReplacingOccurrencesOfString:@"z~" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, 2)];
            }else{
                self.naviTitle = self.UserJid.user;
            }
             NSLog(@"_%d_%@",__LINE__,self.naviTitle);
             NSLog(@"_%d_%@",__LINE__,self.UserJid.user);
        }
    }
    NSLog(@"_%@_%d_%@",[self class] , __LINE__,self.keyParamete);
    NSLog(@"_%@_%d_%@",[self class] , __LINE__,self.UserJid);
    NSLog(@"_%@_%d_%@",[self class] , __LINE__,self.UserJid.full);
    [self setupUI];
    
    //执行查询控制器
    [NSFetchedResultsController deleteCacheWithName:@"Message"];
    
    /** 原来(始) */
    [self.fetchedresultscontroller performFetch:nil];
    NSLog(@"_%@_%d_%@",[self class] , __LINE__,@"先执行");
    self.ChatsArrs = self.fetchedresultscontroller.fetchedObjects;
    if (self.ChatsArrs.count > 10) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:self.ChatsArrs.count -1 inSection:0];
        [self.tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    /** 原来(终) */
    appId = @"1252811222";
    bucket = @"zjlaoi0";
    //dir = @"imfile";
    //self.sign = @"qQ4mfAaITVDgjmynW7v5xarwwU1hPTEwMDU3MzQ2Jms9QUtJRDVyRnAyYWdUaWNyR3Z0ZXBLRmVDbnpLQ1JNWUhFaFhqJmU9MTQ4Njg4MDkzOCZ0PTE0ODY4NzkxMzgmcj0xODUxMzEwODMyJmY9L2ltZmlsZSZiPXpqbGFvc3g";
    self.myClient = [[COSClient alloc] initWithAppId:appId withRegion:@"tj"];
    [[NetworkManager shareManager] gotTencentYunSign:^(OriginalNetDataModel * _Nonnull resultModel) {
        if (resultModel.data) {
//            self.sign = resultModel.data;
            NSString * tempSign = (NSString*)resultModel.data;
            NSString* singEncode = [tempSign stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//
            
            self.sign = singEncode;
            [self creatDir];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
//    [[UserInfo shareUserInfo] gotTencentYunSuccess:^(ResponseObject *response) {
//        NSLog(@"_%d_%@",__LINE__,response.data);
//        if (response.data) {
//            self.sign = response.data;
//        }
//    } failure:^(NSError *error) {
//        NSLog(@"_%d_%@",__LINE__,error);
//    }];
    // Do any additional setup after loading the view.
}
- (void)xmppvCardTempModule:(XMPPvCardTempModule *)vCardTempModule
        didReceivevCardTemp:(XMPPvCardTemp *)vCardTemp
                     forJID:(XMPPJID *)jid{
    if (vCardTemp.nickname.length>0 && ![vCardTemp.nickname isEqualToString:@"null"]) {
        
        self.naviTitle = vCardTemp.nickname;
    }
    NSLog(@"_%@_%d_本地没有昵称 , 服务器请求后返回的%@----%@",[self class] , __LINE__,vCardTemp.nickname , jid.user);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}


//发送消息
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSData * data = [[NSData alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"loading.gif" ofType:nil]];
//    [[GDXmppStreamManager ShareXMPPManager] sendImageMessage:data toAccount:@"zhangkaiqiang"];
//
//
//}


//- (void)turnSocket:(TURNSocket *)sender didSucceed:(GCDAsyncSocket *)socket{
//    LOG(@"_%@_%d_文件传输相关%@",[self class] , __LINE__,sender);
//    //    XMPPSIFileTransfer * ssss = [XMPPSIFileTransfer new];
//}

//- (void)turnSocketDidFail:(TURNSocket *)sender{
//    LOG(@"_%@_%d_文件传输相关%@",[self class] , __LINE__,sender);
//
//}


#pragma mark Roster(好友列表)的代理
/** 收到添加好友的请求信息 */
//-(void)xmppRoster:(XMPPRoster *)sender didReceivePresenceSubscriptionRequest:(XMPPPresence *)presence
//{
//    LOG(@"_%@_%d_收到添加好友请求 XMPPRoster:%@\nXMPPPresence:%@",[self class] , __LINE__,sender,presence);
//    [[GDXmppStreamManager ShareXMPPManager].XmppRoster acceptPresenceSubscriptionRequestFrom:presence.from andAddToRoster:YES];//同意
//
//}

//删除好友
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //    XMPPUserCoreDataStorageObject *user = self.RecentlyArrs[indexPath.row];
//    XMPPJID *jid =  [XMPPJID jidWithUser:@"caohenghui" domain:@"jabber.zjlao.com" resource:@"fuck"];
//    [[GDXmppStreamManager ShareXMPPManager].XmppRoster removeUser:jid];
//}

/** 添加好友请求 */
//- (IBAction)AddFrend:(UIBarButtonItem *)sender {
//
//    [[GDXmppStreamManager ShareXMPPManager].XmppRoster addUser:[XMPPJID jidWithUser:@"zhangkaiqiang" domain:@"jabber.zjlao.com" resource:@"fuck"] withNickname:@"我来加你好友啦"];
//
//
//}


//头像代理
//刷新头像
//-(void)xmppvCardAvatarModule:(XMPPvCardAvatarModule *)vCardTempModule didReceivePhoto:(UIImage *)photo forJID:(XMPPJID *)jid
//{
//    [self.tableView reloadData];
//}































#pragma mark UI




@end





















































////
////  ChatVC.m
////  b2c
////
////  Created by wangyuanfei on 16/5/11.
////  Copyright © 2016年 www.16lao.com. All rights reserved.
////
//
//#import "ChatVC.h"
////#import "Base64.h"
////#import "GCDAsyncSocket.h"
//#import "ChatCellBC.h"
//#import "MeChatCell.h"
//#import "OtherChatCell.h"
//
//#import "ChatModel.h"
//
//#import "PerformChatTool.h"
//
//
///** xmpp开始 */
//#import "GDXmppStreamManager.h"
//#import "XMPPJID.h"
//
//#import "TURNSocket.h"
//
//#import "GDTextView.h"
//#import "GDKeyBoard.h"
//#import "GDTextAttachment.h"
///** xmpp结束 */
//#import "XMPPMessage+XEP_0172.h"
//
//
//#import "TestScrollViewProPerty.h"
//
//@interface ChatVC ()<UITableViewDataSource,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate/*,UITextInputDelegate*/,UITextViewDelegate ,/** xmpp相关协议 */NSFetchedResultsControllerDelegate,XMPPRosterDelegate,XMPPvCardTempModuleDelegate,XMPPvCardAvatarDelegate>
//
//@property(nonatomic,strong)NSXMLParser * xml ;
//
///** <#注释#> */
//@property (nonatomic, strong) NSMutableArray *dataSources;/**数据源*/
//
////UI
///** 辅助键盘 */
//@property(nonatomic,strong)UIView * inputView ;
///** 输入框 属于inputview的子空间 */
//@property(nonatomic,weak)   GDTextView * textView ;//
///** 表情键盘 */
//@property(nonatomic,strong)GDKeyBoard *  browKeyBoard ;
//@property(nonatomic,strong)UIImagePickerController * picker ;
//@property(nonatomic,assign)BOOL  isKeyboardShow ;
//@property(nonatomic,strong)PerformChatTool * chatTool ;
//
//@property(nonatomic,assign)BOOL  needShowKeyboardAgain ;
////@property(nonatomic,copy)NSString * sessionID ;
////@property(nonatomic,strong)NSTimer * timer ;
//
///** xmpp开始 */
////查询请求控制器
//@property (nonatomic ,strong)NSFetchedResultsController *fetchedresultscontroller;
//
//@property (nonatomic , strong)NSArray *ChatsArrs;
//@property(nonatomic,assign)CGFloat  keyboardHeight ;
//@property(nonatomic,weak)UIButton * browButton ;//表情按钮
///** xmpp结束 */
//
//@end
//
//@implementation ChatVC
//
////#define  gotResourceWithSourceName(a)sourceType()SourceDirectory()  NSString * path = [[NSBundle mainBundle] pathForResource:@"Resource" ofType:@"bundle"];
////NSBundle * subBundel = [NSBundle bundleWithPath:path];
////NSString * soundPath = [subBundel pathForResource:@"msg" ofType:@"mp3" inDirectory:@"Sound"];
//
//
//
////- (void)viewDidLoad {
////    [super viewDidLoad];
////    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(customDelete:) name:@"CUSTOMDELETE" object:nil];
////    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputBrow:) name:@"INPUTBROW" object:nil];
////    //设置头像代理
////    [[GDXmppStreamManager ShareXMPPManager].xmppvcardavatarModule addDelegate:self delegateQueue:dispatch_get_main_queue()];
////    if (!self.UserJid) {
////        self.UserJid = self.keyParamete[@"paramete"];
////    }
////    self.naviTitle = self.UserJid.user;
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.keyParamete);
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.UserJid);
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.UserJid.full);
////    [self setupUI];
////    
////    //执行查询控制器
////    [NSFetchedResultsController deleteCacheWithName:@"Message"];
////    
////    /** 原来(始) */
////    [self.fetchedresultscontroller performFetch:nil];
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"先执行");
////    self.ChatsArrs = self.fetchedresultscontroller.fetchedObjects;
////    if (self.ChatsArrs.count > 10) {
////        NSIndexPath *index = [NSIndexPath indexPathForRow:self.ChatsArrs.count -1 inSection:0];
////        [self.tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:NO];
////    }
////    /** 原来(终) */
////    
////    // Do any additional setup after loading the view.
////}
////
////
////
////
//////- (void)viewDidLoad {
//////    [super viewDidLoad];
//////    self.UserJid = self.keyParamete[@"paramete"];
//////    [self setupUI];
//////    UIButton * sendMessageButton = [[UIButton alloc]init];
//////    [sendMessageButton setTitle:@"send" forState:UIControlStateNormal];
//////    [sendMessageButton.titleLabel setFont:[UIFont systemFontOfSize:10]];
//////    [sendMessageButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//////    self.navigationBarRightActionViews=@[sendMessageButton];
//////    [sendMessageButton addTarget:self action:@selector(sendMessageClick:) forControlEvents:UIControlEventTouchUpInside];
//////
//////}
////#pragma mark UI
////-(void)setupUI
////{
////    NSString * sourctPath = gotResourceInSubBundle(@"cy", @"gif", @"face_img");
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,sourctPath);
////    self.automaticallyAdjustsScrollViewInsets  = NO;
////    [self setupTableView];
////    
////    [self setupInputView];
////    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
////    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
////    
////        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
////    
////    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
////    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
////    
////}
////
////-(void)viewWillLayoutSubviews{
////    [super viewWillLayoutSubviews];
////    [self.textView becomeFirstResponder];
////    if (self.ChatsArrs.count>0) {
////        
////        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.ChatsArrs.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
////        
////    }
////    
////}
////
////#pragma mark tableViewDataSource
////-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
////    return self.ChatsArrs.count;
////}
////-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//////    ChatCellBC * cell = [tableView dequeueReusableCellWithIdentifier:@"ChatCellBC"];
//////    if (!cell) {
//////        cell=[[ChatCellBC alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChatCellBC"];
//////    }
//////
//////    XMPPMessageArchiving_Message_CoreDataObject * message  = self.ChatsArrs[indexPath.row];
//////
//////    //注意,这里的头像有两个方向
//////       cell.chatMessageModel=message;
//////    if (message.isOutgoing) {
//////        //我发出去
//////        NSData *avatordata = [GDXmppStreamManager ShareXMPPManager].xmppvcardtempModule.myvCardTemp.photo;
//////     
//////        UIImage * image = [UIImage imageWithData:avatordata];
//////        cell.rightImg = image;
//////        
//////    }else
//////    {//别人发出去的
//////        NSData *avatordata = [[GDXmppStreamManager ShareXMPPManager].xmppvcardavatarModule photoDataForJID:self.UserJid];
//////        UIImage * image  = [UIImage imageWithData:avatordata];
//////        cell.leftImg = image;
//////    }
//////
//////    return cell;
////    
//////    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//////    if (!cell) {
//////        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//////    }
//////    cell.backgroundColor = randomColor;
//////    return cell;
////    
////    
////        XMPPMessageArchiving_Message_CoreDataObject * message  = self.ChatsArrs[indexPath.row];
////    
////        //注意,这里的头像有两个方向
////    
////    UITableViewCell * cell = nil ;
////        if (message.isOutgoing) {
////            //我发出去
////            cell = [tableView dequeueReusableCellWithIdentifier:@"MeChatCell"];
////            if (!cell) {
////                cell=[[MeChatCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MeChatCell"];
////            }
////            OtherChatCell * me = (OtherChatCell*)cell ;
////            me.chatMessageModel=message;
////            return me;
////        }else  {//别人发出去的
////
////            cell = [tableView dequeueReusableCellWithIdentifier:@"OtherChatCell"];
////            if (!cell) {
////                cell=[[OtherChatCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OtherChatCell"];
////            }
////            OtherChatCell * other = (OtherChatCell*)cell ;
////            other.chatMessageModel=message;
////            return other;
////        }
////    
////    
////    
////    
////    
////}
////
////-(void)viewDidAppear:(BOOL)animated{
////    [super viewDidAppear:animated];
////    LOG(@"_%@_%d_bouns-->%@",[self class] , __LINE__,NSStringFromCGRect(self.tableView.bounds));
////    
////    LOG(@"_%@_%d_frame-->%@",[self class] , __LINE__,NSStringFromCGRect(self.tableView.frame));
////    
////    LOG(@"_%@_%d_contentSize-->%@",[self class] , __LINE__,NSStringFromCGSize(self.tableView.contentSize));
////    
////    LOG(@"_%@_%d_contentOffset-->%@",[self class] , __LINE__,NSStringFromCGPoint(self.tableView.contentOffset));
////    
////    LOG(@"_%@_%d_contentInset-->%@\n",[self class] , __LINE__,NSStringFromUIEdgeInsets(self.tableView.contentInset));
////}
////
////#pragma mark tableViewDelegate
////-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
////    
////        LOG(@"_%@_%d_\n\n\n%@\n",[self class] , __LINE__,@"停止滚动惯性方法中的数据");
////        LOG(@"_%@_%d_bouns-->%@",[self class] , __LINE__,NSStringFromCGRect(self.tableView.bounds));
////    
////        LOG(@"_%@_%d_frame-->%@",[self class] , __LINE__,NSStringFromCGRect(self.tableView.frame));
////    
////        LOG(@"_%@_%d_滚动范围contentSize-->%@",[self class] , __LINE__,NSStringFromCGSize(self.tableView.contentSize));
////    
////        LOG(@"_%@_%d_当前偏移量contentOffset-->%@",[self class] , __LINE__,NSStringFromCGPoint(self.tableView.contentOffset));
////    
////        LOG(@"_%@_%d_容器视图的偏移量contentInset-->%@\n\n\n\n",[self class] , __LINE__,NSStringFromUIEdgeInsets(self.tableView.contentInset));
//////    if (self.ChatsArrs.count>0) {
//////        if ([self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] == self.tableView.visibleCells[0]){
////            //        NSMutableArray * arr = [ NSMutableArray arrayWithCapacity:10];
////            //        NSMutableArray * idxArr = [NSMutableArray arrayWithCapacity:10];
////            //        int a = self.i;
////            //        for ([self i]  ; self.i<40+a; self.i++) {
////            //            ChatModel * model = [[ChatModel alloc]init];
////            //
////            //            if (self.i%2==0) {
////            //                model.isMe=YES;
////            //            }else{
////            //                model.isMe=NO;
////            //            }
////            //            model.txtContent=[NSString stringWithFormat:@"%d",self.i];
////            //            [ arr addObject:model];
////            ////            [self.ChatsArrs insertObject:model atIndex:0];
////            //            NSIndexPath * idx = [NSIndexPath indexPathForRow:self.i inSection:0];
////            //            [idxArr addObject:idx];
////            //        }
////            //        [self.tableView reloadData];
////            //        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:40 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
////            
//////        }
//////    }
////    
////    
////}
//////拖动调整键盘
////-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
////    LOG(@"_%@_%d_%d",[self class] , __LINE__,self.isKeyboardShow)
////    if (scrollView != self.tableView) {
////        return;
////    }
////    if (self.isKeyboardShow) {
////        [self.textView resignFirstResponder];
////    }else{
////        LOG(@"_%@_%d_%@",[self class] , __LINE__,NSStringFromCGPoint(self.tableView.contentOffset))
////        LOG(@"_%@_%d_%@",[self class] , __LINE__,NSStringFromCGSize(self.tableView.contentSize))
////        if (self.tableView.contentOffset.y+self.tableView.bounds.size.height>self.tableView.contentSize.height) {
////            [self.textView becomeFirstResponder];
////        }
////    }
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.textView.inputView)
////    
////}
////
////-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//////    LOG(@"_%@_%d_\n\n\n%@\n",[self class] , __LINE__,@"正在滚动方法中的数据");
//////    LOG(@"_%@_%d_bouns-->%@",[self class] , __LINE__,NSStringFromCGRect(self.tableView.bounds));
//////    
//////    LOG(@"_%@_%d_frame-->%@",[self class] , __LINE__,NSStringFromCGRect(self.tableView.frame));
//////    
//////    LOG(@"_%@_%d_滚动范围contentSize-->%@",[self class] , __LINE__,NSStringFromCGSize(self.tableView.contentSize));
//////    
//////    LOG(@"_%@_%d_当前偏移量contentOffset-->%@",[self class] , __LINE__,NSStringFromCGPoint(self.tableView.contentOffset));
//////    
//////    LOG(@"_%@_%d_容器视图的偏移量contentInset-->%@\n\n正在滚动方法中的数据\n\n\n",[self class] , __LINE__,NSStringFromUIEdgeInsets(self.tableView.contentInset));
////}
////
////-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
//// LOG(@"_%@_%d_\n\n\n%@\n",[self class] , __LINE__,@"滚动动画结束方法中的数据");
////    LOG(@"_%@_%d_bouns-->%@",[self class] , __LINE__,NSStringFromCGRect(self.tableView.bounds));
////    
////    LOG(@"_%@_%d_frame-->%@",[self class] , __LINE__,NSStringFromCGRect(self.tableView.frame));
////    
////    LOG(@"_%@_%d_滚动范围contentSize-->%@",[self class] , __LINE__,NSStringFromCGSize(self.tableView.contentSize));
////    
////    LOG(@"_%@_%d_当前偏移量contentOffset-->%@",[self class] , __LINE__,NSStringFromCGPoint(self.tableView.contentOffset));
////    
////    LOG(@"_%@_%d_容器视图的偏移量contentInset-->%@\n\\n",[self class] , __LINE__,NSStringFromUIEdgeInsets(self.tableView.contentInset));
////
////}
////
////
////#pragma mark textViewdelegate
//////发送消息
////-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
////{
////    
////    if ([text isEqualToString:@"\n"]) {
////        LOG(@"_%@_%d_%lu",[self class] , __LINE__,(unsigned long)textView.text.length)
////        //        ChatModel * model = [[ChatModel alloc]init];
////        //        model.txtContent=[NSString stringWithFormat:@"%d",self.i++];
////        //        [ self.ChatsArrs addObject:model];
////        NSIndexPath * idx = [NSIndexPath indexPathForRow:self.ChatsArrs.count-1 inSection:0];
////        //        model.txtContent=textView.text;
////        //        [self.chatTool sendMessage:model.txtContent usersId:@"4" messageType:1];
////        //        textView.text=@"";
////        //        //        self.tableView.contentInset=UIEdgeInsetsMake(0, 0, 258+50, 0);
////        
////        XMPPMessage *message = [XMPPMessage messageWithType:@"chat" to:self.UserJid];
////        
////        [message addBody:self.textView.sendStr];
////        
////        [[GDXmppStreamManager ShareXMPPManager].XmppStream sendElement:message];
////        self.textView.text = nil ;
////        //        [self.tableView reloadData];
////        //        [self.tableView scrollToRowAtIndexPath:idx atScrollPosition:UITableViewScrollPositionBottom animated:YES];
////        return NO;
////    }
////    return YES;
////}
////#pragma mark customMethod
////
////-(GDKeyBoard *)browKeyBoard{
////    if (_browKeyBoard==nil) {
////        CGFloat keyboardH = 0;
////        if (screenW<321) {//4,5
////            keyboardH = 216;
////        }else if (screenW<321) {//6
////            keyboardH = 226 ;
////        }else if (screenW<376) {//6p
////            keyboardH = 258 ;
////        }else {
////            keyboardH = 258 ;
////        }
////        GDKeyBoard * keyBoard =[[GDKeyBoard alloc]initWithFrame: CGRectMake(0, 0, screenW,keyboardH )];
////        NSMutableArray * bigArrm = [NSMutableArray new];
////        NSString * path = gotResourceInSubBundle(@"brow", @"plist", @"face_img");
////        NSArray * littleArr = [NSArray arrayWithContentsOfFile:path];
////        [bigArrm addObject:littleArr];
////        keyBoard.allBrowNames = bigArrm;
////        LOG(@"_%@_%d_%@",[self class] , __LINE__,keyBoard.allBrowNames);
////        _browKeyBoard = keyBoard;
////    }
////    return _browKeyBoard;
////}
////
////-(void)showBrow:(UIButton * ) sender
////{
////
////    if (self.isKeyboardShow) {//正常切换
//////        [self.textView resignFirstResponder];
////        if (self.textView.inputView) {//切换到键盘
////            self.textView.inputView = nil;
//////            [self.textView reloadInputViews];
//////            [self.textView becomeFirstResponder];
////        }else{//切换到表情
////          
////            self.textView.inputView = self.browKeyBoard;
//////            [self.textView becomeFirstResponder];
////        }
////        
////    }else{
////        if (self.textView.inputView) {//切换到表情
////            self.textView.inputView = self.browKeyBoard;
//////            [self.textView becomeFirstResponder];
////        }else{//切换到键盘
////            self.textView.inputView = nil;
//////            [self.textView becomeFirstResponder];
////        }
////        [self.textView becomeFirstResponder];
////    }
////    [self.textView reloadInputViews];
////}
////-(void)keyboardWillChanged:(NSNotification*)note
////{
////    if (self.textView.inputView) {//当前为表情键盘 , 按钮状态显示键盘
////        self.browButton.selected = YES ;
////    }else{//当前为键盘 , 按钮状态显示表情
////        self.browButton.selected = NO ;
////    }
////}
////
////#pragma mark 键盘的改变
////-(void)keyboardWillHide:(NSNotification*)note
////{
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,[NSThread currentThread]);
////    self.isKeyboardShow=NO;
////    double duration =  [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
////    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
////    if (self.keyboardHeight==0) {
////        self.keyboardHeight=keyboardFrame.size.height;;
////    }
////    
////    [UIView animateWithDuration:duration animations:^{
////        self.inputView.mj_y=screenH-self.inputView.bounds.size.height;
////        [self.tableView setContentInset:UIEdgeInsetsZero];
////        
////    }];
////    
////    
////}
////-(void)keyboardDidHide:(NSNotification*)note
////{
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,[NSThread currentThread]);
////    [self.tableView setContentInset:UIEdgeInsetsZero];
////}
////
////-(void)keyboardDidShow:(NSNotification*)note
////{
////    
////    
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"键盘出来以后的数据\n");
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,[NSThread currentThread]);
////     [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, self.keyboardHeight+self.inputView.bounds.size.height, 0)];
////    LOG(@"_%@_%d_bouns-->%@",[self class] , __LINE__,NSStringFromCGRect(self.tableView.bounds));
////    
////    LOG(@"_%@_%d_frame-->%@",[self class] , __LINE__,NSStringFromCGRect(self.tableView.frame));
////    
////    LOG(@"_%@_%d_contentSize-->%@",[self class] , __LINE__,NSStringFromCGSize(self.tableView.contentSize));
////    
////    LOG(@"_%@_%d_contentOffset-->%@",[self class] , __LINE__,NSStringFromCGPoint(self.tableView.contentOffset));
////    
////    LOG(@"_%@_%d_contentInset-->%@\n\n",[self class] , __LINE__,NSStringFromUIEdgeInsets(self.tableView.contentInset));
////}
////-(void)keyboardWillShow:(NSNotification*)note
////{
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,[NSThread currentThread]);
////    self.isKeyboardShow=YES;
////    double duration =  [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
////    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
////    CGFloat keyboardHeight = keyboardFrame.size.height;
////    
////    self.keyboardHeight=keyboardHeight;
////    
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,NSStringFromCGSize( self.tableView.contentSize ))
////    LOG(@"_%@_%d实时键盘的高度是 -->_%f",[self class] , __LINE__,keyboardHeight)
////    [UIView animateWithDuration:duration animations:^{
////        self.inputView.mj_y=screenH-keyboardHeight-self.inputView.bounds.size.height;
////        [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, keyboardHeight, 0)];
////    } completion:^(BOOL finished) {
////        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.ChatsArrs.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
////
////    }];
//////    [UIView animateWithDuration:duration animations:^{
//////        self.inputView.mj_y=screenH-keyboardHeight-self.inputView.bounds.size.height;
//////        [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, keyboardHeight, 0)];
//////        if (self.ChatsArrs.count>0) {
//////            
//////            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.ChatsArrs.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
//////        }
//////    }];
////}
////
////-(void)setupInputView
////{
////    
////    UIView * inputView =[self gotInputView];
////    self.inputView=inputView;
////    [self.view addSubview:inputView];
////}
////-(void)setupTableView
////{
////    
////    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, screenW, screenH-50-64)];
////    [self.view addSubview:tableView];
////    self.tableView=tableView;
////    self.tableView.backgroundColor=BackgroundGray;
////    self.tableView.delegate = self;
////    self.tableView.dataSource=self;
////    self.tableView.rowHeight=UITableViewAutomaticDimension;
////    self.tableView.estimatedRowHeight = 14.0;
//////    [self.tableView registerClass:[ChatCellBC class] forCellReuseIdentifier:@"ChatCellBC"];
//////    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
////    self.tableView.showsVerticalScrollIndicator=NO;
////    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
////    //    UIView * ffff = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 30)];
////    //    self.tableView.tableFooterView =ffff;
////    //    self.tableView.contentInset=UIEdgeInsetsMake(0, 0, 50, 0);
////    
////}
//////
//////- (void)didReceiveMemoryWarning {
//////    [super didReceiveMemoryWarning];
//////    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"内存警告")
//////}
////-(void)dealloc{
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"dealloc")
////    [[NSNotificationCenter defaultCenter] removeObserver:self ];
////    
////}
////
////
////
////
////-(UIView*)gotInputView
////{
////    /** 有表情按钮的 */
////    CGFloat margin= 10 ;
////    UIView * inputView = [[UIView alloc]initWithFrame: CGRectMake(0, screenH-50, screenW, 50)];
////    
////    inputView.backgroundColor= [UIColor whiteColor];
//////    UIButton * picture = [[UIButton alloc]initWithFrame:CGRectMake(10, inputView.bounds.size.height-10-30, 30, 30)];
//////    [inputView addSubview:picture];
//////    [picture setImage:[UIImage imageNamed:@"bg_female baby"] forState:UIControlStateNormal];
//////    [picture setImage:[UIImage imageNamed:@"bg_electric"] forState:UIControlStateHighlighted];
//////    [picture addTarget:self action:@selector(gotPicture:) forControlEvents:UIControlEventTouchUpInside];
////    //    //    picture.backgroundColor=randomColor;
////    CGFloat browX =  margin ;
////    CGFloat browY =  inputView.bounds.size.height-10-30 ;
////    CGFloat browW =   30;
////    CGFloat browH =   30;
////    
////    
////        UIButton * brow = [[UIButton alloc]initWithFrame:CGRectMake(browX,browY,browW,browH)];
////    self.browButton = brow;
////        [inputView addSubview:brow];
////        [brow setImage:[UIImage imageNamed:@"bg_icon_ff"] forState:UIControlStateNormal];
////        [brow setImage:[UIImage imageNamed:@"bg_icon_ww"] forState:UIControlStateSelected];
//////    [brow setTitle:@"情" forState:UIControlStateNormal];
//////    [brow setTitle:@"盘" forState:UIControlStateSelected];
////    [brow addTarget:self action:@selector(showBrow:) forControlEvents:UIControlEventTouchUpInside];
////    
////    CGFloat sendButtonW = 30 ;
////    CGFloat sendButtonH = 30 ;
////    CGFloat sendButtonX = screenW - margin - sendButtonW ;
////    CGFloat sendButtonY = (inputView.bounds.size.height - sendButtonH)/2 ;
////    
////    UIButton * sendButton = [[UIButton alloc]initWithFrame:CGRectMake(sendButtonX,sendButtonY,sendButtonW,sendButtonH)];
////    //    emoj.backgroundColor=randomColor;
////    [sendButton setImage:[UIImage imageNamed:@"bg_icon_xx"] forState:UIControlStateNormal];
//////    [sendButton setImage:[UIImage imageNamed:@"bg_Production"] forState:UIControlStateDisabled];
////    [sendButton addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
////    
////    [inputView addSubview:sendButton];
////    CGFloat textviewW = screenW - margin*2 -margin - sendButtonW - browW - margin;
////    CGFloat textviewX = margin +browW+margin;
////    CGFloat textviewY = margin;
////    CGFloat textviewH = inputView.bounds.size.height - textviewY*2;
////    GDTextView * textView = [[GDTextView alloc]initWithFrame:CGRectMake(textviewX,textviewY,textviewW,textviewH)];
////    [inputView addSubview:textView];
////    textView.backgroundColor = [UIColor colorWithRed:0.89 green:0.89 blue:0.89 alpha:1];
////    self.textView = textView;
////    textView.layer.borderColor=inputView.backgroundColor.CGColor;
////    textView.layer.borderWidth=2;
////    textView.layer.masksToBounds=YES;
////    textView.layer.cornerRadius=13;
////    textView.textContainerInset=UIEdgeInsetsMake(8, 10, 8, 5);
////    textView.keyboardType=UIKeyboardTypeTwitter;
////    textView.returnKeyType=UIReturnKeySend;
////    textView.inputDelegate=self;
////    textView.enablesReturnKeyAutomatically=YES;
////    textView.delegate = self ;
////    textView.showsVerticalScrollIndicator = NO ;
////    return inputView;
////
////
////
/////** 先提一版没有表情按钮的 */
//////    CGFloat margin= 10 ;
//////    UIView * inputView = [[UIView alloc]initWithFrame: CGRectMake(0, screenH-50, screenW, 50)];
//////    
//////    inputView.backgroundColor=[UIColor colorWithRed:0.89 green:0.89 blue:0.89 alpha:1];
//////
//////    CGFloat sendButtonW = 30 ;
//////    CGFloat sendButtonH = 30 ;
//////    CGFloat sendButtonX = screenW - margin - sendButtonW ;
//////    CGFloat sendButtonY = (inputView.bounds.size.height - sendButtonH)/2 ;
//////    
//////    UIButton * sendButton = [[UIButton alloc]initWithFrame:CGRectMake(sendButtonX,sendButtonY,sendButtonW,sendButtonH)];
//////    //    emoj.backgroundColor=randomColor;
//////    [sendButton setImage:[UIImage imageNamed:@"btn_Top"] forState:UIControlStateNormal];
//////    [sendButton setImage:[UIImage imageNamed:@"bg_Production"] forState:UIControlStateDisabled];
//////    [sendButton addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
//////    
//////    [inputView addSubview:sendButton];
//////    CGFloat textviewW = screenW - margin*2 -margin - sendButtonW  - margin;
//////    CGFloat textviewX = margin +margin;
//////    CGFloat textviewY = margin;
//////    CGFloat textviewH = inputView.bounds.size.height - textviewY*2;
//////    GDTextView * textView = [[GDTextView alloc]initWithFrame:CGRectMake(textviewX,textviewY,textviewW,textviewH)];
//////    [inputView addSubview:textView];
//////    self.textView = textView;
//////    textView.layer.borderColor=inputView.backgroundColor.CGColor;
//////    textView.layer.borderWidth=2;
//////    textView.layer.masksToBounds=YES;
//////    textView.layer.cornerRadius=13;
//////    textView.textContainerInset=UIEdgeInsetsMake(8, 10, 8, 5);
//////    textView.keyboardType=UIKeyboardTypeTwitter;
//////    textView.returnKeyType=UIReturnKeySend;
//////    textView.inputDelegate=self;
//////    textView.enablesReturnKeyAutomatically=YES;
//////    textView.delegate = self ;
//////    textView.showsVerticalScrollIndicator = NO ;
//////    return inputView;
////
////}
////-(void)sendMessage:(UIButton*)sender
////{
////    if (self.textView.text.length==0) {
////        return;
////    }
////    XMPPMessage *message = [XMPPMessage messageWithType:@"chat" to:self.UserJid];
////    NSString * temp =self.textView.sendStr;
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,temp );
////    [message addBody:self.textView.sendStr];
////    
////    
////    [[GDXmppStreamManager ShareXMPPManager].XmppStream sendElement:message];
////    self.textView.text = nil ;
////}
/////**注销掉先
////-(UIView*)gotInputView
////{
////    UIView * inputView = [[UIView alloc]initWithFrame: CGRectMake(0, screenH-50, screenW, 50)];
////    
////    inputView.backgroundColor=[UIColor lightGrayColor];
////    UIButton * picture = [[UIButton alloc]initWithFrame:CGRectMake(10, inputView.bounds.size.height-10-30, 30, 30)];
////    [inputView addSubview:picture];
////    [picture setImage:[UIImage imageNamed:@"bg_female baby"] forState:UIControlStateNormal];
////    [picture setImage:[UIImage imageNamed:@"bg_electric"] forState:UIControlStateHighlighted];
////    [picture addTarget:self action:@selector(gotPicture:) forControlEvents:UIControlEventTouchUpInside];
////    //    picture.backgroundColor=randomColor;
////    UIButton * emoj = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(picture.frame)+10, CGRectGetMinY(picture.frame), 30, 30)];
////    //    emoj.backgroundColor=randomColor;
////    [emoj setImage:[UIImage imageNamed:@"bg_supermarket"] forState:UIControlStateNormal];
////    [emoj setImage:[UIImage imageNamed:@"bg_Production"] forState:UIControlStateHighlighted];
////    [emoj addTarget:self action:@selector(chooseEmoj:) forControlEvents:UIControlEventTouchUpInside];
////    
////    [inputView addSubview:emoj];
////    
////    UITextView * textView = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(emoj.frame)+10, 10, inputView.bounds.size.width-10-picture.bounds.size.width-10-emoj.bounds.size.width-10-10, inputView.bounds.size.height-20)];
////    [inputView addSubview:textView];
////    self.textView = textView;
////    textView.layer.borderColor=[UIColor lightGrayColor].CGColor;
////    textView.layer.borderWidth=2;
////    textView.layer.masksToBounds=YES;
////    textView.layer.cornerRadius=13;
////    textView.textContainerInset=UIEdgeInsetsMake(8, 10, 8, 5);
////    textView.keyboardType=UIKeyboardTypeTwitter;
////    textView.returnKeyType=UIReturnKeySend;
////    textView.inputDelegate=self;
////    textView.enablesReturnKeyAutomatically=YES;
////    textView.delegate = self ;
////    return inputView;
////}
////
////**/
////-(void)gotPicture:(UIButton *)sender
////{
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"huo qu tu pian ")
////    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
////    picker.allowsEditing=YES;
////    self.picker=picker;
////    picker.delegate = self;
////    picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
////    [self presentViewController:picker animated:YES completion:nil];
////}
////
////
////- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo{
////    //    ChatCell * cell = (ChatCell * ) [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.ChatsArrs.count-1 inSection:0]];
////    //    ChatModel * model = [[ChatModel alloc]init];
////    //    model.meImage=image;
////    //    cell.chatModel=model;
////    
////}
////- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
////    //    ChatCellBC * cell = (ChatCellBC * ) [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.ChatsArrs.count-1 inSection:0]];
////    //    ChatModel * model = [[ChatModel alloc]init];
////    //    [ self.ChatsArrs addObject:model];
////    //    NSIndexPath * idx = [NSIndexPath indexPathForRow:self.ChatsArrs.count-1 inSection:0];
////    //
////    //    UIImage * image =    info[UIImagePickerControllerOriginalImage];
////    //    model.meImage=image;
////    //    cell.chatModel=model;
////    //    [self.tableView reloadData];
////    //    [self.tableView scrollToRowAtIndexPath:idx atScrollPosition:UITableViewScrollPositionBottom animated:YES];
////    
////    [picker dismissViewControllerAnimated:YES completion:nil];
////    LOG_METHOD
////}
////
//////-(void)changeTableViewContentInsetBottom:(CGFloat)bottom{
//////     self.tableView.contentInset=UIEdgeInsetsMake(0, 0, bottom, 0);
//////
//////
//////
//////}
////
////
////#pragma mark  //////////////////xmpp相关//////////////////////
////-(NSArray *)ChatsArrs
////{
////    if (_ChatsArrs == nil) {
////        _ChatsArrs = [NSArray array];
////    }
////    return _ChatsArrs;
////}
////
////-(NSFetchedResultsController *)fetchedresultscontroller
////{
////    if (_fetchedresultscontroller == nil) {
////        
////        NSFetchRequest *fetchrequest = [[NSFetchRequest alloc]init];
//////        [fetchrequest setFetchLimit:20];
////        //从游离态中获取实体描述
////        NSEntityDescription *entitys = [NSEntityDescription entityForName:@"XMPPMessageArchiving_Message_CoreDataObject" inManagedObjectContext:[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext];
////        //设置实体描述
////        fetchrequest.entity = entitys;
////        
////        
////        //设置谓词(条件筛选)
////        NSPredicate *pre = [NSPredicate predicateWithFormat:@"bareJidStr = %@",self.UserJid.bare];
////        fetchrequest.predicate = pre;
////        //
////        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES];
////        fetchrequest.sortDescriptors = @[sort];
////        
////        _fetchedresultscontroller = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchrequest managedObjectContext:[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext sectionNameKeyPath:nil cacheName:@"Message"];
////        
////        //设置代理
////        _fetchedresultscontroller.delegate = self;
////        /** 好友列表对象 */
////        [[GDXmppStreamManager ShareXMPPManager].XmppRoster addDelegate:self delegateQueue:dispatch_get_main_queue()];
////    }
////    return _fetchedresultscontroller;
////}
//////-(void)setEditing:(BOOL)editing animated:(BOOL)animated{}
//////代理 , 每当收到数据的时候回调用一次,发消息是 也 会自动调用  , 用来更新数据
////
////#pragma mark 更新消息数据
////-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
////{
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,[NSThread currentThread]);
////    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES];
//////   [self.tableView reloadData];
////    LOG(@"_%@_%d_%d",[self class] , __LINE__,self.ChatsArrs.count);
////    self.ChatsArrs = [self.fetchedresultscontroller.fetchedObjects sortedArrayUsingDescriptors:@[sort]];
////    LOG(@"_%@_%d_%d",[self class] , __LINE__,self.ChatsArrs.count);
////    //    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.ChatsArrs);
////    [self.tableView reloadData];
////    
//////    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, self.keyboardHeight+self.inputView.bounds.size.height, 0)];
////    LOG(@"_%@_%d_键盘的高度%f",[self class] , __LINE__,self.keyboardHeight);
////    LOG(@"_%@_%d_辅助键盘的高度%f",[self class] , __LINE__,self.inputView.bounds.size.height);
////    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, self.keyboardHeight+self.inputView.bounds.size.height, 0)];
////
////    if (self.ChatsArrs.count > 1) {
////         LOG(@"_%@_%d_\n\n\n%@\n",[self class] , __LINE__,@"发送消息方法中的数据");
////    LOG(@"_%@_%d_%d",[self class] , __LINE__,self.ChatsArrs.count);
////        
////        LOG(@"_%@_%d_bouns-->%@",[self class] , __LINE__,NSStringFromCGRect(self.tableView.bounds));
////        
////        LOG(@"_%@_%d_frame-->%@",[self class] , __LINE__,NSStringFromCGRect(self.tableView.frame));
////        
////        LOG(@"_%@_%d_滚动范围contentSize-->%@",[self class] , __LINE__,NSStringFromCGSize(self.tableView.contentSize));
////        
////        LOG(@"_%@_%d_当前偏移量contentOffset-->%@",[self class] , __LINE__,NSStringFromCGPoint(self.tableView.contentOffset));
////        
////        LOG(@"_%@_%d_容器视图的偏移量contentInset-->%@\n",[self class] , __LINE__,NSStringFromUIEdgeInsets(self.tableView.contentInset));
////        NSIndexPath * index = [NSIndexPath indexPathForRow:self.ChatsArrs.count - 1 inSection:0];
////        [self.tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:NO];
////        
////        
////        
////        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"滚动以后的\n\n\n");
////        LOG(@"_%@_%d_bouns-->%@",[self class] , __LINE__,NSStringFromCGRect(self.tableView.bounds));
////        
////        LOG(@"_%@_%d_frame-->%@",[self class] , __LINE__,NSStringFromCGRect(self.tableView.frame));
////        
////        LOG(@"_%@_%d_滚动范围contentSize-->%@",[self class] , __LINE__,NSStringFromCGSize(self.tableView.contentSize));
////        
////        LOG(@"_%@_%d_当前偏移量contentOffset-->%@",[self class] , __LINE__,NSStringFromCGPoint(self.tableView.contentOffset));
////        
////        LOG(@"_%@_%d_容器视图的偏移量contentInset-->%@\n",[self class] , __LINE__,NSStringFromUIEdgeInsets(self.tableView.contentInset));
////    }
////    
//////    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//////        NSIndexPath * index = [NSIndexPath indexPathForRow:self.ChatsArrs.count - 1 inSection:0];
//////        [self.tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:YES];
////
//////    });
////    
//////    [UIView animateWithDuration:3 animations:^{
//////        [self.tableView reloadData];
//////    } completion:^(BOOL finished) {
//////        if (self.ChatsArrs.count>0) {
//////            
//////            NSIndexPath * index = [NSIndexPath indexPathForRow:self.ChatsArrs.count - 1 inSection:0];
//////            [self.tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:NO];
//////            
//////        }
//////    }];
////    //    LOG(@"_%@_%d_%ld",[self class] , __LINE__,self.ChatsArrs.count);
//////    if (self.ChatsArrs.count > 1) {
////    
////
//////        NSIndexPath * index = [NSIndexPath indexPathForRow:self.ChatsArrs.count - 1 inSection:0];
//////        [self.tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:NO];
//////        [UIView animateWithDuration:3.1 animations:^{
//////            
//////            self.tableView.contentOffset = CGPointMake(0, (self.tableView.contentSize.height - self.tableView.bounds.size.height - self.keyboardHeight*3.7 ) );
//////        }];
//////    }else{
//////         [self.tableView reloadData];
//////    }
//////    if (self.tableView.contentSize.height > self.tableView.frame.size.height)
//////    {
//////        CGPoint offset = CGPointMake(0, self.tableView.contentSize.height - self.tableView.frame.size.height - self.keyboardHeight- 64);
//////        [self.tableView setContentOffset:offset animated:NO];
//////    }
////}
////-(void)tESAst
////{
////// NSManagedObject 
////}
////-(void)customDelete:(NSNotification*)note
////{
////    [self.textView deleteBackward];
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,note);
////}
////
////
////
////
////
////
////
////
////-(void)inputBrow:(NSNotification*)note
////{
////
////    
////    
////    self.textView.font = [UIFont systemFontOfSize:14 ];
////    LOG(@"_%@_%d_/%@; %@",[self class] , __LINE__,note.userInfo[@"code"],note.userInfo[@"title"]);
////    NSString * imgName = note.userInfo[@"code"];
////    imgName=  [imgName stringByReplacingOccurrencesOfString:@";" withString:@""];
////    imgName= [imgName stringByReplacingOccurrencesOfString:@"/" withString:@""];
////    NSRange currentRange = self.textView.selectedRange;
////    
////
////    
////    /** 用于展示 */
////    NSMutableAttributedString * currentAttributStr = [[NSMutableAttributedString alloc]initWithAttributedString:self.textView.attributedText];
////    GDTextAttachment * tachment = [[GDTextAttachment alloc]init];
////    tachment.desc = [NSString stringWithFormat:@"/%@;",note.userInfo[@"code"]];
////    tachment.image = [UIImage imageWithContentsOfFile:gotResourceInSubBundle(imgName, @"gif", @"face_img")];
////    tachment.bounds = CGRectMake(0, -4, self.textView.font.lineHeight, self.textView.font.lineHeight);
////    NSAttributedString * showStr = [NSAttributedString attributedStringWithAttachment:tachment];
////    
////    /** 拼回去 */
////    [currentAttributStr replaceCharactersInRange:currentRange withAttributedString:showStr];
////    
////    [currentAttributStr  addAttribute:NSFontAttributeName value:self.textView.font range:NSMakeRange(0, currentAttributStr.length)];
////    
////    //    /** 在这调一个方法 解析属性字符串 */
////    //   NSAttributedString * result =  [self dealTheStr:currentAttributStr.string];
////    
////    self.textView.attributedText = currentAttributStr;
////    
////    /**把标也放回去 */
////    self.textView.selectedRange = NSMakeRange(currentRange.location+showStr.length, 0);
////    
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.textView.attributedText);
////
//////    [self.textView.attributedText  enumerateAttribute:<#(nonnull NSString *)#> inRange:<#(NSRange)#> options:<#(NSAttributedStringEnumerationOptions)#> usingBlock:<#^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop)block#>]
////    
////
////    
////}
////
////-(NSAttributedString*)dealTheStr:(NSString*)str
////{
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,str);
////    NSMutableAttributedString * mAttriStr = [[NSMutableAttributedString alloc]initWithString:str];
////
////    NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:@"/[a-zA-Z]+;" options:NSRegularExpressionCaseInsensitive error:nil];
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,mAttriStr);
////    NSArray * matches = [regex matchesInString:str options:0 range:NSMakeRange(0, str.length)];
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,matches);
////    if (matches) {
////        for (NSTextCheckingResult * result  in matches) {
////            LOG(@"_%@_%d_%@",[self class] , __LINE__,NSStringFromRange(result.range));
////            /** 取出图片名 */
////            NSString * imgName = [str substringWithRange:result.range];
////              imgName=  [imgName stringByReplacingOccurrencesOfString:@";" withString:@""];
////            imgName= [imgName stringByReplacingOccurrencesOfString:@"/" withString:@""];
////            NSTextAttachment * tachment = [[NSTextAttachment alloc]init];
////            tachment.image = [UIImage imageWithContentsOfFile:gotResourceInSubBundle(imgName, @"gif", @"face_img")];
////            NSAttributedString * imgStr = [NSAttributedString attributedStringWithAttachment:tachment];
////            [mAttriStr replaceCharactersInRange:result.range withAttributedString:imgStr];
////            
////            
////            LOG(@"_%@_%d_%@",[self class] , __LINE__,imgName);
////        }
////    }
////    
////    
////    
////    
////    return mAttriStr;
////}
////
////
////- (void)didReceiveMemoryWarning {
////    [super didReceiveMemoryWarning];
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
////    // Dispose of any resources that can be recreated.
////}
////
////
//////发送消息
////- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//////    NSData * data = [[NSData alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"loading.gif" ofType:nil]];
//////    [[GDXmppStreamManager ShareXMPPManager] sendImageMessage:data toAccount:@"zhangkaiqiang"];
////
//////    BaseModel * model = [[BaseModel alloc]init];
//////    model.actionKey = @"TestScrollViewProPerty";
//////    [[SkipManager shareSkipManager] skipByVC:self withActionModel:model];
////    NSIndexPath * index = [NSIndexPath indexPathForRow:self.ChatsArrs.count - 1 inSection:0];
////    [self.tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:NO];
////    
////}
////
////
////- (void)turnSocket:(TURNSocket *)sender didSucceed:(GCDAsyncSocket *)socket{
////    LOG(@"_%@_%d_文件传输相关%@",[self class] , __LINE__,sender);
////    //    XMPPSIFileTransfer * ssss = [XMPPSIFileTransfer new];
////}
////
////- (void)turnSocketDidFail:(TURNSocket *)sender{
////    LOG(@"_%@_%d_文件传输相关%@",[self class] , __LINE__,sender);
////    
////}
////
////
////#pragma mark Roster(好友列表)的代理
/////** 收到添加好友的请求信息 */
////-(void)xmppRoster:(XMPPRoster *)sender didReceivePresenceSubscriptionRequest:(XMPPPresence *)presence
////{
////    LOG(@"_%@_%d_收到添加好友请求 XMPPRoster:%@\nXMPPPresence:%@",[self class] , __LINE__,sender,presence);
////    [[GDXmppStreamManager ShareXMPPManager].XmppRoster acceptPresenceSubscriptionRequestFrom:presence.from andAddToRoster:YES];//同意
////    
////}
////
//////删除好友
//////- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//////{
//////    //    XMPPUserCoreDataStorageObject *user = self.RecentlyArrs[indexPath.row];
//////    XMPPJID *jid =  [XMPPJID jidWithUser:@"caohenghui" domain:@"jabber.zjlao.com" resource:@"fuck"];
//////    [[GDXmppStreamManager ShareXMPPManager].XmppRoster removeUser:jid];
//////}
////
/////** 添加好友请求 */
////- (IBAction)AddFrend:(UIBarButtonItem *)sender {
////    
////    [[GDXmppStreamManager ShareXMPPManager].XmppRoster addUser:[XMPPJID jidWithUser:@"zhangkaiqiang" domain:@"jabber.zjlao.com" resource:@"fuck"] withNickname:@"我来加你好友啦"];
////    
////    
////}
////
////
//////头像代理
//////刷新头像
////-(void)xmppvCardAvatarModule:(XMPPvCardAvatarModule *)vCardTempModule didReceivePhoto:(UIImage *)photo forJID:(XMPPJID *)jid
////{
////    [self.tableView reloadData];
////}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//#pragma mark UI
//-(void)setupUI
//{
//    NSString * sourctPath = gotResourceInSubBundle(@"cy", @"gif", @"face_img");
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,sourctPath);
//    self.automaticallyAdjustsScrollViewInsets  = NO;
//    [self setupTableView];
//    
//    [self setupInputView];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
//    
//}
//
//-(void)viewWillLayoutSubviews{
//    [super viewWillLayoutSubviews];
//    if (self.ChatsArrs.count>0) {
//        
//        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.ChatsArrs.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//        
//    }
//    
//}
//
//#pragma mark tableViewDataSource
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.ChatsArrs.count;
//}
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
////    ChatCellBC * cell = [tableView dequeueReusableCellWithIdentifier:@"ChatCellBC"];
////    if (!cell) {
////        cell=[[ChatCellBC alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ChatCellBC"];
////    }
////    //    ChatModel * model = [[ChatModel alloc]init];
////    //    model.txtContent = @"3";
////    XMPPMessageArchiving_Message_CoreDataObject * message  = self.ChatsArrs[indexPath.row];
////    //    XMPPMessageArchiving_Message_CoreDataObject , xmppmessage的父类
////    //    model.txtContent = message.body;
////    //    LOG(@"_%@_%d_%d",[self class] , __LINE__,message.isOutgoing);
////    //注意,这里的头像有两个方向
////    cell.chatMessageModel=message;
////    if (message.isOutgoing) {
////        //我发出去
////        NSData *avatordata = [GDXmppStreamManager ShareXMPPManager].xmppvcardtempModule.myvCardTemp.photo;
////        
////        UIImage * image = [UIImage imageWithData:avatordata];
////        cell.rightImg = image;
////        
////    }else
////    {//别人发出去的
////        NSData *avatordata = [[GDXmppStreamManager ShareXMPPManager].xmppvcardavatarModule photoDataForJID:self.UserJid];
////        UIImage * image  = [UIImage imageWithData:avatordata];
////        cell.leftImg = image;
////    }
////    
////    //    LOG(@"_%@_%d_%@",[self class] , __LINE__,message.bareJid.user);
////    //    cell.chatMessageModel=message;
////    //    NSString * result = [message.timestamp.description formatterDateStringToMinute];
////    //    LOG(@"_%@_%d_%@",[self class] , __LINE__,result);
////    return cell;
//    
//    
//            XMPPMessageArchiving_Message_CoreDataObject * message  = self.ChatsArrs[indexPath.row];
//
//    XMPPvCardTemp * vcard = [[GDXmppStreamManager ShareXMPPManager].xmppvcardtempModule vCardTempForJID:message.bareJid shouldFetch:YES];
//
//        LOG(@"_%@_%d_\n\n\n昵称啊昵称%@\n\n\n",[self class] , __LINE__,vcard.nickname);
//            //注意,这里的头像有两个方向
//    
//        UITableViewCell * cell = nil ;
//            if (message.isOutgoing) {
//                //我发出去
//                cell = [tableView dequeueReusableCellWithIdentifier:@"MeChatCell"];
//                if (!cell) {
//                    cell=[[MeChatCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MeChatCell"];
//                }
//                OtherChatCell * me = (OtherChatCell*)cell ;
//                me.chatMessageModel=message;
////                LOG(@"_%@_%d_%@",[self class] , __LINE__,me);
//                return me;
//            }else  {//别人发出去的
//    
//                cell = [tableView dequeueReusableCellWithIdentifier:@"OtherChatCell"];
//                if (!cell) {
//                    cell=[[OtherChatCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OtherChatCell"];
//                }
//                OtherChatCell * other = (OtherChatCell*)cell ;
//                other.chatMessageModel=message;
////                LOG(@"_%@_%d_%@",[self class] , __LINE__,other);
//                return other;
//            }
//}
//
//#pragma mark tableViewDelegate
////-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
////    if (self.ChatsArrs.count>0) {
////        if ([self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] == self.tableView.visibleCells[0]){
//            //        NSMutableArray * arr = [ NSMutableArray arrayWithCapacity:10];
//            //        NSMutableArray * idxArr = [NSMutableArray arrayWithCapacity:10];
//            //        int a = self.i;
//            //        for ([self i]  ; self.i<40+a; self.i++) {
//            //            ChatModel * model = [[ChatModel alloc]init];
//            //
//            //            if (self.i%2==0) {
//            //                model.isMe=YES;
//            //            }else{
//            //                model.isMe=NO;
//            //            }
//            //            model.txtContent=[NSString stringWithFormat:@"%d",self.i];
//            //            [ arr addObject:model];
//            ////            [self.ChatsArrs insertObject:model atIndex:0];
//            //            NSIndexPath * idx = [NSIndexPath indexPathForRow:self.i inSection:0];
//            //            [idxArr addObject:idx];
//            //        }
//            //        [self.tableView reloadData];
//            //        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:40 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
//            
////        }
////    }
////    
////    
////}
////拖动调整键盘
//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    LOG(@"_%@_%d_%d",[self class] , __LINE__,self.isKeyboardShow)
//    if (scrollView != self.tableView) {
//        return;
//    }
//    if (self.isKeyboardShow) {
//        [self.textView resignFirstResponder];
//    }else{
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,NSStringFromCGPoint(self.tableView.contentOffset))
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,NSStringFromCGSize(self.tableView.contentSize))
//        if (self.tableView.contentOffset.y+self.tableView.bounds.size.height>self.tableView.contentSize.height) {
//            [self.textView becomeFirstResponder];
//        }
//    }
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.textView.inputView)
//    
//}
//#pragma mark textViewdelegate
////发送消息
//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
//{
//    
//    if ([text isEqualToString:@"\n"]) {
//        LOG(@"_%@_%d_%lu",[self class] , __LINE__,(unsigned long)textView.text.length)
//        //        ChatModel * model = [[ChatModel alloc]init];
//        //        model.txtContent=[NSString stringWithFormat:@"%d",self.i++];
//        //        [ self.ChatsArrs addObject:model];
////        NSIndexPath * idx = [NSIndexPath indexPathForRow:self.ChatsArrs.count-1 inSection:0];
//        //        model.txtContent=textView.text;
//        //        [self.chatTool sendMessage:model.txtContent usersId:@"4" messageType:1];
//        //        textView.text=@"";
//        //        //        self.tableView.contentInset=UIEdgeInsetsMake(0, 0, 258+50, 0);
//        
//        XMPPMessage *message = [XMPPMessage messageWithType:@"chat" to:self.UserJid];
//        
//        [message addBody:self.textView.sendStr];
//        
//        [[GDXmppStreamManager ShareXMPPManager].XmppStream sendElement:message];
//        self.textView.text = nil ;
//        //        [self.tableView reloadData];
//        //        [self.tableView scrollToRowAtIndexPath:idx atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//        return NO;
//    }
//    return YES;
//}
//#pragma mark customMethod
//
//-(GDKeyBoard *)browKeyBoard{
//    if (_browKeyBoard==nil) {
//        CGFloat keyboardH = 0;
//        if (screenW<321) {//4,5
//            keyboardH = 216;
//        }else if (screenW<321) {//6
//            keyboardH = 226 ;
//        }else if (screenW<376) {//6p
//            keyboardH = 258 ;
//        }else {
//            keyboardH = 258 ;
//        }
//        GDKeyBoard * keyBoard =[[GDKeyBoard alloc]initWithFrame: CGRectMake(0, 0, screenW,keyboardH )];
//        NSMutableArray * bigArrm = [NSMutableArray new];
//        NSString * path = gotResourceInSubBundle(@"brow", @"plist", @"face_img");
//        NSArray * littleArr = [NSArray arrayWithContentsOfFile:path];
//        [bigArrm addObject:littleArr];
//        keyBoard.allBrowNames = bigArrm;
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,keyBoard.allBrowNames);
//        _browKeyBoard = keyBoard;
//    }
//    return _browKeyBoard;
//}
//
//-(void)showBrow:(UIButton * ) sender
//{
//    
//    if (self.isKeyboardShow) {//正常切换
//        //        [self.textView resignFirstResponder];
//        if (self.textView.inputView) {//切换到键盘
//            self.textView.inputView = nil;
//            //            [self.textView reloadInputViews];
//            //            [self.textView becomeFirstResponder];
//        }else{//切换到表情
//            
//            self.textView.inputView = self.browKeyBoard;
//            //            [self.textView becomeFirstResponder];
//        }
//        
//    }else{
//        if (self.textView.inputView) {//切换到表情
//            self.textView.inputView = self.browKeyBoard;
//            //            [self.textView becomeFirstResponder];
//        }else{//切换到键盘
//            self.textView.inputView = nil;
//            //            [self.textView becomeFirstResponder];
//        }
//        [self.textView becomeFirstResponder];
//    }
//    [self.textView reloadInputViews];
//}
//-(void)keyboardWillChanged:(NSNotification*)note
//{
//    if (self.textView.inputView) {//当前为表情键盘 , 按钮状态显示键盘
//        self.browButton.selected = YES ;
//    }else{//当前为键盘 , 按钮状态显示表情
//        self.browButton.selected = NO ;
//    }
//}
//-(void)keyboardWillHide:(NSNotification*)note
//{
//    self.isKeyboardShow=NO;
//    double duration =  [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
////    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
////    CGFloat keyboardHeight = keyboardFrame.size.height;
//    
//    [UIView animateWithDuration:duration animations:^{
//        self.inputView.mj_y=screenH-self.inputView.bounds.size.height;
//        [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
//        
//    }];
//    
//    
//}
//-(void)keyboardDidHide:(NSNotification*)note
//{
//    
//}
//-(void)keyboardWillShow:(NSNotification*)note
//{
//    
//    self.isKeyboardShow=YES;
//    double duration =  [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGFloat keyboardHeight = keyboardFrame.size.height;
//    if (self.keyboardHeight==0) {
//        self.keyboardHeight=keyboardHeight;
//    }
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,NSStringFromCGSize( self.tableView.contentSize ))
//    LOG(@"_%@_%d_%f",[self class] , __LINE__,keyboardHeight)
//    
//    [UIView animateWithDuration:duration animations:^{
//        self.inputView.mj_y=screenH-keyboardHeight-self.inputView.bounds.size.height;
//        [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, keyboardHeight, 0)];
//        if (self.ChatsArrs.count>0) {
//            
//            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.ChatsArrs.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//        }
//    }];
//}
//-(void)setupInputView
//{
//    
//    UIView * inputView =[self gotInputView];
//    self.inputView=inputView;
//    [self.view addSubview:inputView];
//}
//-(void)setupTableView
//{
//    
//    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, screenW, screenH-56*SCALE-64)];
//    [self.view addSubview:tableView];
//    self.tableView=tableView;
//    self.tableView.backgroundColor=BackgroundGray;
//    self.tableView.delegate = self;
//    self.tableView.dataSource=self;
//    self.tableView.estimatedRowHeight = 100.0;
//    self.tableView.rowHeight=UITableViewAutomaticDimension;
////    [self.tableView registerClass:[ChatCellBC class] forCellReuseIdentifier:@"ChatCellBC"];
////    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
//    self.tableView.showsVerticalScrollIndicator=NO;
//    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
//    //    UIView * ffff = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 30)];
//    //    self.tableView.tableFooterView =ffff;
//    //    self.tableView.contentInset=UIEdgeInsetsMake(0, 0, 50, 0);
//    
//}
////
////- (void)didReceiveMemoryWarning {
////    [super didReceiveMemoryWarning];
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"内存警告")
////}
//-(void)dealloc{
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"dealloc")
//    [[NSNotificationCenter defaultCenter] removeObserver:self ];
//    
//}
//
//
//
//
//-(UIView*)gotInputView
//{
//    /** 有表情按钮的 */
//    CGFloat margin= 10 ;
//    UIView * inputView = [[UIView alloc]initWithFrame: CGRectMake(0, screenH-56*SCALE, screenW, 56*SCALE)];
//    
//    inputView.backgroundColor= [UIColor whiteColor];
//    //    UIButton * picture = [[UIButton alloc]initWithFrame:CGRectMake(10, inputView.bounds.size.height-10-30, 30, 30)];
//    //    [inputView addSubview:picture];
//    //    [picture setImage:[UIImage imageNamed:@"bg_female baby"] forState:UIControlStateNormal];
//    //    [picture setImage:[UIImage imageNamed:@"bg_electric"] forState:UIControlStateHighlighted];
//    //    [picture addTarget:self action:@selector(gotPicture:) forControlEvents:UIControlEventTouchUpInside];
//    //    //    picture.backgroundColor=randomColor;
//    CGFloat browX =  0 ;
//    CGFloat browY =  0 ;
//    CGFloat browH =   inputView.bounds.size.height;
//    CGFloat browW =  browH ;
//    
//    
//    UIButton * brow = [[UIButton alloc]initWithFrame:CGRectMake(browX,browY,browW,browH)];
//    self.browButton = brow;
//    brow.imageEdgeInsets = UIEdgeInsetsMake(10*SCALE, 10*SCALE, 10*SCALE, 10*SCALE);
////    brow.backgroundColor = randomColor;
//    [inputView addSubview:brow];
//    [brow setImage:[UIImage imageNamed:@"bg_icon_ff"] forState:UIControlStateNormal];
//    [brow setImage:[UIImage imageNamed:@"bg_icon_ww"] forState:UIControlStateSelected];
//    //    [brow setTitle:@"情" forState:UIControlStateNormal];
//    //    [brow setTitle:@"盘" forState:UIControlStateSelected];
//    [brow addTarget:self action:@selector(showBrow:) forControlEvents:UIControlEventTouchUpInside];
//    
//    CGFloat sendButtonH = inputView.bounds.size.height ;
//    CGFloat sendButtonW = sendButtonH ;
//    CGFloat sendButtonX = screenW - sendButtonW ;
//    CGFloat sendButtonY = (inputView.bounds.size.height - sendButtonH)/2 ;
//    UIButton * sendButton = [[UIButton alloc]initWithFrame:CGRectMake(sendButtonX,sendButtonY,sendButtonW,sendButtonH)];
//    //    emoj.backgroundColor=randomColor;
//    [sendButton setImage:[UIImage imageNamed:@"bg_icon_xx"] forState:UIControlStateNormal];
//    sendButton.imageEdgeInsets = UIEdgeInsetsMake(10*SCALE, 10*SCALE, 10*SCALE, 10*SCALE);
////    sendButton.backgroundColor = randomColor;
////    [sendButton setImage:[UIImage imageNamed:@"bg_Production"] forState:UIControlStateDisabled];
//    [sendButton addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [inputView addSubview:sendButton];
//    CGFloat textviewW = screenW -  sendButtonW - browW;
//    CGFloat textviewX = browW ;
//    CGFloat textviewY = margin*0.8;
//    CGFloat textviewH = inputView.bounds.size.height - textviewY*2;
//    GDTextView * textView = [[GDTextView alloc]initWithFrame:CGRectMake(textviewX,textviewY,textviewW,textviewH)];
//    [inputView addSubview:textView];
//    textView.backgroundColor = [UIColor colorWithRed:0.89 green:0.89 blue:0.89 alpha:1];
//    self.textView = textView;
//    textView.layer.borderColor=inputView.backgroundColor.CGColor;
//    textView.layer.borderWidth=2;
//    textView.layer.masksToBounds=YES;
//    textView.layer.cornerRadius=13;
//    textView.textContainerInset=UIEdgeInsetsMake(8, 10, 8, 5);
//    textView.keyboardType=UIKeyboardTypeTwitter;
//    textView.returnKeyType=UIReturnKeySend;
////    textView.inputDelegate=self;
//    textView.enablesReturnKeyAutomatically=YES;
//    textView.delegate = self ;
//    textView.showsVerticalScrollIndicator = NO ;
//    return inputView;
//    
//    
//    
//    /** 先提一版没有表情按钮的 */
//    //    CGFloat margin= 10 ;
//    //    UIView * inputView = [[UIView alloc]initWithFrame: CGRectMake(0, screenH-50, screenW, 50)];
//    //
//    //    inputView.backgroundColor=[UIColor colorWithRed:0.89 green:0.89 blue:0.89 alpha:1];
//    //
//    //    CGFloat sendButtonW = 30 ;
//    //    CGFloat sendButtonH = 30 ;
//    //    CGFloat sendButtonX = screenW - margin - sendButtonW ;
//    //    CGFloat sendButtonY = (inputView.bounds.size.height - sendButtonH)/2 ;
//    //
//    //    UIButton * sendButton = [[UIButton alloc]initWithFrame:CGRectMake(sendButtonX,sendButtonY,sendButtonW,sendButtonH)];
//    //    //    emoj.backgroundColor=randomColor;
//    //    [sendButton setImage:[UIImage imageNamed:@"btn_Top"] forState:UIControlStateNormal];
//    //    [sendButton setImage:[UIImage imageNamed:@"bg_Production"] forState:UIControlStateDisabled];
//    //    [sendButton addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
//    //
//    //    [inputView addSubview:sendButton];
//    //    CGFloat textviewW = screenW - margin*2 -margin - sendButtonW  - margin;
//    //    CGFloat textviewX = margin +margin;
//    //    CGFloat textviewY = margin;
//    //    CGFloat textviewH = inputView.bounds.size.height - textviewY*2;
//    //    GDTextView * textView = [[GDTextView alloc]initWithFrame:CGRectMake(textviewX,textviewY,textviewW,textviewH)];
//    //    [inputView addSubview:textView];
//    //    self.textView = textView;
//    //    textView.layer.borderColor=inputView.backgroundColor.CGColor;
//    //    textView.layer.borderWidth=2;
//    //    textView.layer.masksToBounds=YES;
//    //    textView.layer.cornerRadius=13;
//    //    textView.textContainerInset=UIEdgeInsetsMake(8, 10, 8, 5);
//    //    textView.keyboardType=UIKeyboardTypeTwitter;
//    //    textView.returnKeyType=UIReturnKeySend;
//    //    textView.inputDelegate=self;
//    //    textView.enablesReturnKeyAutomatically=YES;
//    //    textView.delegate = self ;
//    //    textView.showsVerticalScrollIndicator = NO ;
//    //    return inputView;
//    
//}
//-(void)sendMessage:(UIButton*)sender
//{
//    if (self.textView.text.length==0) {
//        return;
//    }
//    XMPPMessage *message = [XMPPMessage messageWithType:@"chat" to:self.UserJid];
//    NSString * temp =self.textView.sendStr;
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,temp );
//    [message addBody:self.textView.sendStr];
//    
//    
//    [[GDXmppStreamManager ShareXMPPManager].XmppStream sendElement:message];
//    self.textView.text = nil ;
//}
///**注销掉先
// -(UIView*)gotInputView
// {
// UIView * inputView = [[UIView alloc]initWithFrame: CGRectMake(0, screenH-50, screenW, 50)];
// 
// inputView.backgroundColor=[UIColor lightGrayColor];
// UIButton * picture = [[UIButton alloc]initWithFrame:CGRectMake(10, inputView.bounds.size.height-10-30, 30, 30)];
// [inputView addSubview:picture];
// [picture setImage:[UIImage imageNamed:@"bg_female baby"] forState:UIControlStateNormal];
// [picture setImage:[UIImage imageNamed:@"bg_electric"] forState:UIControlStateHighlighted];
// [picture addTarget:self action:@selector(gotPicture:) forControlEvents:UIControlEventTouchUpInside];
// //    picture.backgroundColor=randomColor;
// UIButton * emoj = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(picture.frame)+10, CGRectGetMinY(picture.frame), 30, 30)];
// //    emoj.backgroundColor=randomColor;
// [emoj setImage:[UIImage imageNamed:@"bg_supermarket"] forState:UIControlStateNormal];
// [emoj setImage:[UIImage imageNamed:@"bg_Production"] forState:UIControlStateHighlighted];
// [emoj addTarget:self action:@selector(chooseEmoj:) forControlEvents:UIControlEventTouchUpInside];
// 
// [inputView addSubview:emoj];
// 
// UITextView * textView = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(emoj.frame)+10, 10, inputView.bounds.size.width-10-picture.bounds.size.width-10-emoj.bounds.size.width-10-10, inputView.bounds.size.height-20)];
// [inputView addSubview:textView];
// self.textView = textView;
// textView.layer.borderColor=[UIColor lightGrayColor].CGColor;
// textView.layer.borderWidth=2;
// textView.layer.masksToBounds=YES;
// textView.layer.cornerRadius=13;
// textView.textContainerInset=UIEdgeInsetsMake(8, 10, 8, 5);
// textView.keyboardType=UIKeyboardTypeTwitter;
// textView.returnKeyType=UIReturnKeySend;
// textView.inputDelegate=self;
// textView.enablesReturnKeyAutomatically=YES;
// textView.delegate = self ;
// return inputView;
// }
// 
// **/
//-(void)gotPicture:(UIButton *)sender
//{
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"huo qu tu pian ")
//    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
//    picker.allowsEditing=YES;
//    self.picker=picker;
//    picker.delegate = self;
//    picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
//    [self presentViewController:picker animated:YES completion:nil];
//}
//
//
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo{
//    //    ChatCell * cell = (ChatCell * ) [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.ChatsArrs.count-1 inSection:0]];
//    //    ChatModel * model = [[ChatModel alloc]init];
//    //    model.meImage=image;
//    //    cell.chatModel=model;
//    
//}
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
//    //    ChatCellBC * cell = (ChatCellBC * ) [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.ChatsArrs.count-1 inSection:0]];
//    //    ChatModel * model = [[ChatModel alloc]init];
//    //    [ self.ChatsArrs addObject:model];
//    //    NSIndexPath * idx = [NSIndexPath indexPathForRow:self.ChatsArrs.count-1 inSection:0];
//    //
//    //    UIImage * image =    info[UIImagePickerControllerOriginalImage];
//    //    model.meImage=image;
//    //    cell.chatModel=model;
//    //    [self.tableView reloadData];
//    //    [self.tableView scrollToRowAtIndexPath:idx atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//    
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    LOG_METHOD
//}
//
////-(void)changeTableViewContentInsetBottom:(CGFloat)bottom{
////     self.tableView.contentInset=UIEdgeInsetsMake(0, 0, bottom, 0);
////
////
////
////}
//
//
//#pragma mark  //////////////////xmpp相关//////////////////////
//-(NSArray *)ChatsArrs
//{
//    if (_ChatsArrs == nil) {
//        _ChatsArrs = [NSArray array];
//    }
//    return _ChatsArrs;
//}
//
//-(NSFetchedResultsController *)fetchedresultscontroller
//{
//    if (_fetchedresultscontroller == nil) {
//        
//        NSFetchRequest *fetchrequest = [[NSFetchRequest alloc]init];
//        //        [fetchrequest setFetchLimit:20];
//        //从游离态中获取实体描述
//        NSEntityDescription *entitys = [NSEntityDescription entityForName:@"XMPPMessageArchiving_Message_CoreDataObject" inManagedObjectContext:[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext];
//        //设置实体描述
//        fetchrequest.entity = entitys;
//        
//        
//        //设置谓词(条件筛选)
//        NSPredicate *pre = [NSPredicate predicateWithFormat:@"bareJidStr = %@",self.UserJid.bare];
//        fetchrequest.predicate = pre;
//        //
//        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES];
//        fetchrequest.sortDescriptors = @[sort];
//        
//        _fetchedresultscontroller = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchrequest managedObjectContext:[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext sectionNameKeyPath:nil cacheName:@"Message"];
//        
//        //设置代理
//        _fetchedresultscontroller.delegate = self;
//        /** 好友列表对象 */
////        [[GDXmppStreamManager ShareXMPPManager].XmppRoster addDelegate:self delegateQueue:dispatch_get_main_queue()];
//    }
//    return _fetchedresultscontroller;
//}
////-(void)setEditing:(BOOL)editing animated:(BOOL)animated{}
////代理 , 每当收到数据的时候回调用一次,发消息是 也 会自动调用  , 用来更新数据
//-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
//{
//    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES];
//    
//    self.ChatsArrs = [self.fetchedresultscontroller.fetchedObjects sortedArrayUsingDescriptors:@[sort]];
//    //    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.ChatsArrs);
//    [self.tableView reloadData];
//    //    LOG(@"_%@_%d_%ld",[self class] , __LINE__,self.ChatsArrs.count);
//    if (self.ChatsArrs.count > 1) {
//        NSIndexPath *index = [NSIndexPath indexPathForRow:self.ChatsArrs.count -1 inSection:0];
//        [self.tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:NO];
//    }
//}
//-(void)tESAst
//{
//    // NSManagedObject
//}
//-(void)customDelete:(NSNotification*)note
//{
//    [self.textView deleteBackward];
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,note);
//}
//
//
//
//
//
//
//
//
//-(void)inputBrow:(NSNotification*)note
//{
//    
//    
//    
//    self.textView.font = [UIFont systemFontOfSize:14 ];
//    LOG(@"_%@_%d_/%@; %@",[self class] , __LINE__,note.userInfo[@"code"],note.userInfo[@"title"]);
//    NSString * imgName = note.userInfo[@"code"];
//    imgName=  [imgName stringByReplacingOccurrencesOfString:@";" withString:@""];
//    imgName= [imgName stringByReplacingOccurrencesOfString:@"/" withString:@""];
//    NSRange currentRange = self.textView.selectedRange;
//    
//    
//    
//    /** 用于展示 */
//    NSMutableAttributedString * currentAttributStr = [[NSMutableAttributedString alloc]initWithAttributedString:self.textView.attributedText];
//    GDTextAttachment * tachment = [[GDTextAttachment alloc]init];
//    tachment.desc = [NSString stringWithFormat:@"/%@;",note.userInfo[@"code"]];
//    tachment.image = [UIImage imageWithContentsOfFile:gotResourceInSubBundle(imgName, @"gif", @"face_img")];
//    tachment.bounds = CGRectMake(0, -4, self.textView.font.lineHeight, self.textView.font.lineHeight);
//    NSAttributedString * showStr = [NSAttributedString attributedStringWithAttachment:tachment];
//    
//    /** 拼回去 */
//    [currentAttributStr replaceCharactersInRange:currentRange withAttributedString:showStr];
//    
//    [currentAttributStr  addAttribute:NSFontAttributeName value:self.textView.font range:NSMakeRange(0, currentAttributStr.length)];
//    
//    //    /** 在这调一个方法 解析属性字符串 */
//    //   NSAttributedString * result =  [self dealTheStr:currentAttributStr.string];
//    
//    self.textView.attributedText = currentAttributStr;
//    
//    /**把标也放回去 */
//    self.textView.selectedRange = NSMakeRange(currentRange.location+showStr.length, 0);
//    
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.textView.attributedText);
//    
//    //    [self.textView.attributedText  enumerateAttribute:<#(nonnull NSString *)#> inRange:<#(NSRange)#> options:<#(NSAttributedStringEnumerationOptions)#> usingBlock:<#^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop)block#>]
//    
//    
//    
//}
//
//-(NSAttributedString*)dealTheStr:(NSString*)str
//{
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,str);
//    NSMutableAttributedString * mAttriStr = [[NSMutableAttributedString alloc]initWithString:str];
//    
//    NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:@"/[a-zA-Z]+;" options:NSRegularExpressionCaseInsensitive error:nil];
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,mAttriStr);
//    NSArray * matches = [regex matchesInString:str options:0 range:NSMakeRange(0, str.length)];
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,matches);
//    if (matches) {
//        for (NSTextCheckingResult * result  in matches) {
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,NSStringFromRange(result.range));
//            /** 取出图片名 */
//            NSString * imgName = [str substringWithRange:result.range];
//            imgName=  [imgName stringByReplacingOccurrencesOfString:@";" withString:@""];
//            imgName= [imgName stringByReplacingOccurrencesOfString:@"/" withString:@""];
//            NSTextAttachment * tachment = [[NSTextAttachment alloc]init];
//            tachment.image = [UIImage imageWithContentsOfFile:gotResourceInSubBundle(imgName, @"gif", @"face_img")];
//            NSAttributedString * imgStr = [NSAttributedString attributedStringWithAttachment:tachment];
//            [mAttriStr replaceCharactersInRange:result.range withAttributedString:imgStr];
//            
//            
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,imgName);
//        }
//    }
//    
//    
//    
//    
//    return mAttriStr;
//}
//
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(customDelete:) name:@"CUSTOMDELETE" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputBrow:) name:@"INPUTBROW" object:nil];
//    //设置头像代理
////    [[GDXmppStreamManager ShareXMPPManager].xmppvcardavatarModule addDelegate:self delegateQueue:dispatch_get_main_queue()];
//    if (!self.UserJid) {
//        self.UserJid = self.keyParamete[@"paramete"];
//    }
//    
//    XMPPvCardTemp * vcard = [[GDXmppStreamManager ShareXMPPManager].xmppvcardtempModule vCardTempForJID:self.UserJid shouldFetch:YES];
//    [[GDXmppStreamManager ShareXMPPManager].xmppvcardtempModule addDelegate:self  delegateQueue:dispatch_get_main_queue()];
//    if (vcard.nickname.length>0 && ![vcard.nickname isEqualToString:@"null"]) {
//        self.naviTitle =  vcard.nickname ;
//        
//    }else{
//        self.naviTitle = self.UserJid.user;
//    }
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.keyParamete);
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.UserJid);
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.UserJid.full);
//    [self setupUI];
//    
//    //执行查询控制器
//    [NSFetchedResultsController deleteCacheWithName:@"Message"];
//    
//    /** 原来(始) */
//    [self.fetchedresultscontroller performFetch:nil];
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"先执行");
//    self.ChatsArrs = self.fetchedresultscontroller.fetchedObjects;
//    if (self.ChatsArrs.count > 10) {
//        NSIndexPath *index = [NSIndexPath indexPathForRow:self.ChatsArrs.count -1 inSection:0];
//        [self.tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//    }
//    /** 原来(终) */
//    
//    // Do any additional setup after loading the view.
//}
//- (void)xmppvCardTempModule:(XMPPvCardTempModule *)vCardTempModule
//        didReceivevCardTemp:(XMPPvCardTemp *)vCardTemp
//                     forJID:(XMPPJID *)jid{
//    self.naviTitle = vCardTemp.nickname;
//    LOG(@"_%@_%d_本地没有昵称 , 服务器请求后返回的%@----%@",[self class] , __LINE__,vCardTemp.nickname , jid.user);
//}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
//    // Dispose of any resources that can be recreated.
//}
//
//
////发送消息
////- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
////    NSData * data = [[NSData alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"loading.gif" ofType:nil]];
////    [[GDXmppStreamManager ShareXMPPManager] sendImageMessage:data toAccount:@"zhangkaiqiang"];
////    
////    
////}
//
//
////- (void)turnSocket:(TURNSocket *)sender didSucceed:(GCDAsyncSocket *)socket{
////    LOG(@"_%@_%d_文件传输相关%@",[self class] , __LINE__,sender);
////    //    XMPPSIFileTransfer * ssss = [XMPPSIFileTransfer new];
////}
//
////- (void)turnSocketDidFail:(TURNSocket *)sender{
////    LOG(@"_%@_%d_文件传输相关%@",[self class] , __LINE__,sender);
////    
////}
//
//
//#pragma mark Roster(好友列表)的代理
///** 收到添加好友的请求信息 */
////-(void)xmppRoster:(XMPPRoster *)sender didReceivePresenceSubscriptionRequest:(XMPPPresence *)presence
////{
////    LOG(@"_%@_%d_收到添加好友请求 XMPPRoster:%@\nXMPPPresence:%@",[self class] , __LINE__,sender,presence);
////    [[GDXmppStreamManager ShareXMPPManager].XmppRoster acceptPresenceSubscriptionRequestFrom:presence.from andAddToRoster:YES];//同意
////    
////}
//
////删除好友
////- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
////{
////    //    XMPPUserCoreDataStorageObject *user = self.RecentlyArrs[indexPath.row];
////    XMPPJID *jid =  [XMPPJID jidWithUser:@"caohenghui" domain:@"jabber.zjlao.com" resource:@"fuck"];
////    [[GDXmppStreamManager ShareXMPPManager].XmppRoster removeUser:jid];
////}
//
///** 添加好友请求 */
////- (IBAction)AddFrend:(UIBarButtonItem *)sender {
////    
////    [[GDXmppStreamManager ShareXMPPManager].XmppRoster addUser:[XMPPJID jidWithUser:@"zhangkaiqiang" domain:@"jabber.zjlao.com" resource:@"fuck"] withNickname:@"我来加你好友啦"];
////    
////    
////}
//
//
////头像代理
////刷新头像
////-(void)xmppvCardAvatarModule:(XMPPvCardAvatarModule *)vCardTempModule didReceivePhoto:(UIImage *)photo forJID:(XMPPJID *)jid
////{
////    [self.tableView reloadData];
////}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//#pragma mark UI
//
//
//
//
//@end
