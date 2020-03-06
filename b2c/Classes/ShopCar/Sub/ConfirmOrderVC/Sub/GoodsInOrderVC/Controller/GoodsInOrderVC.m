//
//  GoodsInOrderVC.m
//  b2c
//
//  Created by wangyuanfei on 16/5/17.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "GoodsInOrderVC.h"
#import "GOHeaderView.h"
#import "GOCell.h"
#import "GOHeaderModel.h"
#import "GOCellModel.h"
#import "AMCellModel.h"
//#import "SpecModel.h"

@interface GoodsInOrderVC ()
/** goodsID是json格式数组,元素是goodsID */
//
//@property(nonatomic,copy)NSString * goodsID ;
//    @property(nonatomic,strong)AMCellModel * addressModel ;
@property(nonatomic,strong)NSMutableArray * dataS ;
    
@end

@implementation GoodsInOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviTitle = @"商品清单";
    if (!self.goodsID) {
        
        self.goodsID =  self.keyParamete[@"paramete"];
    }
    self.automaticallyAdjustsScrollViewInsets = NO ;
    [self gotGoodsListSuccess:^(ResponseObject *responseObject) {
        [self setuptableview];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,error);

    }];
    // Do any additional setup after loading the view.
}

-(void)setuptableview;
{
    CGRect frame = CGRectMake(0, self.startY, self.view.bounds.size.width, self.view.bounds.size.height-self.startY);
    UITableView * tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
    tableView.rowHeight = 104*SCALE;
    UIView * tableHeader =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 0.000000000001)];
    UIView * tableFooter =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 0.000000000001)];

    tableView.tableHeaderView=tableHeader;
    tableView.tableFooterView = tableFooter;
    tableView.separatorStyle=0;
    self.tableView = tableView ;
//    self.tableView.backgroundColor = [UIColor redColor];
    
    tableView.showsVerticalScrollIndicator = NO;
    
    
//    MJRefreshAutoStateFooter* refreshFooter = [MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(LoadMore)];
//    self.tableView.mj_footer = refreshFooter;
//    HomeRefreshHeader * refreshHeader = [HomeRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
//    self.tableView.mj_header=refreshHeader;
    
    
    
    
    
}

-(void)gotGoodsListSuccess:(void(^)(ResponseObject *responseObject))success failure:(void(^)(NSError *error))failure{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,_goodsID);
    
    [[UserInfo shareUserInfo] gotOrderGoodsDetail:self.goodsID addressID:self.addressModel.ID  success:^(ResponseObject *responseObject) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
         NSLog(@"_%d_%@",__LINE__,responseObject.msg);
        if ([responseObject.data isKindOfClass:[NSArray class]] && [responseObject.data count]) {
            NSMutableArray*headerModelArrM = [NSMutableArray array];
            for (id sub in responseObject.data  ) {
                if ([sub isKindOfClass:[NSDictionary class]]) {
                    GOHeaderModel*headerModel = [[GOHeaderModel alloc]initWithDict:sub];
                    NSMutableArray*cellModelArrM = [NSMutableArray array];
                    for (id subsub in headerModel.list) {
                        if ([subsub isKindOfClass:[NSDictionary class]]) {
                            
                            NSMutableArray * sub_itemsArrM = [NSMutableArray array];
                            if ([subsub[@"sub_items"] isKindOfClass:[NSArray class]] && [subsub[@"sub_items"] count] >0) {
                                NSArray * sub_items  = subsub[@"sub_items"];
                                for (int i = 0 ; i<sub_items.count; i++) {
                                    if ([sub_items[i] isKindOfClass:[NSDictionary class]]) {
                                        SpecModel * specModel = [[SpecModel alloc]initWithDict:sub_items[i]];
                                        [sub_itemsArrM addObject:specModel];
                                    }
                                }
                                //                        [goodsDict setValue:sub_itemsArrM forKey:@"sub_items"];
                            }
                            
                            GOCellModel * cellModel = [[GOCellModel alloc]initWithDict:subsub];
                            cellModel.sub_items = sub_itemsArrM;
                            
                            
                            [cellModelArrM addObject:cellModel];
                            
                            
                        }
                    }
                    headerModel.list = cellModelArrM;
                    if (headerModel.list.count>0) {
                        [headerModelArrM addObject:headerModel];
                    }
                }
                
            }
            self.dataS = headerModelArrM;
        }
        
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.dataS);
    return self.dataS.count ;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    GOHeaderModel * shop = self.dataS[section];
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,shop.list);
    return shop.list.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GOCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell= [[GOCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    GOHeaderModel * headerModel = self.dataS[indexPath.section];
    GOCellModel * cellModel =headerModel.list[indexPath.row];
    
    if (headerModel.list.count-1 == indexPath.row) {
        cellModel.hiddenBottomLine = YES;
    }
    cell.cellModel = cellModel;
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44*SCALE;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    GOHeaderModel * shop = self.dataS[section];
        if (section==self.dataS.count-1) {
            return 0.000000001;
        }else{
            return 10;
        }
    
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    GOHeaderView * header =[[GOHeaderView alloc]init];
        header.backgroundColor = [UIColor whiteColor];
    header.headerModel=self.dataS[section];
//    header.SCShopHeaderHelegate = self;
    return header;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{

    UIView * footer =  [[UIView alloc]init];
    footer.backgroundColor  = BackgroundGray;
    return footer;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GOCellModel * model = [self.dataS[indexPath.section] list][indexPath.row];
    model.actionKey =@"HGoodsVC";
    [[SkipManager shareSkipManager]skipByVC:self withActionModel:model];
    //    [[SkipManager shareSkipManager] skipForHomeByVC:self withActionModel:model];
    //    LOG(@"_%@_%d_%@",[self class] , __LINE__,    model.actionKey)
    
}

-(NSMutableArray * )dataS{
    if(_dataS==nil){
        _dataS = [[NSMutableArray alloc]init];
//        NSMutableArray * shopArr = [NSMutableArray array];
//        for (int i = 0 ; i<3; i++) {
//            GOHeaderModel * headerModel = [[GOHeaderModel alloc]init];
//            headerModel.name = @"花瓣美文";
//            if (i%2==0) {
//            headerModel.freight = @9;
//            }else{
//            headerModel.freight = @0;
//            }
//            NSMutableArray * list = [NSMutableArray array];
//            for (int j=0 ;  j < 3; j++) {
//                GOCellModel * cellModel  = [[GOCellModel alloc]init];
//                cellModel.title = @"生命里，总有一些温暖，一些守候，每一天，都昨日重现。遇见，是缘，相守是修行，相处是人心。总有一些情，能维系一生，许你，最美的情意，不离不弃。";
//                cellModel.img = @"http://s7.sinaimg.cn/mw690/51ebff8ahd303c1055a46&690";
//                cellModel.number = @2 ;
//                cellModel.shop_price=@"77.93";
//                cellModel.attribute = @"时光越老，人心越淡。轻轻的呼吸，浅浅的微笑。 生活，平平淡淡不悲不喜不惊不扰，这样就好";
//                [list addObject:cellModel];
//            }
//            headerModel.list = list;
//            [shopArr addObject:headerModel];
//        }
//        _dataS = shopArr;
        
        
    }
    return _dataS;
}
@end
