//
//  AddressManagerVC.m
//  b2c
//
//  Created by wangyuanfei on 4/6/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "AddressManagerVC.h"
#import "AMCell.h"
#import "AMCellModel.h"
#import "EditAddressVC.h"
#import "CaculateManager.h"
@interface AddressManagerVC ()<UITableViewDelegate,UITableViewDataSource,AMCellDelegate,EditAddressVCDelegate>


@property(nonatomic,strong)NSMutableArray  * addresses ;//默认地址排在第一位
@end

@implementation AddressManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self gotAddressSuccess:^{
        [self.tableView reloadData];
    } failure:^{
        
    }];
    self.naviTitle=@"收货地址管理";
    [self setupRightBarbuttonItem];
    self.view.backgroundColor=BackgroundGray;
    [self setupTableView];
    
    // Do any additional setup after loading the view.
}
-(void)setupRightBarbuttonItem
{
    //    UIButton * rightButton = [[UIButton alloc]init];
    //    [rightButton setTitleColor:SubTextColor forState:UIControlStateNormal];
    //    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    //    [rightButton setTitle:@"新增" forState:UIControlStateNormal];
    //
    //    [rightButton addTarget:self action:@selector(addAddress:) forControlEvents:UIControlEventTouchUpInside];
    //    self.navigationBarRightActionViews=@[rightButton];
}
-(void)gotAddressSuccess:(void(^)())success failure:(void(^)())failure{
    [[UserInfo shareUserInfo] gotAddressSuccess:^(ResponseObject *responseObject) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
        if (responseObject.data && [responseObject.data isKindOfClass:[NSArray class]]) {
            [self.addresses removeAllObjects];
            for (id sub in responseObject.data) {
                if ([sub isKindOfClass:[NSDictionary class]]) {
                    AMCellModel * model = [[AMCellModel alloc]initWithdictionary:sub];
                    [self.addresses addObject:model];
                }
            }
        }
        
        
        success(responseObject);
    } failure:^(NSError *error) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
    }];
    
    
}
-(void)setupTableView
{
    
    
    //    [self setAddbutton];
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
    
    
    
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    UITableView*tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.startY, self.view.bounds.size.width, addButtonY-self.startY) style:UITableViewStylePlain];
    self.tableView=tableView;
    self.tableView.backgroundColor=BackgroundGray;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //    self.tableView.estimatedRowHeight=200;
    //    self.tableView.rowHeight=UITableViewAutomaticDimension;
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    AMCellModel * model = self.addresses[indexPath.row];
//    NSString * str = [NSString stringWithFormat:@"%@ %@",model.area,model.address] ;
    NSString * str = nil ;
    if ([model.area containsString:@"亚洲中国"] ) {//国内先隐藏洲和国
        str =[NSString stringWithFormat:@"%@ %@",[model.area stringByReplacingOccurrencesOfString:@"亚洲中国" withString:@""] ,model.address];
    }else if([model.area containsString:@"亚洲 中国"]){
        str =[NSString stringWithFormat:@"%@ %@",[model.area stringByReplacingOccurrencesOfString:@"亚洲 中国" withString:@""] ,model.address];
    } else{
        str = [NSString stringWithFormat:@"%@ %@",model.area,model.address] ;
    }

    return   [CaculateManager caculateRowHeightWithString:str fontSize:15 lineNum:3 maxWidth:screenW-20 itemMargin:0 topHeight:30 bottomHeight:44 topMargin:0 bottomMargin:10];
    
}


-(void)addAddress:(ActionBaseView*)sender
{
    EditAddressVC * cv = [[EditAddressVC alloc]initWithActionStyle:Adding];
    cv.delegate=self;
    [self.navigationController pushViewController:cv animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}

#pragma tableViewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.addresses.count ;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AMCellModel * model = self.addresses[indexPath.row];
    AMCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[AMCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.model=model;
    cell.delegate=self;
    return cell;
}


#pragma lazyload

-(NSMutableArray * )addresses{
    if(_addresses==nil){
        NSMutableArray * arrM =  [[NSMutableArray alloc]init];
        //        for (int i = 0 ; i<6; i++) {
        //            AMCellModel*model = [[AMCellModel alloc]init];
        //            model.username=@"John Lock";
        //            model.mobile=@"188 3812 0444";
        //            model.province=@"省1";
        //            model.city=@"市2";
        //            model.area=@"区3";
        //            model.isDefaultAddress=NO;
        //            if (i==2) {
        //                model.area=@"北京市海淀区";
        //            }
        //            //            model.street=@"航丰路街道";
        //            model.address = @"时代财富天地2015";
        //            model.postalCode=@"100000";
        //            [arrM addObject:model];
        //        }
        _addresses = arrM;
    }
    return _addresses;
}
#pragma cellDelegate
-(void)setDefaultAddressAtCell:(AMCell*)cell{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"代理方法执行成功")
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    for (int i = 0 ; i < self.addresses.count;i++) {
        AMCellModel * temp = self.addresses[i];
        if (i==indexPath.row) {
            
            temp.isDefaultAddress=YES;
            [[UserInfo shareUserInfo] setDefaultAddressWithAddressModel:temp success:^(ResponseObject *responseObject) {
                [self.tableView reloadData];
            } failure:^(NSError *error) {
                AlertInVC(@"操作失败")
            }];
        }else{
            temp.isDefaultAddress=NO;
            
        }
    }
    //    AMCellModel * model = self.addresses[indexPath.row];
    [self.tableView reloadData];
}

