//
//  ProfileVC.m
//  b2c
//
//  Created by wangyuanfei on 3/23/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "ProfileVC.h"
#import "PTableView.h"
#import "BaseCell.h"
#import "PBackgroundVC.h"
#import "POrderCell.h"
#import "PAssetsCell.h"
#import "PNormalCell.h"
#import "PTableCellModel.h"
#import "PTableHeaderModel.h"
#import "POrderCellComposeModel.h"
#import "CaculateManager.h"
@interface ProfileVC ()<PTableViewDelegate,PBaseCellDelegate>
@property(nonatomic,assign)CGPoint  targetPoint;
@property(nonatomic,strong)NSMutableArray * profileData ;//和头部视图分开处理
@property(nonatomic,strong)PTableCellModel * headerViewModel ;

@property(nonatomic,copy)NSString * goodsCollectCount ;
@property(nonatomic,copy)NSString * shopCollectCount ;
@property(nonatomic,copy)NSString * attentionBrandCount ;
@property(nonatomic,weak)PTableView * tempTableView ;

@property(nonatomic,assign)BOOL redPointShow ;

//@property(nonatomic,strong)NSMutableArray * arrM ;
@end

@implementation ProfileVC




-(void)gotProfileDataFromDisk
{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"沙盒中的个人中心数据不存在 , 从bundle中取")
    NSString *strResourcesBundle = [[NSBundle mainBundle] pathForResource:@"Resource" ofType:@"bundle"];
    NSString *path = [[NSBundle bundleWithPath:strResourcesBundle] pathForResource:@"ProfileData" ofType:@"plist" inDirectory:@"Txt"];
    NSDictionary * dictHome = [[NSDictionary alloc]initWithContentsOfFile:path];
    ResponseObject * getFromDisk = [[ResponseObject alloc]initWithDict:dictHome];//
    [self analysisDataWith:getFromDisk];
}

