//
//  LogisticsStatusVC.m
//  b2c
//
//  Created by wangyuanfei on 16/5/11.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "LogisticsStatusVC.h"

#import "GDXmppStreamManager.h"
#import "XMPPJID.h"
@interface LogisticsStatusVC ()//<NSFetchedResultsControllerDelegate,XMPPRosterDelegate>
//查询请求控制器
//@property (nonatomic ,strong)NSFetchedResultsController *fetchedresultscontroller;
//
//@property (nonatomic , strong)NSArray *ChatsArrs;
@end

@implementation LogisticsStatusVC

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
//        //从游离态中获取实体描述
//        NSEntityDescription *entitys = [NSEntityDescription entityForName:@"XMPPMessageArchiving_Message_CoreDataObject" inManagedObjectContext:[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext];
//        //设置实体描述
//        fetchrequest.entity = entitys;
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
//            /** 好友列表对象 */
//            [[GDXmppStreamManager ShareXMPPManager].XmppRoster addDelegate:self delegateQueue:dispatch_get_main_queue()];
//    }
//    return _fetchedresultscontroller;
//}
//
////用来更新数据
//-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
//{
//    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES];
//    
//    self.ChatsArrs = [self.fetchedresultscontroller.fetchedObjects sortedArrayUsingDescriptors:@[sort]];
////    [self.tableview reloadData];
//    LOG(@"_%@_%d_%ld",[self class] , __LINE__,self.ChatsArrs.count);
//    if (self.ChatsArrs.count > 10) {
//        NSIndexPath *index = [NSIndexPath indexPathForRow:self.ChatsArrs.count -1 inSection:0];
////        [self.tableview scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
        self.originURL = self.keyParamete[@"paramete"];
    
    
    
    
////    [self performLogin ];
//    //执行查询控制器
//    [NSFetchedResultsController deleteCacheWithName:@"Message"];
//    [self.fetchedresultscontroller performFetch:nil];
//    self.ChatsArrs = self.fetchedresultscontroller.fetchedObjects;
////    [self.tableview reloadData];
//    
//    if (self.ChatsArrs.count > 10) {
//        NSIndexPath *index = [NSIndexPath indexPathForRow:self.ChatsArrs.count -1 inSection:0];
////        [self.tableview scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//    }

    // Do any additional setup after loading the view.
}

//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//-(void)performLogin//登录放在appdelegate中(判断如果账户处于登录状态 , 就也链接im服务器, 否则就不链接 , 在登录成功的地方链接imTODO)
//{
////    //登录
////    [[GDXmppStreamManager ShareXMPPManager]loginWithJID:[XMPPJID jidWithUser:@"wangyuanfei" domain:@"chh-PC" resource:@"iOS"] passWord:@"123456"];
//    //登录
//    [[GDXmppStreamManager ShareXMPPManager]loginWithJID:[XMPPJID jidWithUser:@"wangyuanfei" domain:@"jabber.zjlao.com" resource:@"iOS"] passWord:@"123456"];
//}
//
////发送消息
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//    //需要一个JID
////    XMPPJID *jid = [XMPPJID jidWithUser:@"zhangkaiqiang" domain:@"chh-PC" resource:@"ahaha"];
//    XMPPMessage *message = [XMPPMessage messageWithType:@"chat" to:self.UserJid];
//    
//    [message addBody:[NSString stringWithFormat:@"%@",@"发送测试数据"]];
//    
//    [[GDXmppStreamManager ShareXMPPManager].XmppStream sendElement:message];
//    
//}
//
//-(XMPPJID * )UserJid{
//    if(_UserJid==nil){
//        _UserJid = [XMPPJID jidWithUser:@"zhangkaiqiang" domain:@"jabber.zjlao.com" resource:@"ahaha"];
//    }
//    return _UserJid;
//}
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
//#pragma mark Roster(好友列表)的代理
///** 收到添加好友的请求信息 */
//-(void)xmppRoster:(XMPPRoster *)sender didReceivePresenceSubscriptionRequest:(XMPPPresence *)presence
//{
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"收到添加好友请求");
//    [[GDXmppStreamManager ShareXMPPManager].XmppRoster acceptPresenceSubscriptionRequestFrom:presence.from andAddToRoster:YES];//同意
//    
//}
//
////删除好友
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
////    XMPPUserCoreDataStorageObject *user = self.RecentlyArrs[indexPath.row];
//    XMPPJID *jid =  [XMPPJID jidWithUser:@"caohenghui" domain:@"jabber.zjlao.com" resource:@"fuck"];
//    [[GDXmppStreamManager ShareXMPPManager].XmppRoster removeUser:jid];
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"收到好友请求");
//}
//
///** 添加好友请求 */
//- (IBAction)AddFrend:(UIBarButtonItem *)sender {
//    
//    [[GDXmppStreamManager ShareXMPPManager].XmppRoster addUser:[XMPPJID jidWithUser:@"zhangkaiqiang" domain:@"jabber.zjlao.com" resource:@"fuck"] withNickname:@"我来加你好友啦"];
//    
//    
//}





@end
