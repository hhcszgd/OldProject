//
//  FriendListVC.m
//  b2c
//
//  Created by wangyuanfei on 7/2/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "FriendListVC.h"
#import "OldSkipManager.h"
#import "GDXmppStreamManager.h"
#import "NSObject+Scale.h"
#import "XMPPvCardTemp.h"
#import "OldBaseModel.h"
#import "zjlao-Swift.h"
#import "MessageCenterCell.h"

//#import "zjlao-Swift.h"

#import <CoreData/CoreData.h>
#import <XMPPFramework/XMPPvCardTempModule.h>
#import <XMPPFramework/XMPPMessageArchivingCoreDataStorage.h>
#import <XMPPFramework/XMPPRosterCoreDataStorage.h>
@interface FriendListVC ()<UITableViewDelegate,UITableViewDataSource,NSFetchedResultsControllerDelegate>

@property (nonatomic , strong)NSArray *ContactArrs;
@property (nonatomic , strong)NSArray <NSDictionary *> * CustomContactArrs;




/** 物流和商城公告 */


@property(nonatomic,strong)NSMutableArray * topArrM ;
@property (nonatomic , strong)NSFetchedResultsController *fetchedresultsController;
/** 测试匹配昵称 */
@property(nonatomic,strong)   NSFetchedResultsController*resultController ;
/*无消息界面*/
@property(nonatomic,strong )UIImageView * noMessageImgView ;
/*无消息问题提示*/
@property(nonatomic,strong)UILabel * noMessageLabel ;

@end

@implementation FriendListVC