-(void)analysisDataWith:(ResponseObject*)responseObject
{
    
    LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.msg);
    if (!responseObject.data) {
        [self gotProfileDataFromDisk];
        return;
    }
    if ([responseObject.data isKindOfClass:[NSArray class]]) {//数据结构固定,判断的好费劲
        if (self.profileData.count>0) {
            
            [self.profileData removeAllObjects];
        }
        for (id sub in   responseObject.data) {
            if ([sub isKindOfClass:[NSDictionary class]]) {
                
                PTableCellModel * model =  [[PTableCellModel alloc]initWithDict:sub];
                
                if (model.items.count>0) {
                    NSMutableArray * subArrM = [NSMutableArray array ];
                    for (id subsub in model.items) {
                        if ([subsub isKindOfClass:[NSDictionary class]]) {
                            POrderCellComposeModel * subModel = [[POrderCellComposeModel alloc]initWithDict:subsub];
                            [subArrM addObject:subModel];
                            if ([model.key isEqualToString:@"userinfo"]) {
                                //                                LOG(@"_%@_%d_lllllllllllllllllllllllllll%@",[self class] , __LINE__,subModel);
                            }
                        }
                    }
                    model.items = subArrM;
                }
                
                /////////////手动添加相关字段的值 ,如图片标题等//////////////
                
                
                
                
                
                if ([model.key isEqualToString:@"userinfo"]) {
                    
                    PTableHeaderModel * headerUserinfoModel = [[PTableHeaderModel alloc]init];
                    
                    if ([UserInfo shareUserInfo].isLogin) {
                        [[UserInfo shareUserInfo] gotPersonalInfoSuccess:^(ResponseStatus response) {//登录状态且有网时给头部加载的数据
                            headerUserinfoModel.level = [UserInfo shareUserInfo].level;
                            headerUserinfoModel.accountName = [UserInfo shareUserInfo].name;
                            headerUserinfoModel.iconUrl  = [UserInfo shareUserInfo].head_images;
                            
                            headerUserinfoModel.cellModel = model;
                            self.tempTableView.tableHeaderModel = headerUserinfoModel;
                            
                            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"");
                            //        LOG(@"_%@_%d_%@",[self class] , __LINE__,[UserInfo shareUserInfo].name)
                            //        LOG(@"_%@_%d_%ld",[self class] , __LINE__,[UserInfo shareUserInfo].member_id)
                            //        LOG(@"_%@_%d_%ld",[self class] , __LINE__,[UserInfo shareUserInfo].level)
                            //        LOG(@"_%@_%d_%@",[self class] , __LINE__,[UserInfo shareUserInfo].head_images)
                            //        LOG(@"_%@_%d_%@",[self class] , __LINE__,[UserInfo shareUserInfo].nickname)
                            
                        } failure:^(NSError *error) {//没网,但出于登录状态时点退出后给头部加载的数据信息
                            LOG(@"_%@_%d_%@",[self class] , __LINE__,error)
                            headerUserinfoModel.cellModel = model;
                            self.tempTableView.tableHeaderModel = headerUserinfoModel;
                        }];
                    }else{//未登录时给个人中心加载的头不数据信息
                        headerUserinfoModel.cellModel = model;
                        self.tempTableView.tableHeaderModel = headerUserinfoModel;
                        
                    }
                    
                    
                    //                    [[UserInfo shareUserInfo] gotPersonalInfoSuccess:^(ResponseStatus response) {
                    //                            headerUserinfoModel.level = [UserInfo shareUserInfo].level;
                    //                            headerUserinfoModel.accountName = [UserInfo shareUserInfo].name;
                    //                            headerUserinfoModel.iconUrl  = [UserInfo shareUserInfo].head_images;
                    //
                    //                        headerUserinfoModel.cellModel = model;
                    //                        self.tempTableView.tableHeaderModel = headerUserinfoModel;
                    //
                    //                        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"");
                    //                        //        LOG(@"_%@_%d_%@",[self class] , __LINE__,[UserInfo shareUserInfo].name)
                    //                        //        LOG(@"_%@_%d_%ld",[self class] , __LINE__,[UserInfo shareUserInfo].member_id)
                    //                        //        LOG(@"_%@_%d_%ld",[self class] , __LINE__,[UserInfo shareUserInfo].level)
                    //                        //        LOG(@"_%@_%d_%@",[self class] , __LINE__,[UserInfo shareUserInfo].head_images)
                    //                        //        LOG(@"_%@_%d_%@",[self class] , __LINE__,[UserInfo shareUserInfo].nickname)
                    //
                    //                    } failure:^(NSError *error) {
                    //                        LOG(@"_%@_%d_%@",[self class] , __LINE__,error)
                    //                         headerUserinfoModel.cellModel = model;
                    //                        self.tempTableView.tableHeaderModel = headerUserinfoModel;
                    //                    }];
                    
                    
                    
                    
                    
                    
                    //                        self.headerViewModel = model;
                }else if ([model.key isEqualToString:@"order"]){
                    model.actionKey = ActionTotalOrder;
                    model.judge=YES;
                    
                    model.rightDetailTitle = @"查看全部订单";
                }else if ([model.key isEqualToString:@"my_capital"]){
                    model.actionKey = ActionAssets;
                    model.judge=YES;
                    model.rightDetailTitle = @"查看全部资产";
                }else if ([model.key isEqualToString:@"set"]){
                    model.actionKey = ActionSetting;
                    model.judge=NO;
                    model.leftImage = [UIImage imageNamed:@"icon_set up"];
                }else if ([model.key isEqualToString:@"help"]){
                    model.actionKey = ActionHelpCenter;
                    model.judge=NO;
                    model.leftImage = [UIImage imageNamed:@"icon_help"];
                }else if ([model.key isEqualToString:@"member_club"]){
                    model.actionKey = ActionHelpFeedBack;
                    model.judge=YES;
                    model.leftImage = [UIImage imageNamed:@"icon_consultation"];
                }else{
                    
                }
                if (model.url) {
                    model.keyParamete = @{@"paramete":model.url};
                    
                }
                /////////////手动添加结束/////////////
                
                //                if (model.items.count>0) {
                //                    NSMutableArray * subArrM = [NSMutableArray array ];
                //                    for (id subsub in model.items) {
                //                        if ([subsub isKindOfClass:[NSDictionary class]]) {
                //                            POrderCellComposeModel * subModel = [[POrderCellComposeModel alloc]initWithDict:subsub];
                //                            [subArrM addObject:subModel];
                //                            if ([model.key isEqualToString:@"userinfo"]) {
                //                                LOG(@"_%@_%d_lllllllllllllllllllllllllll%@",[self class] , __LINE__,subModel);
                //                            }
                //                        }
                //                    }
                //                    model.items = subArrM;
                //                }
                if (![model.key isEqualToString:@"userinfo"]) {
                    [self.profileData addObject:model];
                    
                }
                
            }
        }
    }
    [self.tableView reloadData];
    
}
-(void)gotProfiledata
{
    if (![UserInfo shareUserInfo].token) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"数据初始化失败,请检查网络")
        AlertInVC(@"数据初始化失败,请检查网络")
        return;
    }
    
    
    /**数据结构变化, 暂时注释掉数据解析*/
    [[UserInfo shareUserInfo] gotProfileDataSuccess:^(ResponseObject * responseObject) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.msg);
         NSLog(@"_%d_%@",__LINE__,responseObject.data);
        if (!responseObject.data) {
            
            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"网络获取的个人中心的数据为空");
        }
        [self analysisDataWith:responseObject];
        
    } failure:^(NSError *error) {//有一种可能 , 用户信息请求成功 , 但 个人首页界面数据请求失败
        LOG(@"_%@_%d_%@",[self class] , __LINE__,error)
        PTableHeaderModel * headerUserinfoModel = [[PTableHeaderModel alloc]init];
        headerUserinfoModel.level = [UserInfo shareUserInfo].level;
        headerUserinfoModel.accountName = [UserInfo shareUserInfo].name;
        headerUserinfoModel.iconUrl  = [UserInfo shareUserInfo].head_images;
        //        headerUserinfoModel.cellModel = model;
        self.tempTableView.tableHeaderModel = headerUserinfoModel;
        
    }];
}
/**当个人中心需要根据self.redPointShow改变小红点时调一下这个方法 */
-(void)changeRedPointState
{
    NSDictionary * userinfo = @{@"state":@(self.redPointShow)};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ProfileRedPointShow" object:nil userInfo:userinfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    // Do any additional setup after loading the view.
    [self changeRedPointState];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LOGINSUCCESSCALLBACK) name:LOGINSUCCESS object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LOGINOUTSUCCESSCALLBACK) name:LOGINOUTSUCCESS object:nil];
    
    
    [self resetDataInProfile];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}
