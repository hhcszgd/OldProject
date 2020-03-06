//
//  NewChatVC.m
//  b2c
//
//  Created by WY on 17/3/13.
//  Copyright © 2017年 www.16lao.com. All rights reserved.
//

#import "NewChatVC.h"

#import <Photos/Photos.h>

//#import "Base64.h"
//#import "GCDAsyncSocket.h"
#import "ChatCellBC.h"
#import "NewMeChatCell.h"
#import "NewOtherChatCell.h"

#import "ChatModel.h"

#import "PerformChatTool.h"
#import "NSString+Hash.h"
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

#import "TestScrollViewProPerty.h"

#import "COSTask.h"
#import "COSClient.h"
#import "HttpClient.h"
#import "GDMessage.h"
#import "b2c-Swift.h"
@interface NewChatVC ()<UITableViewDataSource,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate/*,UITextInputDelegate*/,UITextViewDelegate ,/** xmpp相关协议 */NSFetchedResultsControllerDelegate,XMPPRosterDelegate,XMPPvCardTempModuleDelegate,XMPPvCardAvatarDelegate>
{

    int64_t currentTaskid;
    
}


@property(nonatomic,copy)NSString * appId ;
@property(nonatomic,copy)NSString * bucket ;
@property(nonatomic,copy)NSString * dir ;

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
@property(nonatomic,strong)PerformChatTool * chatTool ;

@property(nonatomic,assign)BOOL  needShowKeyboardAgain ;
//@property(nonatomic,copy)NSString * sessionID ;
//@property(nonatomic,strong)NSTimer * timer ;

/** xmpp开始 */
//查询请求控制器
@property (nonatomic ,strong)NSFetchedResultsController *fetchedresultscontroller;

@property (nonatomic , strong)NSArray *ChatsArrs;
@property(nonatomic,assign)CGFloat  keyboardHeight ;
@property(nonatomic,weak)UIButton * browButton ;//表情按钮
@property(nonatomic,strong)COSClient * myClient ;
@property(nonatomic,strong)HttpClient * client ;
//@property(nonatomic,assign)BOOL  storeLocal ;//本地是否已经有聊天记录 , 设计规则:本地有说明服务器一定有
//
//@property(nonatomic,assign)BOOL  storeServer ;//服务器是否已经有聊天记录 , 服务器有本地不一定会有
@property(nonatomic,assign)BOOL  needSaveMessage;//本地是否需要存储聊天记录 , 服务器和本地都没有就不用存储到本地(实现方式是:关闭聊天界面,删除与之聊天的人的消息记录 , 下次进来直接到服务器请求 , 保证最老的那一条消息有serverID)

@property(nonatomic,copy)NSString * lastSortKey ; // 最后一条消息的排序key , 用于查本地
@property(nonatomic,copy)NSString * lastRowNumber ; // 最后一条消息的sortKey对应的行号

@property(nonatomic,copy)NSString * lastMessageID ; // 最后一条消息的服务器消息id , 用于查服务器
/** xmpp结束 */

@end

@implementation NewChatVC



#pragma mark 注释: viewDidLoad
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(customDelete:) name:@"CUSTOMDELETE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputBrow:) name:@"INPUTBROW" object:nil];
    GDlog(@"%@",self.UserJid.user)
    //设置头像代理
    //    [[GDXmppStreamManager ShareXMPPManager].xmppvcardavatarModule addDelegate:self delegateQueue:dispatch_get_main_queue()];
    NSLog(@"_%d_%@",__LINE__,self.keyParamete);
    if (!self.UserJid) {
        self.UserJid = self.keyParamete[@"paramete"];
    }else{
        NSLog(@"_%d_%@",__LINE__,self.keyParamete);
    }
    GDlog(@"%@",self.UserJid.user)

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateFromLocalMessage) name:self.UserJid.user object:nil];
    NSLog(@"_%d_%@",__LINE__,self.UserJid.user);
    XMPPvCardTemp * vcard = [[GDXmppStreamManager ShareXMPPManager].xmppvcardtempModule vCardTempForJID:self.UserJid shouldFetch:YES];
    [[GDXmppStreamManager ShareXMPPManager].xmppvcardtempModule addDelegate:self  delegateQueue:dispatch_get_main_queue()];
    if (vcard.nickname.length>0 && ![vcard.nickname isEqualToString:@"null"]) {
        self.naviTitle =  vcard.nickname ;
        
    }else{
        if ([self.UserJid.user isEqualToString:@"kefu"]) {
            self.naviTitle =  @"直接捞客服" ;
        }else{
            if ([self.UserJid.user hasPrefix:@"z~"]) {
                self.naviTitle = [self.UserJid.user stringByReplacingOccurrencesOfString:@"z~" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, 2)];
            }else{
                self.naviTitle = self.UserJid.user;
            }
            //            self.naviTitle = self.UserJid.user;
            NSLog(@"_%d_%@",__LINE__,self.naviTitle);
            NSLog(@"_%d_%@",__LINE__,self.UserJid.user);
        }
    }
    
    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.keyParamete);
    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.UserJid);
    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.UserJid.full);
    [self setupUI];
    
    //执行查询控制器