-(void )theMessageChange
{
    [[GDStorgeManager share] gotRecentContactListWithCallBack:^(NSInteger resultCode, NSArray<NSDictionary<NSString *,NSString *> *> * _Nonnull resultArr) {
        self.CustomContactArrs =  [self.topArrM arrayByAddingObjectsFromArray:resultArr];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.CustomContactArrs.count>0) {
                self.noMessageImgView.hidden = YES ;
                self.noMessageLabel.hidden = YES ;
            }else{
                self.noMessageImgView.hidden = NO ;
                self.noMessageLabel.hidden = NO ;
            }
            [self.tableView reloadData];
        });
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(theMessageChange) name:@"MESSAGECOUNTCHANGED" object:nil];
    UIImageView * noMessageImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"noMessageImg"]];
    self.noMessageImgView = noMessageImgView;
    noMessageImgView.center = self.view.center;
    [self.view addSubview:noMessageImgView];
    
    UILabel * noMessageLabel = [[UILabel alloc]initWithTitle:@"还没有人跟你说话哦" color:[UIColor lightGrayColor] fontSize:20 margin:0];
    
    self.noMessageLabel = noMessageLabel;
    [self.view addSubview:noMessageLabel];
    [noMessageLabel sizeToFit];
    self.noMessageLabel.frame = CGRectMake(self.noMessageImgView.center.x - self.noMessageLabel.bounds.size.width/2, CGRectGetMaxY(self.noMessageImgView.frame)+18, self.noMessageLabel.bounds.size.width, self.noMessageLabel.bounds.size.height);
    UIButton * rightBtn1 = [UIButton buttonWithType:UIButtonTypeCustom]; // UIButton(type: UIButtonType.custom)
    [rightBtn1 setImage:[UIImage imageNamed:@"icon_set up"] forState:UIControlStateNormal];
    [rightBtn1 addTarget:self  action:@selector(settingBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    rightBtn1.addTarget(self, action: #selector(settingBtnClick), for: UIControlEvents.touchUpInside)
//    naviBar.rightBarButtons = [rightBtn1]

    self.navigationBarRightActionViews =  @[rightBtn1];
    
    self.naviTitle=@"消息中心";
    
    
    
    
    
    
    
//    [NSFetchedResultsController deleteCacheWithName:@"Recently"];
    [self setupTableView ];
    //执行查找数据
//    [self.fetchedresultsController performFetch:nil];
//
//    
//        self.ContactArrs =  self.fetchedresultsController.fetchedObjects;
    [[GDStorgeManager share] gotRecentContactListWithCallBack:^(NSInteger resultCode, NSArray<NSDictionary<NSString *,NSString *> *> * _Nonnull resultArr) {
        self.CustomContactArrs =  [self.topArrM arrayByAddingObjectsFromArray:resultArr];
        if (self.CustomContactArrs.count>0) {
            self.noMessageImgView.hidden = YES ;
            self.noMessageLabel.hidden = YES ;
        }else{
            self.noMessageImgView.hidden = NO ;
            self.noMessageLabel.hidden = NO ;
        }
        [self.tableView reloadData];
//        [self editMyVCardInfo];
    }];

}

-(void)settingBtnClick{
    ProfileChannelModel * model = [[ProfileChannelModel alloc] initWithDict: @{@"actionkey" : @"set"}];
    [SkipManager skipWithViewController:self model:model];
}

-(void)editMyVCardInfo
{
//    [[GDXmppStreamManager ShareXMPPManager].xmppvcardtempModule addDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
//    [[GDXmppStreamManager ShareXMPPManager].xmppvcardtempModule fetchvCardTempForJID:[GDXmppStreamManager ShareXMPPManager].XmppStream.myJID];
//   XMPPvCardTemp * myCard = [[GDXmppStreamManager ShareXMPPManager].xmppvcardtempModule vCardTempForJID:[GDXmppStreamManager ShareXMPPManager].XmppStream.myJID shouldFetch:YES];
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,myCard.jid.user);
        [[GDXmppStreamManager ShareXMPPManager].xmppvcardtempModule addDelegate:self delegateQueue:dispatch_get_main_queue()];
    XMPPvCardTemp * myCard = [GDXmppStreamManager ShareXMPPManager].xmppvcardtempModule.myvCardTemp;
//    [GDXmppStreamManager ShareXMPPManager].xmppvcardtempModule.myvCardTemp.nickname = @"fuck";
//    [GDXmppStreamManager ShareXMPPManager].xmppvcardtempModule.myvCardTemp.jid = [GDXmppStreamManager ShareXMPPManager].XmppStream.myJID;
//    [GDXmppStreamManager ShareXMPPManager].xmppvcardtempModule.myvCardTemp.desc = @"我就是我,不一样的烟火";
//    [[GDXmppStreamManager ShareXMPPManager].xmppvcardtempModule updateMyvCardTemp:myCard];
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,myCard.nickname);
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,myCard.bday);
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,myCard.jid);
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,myCard.name);
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,myCard);
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,myCard.photo);
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,myCard.desc);
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,myCard.agent);
    }
-(void)setupTableView
{
    //    CGRect frame  = CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height - self.tabBarController.tabBar.bounds.size.height);
    CGRect frame =  CGRectMake(0, self.startY, self.view.bounds.size.width, self.view.bounds.size.height-self.startY);
    UITableView     * tableView =[[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
    self.tableView =tableView;
    tableView.separatorStyle=0;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.backgroundColor =  [UIColor colorWithRed:244/256.0 green:244/256.0 blue:244/256.0 alpha:1];
    tableView.sectionHeaderHeight=0.00001;
    tableView.sectionFooterHeight = 0.00001;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 0.000001)];
    tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 0.000001)];
//    tableView.delegate=self;
//    tableView.dataSource = self;
    //    tableView.rowHeight = UITableViewAutomaticDimension;
    //    tableView.estimatedRowHeight=200;dide
    
    
}
//懒加载
-(NSArray *)ContactArrs
{
    if (_ContactArrs == nil) {
        _ContactArrs = [NSArray array];
    }
    return  _ContactArrs;
}

