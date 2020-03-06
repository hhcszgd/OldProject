//
//  HMessageVC.m
//  b2c
//
//  Created by wangyuanfei on 3/28/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "HMessageVC.h"
#import "BaseWebVC.h"
#import "MessageCenterCellModel.h"
#import "MessageCenterCell.h"
#import "ChatVC.h"

@interface HMessageVC ()
@property(nonatomic,strong)NSMutableArray * messageCenterData ;
@end

@implementation HMessageVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviTitle=@"消息中心";

    
    
    // Do any additional setup after loading the view.
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    BaseModel * model = [[BaseModel alloc]init];
//    model.actionKey = @"ChatVC";
//    model.actionKey = @"RecentContactsVC";
    model.actionKey = @"FriendListVC";
//    model.keyParamete = @{@"paramete":[XMPPJID jidWithUser:@"zhangkaiqiang" domain:@"jabber.zjlao.com" resource:@"fuck"] };
    [[SkipManager shareSkipManager] skipByVC:self withActionModel:model];

}
























#pragma 暂时注销/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.naviTitle=@"消息中心";
//    [self setupTableView];
//
//    [self gotMessageCenterDataWithPageNum:0 actionType:Init  Success:^{
//        [self.tableView reloadData];
//    } failure:^{
//        
//    }];
//    // Do any additional setup after loading the view.
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//
//-(void)setupTableView
//{
//    //    CGRect frame  = CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height - self.tabBarController.tabBar.bounds.size.height);
////    CGRect frame = self.view.bounds;
//    CGRect frame = CGRectMake(0, self.startY, self.view.bounds.size.width, self.view.bounds.size.height - self.startY);
//    UITableView     * tableView =[[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
//    self.tableView =tableView;
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    tableView.separatorStyle=0;
//    tableView.showsVerticalScrollIndicator = NO;
//    tableView.backgroundColor = BackgroundGray;
//    tableView.delegate=self;
//    tableView.dataSource = self;
//    //    tableView.rowHeight = UITableViewAutomaticDimension;
//    //    tableView.estimatedRowHeight=200;
//    tableView.rowHeight = 48 ;
//    
//    
//    
//}
//
///** cell的代理方法 */
////-(void) skipInLaoStoryTabCell:(LaoStoryTabCell*)storyTabCell WithComposeModel:(BaseModel*)composeModel {
////    [[SkipManager shareSkipManager] skipByVC:self withActionModel:composeModel];
////    //    [[SkipManager shareSkipManager] skipForLocalByVC:self withActionModel:composeModel];
////}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0.00000000001;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 0.000000000000001;
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.messageCenterData)
//    return self.messageCenterData.count;
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    MessageCenterCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (!cell) {
//        cell = [[MessageCenterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    }
//    MessageCenterCellModel* cellModel = self.messageCenterData[indexPath.row];
//    cell.cellModel = cellModel;
////    cell.delegate=self;
//    return cell;
//}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    ///////
//    BaseModel * model = self.messageCenterData[indexPath.row];
//    [[SkipManager shareSkipManager] skipByVC:self withActionModel:model];
//
//}
//
////抽取方法
//-(void)gotMessageCenterDataWithPageNum:(NSInteger)pageNum actionType:(LoadDataActionType)actionType Success:(void(^)())success failure:(void(^)())failure{
//    
//    [[UserInfo shareUserInfo] gotMessageCenterDataSuccess:^(ResponseObject *responseObject) {
//        [self.messageCenterData removeAllObjects];
//        if ([responseObject.data isKindOfClass:[NSArray class]]) {
//          self.messageCenterData =   [self analyseDataWithData:responseObject.data];
//            success(responseObject);
////            LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
//        }
//    } failure:^(NSError *error) {
//       
//        failure(error);
//    }];
//
//}
//
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
//
//
//-(NSMutableArray*)initdata
//{
//
//    NSDictionary * dict1 = @{
//                            
//                            @"imgStr":@"http://f.hiphotos.baidu.com/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=1eafa54f500fd9f9b41a5d3b4444bf4f/a9d3fd1f4134970ac5199a1c94cad1c8a7865d9f.jpg",
//                            @"mainTitle":@"物流信息",
//                            @"subTitle":@"",
//                            @"addition":@"2016-02-16",
//                            @"actionkey":@"LogisticsStatusVC"
//                            
//                            };
//    NSDictionary * dict2 = @{
//                             
//                             @"imgStr":@"http://g.hiphotos.baidu.com/baike/c0%3Dbaike116%2C5%2C5%2C116%2C38/sign=73c143f9ae51f3ded7bfb136f5879b7a/6d81800a19d8bc3e5fe28df9838ba61ea8d3451f.jpg",
//                             @"mainTitle":@"商城公告",
//                             @"subTitle":@"",
//                             @"addition":@"2016-02-16",
//                             @"actionkey":@"SuperMarketPlacardVC"
//                             
//                             };
//    NSDictionary * dict3 = @{
//                             
//                             @"imgStr":@"http://e.hiphotos.baidu.com/baike/c0%3Dbaike150%2C5%2C5%2C150%2C50/sign=e62d07024b90f60310bd9415587bd87e/10dfa9ec8a1363270e7f4900908fa0ec08fac777.jpg",
//                             @"mainTitle":@"淤泥房旗舰店",
//                             @"subTitle":@"一会儿发货哦",
//                             @"addition":@"2016-02-16",
//                             @"actionkey":@"ChatVC"
//                             
//                             };
//    
//    NSMutableArray * arrM = [NSMutableArray array];
//    for (int i = 0 ; i< 15; i++) {
//        if (i%3==0) {
//            [arrM addObject:dict1.copy];
//        }else if (i%3==1) {
//            [arrM addObject:dict2.copy];
//        }else if (i%3==2) {
//            [arrM addObject:dict3.copy];
//        }
//    }
//    
//    return arrM;
//}
//
//-(NSMutableArray*)analyseDataWithData:(NSArray*)arr
//{
//    NSMutableArray * arrM = [NSMutableArray array];
//    for (NSDictionary * sub in arr) {
//        MessageCenterCellModel * model  = [[MessageCenterCellModel alloc]initWithDict:sub];
//        [arrM addObject:model];
//    }
//    
//    return  arrM ;
//}
//
//-(NSMutableArray * )messageCenterData{
//    if(_messageCenterData==nil){
//        _messageCenterData = [[NSMutableArray alloc]init];
////        _messageCenterData = [self analyseDataWithData:[self initdata]];
//    }
//    return _messageCenterData;
//}


@end
