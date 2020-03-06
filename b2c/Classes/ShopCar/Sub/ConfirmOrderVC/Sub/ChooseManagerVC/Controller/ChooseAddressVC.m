//
//  ChooseAddressVC.m
//  b2c
//
//  Created by wangyuanfei on 16/5/17.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "ChooseAddressVC.h"
#import "AMCellModel.h"
#import "ChooseAddressCell.h"
#import "EditAddressVC.h"
#import "CaculateManager.h"
@interface ChooseAddressVC ()<EditAddressVCDelegate>
@property(nonatomic,strong)NSMutableArray * dataS ;
@end

@implementation ChooseAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviTitle = @"收货地址";
    [self gotAddressSuccess:^{
        [self setuptableview];
        [self.tableView reloadData];
    } failure:^{
        
    }];
    [self setupRightBarbuttonItem];
    // Do any additional setup after loading the view.
}
-(void)setupRightBarbuttonItem
{
    UIButton * rightButton = [[UIButton alloc]init];
    [rightButton setTitle:@"管理" forState:UIControlStateNormal];
    
    [rightButton setTitleColor:SubTextColor forState:UIControlStateNormal];
    //    rightButton.backgroundColor=randomColor;
    [rightButton addTarget:self action:@selector(addressManager:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationBarRightActionViews=@[rightButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}
-(void)addressManager:(UIButton*)sender{
    BaseModel * model = [[BaseModel alloc]init];
    model.actionKey = @"AddressManagerVC";
    [[SkipManager shareSkipManager] skipByVC:self withActionModel:model];
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


-(void)setuptableview;
{
    self.automaticallyAdjustsScrollViewInsets = NO ;
    
    //    CGFloat margin = 20 ;
    //    CGFloat confirmBtnW = self.view.bounds.size.width - margin*2 ;
    //    CGFloat confirmBtnH = 44 ;
    //    CGFloat confirmBtnX = margin ;
    //    CGFloat confirmBtnY = self.view.bounds.size.height-margin -confirmBtnH ;
    //先设置加号按钮
    CGFloat margin = 10 ;
    CGFloat addButtonW = self.view.bounds.size.width - margin * 2 ;
    CGFloat addButtonH = 44 * SCALE ;
    CGFloat addButtonX = margin ;
    CGFloat addButtonY = self.view.bounds.size.height - margin*2 - addButtonH ;
    UIButton * addButton = [[UIButton alloc]initWithFrame:CGRectMake(addButtonX, addButtonY, addButtonW, addButtonH)];
    addButton.layer.cornerRadius = 5 ;
    addButton.layer.masksToBounds = YES;
    [addButton addTarget:self action:@selector(addAddress:) forControlEvents:UIControlEventTouchUpInside];
    addButton.backgroundColor = THEMECOLOR;
    [addButton setImage:[UIImage imageNamed:@"icon_add"] forState:UIControlStateNormal];
    [addButton setTitle:@"    新建地址" forState:UIControlStateNormal];
    [self.view addSubview:addButton];
    
    
    
    CGRect frame = CGRectMake(0, self.startY, self.view.bounds.size.width, addButtonY-self.startY);
    UITableView * tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
    //    tableView.rowHeight = UITableViewAutomaticDimension;
    //    tableView.estimatedRowHeight = 22 ;
    //    self.tableView.estimatedRowHeight=200;
    //    self.tableView.rowHeight=UITableViewAutomaticDimension;
    UIView * tableHeader =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 0.000000000001)];
    UIView * tableFooter =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 0.000000000001)];
    
    tableView.tableHeaderView=tableHeader;
    tableView.tableFooterView = tableFooter;
    tableView.separatorStyle=0;
    self.tableView = tableView ;
    
    tableView.showsVerticalScrollIndicator = NO;
    
    //    UIButton * confirmButton =  [[UIButton alloc]initWithFrame:CGRectMake(confirmBtnX, confirmBtnY, confirmBtnW, confirmBtnH)];
    //    [confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    //    confirmButton.backgroundColor = [UIColor colorWithHexString:@"e95513"];
    //    [self.view addSubview:confirmButton];
    
    
}


-(void)addAddress:(ActionBaseView*)sender
{
    EditAddressVC * cv = [[EditAddressVC alloc]initWithActionStyle:Adding];
    cv.delegate=self;
    [self.navigationController pushViewController:cv animated:YES];
}
-(void)gotAddressSuccess:(void(^)())success failure:(void(^)())failure{
    [[UserInfo shareUserInfo] gotAddressSuccess:^(ResponseObject *responseObject) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
        if (responseObject.data && [responseObject.data isKindOfClass:[NSArray class]]) {
            [self.dataS removeAllObjects];
            for (int i = 0 ;i<[responseObject.data count];i++) {
                id sub = responseObject.data[i];
                if ([sub isKindOfClass:[NSDictionary class]]) {
                    AMCellModel * model = [[AMCellModel alloc]initWithdictionary:sub];
                    if (self.choosedAddressID==0) {
                        if (i==0) {
                            
                            model.isSelected=YES;
                        }
                    }else{
                        if ([model.ID integerValue]==self.choosedAddressID ) {
                            model.isSelected=YES;
                            if ([self.ChooseAddressDelegate respondsToSelector:@selector(chooseTheAddressModel:)]) {
                                [self.ChooseAddressDelegate chooseTheAddressModel:model];
                            }
                        }
                    }
                    [self.dataS addObject:model];
                }
            }
        }
        

        success(responseObject);
    } failure:^(NSError *error) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
    }];
    
    
}