-(void)deleteButtonClickAtCell:(AMCell *)cell{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"代理方法执行成功 点击删除按钮")
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:@"确定要删除此收货地址吗" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * perform=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
#pragma 记得更新服务器端的数据
        [[UserInfo shareUserInfo] deleteAddressWithAddressModel:self.addresses[indexPath.row] success:^(ResponseObject *responseObject) {
            
            [self.addresses removeObjectAtIndex:indexPath.row];
            [self.tableView reloadData];
        } failure:^(NSError *error) {
            AlertInVC(@"操作失败");
        }];
        
    }];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:perform];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)editButtonClickAtCell:(AMCell *)cell{
    
    EditAddressVC * cv = [[EditAddressVC alloc]initWithActionStyle:Editing];
    cv.delegate=self;
    
    [self.navigationController pushViewController:cv animated:YES];
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    cv.editingCell=cell;
    //    });
    
}
-(void)endEditingAddtess:(EditAddressVC *)editVC andEditingCell:(AMCell *)editingCell{
    
    NSIndexPath * indexPath = [self.tableView indexPathForCell:editingCell];
    //    AMCellModel * model = self.addresses[indexPath.row];
    //    model = editingCell.model;
    //     self.addresses[indexPath.row]= model ;
    [self.addresses replaceObjectAtIndex:indexPath.row withObject:editingCell.model];
    [self.tableView reloadData];
    
    
}
-(void)addAddressWithModel:(AMCellModel *)model{
    [self.addresses addObject:model];
    [self.tableView reloadData];
    
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
////  AddressManagerVC.m
////  b2c
////
////  Created by wangyuanfei on 4/6/16.
////  Copyright © 2016 www.16lao.com. All rights reserved.
////
//
//#import "AddressManagerVC.h"
//#import "AMCell.h"
//#import "AMCellModel.h"
//#import "EditAddressVC.h"
//@interface AddressManagerVC ()<UITableViewDelegate,UITableViewDataSource,AMCellDelegate,EditAddressVCDelegate>
//
//
//@property(nonatomic,strong)NSMutableArray  * addresses ;//默认地址排在第一位
//@end
//
//@implementation AddressManagerVC
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    [self gotAddressSuccess:^{
//        [self.tableView reloadData];
//    } failure:^{
//        
//    }];
//    self.naviTitle=@"收货地址管理";
//    [self setupRightBarbuttonItem];
//    self.view.backgroundColor=BackgroundGray;
//    [self setupTableView];
//    
//    // Do any additional setup after loading the view.
//}
//-(void)setupRightBarbuttonItem
//{
////    UIButton * rightButton = [[UIButton alloc]init];
////    [rightButton setTitleColor:SubTextColor forState:UIControlStateNormal];
////    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
////    [rightButton setTitle:@"新增" forState:UIControlStateNormal];
////    
////    [rightButton addTarget:self action:@selector(addAddress:) forControlEvents:UIControlEventTouchUpInside];
////    self.navigationBarRightActionViews=@[rightButton];
//}
//-(void)gotAddressSuccess:(void(^)())success failure:(void(^)())failure{
//    [[UserInfo shareUserInfo] gotAddressSuccess:^(ResponseObject *responseObject) {
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
//        if (responseObject.data && [responseObject.data isKindOfClass:[NSArray class]]) {
//            [self.addresses removeAllObjects];
//            for (id sub in responseObject.data) {
//                if ([sub isKindOfClass:[NSDictionary class]]) {
//                    AMCellModel * model = [[AMCellModel alloc]initWithdictionary:sub];
//                    [self.addresses addObject:model];
//                }
//            }
//        }
//        
//        
//        success(responseObject);
//    } failure:^(NSError *error) {
//       LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
//    }];
//
//
//}
//-(void)setupTableView
//{
//    
//    
////    [self setAddbutton];
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
//    
//    self.automaticallyAdjustsScrollViewInsets=NO;
//    UITableView*tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.startY, self.view.bounds.size.width, addButtonY-self.startY) style:UITableViewStylePlain];
//    self.tableView=tableView;
//    self.tableView.backgroundColor=BackgroundGray;
//    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
//    self.tableView.estimatedRowHeight=200;
//    self.tableView.rowHeight=UITableViewAutomaticDimension;
//    self.tableView.delegate=self;
//    self.tableView.dataSource=self;
//    
//}
//
//-(void)addAddress:(ActionBaseView*)sender
//{
//    EditAddressVC * cv = [[EditAddressVC alloc]initWithActionStyle:Adding];
//    cv.delegate=self;
//    [self.navigationController pushViewController:cv animated:YES];
//}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
//    // Dispose of any resources that can be recreated.
//}
//
//#pragma tableViewDatasource
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.addresses.count ;
//}
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    AMCellModel * model = self.addresses[indexPath.row];
//    AMCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (!cell) {
//        cell=[[AMCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    }
//    cell.model=model;
//    cell.delegate=self;
//    return cell;
//}
//
//
//#pragma lazyload
//
//-(NSMutableArray * )addresses{
//    if(_addresses==nil){
//        NSMutableArray * arrM =  [[NSMutableArray alloc]init];
////        for (int i = 0 ; i<6; i++) {
////            AMCellModel*model = [[AMCellModel alloc]init];
////            model.username=@"John Lock";
////            model.mobile=@"188 3812 0444";
////            model.province=@"省1";
////            model.city=@"市2";
////            model.area=@"区3";
////            model.isDefaultAddress=NO;
////            if (i==2) {
////                model.area=@"北京市海淀区";
////            }
////            //            model.street=@"航丰路街道";
////            model.address = @"时代财富天地2015";
////            model.postalCode=@"100000";
////            [arrM addObject:model];
////        }
//        _addresses = arrM;
//    }
//    return _addresses;
//}
//#pragma cellDelegate
//-(void)setDefaultAddressAtCell:(AMCell*)cell{
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"代理方法执行成功")
//    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
//    for (int i = 0 ; i < self.addresses.count;i++) {
//        AMCellModel * temp = self.addresses[i];
//        if (i==indexPath.row) {
//            
//            temp.isDefaultAddress=YES;
//            [[UserInfo shareUserInfo] setDefaultAddressWithAddressModel:temp success:^(ResponseObject *responseObject) {
//                [self.tableView reloadData];
//            } failure:^(NSError *error) {
//                AlertInVC(@"操作失败")
//            }];
//        }else{
//            temp.isDefaultAddress=NO;
//        
//        }
//    }
////    AMCellModel * model = self.addresses[indexPath.row];
//    [self.tableView reloadData];
//}
//
//-(void)deleteButtonClickAtCell:(AMCell *)cell{
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"代理方法执行成功 点击删除按钮")
//    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
//    
//    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:@"确定要删除此收货地址吗" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction * perform=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//#pragma 记得更新服务器端的数据
//        [[UserInfo shareUserInfo] deleteAddressWithAddressModel:self.addresses[indexPath.row] success:^(ResponseObject *responseObject) {
//            
//            [self.addresses removeObjectAtIndex:indexPath.row];
//            [self.tableView reloadData];
//        } failure:^(NSError *error) {
//            AlertInVC(@"操作失败");
//        }];
//        
//    }];
//    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        
//    }];
//    [alert addAction:perform];
//    [alert addAction:cancel];
//    [self presentViewController:alert animated:YES completion:nil];
//}
//-(void)editButtonClickAtCell:(AMCell *)cell{
//    
//    EditAddressVC * cv = [[EditAddressVC alloc]initWithActionStyle:Editing];
//    cv.delegate=self;
//
//    [self.navigationController pushViewController:cv animated:YES];
////    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    cv.editingCell=cell;
////    });
//    
//}
//-(void)endEditingAddtess:(EditAddressVC *)editVC andEditingCell:(AMCell *)editingCell{
//    
//    NSIndexPath * indexPath = [self.tableView indexPathForCell:editingCell];
//    //    AMCellModel * model = self.addresses[indexPath.row];
//    //    model = editingCell.model;
//    //     self.addresses[indexPath.row]= model ;
//    [self.addresses replaceObjectAtIndex:indexPath.row withObject:editingCell.model];
//    [self.tableView reloadData];
//    
//    
//}
//-(void)addAddressWithModel:(AMCellModel *)model{
//    [self.addresses addObject:model];
//    [self.tableView reloadData];
//    
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