-(NSFetchedResultsController *)fetchedresultsController
{
    if (_fetchedresultsController == nil) {
        //查询请求
        NSFetchRequest *fetchrequest = [[NSFetchRequest alloc]init];
        //实体描述
        
        NSEntityDescription *entitys =  [NSEntityDescription entityForName:@"XMPPMessageArchiving_Contact_CoreDataObject" inManagedObjectContext:[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext];
        
        fetchrequest.entity = entitys;
        
#pragma mark 查询请求控制器需要一个排序
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"mostRecentMessageTimestamp" ascending:YES];
        fetchrequest.sortDescriptors = @[sort];
        
        //创建懒加载对象(查询请求控制器)
        _fetchedresultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchrequest managedObjectContext:[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext sectionNameKeyPath:nil cacheName:@"Recently"];
        
        _fetchedresultsController.delegate = self;
    }
    return _fetchedresultsController;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   BOOL need = !([GDXmppStreamManager ShareXMPPManager].XmppStream.isConnected || [GDXmppStreamManager ShareXMPPManager].XmppStream.isConnecting) && [Account shareAccount].isLogin ;
    if ( need ) {
        [[GDXmppStreamManager ShareXMPPManager] loginWithJID:[XMPPJID jidWithString:  [Account shareAccount].name] passWord:[NetworkManager shareManager].token];
    }else{
    
        [self theMessageChange];
    
    }



}
-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
//    NSLog(@"*************************ContactArrs****************** = %lu",(unsigned long)self.ContactArrs.count);
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.topArrM);
//    self.ContactArrs =  self.fetchedresultsController.fetchedObjects;
//    if (self.ContactArrs.count>0) {
//        self.noMessageImgView.hidden = YES ;
//        self.noMessageLabel.hidden = YES ;
//    }else{
//        self.noMessageImgView.hidden = NO ;
//        self.noMessageLabel.hidden = NO ;
//    }
////    self.ContactArrs = [self.topArrM arrayByAddingObjectsFromArray:self.fetchedresultsController.fetchedObjects];
//    [self.tableView reloadData];
}