#pragma UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AMCellModel * chooseModel = nil ;
    for (int i = 0 ; i < self.dataS.count; i++) {
        AMCellModel * model = self.dataS[i];
        if (indexPath.row == i ) {
            model.isSelected = YES;
            chooseModel = model;
        }else{
            model.isSelected = NO ;
        }
    }
    [self.tableView reloadData];
    if ([self.ChooseAddressDelegate respondsToSelector:@selector(chooseTheAddressModel:)]) {
        [self.ChooseAddressDelegate chooseTheAddressModel:chooseModel];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataS.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChooseAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[ChooseAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    AMCellModel * model = self.dataS[indexPath.row];
    
    cell.addressModel = model;
    //    cell.backgroundColor=randomColor;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    AMCellModel * model = self.dataS[indexPath.row];
//    NSString * str = [NSString stringWithFormat:@"%@ %@",model.area,model.address] ;
    NSString * str = nil ;
    if ([model.area containsString:@"亚洲中国"] ) {//国内先隐藏洲和国
        str =[NSString stringWithFormat:@"%@ %@",[model.area stringByReplacingOccurrencesOfString:@"亚洲中国" withString:@""] ,model.address];
    }else if([model.area containsString:@"亚洲 中国"]){
           str =[NSString stringWithFormat:@"%@ %@",[model.area stringByReplacingOccurrencesOfString:@"亚洲 中国" withString:@""] ,model.address];
    } else{
        str = [NSString stringWithFormat:@"%@ %@",model.area,model.address] ;
    }

    
    CGFloat margin = 10 ;
    CGFloat rightW = 60 *SCALE ;
    CGFloat leftW = screenW - rightW; //剩余宽度
    CGFloat areaLabelW =  leftW - 2*margin;
    CGFloat arealabelMaxWidth = areaLabelW ;
    
    
    
    return   [CaculateManager caculateRowHeightWithString:str fontSize:15.5 lineNum:5 maxWidth:arealabelMaxWidth itemMargin:0 topHeight:40 bottomHeight:0 topMargin:0 bottomMargin:margin];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.000000100001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0000010001;
}


-(NSMutableArray * )dataS{
    if(_dataS==nil){
        _dataS = [[NSMutableArray alloc]init];
    }
    return _dataS;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self gotAddressSuccess:^{
        [self.tableView reloadData];
    } failure:^{
        
    }];
}

@end




