-(void)setupTableView
{
    CGRect frame  = CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height - self.tabBarController.tabBar.bounds.size.height);
    PTableView * tableView =[[PTableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
    self.tableView =tableView;
    self.tempTableView = tableView;
    tableView.PTableViewDelegate=self;
    //    tableView.rowHeight = UITableViewAutomaticDimension;
    //    tableView.estimatedRowHeight=200;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.profileData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PBaseCell * cell = nil ;
    NSString * reuseIdentifier = nil ;
    PTableCellModel * model = self.profileData[indexPath.row];
    switch (indexPath.row) {
        case 0:
            reuseIdentifier = @"POrderCell";
            break;
        case 1:
            reuseIdentifier = @"PAssetsCell";
            break;
        default:
            reuseIdentifier = @"PNormalCell";
            break;
    }
    
    cell =  [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        Class class = NSClassFromString(reuseIdentifier);
        cell = [[class alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    [cell setValue:model forKey:@"cellModel"];
    cell.PCellDelegate=self;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PTableCellModel * model = self.profileData[indexPath.row];
    if ([model.key isEqualToString:@"order"]) {
        return [CaculateManager caculateRowHeightWithItemsCount:1 itemHeight:78*SCALE itemMargin:1 columnCount:model.items.count topHeight:45*SCALE bottomHeight:0 topMargin:0 bottomMargin:11*SCALE ];
    }else if ([model.key isEqualToString:@"my_capital"]){
        return [CaculateManager caculateRowHeightWithItemsCount:1 itemHeight:78*SCALE itemMargin:1 columnCount:model.items.count topHeight:45*SCALE bottomHeight:0 topMargin:0 bottomMargin:11*SCALE ];
    }else if ([model.key isEqualToString:@"set"]){
        return [CaculateManager caculateRowHeightWithItemsCount:0 itemHeight:0 itemMargin:0 columnCount:1 topHeight:45*SCALE bottomHeight:0 topMargin:0 bottomMargin:1*SCALE ];
    }else if ([model.key isEqualToString:@"help"]){
        return [CaculateManager caculateRowHeightWithItemsCount:0 itemHeight:0 itemMargin:0 columnCount:1 topHeight:45*SCALE bottomHeight:0 topMargin:0 bottomMargin:1*SCALE ];
    }else if ([model.key isEqualToString:@"member_club"]){
        return [CaculateManager caculateRowHeightWithItemsCount:0 itemHeight:0 itemMargin:0 columnCount:1 topHeight:45*SCALE bottomHeight:0 topMargin:0 bottomMargin:1*SCALE ];
    }else{
        return [CaculateManager caculateRowHeightWithItemsCount:0 itemHeight:0 itemMargin:0 columnCount:1 topHeight:45*SCALE bottomHeight:0 topMargin:1*SCALE bottomMargin:0 ];
    }
    //    return 22 ;
}
#pragma  cell和tableHeader子控件的点击代理
-(void)actionWithModel:(BaseModel *)model{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,model.actionKey);
    [[SkipManager shareSkipManager] skipByVC:self withActionModel:model];
    
}

-(CGPoint)targetPoint{
    return CGPointMake(self.view.center.x, 200);
}

-(void)test
{
    //    UIImage * img = [UIImage imageNamed:@"ar_back"];
    //    NSData * data = UIImagePNGRepresentation(img);
    
    
}
-(NSMutableArray *)profileData{
    if (!_profileData) {
        NSMutableArray * arrM = [NSMutableArray array];
        if (![UserInfo shareUserInfo].isLogin) {
            for (int i = 0 ; i<6; i++) {
                PTableCellModel * model = [[PTableCellModel alloc]init];
                
                switch (i) {
                    case 0:
                    {
                        model  = [[PTableCellModel alloc]init];
                        model.leftTitle =[NSString stringWithFormat:@"全部订单"];
                        model.actionKey = ActionTotalOrder;
                        
                        model.judge=YES;
                        model.rightDetailTitle = @"查看全部订单";
                    }
                        break;
                    case 1:
                    {
                        model  = [[PTableCellModel alloc]init];
                        model.leftTitle = @"我的资产";
                        model.actionKey = ActionAssets;
                        model.judge=YES;
                        model.rightDetailTitle = @"查看全部资产";
                        
                    }
                        break;
                    case 2:
                    {
                        model  = [[PTableCellModel alloc]init];
                        model.leftTitle =@"我的活动";
                        model.actionKey = ActionMyExercise;
                        model.judge=YES;
                        model.leftImage = [UIImage imageNamed:@"icon_activity"];
                    }
                        break;
                    case 3:
                    {
                        model  = [[PTableCellModel alloc]init];
                        model.leftTitle =@"设置";
                        model.actionKey = ActionSetting;
                        model.judge=NO;
                        model.leftImage = [UIImage imageNamed:@"icon_set up"];
                    }
                        break;
                    case 4:
                    {
                        model= [[PTableCellModel alloc]init];
                        model.leftTitle =@"帮助中心";
                        model.actionKey = ActionHelpCenter;
                        model.judge=YES;
                        model.leftImage = [UIImage imageNamed:@"icon_help"];
                        
                    }
                        break;
                    case 5:
                    {
                        model  = [[PTableCellModel alloc]init];
                        model.leftTitle =@"咨询与反馈";
                        model.actionKey = ActionHelpFeedBack;
                        model.judge=YES;
                        model.leftImage = [UIImage imageNamed:@"icon_consultation"];
                        
                    }
                        break;
                    default:
                        break;
                }
                [arrM addObject:model];
            }
            
            
        }
        
        _profileData=arrM.mutableCopy;
    }
    
    return _profileData;
}

#pragma 每次进来刷一下 , 省去大量的通知了

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //
    [self resetDataInProfile];
    [self changeRedPointState];
}

-(void)resetDataInProfile
{
    
    if ([UserInfo shareUserInfo].isLogin && (NetWorkingStatus==NETWIFI||NetWorkingStatus==NETMOBILE)) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"登录状态")
        [self gotProfiledata];
    }else{
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"未登录状态")
        [self gotProfileDataFromDisk];
        //        PTableHeaderModel * headerUserinfoModel = [[PTableHeaderModel alloc]init];
        ////        tempModel.iconUrl = nil;
        //        headerUserinfoModel.level = -1;
        //        headerUserinfoModel.accountName = nil ;
        //        headerUserinfoModel.iconUrl  = nil;
        ////        headerUserinfoModel.cellModel = model;
        ////        self.tempTableView.tableHeaderModel = headerUserinfoModel;
        //        self.tempTableView.tableHeaderModel = headerUserinfoModel;
        ////        self.profileData=nil;
        ////        [self.tableView reloadData];
    }
    
}