#pragma mark tableview 代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.CustomContactArrs.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取出数据
//    XMPPMessageArchiving_Contact_CoreDataObject *contact = self.ContactArrs[indexPath.row];
    
    NSDictionary * dict = self.CustomContactArrs[indexPath.row];
    
    //创建cell
    MessageCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell"];
    if (!cell) {
        cell = [[MessageCenterCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ContactCell"];
    }
    cell.customCellModel = dict ;


    //返回cell
    return cell;
}

-(void)gotNickNameWithContact:(XMPPMessageArchiving_Contact_CoreDataObject*)contact
{
    NSManagedObjectContext *context= [XMPPRosterCoreDataStorage sharedInstance].mainThreadManagedObjectContext;
    NSFetchRequest *request=[[NSFetchRequest alloc]initWithEntityName:@"XMPPUserCoreDataStorageObject"];
    //对结果进行排序
    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"displayName" ascending:YES];
    request.sortDescriptors=@[sort];
    //设置谓词过滤
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"jidStr==%@",contact.bareJidStr];
    
    request.predicate=pre;
    if (!self.resultController) {
        
        NSFetchedResultsController*resultController=[[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
        self.resultController = resultController;
    }
    
    //设置代理
    self.resultController.delegate=self;
    NSError *error=nil;
    //执行
    [self.resultController performFetch:&error];
    if (error) {
        NSLog(@"_%@_%d_%@",[self class] , __LINE__,error);
    }else{
        NSLog(@"_%@_%d_%@",[self class] , __LINE__,self.resultController.fetchedObjects);
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54*self.scaleHeight;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.navigationController.tabBarItem.badgeValue = nil ;
             if (0) {
        /*
         if (indexPath.row==0) {
        BaseModel * model = [[BaseModel alloc]init];
        model.actionKey = @"SuperMarketPlacardVC";
        model.keyParamete = @{@"paramete":@"https://m.zjlao.com/AppOrder/Notice.html"};
        [[OldSkipManager shareSkipManager] skipByVC:self withActionModel:model];
    }else if (indexPath.row==1){
        BaseModel * model = [[BaseModel alloc]init];
        model.keyParamete = @{@"paramete":@"https://m.zjlao.com/AppOrder/logisticsList.html"};
        model.actionKey = @"LogisticsStatusVC";
        [[OldSkipManager shareSkipManager] skipByVC:self withActionModel:model];
    }else if (indexPath.row==2){
        BaseModel * model = [[BaseModel alloc]init];
        model.keyParamete = @{@"paramete":@"https://m.zjlao.com/AppOrder/promotion.html"};
        model.actionKey = @"LogisticsStatusVC";
        [[OldSkipManager shareSkipManager] skipByVC:self withActionModel:model];
    }else if (indexPath.row==3){
        BaseModel * model = [[BaseModel alloc]init];
        model.keyParamete = @{@"paramete":@"https://m.zjlao.com/AppOrder/activity.html"};
        model.actionKey = @"LogisticsStatusVC";
        [[OldSkipManager shareSkipManager] skipByVC:self withActionModel:model];*/
    }else{
        NSDictionary * dict  = self.CustomContactArrs[indexPath.row];
        if ([dict isKindOfClass:[NSDictionary class]]) {
            
            
            OldBaseModel * model = [[OldBaseModel alloc] init];
            //MARK : 临时切换聊天控制器
            //            model.actionKey = @"ChatVC";
            model.actionKey = @"NewChatVC";
            //            if (vcard.nickname.length>0 && ![vcard.nickname isEqualToString:@"null"]) {
            //                model.keyParamete = @{@"paramete":contact.bareJid , @"nickname":vcard.nickname };
            
            //            }else{
             NSLog(@"%@_%d_%@",[self class],__LINE__,dict[@"other_account"]);
            if (dict[@"other_account"]) {
                XMPPJID * jid = [XMPPJID jidWithUser:dict[@"other_account" ] domain:@"jabber.zjlao.com" resource:@"iOS"];
                model.keyParamete = @{@"paramete": jid};
                
//                [[SkipManager shareSkipManager] skipByVC:self withActionModel:model];
                [[OldSkipManager shareSkipManager] skipByVC:self withActionModel:model];
            }else{
                [GDAlertView alert:@"联系人不存在" image:nil  time:2  complateBlock:^{
                } ];
            }
        }
        
            
    }
}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)cell
//{
//    XMPPMessageArchiving_Contact_CoreDataObject *contact = self.ContactArrs[[self.tableView indexPathForCell:cell].row];
//    CZChatViewController *chatvc = segue.destinationViewController;
//    chatvc.UserJid = contact.bareJid;
//}
- (IBAction)AddRoom:(id)sender {
    
    
}
-(NSMutableArray * )topArrM{
    if(_topArrM==nil){
        _topArrM = [[NSMutableArray alloc]init];
//        for (int i = 0; i<4; i++) {
//            NSString * topModel =nil ;
//
//            
//            if (i==0) {
//                topModel = @"商城公告";
////                topModel.mostRecentMessageBody = @"";
//            }else if (i==1){
//                topModel = @"物流信息";
//            }else if (i==2){
//                topModel = @"促销";
//            }else if (i==3){
//                topModel = @"活动";
//            }
//            [_topArrM  addObject:topModel];
//        }
    }
    return _topArrM;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    self.setnum(num: numStr, index: index)
    [[KeyVC share] setnumWithNum:nil  index:1];
//    [[NSUserDefaults standardUserDefaults] setValue:@(0) forKey:MESSAGECOUNTCHANGED];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"MESSAGECOUNTCHANGED" object:nil];
    // 禁用 iOS8 返回手势
//    if ([UIDevice currentDevice].systemVersion.floatValue<9.0) {
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
        
//    }
}
//cell是否可编辑
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row>3) {
//        return YES;
//    }else{
//        return NO;
//    }
    return YES;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    XMPPMessageArchiving_Contact_CoreDataObject *contact = self.ContactArrs[indexPath.row];
//    [[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext deleteObject:contact];
//    [[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext save:nil];
//    [self.tableView reloadData];

    NSDictionary * dict = self.CustomContactArrs[indexPath.row];
    //删除contact表聊最近联系人
    [[GDStorgeManager share] deleteContactFromContactWithUserName:dict[@"other_account"] callBack:^(NSInteger resultCode, NSString * _Nonnull resultStr) {
//        GDlog(@"删除联系人%@结果%@" ,dict[@"other_account"],resultStr)
    }];
    
    //删除message表聊天记录
    [[GDStorgeManager share] deleteFormContentWithUserName:dict[@"other_account"] callBack:^(NSInteger resultcode, NSString * _Nonnull resultStr) {
//        GDlog(@"删除联系人%@结果%@" ,dict[@"other_account"],resultStr)
    }];
    //删除聊天记录相关文件
    [[GDStorgeManager share ]deleteUserFileWithPath:dict[@"other_account"] callBack:^(NSInteger resultcode, NSString * _Nonnull resultStr) {
//        GDlog(@"删除联系人%@相关文件结果%@" ,dict[@"other_account"],resultStr)
        
        
    }];
    //    XMPPMessageArchiving_Contact_CoreDataObject *contact = self.ContactArrs[indexPath.row];
    //    [[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext deleteObject:contact];
    //    [[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext save:nil];
    //    [[GDStorgeManager share] gotRecentContactWithCallBack:^(NSInteger resultCode, NSArray<NSDictionary<NSString *,NSString *> *> * _Nonnull resultArr) {
    [[GDStorgeManager share] gotRecentContactListWithCallBack:^(NSInteger resultCode, NSArray<NSDictionary<NSString *,NSString *> *> * _Nonnull resultArr) {
//        GDlog(@"%@",resultArr)
        
        
        self.CustomContactArrs =  [self.topArrM arrayByAddingObjectsFromArray:resultArr];
        if (self.CustomContactArrs.count>0) {
            self.noMessageImgView.hidden = YES ;
            self.noMessageLabel.hidden = YES ;
        }else{
            self.noMessageImgView.hidden = NO ;
            self.noMessageLabel.hidden = NO ;
        }
        [self.tableView reloadData];
        //        [self editMyVCardInfo];
        
    }];

    NSLog(@"_%@_%d_%@",[self class] , __LINE__,@"点击删除");
}