//    [NSFetchedResultsController deleteCacheWithName:@"Message"];
    
    
    
    
    /** 原来(始) */
//    [self.fetchedresultscontroller performFetch:nil];
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"先执行");
//    self.ChatsArrs = self.fetchedresultscontroller.fetchedObjects;
//    if (self.ChatsArrs.count > 10) {
//        NSIndexPath *index = [NSIndexPath indexPathForRow:self.ChatsArrs.count -1 inSection:0];
//        [self.tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//    }
    /** 原来(终) */
//    [[GDStorgeManager share] gotMessageHistoryWithUser:self.UserJid.user callBack:^(NSInteger resultCode, NSArray<GDMessage *> * _Nonnull resultArr ) {
//        self.ChatsArrs = resultArr;
//        GDlog(@"%@",[NSThread currentThread])//zhu
//        GDlog(@"%@",self.ChatsArrs)//zhu
//        if(self.ChatsArrs.count == 0 ){//到服务器取 , 并且发送和接受的消息都不用存本地  , 取到的话就存本地
//            [[GDStorgeManager share] insertHistoryMessageFrom:[UserInfo shareUserInfo].name to:self.UserJid.user messageID:self.lastMessageID callBack:^(NSInteger resultCode, NSArray * _Nonnull resultArr) {
//                GDlog(@"%@",resultArr)
//            }];
//        }else{//正常处理
//        
//        }
//    }];

    [[GDStorgeManager share] gotLocakOrServerMessageHistoryWithUser:self.UserJid.user lastSortKey:@"" lastServerMsgID:@"" callBack:^(NSInteger resultCode, NSArray<GDMessage *> * _Nonnull msgArr) {
        GDlog(@"%@",msgArr)
        GDlog(@"%ld",resultCode)
        for (GDMessage * msg  in msgArr) {
            GDlog(@"消息体:%@,发自:%@,发给:%@",msg.body , msg.fromAccount , msg.toAccount)
        }
//        if (resultCode == 2 ) {
//            self.needSaveMessage = NO ;
//        }else{
//            self.needSaveMessage = YES  ;
//        }
        if (msgArr.count>0) {
            self.needSaveMessage = YES  ;

            GDMessage * msg = msgArr.firstObject;
            self.lastSortKey = msg.sortKey;
            self.lastMessageID = msg.serverID;
            self.lastRowNumber = msg.rowNumber;
            GDlog(@"%@",msg.body)
        }
        GDlog(@"%@",self.lastMessageID)
        GDlog(@"%@",self.lastSortKey)
        self.ChatsArrs = msgArr;
        [self.tableView reloadData];
        if (msgArr.count >= 10) {
            
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.ChatsArrs.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
        
        
    }];
    
//    [[GDStorgeManager share] singleGotMessageHistoryFromLocalWithDb:nil  user:self.UserJid.user sortKey:@"50" callBack:^(NSInteger resultcode, NSArray<GDMessage *> * _Nonnull arr) {
//        for (GDMessage  * item  in arr ) {
//            GDlog(@"%@#@#%@#@#%@",item.sortKey, item.body , item.rowNumber)
//        }
//    }];
    
    
    // Do any additional setup after loading the view.
    //    appId = @"10077236";
    self.appId = @"1252811222";
    //    self.bucket = @"zhijielao";
    self.bucket = @"zjlaoi0";
    self.myClient = [[COSClient alloc] initWithAppId:self.appId withRegion:@"tj"];
    
    [[UserInfo shareUserInfo] gotTencentYunSuccess:^(ResponseObject *response) {
        NSLog(@"_%d_%@",__LINE__,response.data);
        if (response.data) {
            NSString * tempSign = (NSString*)response.data;
            NSString* singEncode = [tempSign stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];            
            self.sign = singEncode;
            [self creatDir];
        }
    } failure:^(NSError *error) {
        NSLog(@"_%d_%@",__LINE__,error);
    }];
    //[self getOriginalImagesIsOriginal:NO];
    
}