-(void)LOGINSUCCESSCALLBACK
{
    //    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"登录成功回调");
    //    [self gotProfiledata];
    
    [self resetDataInProfile];
}

-(void)LOGINOUTSUCCESSCALLBACK
{
    //    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"退出成功回调");
    //    PTableHeaderModel * tempModel = [[PTableHeaderModel alloc]init];
    //    //        tempModel.iconUrl = nil;
    //    self.tempTableView.tableHeaderModel = tempModel;
    //    [self.tableView reloadData];
    [self resetDataInProfile];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end




























































////
////  ProfileVC.m
////  b2c
////
////  Created by wangyuanfei on 3/23/16.
////  Copyright © 2016 www.16lao.com. All rights reserved.
////
//
//#import "ProfileVC.h"
//#import "PTableView.h"
//#import "BaseCell.h"
//#import "PBackgroundVC.h"
//#import "POrderCell.h"
//#import "PAssetsCell.h"
//#import "PNormalCell.h"
//#import "PTableCellModel.h"
//#import "PTableHeaderModel.h"
//#import "POrderCellComposeModel.h"
//
//@interface ProfileVC ()<PTableViewDelegate,PBaseCellDelegate>
//@property(nonatomic,assign)CGPoint  targetPoint;
//@property(nonatomic,strong)NSMutableArray * profileData ;//和头部视图分开处理
//@property(nonatomic,strong)PTableCellModel * headerViewModel ;
//
//@property(nonatomic,copy)NSString * goodsCollectCount ;
//@property(nonatomic,copy)NSString * shopCollectCount ;
//@property(nonatomic,copy)NSString * attentionBrandCount ;
//@property(nonatomic,weak)PTableView * tempTableView ;
//
//@property(nonatomic,assign)BOOL redPointShow ;
//
////@property(nonatomic,strong)NSMutableArray * arrM ;
//@end
//
//@implementation ProfileVC
//
//
//
//
//-(void)gotProfileDataFromDisk
//{
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"沙盒中的个人中心数据不存在 , 从bundle中取")
//    NSString *strResourcesBundle = [[NSBundle mainBundle] pathForResource:@"Resource" ofType:@"bundle"];
//    NSString *path = [[NSBundle bundleWithPath:strResourcesBundle] pathForResource:@"ProfileData" ofType:@"plist" inDirectory:@"Txt"];
//    NSDictionary * dictHome = [[NSDictionary alloc]initWithContentsOfFile:path];
//    ResponseObject * getFromDisk = [[ResponseObject alloc]initWithDict:dictHome];//
//    [self analysisDataWith:getFromDisk];
//}
//
//-(void)analysisDataWith:(ResponseObject*)responseObject
//{
//
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.msg);
//    if (!responseObject.data) {
//        [self gotProfileDataFromDisk];
//        return;
//    }
//    if ([responseObject.data isKindOfClass:[NSArray class]]) {//数据结构固定,判断的好费劲
//        if (self.profileData.count>0) {
//            
//            [self.profileData removeAllObjects];
//        }
//        for (id sub in   responseObject.data) {
//            if ([sub isKindOfClass:[NSDictionary class]]) {
//                
//                PTableCellModel * model =  [[PTableCellModel alloc]initWithDict:sub];
//                
//                if (model.items.count>0) {
//                    NSMutableArray * subArrM = [NSMutableArray array ];
//                    for (id subsub in model.items) {
//                        if ([subsub isKindOfClass:[NSDictionary class]]) {
//                            POrderCellComposeModel * subModel = [[POrderCellComposeModel alloc]initWithDict:subsub];
//                            [subArrM addObject:subModel];
//                            if ([model.key isEqualToString:@"userinfo"]) {
////                                LOG(@"_%@_%d_lllllllllllllllllllllllllll%@",[self class] , __LINE__,subModel);
//                            }
//                        }
//                    }
//                    model.items = subArrM;
//                }
//                
//                /////////////手动添加相关字段的值 ,如图片标题等//////////////
//                
//                
//                
//                
//                
//                if ([model.key isEqualToString:@"userinfo"]) {
//                    
//                    PTableHeaderModel * headerUserinfoModel = [[PTableHeaderModel alloc]init];
//                    
//                    if ([UserInfo shareUserInfo].isLogin) {
//                        [[UserInfo shareUserInfo] gotPersonalInfoSuccess:^(ResponseStatus response) {//登录状态且有网时给头部加载的数据
//                            headerUserinfoModel.level = [UserInfo shareUserInfo].level;
//                            headerUserinfoModel.accountName = [UserInfo shareUserInfo].name;
//                            headerUserinfoModel.iconUrl  = [UserInfo shareUserInfo].head_images;
//                            
//                            headerUserinfoModel.cellModel = model;
//                            self.tempTableView.tableHeaderModel = headerUserinfoModel;
//                            
//                            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"");
//                            //        LOG(@"_%@_%d_%@",[self class] , __LINE__,[UserInfo shareUserInfo].name)
//                            //        LOG(@"_%@_%d_%ld",[self class] , __LINE__,[UserInfo shareUserInfo].member_id)
//                            //        LOG(@"_%@_%d_%ld",[self class] , __LINE__,[UserInfo shareUserInfo].level)
//                            //        LOG(@"_%@_%d_%@",[self class] , __LINE__,[UserInfo shareUserInfo].head_images)
//                            //        LOG(@"_%@_%d_%@",[self class] , __LINE__,[UserInfo shareUserInfo].nickname)
//                            
//                        } failure:^(NSError *error) {//没网,但出于登录状态时点退出后给头部加载的数据信息
//                            LOG(@"_%@_%d_%@",[self class] , __LINE__,error)
//                            headerUserinfoModel.cellModel = model;
//                            self.tempTableView.tableHeaderModel = headerUserinfoModel;
//                        }];
//                    }else{//未登录时给个人中心加载的头不数据信息
//                        headerUserinfoModel.cellModel = model;
//                        self.tempTableView.tableHeaderModel = headerUserinfoModel;
//                    
//                    }
//                    
//                    
////                    [[UserInfo shareUserInfo] gotPersonalInfoSuccess:^(ResponseStatus response) {
////                            headerUserinfoModel.level = [UserInfo shareUserInfo].level;
////                            headerUserinfoModel.accountName = [UserInfo shareUserInfo].name;
////                            headerUserinfoModel.iconUrl  = [UserInfo shareUserInfo].head_images;
////            
////                        headerUserinfoModel.cellModel = model;
////                        self.tempTableView.tableHeaderModel = headerUserinfoModel;
////                        
////                        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"");
////                        //        LOG(@"_%@_%d_%@",[self class] , __LINE__,[UserInfo shareUserInfo].name)
////                        //        LOG(@"_%@_%d_%ld",[self class] , __LINE__,[UserInfo shareUserInfo].member_id)
////                        //        LOG(@"_%@_%d_%ld",[self class] , __LINE__,[UserInfo shareUserInfo].level)
////                        //        LOG(@"_%@_%d_%@",[self class] , __LINE__,[UserInfo shareUserInfo].head_images)
////                        //        LOG(@"_%@_%d_%@",[self class] , __LINE__,[UserInfo shareUserInfo].nickname)
////                        
////                    } failure:^(NSError *error) {
////                        LOG(@"_%@_%d_%@",[self class] , __LINE__,error)
////                         headerUserinfoModel.cellModel = model;
////                        self.tempTableView.tableHeaderModel = headerUserinfoModel;
////                    }];
//                    
//                    
//                    
//                    
//                    
//                    
//                    //                        self.headerViewModel = model;
//                }else if ([model.key isEqualToString:@"order"]){
//                    model.actionKey = ActionTotalOrder;
//                    model.judge=YES;
//                    
//                    model.rightDetailTitle = @"查看全部订单";
//                }else if ([model.key isEqualToString:@"my_capital"]){
//                    model.actionKey = ActionAssets;
//                    model.judge=YES;
//                    model.rightDetailTitle = @"查看全部资产";
//                }else if ([model.key isEqualToString:@"set"]){
//                    model.actionKey = ActionSetting;
//                    model.judge=NO;
//                    model.leftImage = [UIImage imageNamed:@"icon_set up"];
//                }else if ([model.key isEqualToString:@"help"]){
//                    model.actionKey = ActionHelpCenter;
//                    model.judge=YES;
//                    model.leftImage = [UIImage imageNamed:@"icon_help"];
//                }else if ([model.key isEqualToString:@"member_club"]){
//                    model.actionKey = ActionHelpFeedBack;
//                    model.judge=YES;
//                    model.leftImage = [UIImage imageNamed:@"icon_consultation"];
//                }else{
//                    
//                }
//                if (model.url) {
//                    model.keyParamete = @{@"paramete":model.url};
//                    
//                }
//                /////////////手动添加结束/////////////
//                
////                if (model.items.count>0) {
////                    NSMutableArray * subArrM = [NSMutableArray array ];
////                    for (id subsub in model.items) {
////                        if ([subsub isKindOfClass:[NSDictionary class]]) {
////                            POrderCellComposeModel * subModel = [[POrderCellComposeModel alloc]initWithDict:subsub];
////                            [subArrM addObject:subModel];
////                            if ([model.key isEqualToString:@"userinfo"]) {
////                                LOG(@"_%@_%d_lllllllllllllllllllllllllll%@",[self class] , __LINE__,subModel);
////                            }
////                        }
////                    }
////                    model.items = subArrM;
////                }
//                if (![model.key isEqualToString:@"userinfo"]) {
//                    [self.profileData addObject:model];
//                    
//                }
//                
//            }
//        }
//    }
//    [self.tableView reloadData];
//
//}
//-(void)gotProfiledata
//{
//    if (![UserInfo shareUserInfo].token) {
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"数据初始化失败,请检查网络")
//        AlertInVC(@"数据初始化失败,请检查网络")
//        return;
//    }
//
//
//    /**数据结构变化, 暂时注释掉数据解析*/
//    [[UserInfo shareUserInfo] gotProfileDataSuccess:^(ResponseObject * responseObject) {
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.msg);
//        if (!responseObject.data) {
//            
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"网络获取的个人中心的数据为空");
//        }
//        [self analysisDataWith:responseObject];
//        
//    } failure:^(NSError *error) {//有一种可能 , 用户信息请求成功 , 但 个人首页界面数据请求失败
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,error)
//         PTableHeaderModel * headerUserinfoModel = [[PTableHeaderModel alloc]init];
//        headerUserinfoModel.level = [UserInfo shareUserInfo].level;
//        headerUserinfoModel.accountName = [UserInfo shareUserInfo].name;
//        headerUserinfoModel.iconUrl  = [UserInfo shareUserInfo].head_images;
////        headerUserinfoModel.cellModel = model;
//        self.tempTableView.tableHeaderModel = headerUserinfoModel;
//
//    }];
//}
///**当个人中心需要根据self.redPointShow改变小红点时调一下这个方法 */
//-(void)changeRedPointState
//{
//    NSDictionary * userinfo = @{@"state":@(self.redPointShow)};
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"ProfileRedPointShow" object:nil userInfo:userinfo];
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    [self setupTableView];
//    // Do any additional setup after loading the view.
//    [self changeRedPointState];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LOGINSUCCESSCALLBACK) name:LOGINSUCCESS object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LOGINOUTSUCCESSCALLBACK) name:LOGINOUTSUCCESS object:nil];
//    
//    
//    [self resetDataInProfile];
//
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
//    // Dispose of any resources that can be recreated.
//}
//-(void)setupTableView
//{
//    CGRect frame  = CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height - self.tabBarController.tabBar.bounds.size.height);
//    PTableView * tableView =[[PTableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
//    self.tableView =tableView;
//    self.tempTableView = tableView;
//    tableView.PTableViewDelegate=self;
//    tableView.rowHeight = UITableViewAutomaticDimension;
//    tableView.estimatedRowHeight=200;
//
//}
//
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.profileData.count;
//}
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    PBaseCell * cell = nil ;
//    NSString * reuseIdentifier = nil ;
//    PTableCellModel * model = self.profileData[indexPath.row];
//    switch (indexPath.row) {
//        case 0:
//            reuseIdentifier = @"POrderCell";
//            break;
//        case 1:
//             reuseIdentifier = @"PAssetsCell";
//            break;
//        default:
//             reuseIdentifier = @"PNormalCell";
//            break;
//    }
//    
//    cell =  [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
//    if (!cell) {
//        Class class = NSClassFromString(reuseIdentifier);
//        cell = [[class alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
//    }
//    [cell setValue:model forKey:@"cellModel"];
//    cell.PCellDelegate=self;
//    return cell;
//}
//#pragma  cell和tableHeader子控件的点击代理
//-(void)actionWithModel:(BaseModel *)model{
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,model.actionKey);
//    [[SkipManager shareSkipManager] skipByVC:self withActionModel:model];
//
//}
//
//-(CGPoint)targetPoint{
//    return CGPointMake(self.view.center.x, 200);
//}
//
//-(void)test
//{
////    UIImage * img = [UIImage imageNamed:@"ar_back"];
////    NSData * data = UIImagePNGRepresentation(img);
//    
//    
//}
//-(NSMutableArray *)profileData{
//    if (!_profileData) {
//        NSMutableArray * arrM = [NSMutableArray array];
//        if (![UserInfo shareUserInfo].isLogin) {
//            for (int i = 0 ; i<6; i++) {
//                PTableCellModel * model = [[PTableCellModel alloc]init];
//                
//                switch (i) {
//                    case 0:
//                    {
//                        model  = [[PTableCellModel alloc]init];
//                        model.leftTitle =[NSString stringWithFormat:@"全部订单"];
//                        model.actionKey = ActionTotalOrder;
//                        
//                        model.judge=YES;
//                        model.rightDetailTitle = @"查看全部订单";
//                    }
//                        break;
//                    case 1:
//                    {
//                        model  = [[PTableCellModel alloc]init];
//                        model.leftTitle = @"我的资产";
//                        model.actionKey = ActionAssets;
//                        model.judge=YES;
//                        model.rightDetailTitle = @"查看全部资产";
//                        
//                    }
//                        break;
//                    case 2:
//                    {
//                        model  = [[PTableCellModel alloc]init];
//                        model.leftTitle =@"我的活动";
//                        model.actionKey = ActionMyExercise;
//                        model.judge=YES;
//                        model.leftImage = [UIImage imageNamed:@"icon_activity"];
//                    }
//                        break;
//                    case 3:
//                    {
//                        model  = [[PTableCellModel alloc]init];
//                        model.leftTitle =@"设置";
//                        model.actionKey = ActionSetting;
//                        model.judge=NO;
//                        model.leftImage = [UIImage imageNamed:@"icon_set up"];
//                    }
//                        break;
//                    case 4:
//                    {
//                        model= [[PTableCellModel alloc]init];
//                        model.leftTitle =@"帮助中心";
//                        model.actionKey = ActionHelpCenter;
//                        model.judge=YES;
//                        model.leftImage = [UIImage imageNamed:@"icon_help"];
//                        
//                    }
//                        break;
//                    case 5:
//                    {
//                        model  = [[PTableCellModel alloc]init];
//                        model.leftTitle =@"咨询与反馈";
//                        model.actionKey = ActionHelpFeedBack;
//                        model.judge=YES;
//                        model.leftImage = [UIImage imageNamed:@"icon_consultation"];
//                        
//                    }
//                        break;
//                    default:
//                        break;
//                }
//                [arrM addObject:model];
//            }
//            
//            
//        }
//  
//        _profileData=arrM.mutableCopy;
//    }
//
//    return _profileData;
//}
//
//#pragma 每次进来刷一下 , 省去大量的通知了
//
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    
////    
//    [self resetDataInProfile];
//   }
//
//-(void)resetDataInProfile
//{
//    
//    if ([UserInfo shareUserInfo].isLogin && (NetWorkingStatus==NETWIFI||NetWorkingStatus==NETMOBILE)) {
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"登录状态")
//        [self gotProfiledata];
//    }else{
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"未登录状态")
//        [self gotProfileDataFromDisk];
////        PTableHeaderModel * headerUserinfoModel = [[PTableHeaderModel alloc]init];
//////        tempModel.iconUrl = nil;
////        headerUserinfoModel.level = -1;
////        headerUserinfoModel.accountName = nil ;
////        headerUserinfoModel.iconUrl  = nil;
//////        headerUserinfoModel.cellModel = model;
//////        self.tempTableView.tableHeaderModel = headerUserinfoModel;
////        self.tempTableView.tableHeaderModel = headerUserinfoModel;
//////        self.profileData=nil;
//////        [self.tableView reloadData];
//    }
//
//}
//
//-(void)LOGINSUCCESSCALLBACK
//{
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"登录成功回调");
////    [self gotProfiledata];
//
//    [self resetDataInProfile];
//}
//
//-(void)LOGINOUTSUCCESSCALLBACK
//{
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"退出成功回调");
////    PTableHeaderModel * tempModel = [[PTableHeaderModel alloc]init];
////    //        tempModel.iconUrl = nil;
////    self.tempTableView.tableHeaderModel = tempModel;
////    [self.tableView reloadData];
//    [self resetDataInProfile];
//}
//
//-(void)dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
//@end