//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//
//    NSString * userName = @"zhangkaiqiang";
//    XMPPJID * userJid = [XMPPJID jidWithUser:userName domain:@"jabber.zjlao.com" resource:nil];
//    BaseModel * model = [[BaseModel alloc]init];
//    model.actionKey=@"ChatVC";
//    model.keyParamete = @{@"paramete":userJid};
//    [[SkipManager shareSkipManager] skipByVC:self withActionModel:model];
//
//
//}

#pragma mark fetchedResultsControllerDelegete
//- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(nullable NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(nullable NSIndexPath *)newIndexPath{
//    LOG_METHOD
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,anObject);
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,indexPath);
//    LOG(@"_%@_%d_%d",[self class] , __LINE__,type);
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,newIndexPath);
//}

/* Notifies the delegate of added or removed sections.  Enables NSFetchedResultsController change tracking.
 
	controller - controller instance that noticed the change on its sections
	sectionInfo - changed section
	index - index of changed section
	type - indicates if the change was an insert or delete
 
	Changes on section info are reported before changes on fetchedObjects.
 */


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type{
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,sectionInfo);
//    LOG(@"_%@_%d_%d",[self class] , __LINE__,sectionIndex);

}

/* Notifies the delegate that section and object changes are about to be processed and notifications will be sent.  Enables NSFetchedResultsController change tracking.
 Clients utilizing a UITableView may prepare for a batch of updates by responding to this method with -beginUpdates
 */

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
}

/* Notifies the delegate that all section and object changes have been sent. Enables NSFetchedResultsController change tracking.
 Providing an empty implementation will enable change tracking if you do not care about the individual callbacks.
 */



//- (nullable NSString *)controller:(NSFetchedResultsController *)controller sectionIndexTitleForSectionName:(NSString *)sectionName __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_4_0){
//    
//    return @"测试";
//}
@end