#pragma mark UI
-(void)setupUI
{
    
    NSString * sourctPath = gotResourceInSubBundle(@"cy", @"gif", @"face_img");
    LOG(@"_%@_%d_%@",[self class] , __LINE__,sourctPath);
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
    if (self.ChatsArrs.count>=10) {
        
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.ChatsArrs.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        
    }
    
}

#pragma mark tableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ChatsArrs.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GDMessage * message  = self.ChatsArrs[indexPath.row];
    
//    XMPPvCardTemp * vcard = [[GDXmppStreamManager ShareXMPPManager].xmppvcardtempModule vCardTempForJID:message.bareJid shouldFetch:YES];
    
//    LOG(@"_%@_%d_\n\n\n昵称啊昵称%@\n\n\n",[self class] , __LINE__,vcard.nickname);
    //注意,这里的头像有两个方向
    
    UITableViewCell * cell = nil ;
    
    GDlog(@"%@%@",message.fromAccount,message.myAccount)
    
    
    if ([message.fromAccount isEqualToString:  message.myAccount] || [message.fromAccount isEqualToString:  message.myAccount]) {
        //我发出去
        cell = [tableView dequeueReusableCellWithIdentifier:@"MeChatCell"];
        if (!cell) {
            cell=[[NewMeChatCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MeChatCell"];
        }
        NewOtherChatCell * me = (NewOtherChatCell*)cell ;
        me.myClient=self.myClient;
        me.chatMessageModel=message;
        //                LOG(@"_%@_%d_%@",[self class] , __LINE__,me);
        return me;
    }else  {//别人发出去的
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"OtherChatCell"];
        if (!cell) {
            cell=[[NewOtherChatCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OtherChatCell"];
        }
        NewOtherChatCell * other = (NewOtherChatCell*)cell ;
        other.myClient=self.myClient;
        other.chatMessageModel=message;
        //                LOG(@"_%@_%d_%@",[self class] , __LINE__,other);
        return other;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GDMessage * message  = self.ChatsArrs[indexPath.row];
    //    NSAttributedString * str = [message.body dealStrWithLabelFont:[UIFont systemFontOfSize:15]];
    
    CGFloat margin = 10 ;
    CGFloat labelX = margin + 30 + 25 ;
    CGFloat labelW = screenW - labelX - 24 ;
    
    if ([message.body hasPrefix:@"img:"]||[message.body hasPrefix:@"Img:"]||[message.body hasPrefix:@"IMG:"] ) {
        
        NSString * imgUrlStr = [message.body stringByReplacingCharactersInRange:NSMakeRange(0, 4) withString:@""];
        NSURLComponents * urlComponents = [NSURLComponents componentsWithString:imgUrlStr ];
        NSArray * queryItems =  urlComponents.queryItems;
        CGFloat maxW = screenW /3 ;
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


//拖动调整键盘
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    LOG(@"_%@_%d_%d",[self class] , __LINE__,self.isKeyboardShow)
    if (scrollView != self.tableView) {
        return;
    }
    if (self.isKeyboardShow) {
        [self.textView resignFirstResponder];
    }else{
        LOG(@"_%@_%d_%@",[self class] , __LINE__,NSStringFromCGPoint(self.tableView.contentOffset))
        LOG(@"_%@_%d_%@",[self class] , __LINE__,NSStringFromCGSize(self.tableView.contentSize))
        if (self.tableView.contentOffset.y+self.tableView.bounds.size.height>self.tableView.contentSize.height) {
            [self.textView becomeFirstResponder];
        }
    }
    LOG(@"_%@_%d_%@",[self class] , __LINE__,NSStringFromCGPoint(self.tableView.contentOffset))
    
}
#pragma mark textViewdelegate
//按return键发送消息
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    
    if ([text isEqualToString:@"\n"]) {
        LOG(@"_%@_%d_%lu",[self class] , __LINE__,(unsigned long)textView.text.length)
        
        NSString * elementID =  [[GDXmppStreamManager ShareXMPPManager].XmppStream generateUUID];
        XMPPMessage *message = [XMPPMessage messageWithType:@"chat" to:self.UserJid  elementID:elementID ];
        NSLog(@"_%d_%@",__LINE__,elementID);
        NSXMLElement *receipt = [NSXMLElement elementWithName:@"request" xmlns:@"urn:xmpp:receipts"];
        //        [receipt addAttributeWithName:@"id" stringValue:elementID];///////////////
        [message addChild:receipt];
        [message addBody:self.textView.sendStr];
        
        [[GDXmppStreamManager ShareXMPPManager].XmppStream sendElement:message];
        [self saveMessageToDB:message];
        [self updateFromLocalMessage];
        self.textView.text = nil ;
        //        [self.tableView reloadData];
        //        [self.tableView scrollToRowAtIndexPath:idx atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        return NO;
    }
    return YES;
}

-(void)updateFromLocalMessage // 待优化 , 实现分页
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
    
        
        
        [[GDStorgeManager share] gotMessageHistoryWithUser:self.UserJid.user callBack:^(NSInteger resultCode, NSArray<GDMessage *> * _Nonnull resultArr ) {
            self.ChatsArrs = resultArr;
//            for (GDMessage * msg  in resultArr) {
//                GDlog(@"消息体:%@,发自:%@,发给:%@",msg.body , msg.fromAccount , msg.toAccount)
//            }
            [self.tableView reloadData];
            if (self.ChatsArrs.count > 1) {
                NSIndexPath *index = [NSIndexPath indexPathForRow:self.ChatsArrs.count -1 inSection:0];
                [self.tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:NO];
            }
        }];
        
        
    });
    
    
}