////
////  ChooseAddressVC.m
////  b2c
////
////  Created by wangyuanfei on 16/5/17.
////  Copyright © 2016年 www.16lao.com. All rights reserved.
////
//
//#import "ChooseAddressVC.h"
//#import "AMCellModel.h"
//#import "ChooseAddressCell.h"
//#import "EditAddressVC.h"
//@interface ChooseAddressVC ()<EditAddressVCDelegate>
//@property(nonatomic,strong)NSMutableArray * dataS ;
//@end
//
//@implementation ChooseAddressVC
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.naviTitle = @"收货地址";
//    [self gotAddressSuccess:^{
//        [self setuptableview];
//        [self.tableView reloadData];
//    } failure:^{
//        
//    }];
//    [self setupRightBarbuttonItem];
//    // Do any additional setup after loading the view.
//}
//-(void)setupRightBarbuttonItem
//{
//    UIButton * rightButton = [[UIButton alloc]init];
//    [rightButton setTitle:@"管理" forState:UIControlStateNormal];
//    
//    [rightButton setTitleColor:SubTextColor forState:UIControlStateNormal];
////    rightButton.backgroundColor=randomColor;
//    [rightButton addTarget:self action:@selector(addressManager:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationBarRightActionViews=@[rightButton];
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
//    // Dispose of any resources that can be recreated.
//}
//-(void)addressManager:(UIButton*)sender{
//    BaseModel * model = [[BaseModel alloc]init];
//    model.actionKey = @"AddressManagerVC";
//    [[SkipManager shareSkipManager] skipByVC:self withActionModel:model];
//
//}
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
//-(void)setuptableview;
//{
//    self.automaticallyAdjustsScrollViewInsets = NO ;
//    
////    CGFloat margin = 20 ;
//    //    CGFloat confirmBtnW = self.view.bounds.size.width - margin*2 ;
//    //    CGFloat confirmBtnH = 44 ;
//    //    CGFloat confirmBtnX = margin ;
//    //    CGFloat confirmBtnY = self.view.bounds.size.height-margin -confirmBtnH ;
//    //先设置加号按钮
//    CGFloat margin = 10 ;
//    CGFloat addButtonW = self.view.bounds.size.width - margin * 2 ;
//    CGFloat addButtonH = 44 * SCALE ;
//    CGFloat addButtonX = margin ;
//    CGFloat addButtonY = self.view.bounds.size.height - margin*2 - addButtonH ;
//    UIButton * addButton = [[UIButton alloc]initWithFrame:CGRectMake(addButtonX, addButtonY, addButtonW, addButtonH)];
//    addButton.layer.cornerRadius = 5 ;
//    addButton.layer.masksToBounds = YES;
//    [addButton addTarget:self action:@selector(addAddress:) forControlEvents:UIControlEventTouchUpInside];
//    addButton.backgroundColor = THEMECOLOR;
//    [addButton setImage:[UIImage imageNamed:@"icon_add"] forState:UIControlStateNormal];
//    [addButton setTitle:@"    新建地址" forState:UIControlStateNormal];
//    [self.view addSubview:addButton];
//    
//
//    
//    CGRect frame = CGRectMake(0, self.startY, self.view.bounds.size.width, addButtonY-self.startY);
//    UITableView * tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
//    tableView.rowHeight = UITableViewAutomaticDimension;
//    tableView.estimatedRowHeight = 22 ;
////    self.tableView.estimatedRowHeight=200;
////    self.tableView.rowHeight=UITableViewAutomaticDimension;
//    UIView * tableHeader =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 0.000000000001)];
//    UIView * tableFooter =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 0.000000000001)];
//    
//    tableView.tableHeaderView=tableHeader;
//    tableView.tableFooterView = tableFooter;
//    tableView.separatorStyle=0;
//    self.tableView = tableView ;
//    
//    tableView.showsVerticalScrollIndicator = NO;
//    
//    //    UIButton * confirmButton =  [[UIButton alloc]initWithFrame:CGRectMake(confirmBtnX, confirmBtnY, confirmBtnW, confirmBtnH)];
//    //    [confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    //    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
//    //    confirmButton.backgroundColor = [UIColor colorWithHexString:@"e95513"];
//    //    [self.view addSubview:confirmButton];
//    
// 
//}
//-(void)addAddress:(ActionBaseView*)sender
//{
//    EditAddressVC * cv = [[EditAddressVC alloc]initWithActionStyle:Adding];
//    cv.delegate=self;
//    [self.navigationController pushViewController:cv animated:YES];
//}
//-(void)gotAddressSuccess:(void(^)())success failure:(void(^)())failure{
//    [[UserInfo shareUserInfo] gotAddressSuccess:^(ResponseObject *responseObject) {
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
//        if (responseObject.data && [responseObject.data isKindOfClass:[NSArray class]]) {
//            [self.dataS removeAllObjects];
//            for (int i = 0 ;i<[responseObject.data count];i++) {
//                id sub = responseObject.data[i];
//                if ([sub isKindOfClass:[NSDictionary class]]) {
//                    AMCellModel * model = [[AMCellModel alloc]initWithdictionary:sub];
//                        if (self.choosedAddressID==0) {
//                            if (i==0) {
//                                
//                                model.isSelected=YES;
//                            }
//                        }else{
//                            if ([model.ID integerValue]==self.choosedAddressID ) {
//                                model.isSelected=YES;
//                            }
//                        }
//                    [self.dataS addObject:model];
//                }
//            }
//        }
//        
//        
//        success(responseObject);
//    } failure:^(NSError *error) {
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
//    }];
//    
//    
//}
//
//
//#pragma UITableViewDelegate
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    AMCellModel * chooseModel = nil ;
//    for (int i = 0 ; i < self.dataS.count; i++) {
//        AMCellModel * model = self.dataS[i];
//        if (indexPath.row == i ) {
//            model.isSelected = YES;
//            chooseModel = model;
//        }else{
//            model.isSelected = NO ;
//        }
//    }
//    [self.tableView reloadData];
//    if ([self.ChooseAddressDelegate respondsToSelector:@selector(chooseTheAddressModel:)]) {
//        [self.ChooseAddressDelegate chooseTheAddressModel:chooseModel];
//    }
//    [self.navigationController popViewControllerAnimated:YES];
//
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.dataS.count ;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    ChooseAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (!cell) {
//        cell=[[ChooseAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    }
//    AMCellModel * model = self.dataS[indexPath.row];
//
//    cell.addressModel = model;
//    //    cell.backgroundColor=randomColor;
//    
//    return cell;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//
//    return 0.000000100001;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0.0000010001;
//}
//
//
//-(NSMutableArray * )dataS{
//    if(_dataS==nil){
//        _dataS = [[NSMutableArray alloc]init];
//    }
//    return _dataS;
//}
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self gotAddressSuccess:^{
//        [self.tableView reloadData];
//    } failure:^{
//        
//    }];
//}
//
//@end