-(void)saveMessageToDB:(XMPPMessage*)message
{
    NSString * fromAccount = [GDXmppStreamManager ShareXMPPManager].XmppStream.myJID.user;
    NSString * toAccount = message.to.user;
    [[GDStorgeManager share] insertMessageToDatabaseWithMessage:message isMax:@"max" from:fromAccount to:toAccount callBack:^(NSInteger resultCode, NSString * _Nonnull resultStr) {
        if (resultCode == 0) {
            GDlog(@"自己消息插入失败:%@",resultStr)
        }else{
            GDlog(@"自己消息插入成功:%@",resultStr)
        }
    }];
    //    [[GDStorgeManager share] insertMessageToDatabaseWithMessage:message isMax:@"max" from:fromAccount to:toAccount];
    
    
}

#pragma mark customMethod

-(GDKeyBoard *)browKeyBoard{
    if (_browKeyBoard==nil) {
        CGFloat keyboardH = 0;
        if (screenW<321) {//4,5
            keyboardH = 216;
        }else if (screenW<321) {//6
            keyboardH = 226 ;
        }else if (screenW<376) {//6p
            keyboardH = 258 ;
        }else {
            keyboardH = 258 ;
        }
        GDKeyBoard * keyBoard =[[GDKeyBoard alloc]initWithFrame: CGRectMake(0, 0, screenW,keyboardH )];
        NSMutableArray * bigArrm = [NSMutableArray new];
        NSString * path = gotResourceInSubBundle(@"brow", @"plist", @"face_img");
        NSArray * littleArr = [NSArray arrayWithContentsOfFile:path];
        [bigArrm addObject:littleArr];
        keyBoard.allBrowNames = bigArrm;
        LOG(@"_%@_%d_%@",[self class] , __LINE__,keyBoard.allBrowNames);
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
        self.inputView.mj_y=screenH-self.inputView.bounds.size.height;
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
    LOG(@"_%@_%d_%@",[self class] , __LINE__,NSStringFromCGSize( self.tableView.contentSize ))
    LOG(@"_%@_%d_%f",[self class] , __LINE__,keyboardHeight)
    
    [UIView animateWithDuration:duration animations:^{
        self.inputView.mj_y=screenH-keyboardHeight-self.inputView.bounds.size.height;
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
-(void)loadMoreMessage
{
    
    [[GDStorgeManager share] gotLocakOrServerMessageHistoryWithUser:self.UserJid.user lastSortKey:self.lastSortKey lastServerMsgID:self.lastMessageID callBack:^(NSInteger resultCode, NSArray<GDMessage *> * _Nonnull msgArr) {
        GDlog(@"%@",msgArr)
        GDlog(@"%ld",resultCode)
        for (GDMessage * msg  in msgArr) {
            GDlog(@"消息体:%@,发自:%@,发给:%@",msg.body , msg.fromAccount , msg.toAccount)
        }
        //        if (resultCode == 2 ) {
        //            self.needSaveMessage = NO ;
        //        }else{
        //            self.needSaveMessage = YES  ;
        //        }
        if (msgArr.count>0) {
            self.needSaveMessage = YES  ;
            
            GDMessage * msg = msgArr.firstObject;
            self.lastSortKey = msg.sortKey;
            self.lastMessageID = msg.serverID;
            self.lastRowNumber = msg.rowNumber;
            GDlog(@"%@",msg.body)
        }
        GDlog(@"%@",self.lastMessageID)
        GDlog(@"%@",self.lastSortKey)
        NSMutableArray * arr  = [NSMutableArray arrayWithArray:msgArr];
        NSArray * temp = arr.copy;
        [arr addObjectsFromArray:self.ChatsArrs];
        self.ChatsArrs = arr.copy;
        self.tableView.mj_header.state = MJRefreshStateIdle;
        [self.tableView reloadData];
        if (msgArr.count ==0) {
            [GDAlertView alert:@"没有更多了" image:nil time:2 complateBlock:^{
                
            }];
        }else {
            if (temp.count>0) {
                
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:msgArr.count inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
            }else{
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:msgArr.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
            }
        }
//        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:msgArr.count-2 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        
        
    }];

    
    
}
-(void)setupTableView
{
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, screenW, screenH-56*SCALE-64)];
    [self.view addSubview:tableView];
    self.tableView=tableView;
    self.tableView.backgroundColor=BackgroundGray;
    self.tableView.delegate = self;
    self.tableView.dataSource=self;
    self.tableView.mj_header = [HomeRefreshHeader headerWithRefreshingTarget:self  refreshingAction:@selector(loadMoreMessage)];
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
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"dealloc")
    NSLog(@"_%d_%@",__LINE__,@"chatVC已销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self ];
    /*//等获取历史消息接口好了再打开
     if (!self.needSaveMessage) {
        if (self.UserJid.user) {
            GDlog(@"%@",self.UserJid.user)
            [[GDStorgeManager share] deleteFormContentWithUserName:self.UserJid.user callBack:^(NSInteger resultCode, NSString * _Nonnull resultStr ) {
                
            }];
            
        }
    }
    */
    
}




-(UIView*)gotInputView
{
    
    
    
    CGFloat margin= 10 ;
    UIView * inputView = [[UIView alloc]initWithFrame: CGRectMake(0, screenH-56*SCALE, screenW, 56*SCALE)];
    
    inputView.backgroundColor= [UIColor whiteColor];
    
    
    
    
    
    CGFloat picH =   inputView.bounds.size.height * 0.6;;
    CGFloat picW =  picH ;
    CGFloat picX =  inputView.bounds.size.width - picW ;
    CGFloat picY =  inputView.bounds.size.height * 0.2 ;
    UIButton * picture = [[UIButton alloc]initWithFrame:CGRectMake(picX, picY,picW, picH)];
    
    [inputView addSubview:picture];
    [picture setImage:[UIImage imageNamed:@"imgPicker"] forState:UIControlStateNormal];
    //    [picture setImage:[UIImage imageNamed:@"bg_electric"] forState:UIControlStateHighlighted];
    [picture addTarget:self action:@selector(gotPicture:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    //    picture.backgroundColor=randomColor;
    CGFloat browH =   picH;
    CGFloat browW =  browH ;
    CGFloat browX =  inputView.bounds.size.width - picW - browW ;
    CGFloat browY =  picY ;
    
    
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

    //换了个产品 , 改需求吧-_-!
//    CGFloat sendButtonH = browH ;
//    CGFloat sendButtonW = browW ;
//    CGFloat sendButtonX = screenW - sendButtonW ;
//    CGFloat sendButtonY = browY ;
//    UIButton * sendButton = [[UIButton alloc]initWithFrame:CGRectMake(sendButtonX,sendButtonY,sendButtonW,sendButtonH)];
//    [sendButton setImage:[UIImage imageNamed:@"bg_icon_xx"] forState:UIControlStateNormal];
//
//    [sendButton addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [inputView addSubview:sendButton];
    CGFloat textviewW = screenW  - browW - picW - margin;
    CGFloat textviewX = margin ;
    CGFloat textviewY = margin*0.8;
    CGFloat textviewH = inputView.bounds.size.height - textviewY*2;
    GDTextView * textView = [[GDTextView alloc]initWithFrame:CGRectMake(textviewX,textviewY,textviewW,textviewH)];
    textView.font = [UIFont systemFontOfSize:17*SCALE];
    [inputView addSubview:textView];
    textView.backgroundColor = BackgroundGray ; //[UIColor colorWithRed:0.89 green:0.89 blue:0.89 alpha:1];
    self.textView = textView;
    textView.layer.borderColor=inputView.backgroundColor.CGColor;
    textView.layer.borderWidth=2;
    textView.layer.masksToBounds=YES;
    textView.layer.cornerRadius=5;
    textView.textContainerInset=UIEdgeInsetsMake(8, 10, 8, 5);
    textView.keyboardType=UIKeyboardTypeTwitter;
    textView.returnKeyType=UIReturnKeySend;
    //    textView.inputDelegate=self;
    textView.enablesReturnKeyAutomatically=YES;
    textView.delegate = self ;
    textView.showsVerticalScrollIndicator = NO ;
    return inputView;
    
    
    
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
    LOG(@"_%@_%d_%@",[self class] , __LINE__,temp );
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
    [self saveMessageToDB:message];
    [self updateFromLocalMessage];
    self.textView.text = nil ;
}

-(void)gotPicture:(UIButton *)sender
{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"huo qu tu pian ")
    if (!self.sign) {
        [[UserInfo shareUserInfo] gotTencentYunSuccess:^(ResponseObject *response) {
            NSLog(@"_%d_%@",__LINE__,response.data);
            if (response.data) {
                NSString * tempSign = (NSString*)response.data;
                NSString* singEncode = [tempSign stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//第一次解码 , 解码失败会返回空
                
                self.sign = singEncode;
                [self creatDir];
            }
        } failure:^(NSError *error) {
            NSLog(@"_%d_%@",__LINE__,error);
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
            AlertInVC(@"摄像头不可用");
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
    GDlog(@"这张照片的方向:%ld",(long)orginalImage.imageOrientation)

//    UIImage * imgUp = nil ;
//    if (orginalImage.imageOrientation == UIImageOrientationRight) {//  3
//
//        imgUp = [UIImage imageWithCGImage:orginalImage.CGImage scale:1.0 orientation:UIImageOrientationUp];
//    }else if (orginalImage.imageOrientation == UIImageOrientationLeft) {//  2
//
//         imgUp = [UIImage imageWithCGImage:orginalImage.CGImage scale:1.0 orientation:UIImageOrientationRight];
//        
//    }else if (orginalImage.imageOrientation == UIImageOrientationDown) {// 1
//
//       imgUp = [UIImage imageWithCGImage:orginalImage.CGImage scale:1.0 orientation:UIImageOrientationDown];
//        
//    }else if (orginalImage.imageOrientation == UIImageOrientationUp) {//  0
//        imgUp = orginalImage;
//    } else{
//        imgUp = orginalImage;
//    }

    // NSString * pathWithJPEG = [photoPath stringByAppendingString:@".jpeg"];
    NSData *imageData = UIImageJPEGRepresentation(orginalImage, 0.5);
    [imageData writeToFile: photoPath atomically:YES];
    
    //imageV.image = orginalImage;
    //imgSavepath = photoPath;
    
    [self uploadFileMultipartWithPath:photoPath];
    LOG_METHOD
}

/**创建目录*/
-(void)creatDir
{
    
    NSString * tempDir = [UserInfo shareUserInfo].name;
    NSString * sign = self.sign ; //待实现
    COSCreateDirCommand *cm = [[COSCreateDirCommand alloc] initWithDir:tempDir
                                                                bucket:self.bucket
                                                                  sign:sign
                                                             attribute:@"attr" ];
    
    __weak __typeof(self)weakSelf = self;
    self.myClient.completionHandler = ^(COSTaskRsp *resp, NSDictionary *context){
        COSCreatDirTaskRsp *rsp = (COSCreatDirTaskRsp *)resp;
        
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        
        NSLog(@"👉[%@][%d]❌%d❌" , [strongSelf class] , __LINE__ ,rsp.retCode);
        NSLog(@"👉[%@][%d]❌%@❌" , [strongSelf class] , __LINE__ ,rsp.descMsg);
        NSLog(@"👉[%@][%d]❌%@❌" , [strongSelf class] , __LINE__ ,rsp.data);
        NSLog(@"👉[%@][%d]❌%@❌" , [strongSelf class] , __LINE__ ,rsp.fileData);
        if (rsp.retCode >= 0  || rsp.retCode == - 178 ) {//创建成功 , 引用self时注意循环引用 , 用weak self
            strongSelf.dir = [UserInfo shareUserInfo].name;
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
    task.bucket = self.bucket;//必填
    //task.attrs = @"customAttribute";
    if (self.dir) {
        task.directory = [NSString stringWithFormat:@"imfile/%@",self.dir];//self.dir ;
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
            //            [message addBody:[NSString stringWithFormat:@"img:%@?width=%f&height=%f",rsp.sourceURL,img.size.width > 0 ? img.size.width : screenW / 3  , img.size.height > 0 ? img.size.height : screenW / 3]];
            //https://i0.zjlao.cn/imfile/someoneUserName/imgname.jpg?width=22&height=33
            NSString * targetURL = rsp.sourceURL;
            if ([targetURL containsString:@"/imfile/"]) {
                NSRange imfileRange = [targetURL rangeOfString:@"/imfile/"];
                targetURL = [targetURL substringFromIndex:imfileRange.location];
            }
            targetURL = [NSString stringWithFormat:@"https://i0.zjlao.com%@",targetURL];
            [message addBody:[NSString stringWithFormat:@"img:%@?width=%f&height=%f",targetURL,img.size.width > 0 ? img.size.width : screenW / 3  , img.size.height > 0 ? img.size.height : screenW / 3]];
            [[GDXmppStreamManager ShareXMPPManager].XmppStream sendElement:message];
            NSLog(@"腾讯云文件上传成功context  = %@",context);
            NSLog(@"_%d_%d",__LINE__,rsp.retCode);
            NSLog(@"上传成功后文件链接为:  %@",rsp.sourceURL);
            NSLog(@"_%d_%@",__LINE__,rsp.descMsg);
            NSLog(@"_%d_%@",__LINE__,rsp.acessURL);
            NSLog(@"_%d_%@",__LINE__,rsp.httpsURL);
            NSLog(@"_%d_%@",__LINE__,rsp.data);
            [strongSelf saveMessageToDB:message];
            [strongSelf updateFromLocalMessage];
        }else{//上传失败
            //            strong.text = rsp.descMsg;
            NSLog(@"腾讯云文件上传失败context  = %@",context);
            [GDAlertView alert:@"图片发送失败\n请重试" image:nil time:2 complateBlock:^{
                
            }];
            [[UserInfo shareUserInfo] gotTencentYunSuccess:^(ResponseObject *response) {
                NSLog(@"_%d_%@",__LINE__,response.data);
                if (response.data) {
                    NSString * tempSign = (NSString*)response.data;
                    NSString* singEncode = [tempSign stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//第一次解码 , 解码失败会返回空
                    
                    strongSelf.sign = singEncode;
                    [strongSelf creatDir];
                }
            } failure:^(NSError *error) {
                NSLog(@"_%d_%@",__LINE__,error);
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
    //    __weak __typeof(self)weakSelf = self;
    //    __strong __typeof(weakSelf)strongSelf = weakSelf;
    self.myClient.completionHandler = ^(COSTaskRsp *resp, NSDictionary *context){
        //    __strong __typeof(weakSelf)strongSelf = weakSelf;
        
        COSGetObjectTaskRsp *rsp = (COSGetObjectTaskRsp *)resp;
        NSLog(@"腾讯云文件下载成功context  = %@",context);
        NSLog(@"_%d_%d",__LINE__,rsp.retCode);
        NSLog(@"_%d_%@",__LINE__,rsp.descMsg);
        NSLog(@"_%d_%@",__LINE__,rsp.data);
        
        //        NSString * savePath =  [strongSelf doloadImgSavePathForURL:imageUrlStr toUserName:strongSelf.UserJid.user];
        
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
    //    if (string) {
    //        self.sign = string;
    //        NSLog(@"self.sign = %@",self.sign);
    //        //imgUrl.text =self.sign;
    //    }else{
    //        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"警告" message:@"签名为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //        [al show];
    //    }
}
-(void)getSign
{
    //网络请求工具类
    //    self.client = [[HttpClient alloc] init];
    //    self.client.vc = self;
    //    //向自己的业务服务器请求 上传所需要的签名
    //    [self getUploadSign];
}
-(void)getUploadSign
{
    //NSString *url = [NSString stringWithFormat:@"http://203.195.194.28/cosv4/getsignv4.php?bucket=%@&service=video",bucket];
    //    NSString * url = [NSString stringWithFormat:@"http://192.168.5.30/cosAuth.php?bucket=%@&service=video",bucket];// @"http://192.168.5.30/cosAuth.php";
    
    
    
    //     NSString * url = [NSString stringWithFormat:@"http://192.168.5.30/cosAuth.php"];// @"http://192.168.5.30/cosAuth.php";
    //    [self.client getSignWithUrl:url callBack:@selector(getSignFinis:)];
}


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
    LOG(@"_%@_%d_%@",[self class] , __LINE__,note);
}








-(void)inputBrow:(NSNotification*)note
{
    
    
    
    self.textView.font = [UIFont systemFontOfSize:14 ];
    LOG(@"_%@_%d_/%@; %@",[self class] , __LINE__,note.userInfo[@"code"],note.userInfo[@"title"]);
    NSString * imgName = note.userInfo[@"code"];
    imgName=  [imgName stringByReplacingOccurrencesOfString:@";" withString:@""];
    imgName= [imgName stringByReplacingOccurrencesOfString:@"/" withString:@""];
    NSRange currentRange = self.textView.selectedRange;
    
    
    
    /** 用于展示 */
    NSMutableAttributedString * currentAttributStr = [[NSMutableAttributedString alloc]initWithAttributedString:self.textView.attributedText];
    GDTextAttachment * tachment = [[GDTextAttachment alloc]init];
    tachment.desc = [NSString stringWithFormat:@"/%@;",note.userInfo[@"code"]];
    tachment.image = [UIImage imageWithContentsOfFile:gotResourceInSubBundle(imgName, @"gif", @"face_img")];
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
    
    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.textView.attributedText);
    
    //    [self.textView.attributedText  enumerateAttribute:<#(nonnull NSString *)#> inRange:<#(NSRange)#> options:<#(NSAttributedStringEnumerationOptions)#> usingBlock:<#^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop)block#>]
    
    
    
}

-(NSAttributedString*)dealTheStr:(NSString*)str
{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,str);
    NSMutableAttributedString * mAttriStr = [[NSMutableAttributedString alloc]initWithString:str];
    
    NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:@"/[a-zA-Z]+;" options:NSRegularExpressionCaseInsensitive error:nil];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,mAttriStr);
    NSArray * matches = [regex matchesInString:str options:0 range:NSMakeRange(0, str.length)];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,matches);
    if (matches) {
        for (NSTextCheckingResult * result  in matches) {
            LOG(@"_%@_%d_%@",[self class] , __LINE__,NSStringFromRange(result.range));
            /** 取出图片名 */
            NSString * imgName = [str substringWithRange:result.range];
            imgName=  [imgName stringByReplacingOccurrencesOfString:@";" withString:@""];
            imgName= [imgName stringByReplacingOccurrencesOfString:@"/" withString:@""];
            NSTextAttachment * tachment = [[NSTextAttachment alloc]init];
            tachment.image = [UIImage imageWithContentsOfFile:gotResourceInSubBundle(imgName, @"gif", @"face_img")];
            NSAttributedString * imgStr = [NSAttributedString attributedStringWithAttachment:tachment];
            [mAttriStr replaceCharactersInRange:result.range withAttributedString:imgStr];
            
            
            LOG(@"_%@_%d_%@",[self class] , __LINE__,imgName);
        }
    }
    
    
    
    
    return mAttriStr;
}

- (void)xmppvCardTempModule:(XMPPvCardTempModule *)vCardTempModule
        didReceivevCardTemp:(XMPPvCardTemp *)vCardTemp
                     forJID:(XMPPJID *)jid{
    if (vCardTemp.nickname.length>0 && ![vCardTemp.nickname isEqualToString:@"null"]) {
        
        self.naviTitle = vCardTemp.nickname;
    }
    LOG(@"_%@_%d_本地没有昵称 , 服务器请求后返回的%@----%@",[self class] , __LINE__,vCardTemp.nickname , jid.user);
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}
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

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //    self.UserJid.user
    //    [[GDStorgeManager share] gotMessageHistoryWithUser: self.UserJid.user];
    //    [[GDStorgeManager share] gotMessageHistoryWithUser:self.UserJid.user callBack:^(NSInteger resultCode, NSArray<NSDictionary<NSString *,NSString *> *> * _Nonnull arr) {
    //         NSLog(@"_%d_%@",__LINE__,arr);
    //    }];
    
}
#pragma mark 注释: 获取图片 新
- (void)getOriginalImagesIsOriginal:(BOOL)isOriginal
{
    // 获得所有的自定义相簿
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    // 遍历所有的自定义相簿
    for (PHAssetCollection *assetCollection in assetCollections) {
        [self enumerateAssetsInAssetCollection:assetCollection original:isOriginal];
    }
    
    // 获得相机胶卷
    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    // 遍历相机胶卷,获取大图
    [self enumerateAssetsInAssetCollection:cameraRoll original:isOriginal];
}
/**
 *  遍历相簿中的所有图片
 *  @param assetCollection 相簿
 *  @param original        是否要原图
 */
- (void)enumerateAssetsInAssetCollection:(PHAssetCollection *)assetCollection original:(BOOL)original
{
    NSLog(@"相簿名:%@", assetCollection.localizedTitle);
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    
    // 获得某个相簿中的所有PHAsset对象
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    NSLog(@"_%d_%ld",__LINE__,assets.count);
    for (PHAsset *asset in assets) {
        // 是否要原图
        CGFloat scale = 0.1 ;
        CGSize customSize = CGSizeMake(asset.pixelWidth * scale, asset.pixelHeight * scale) ;
        CGSize size = original ? CGSizeMake(asset.pixelWidth, asset.pixelHeight) : customSize;
        
        // 从asset中获得图片
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            NSLog(@"_%d_%@",__LINE__,NSStringFromCGSize(result.size));
            NSLog(@"_%d_%@",__LINE__,result);
            NSLog(@"_%d_%@",__LINE__,info);
        }];
    }
}

@end
