//
//  ChooseAreaVC.m
//  b2c
//
//  Created by wangyuanfei on 16/5/21.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "ChooseAreaVC.h"
#import "AMCellModel.h"
#import "AreaModel.h"

@interface ChooseAreaVC ()<ChooseAreaVCDelegate>
@end

@implementation ChooseAreaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.addressModel) {
        self.addressModel=[[AMCellModel alloc]init];
    }

    if (self.addressType==Country) {
        [self gotListWithAreaType:self.addressType areaID:self.areaID succell:^(id responseObject) {
            if ([responseObject isKindOfClass:[NSArray class]] && [responseObject count]>0 ) {
                self.dataS = responseObject;
                [self setuptableview];
                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"第一次进入地址选择 , 当前显示国际列表");
            }
            
        } failure:^(NSError *error) {
            LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
        }];
    }else if (self.addressType==Province) {
        [self gotListWithAreaType:self.addressType areaID:self.areaID succell:^(id responseObject) {
            if ([responseObject isKindOfClass:[NSArray class]] && [responseObject count]>0 ) {
                self.dataS = responseObject;
                [self setuptableview];
                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"第一次进入地址选择 , 当前显示国际列表");
            }
            
        } failure:^(NSError *error) {
            LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
        }];
    }  else{
         [self setuptableview];
    }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}


-(void)setuptableview;
{
    self.automaticallyAdjustsScrollViewInsets = NO ;
    
    CGRect frame = CGRectMake(0, self.startY, self.view.bounds.size.width, self.view.bounds.size.height-self.startY);
    UITableView * tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
    tableView.rowHeight = 44*SCALE;
    UIView * tableHeader =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 0.000000000001)];
    UIView * tableFooter =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 0.000000000001)];
    
    tableView.tableHeaderView=tableHeader;
    tableView.tableFooterView = tableFooter;
    tableView.separatorStyle=0;
    self.tableView = tableView ;
    
    tableView.showsVerticalScrollIndicator = NO;
    

    
}
-(void)gotListWithAreaType:(AddressType)areaType  areaID:(NSString*)areaID succell:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{

    [[UserInfo shareUserInfo] gotAreaListWithAreaType:areaType areaID:areaID success:^(ResponseObject *responseObject) {
        
        success([self analysisWithData:responseObject.data]);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
-(NSMutableArray*)analysisWithData:(id)result
{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,result);
    if ([result isKindOfClass:[NSDictionary class]]) {
        NSMutableArray * arrM = [NSMutableArray array];
        
        if (result[@"items"]&&[result[@"items"] isKindOfClass:[NSArray class]]) {
            for (id  sub in result[@"items"]) {
                if (sub && [sub isKindOfClass:[NSDictionary class]]) {
                    AreaModel * areaModel = [[AreaModel alloc]initWithdictionary:sub];
                    [arrM addObject:areaModel];
                    LOG(@"_%@_%d_%@",[self class] , __LINE__,areaModel.ID);
                }
            }
        }
        return arrM.mutableCopy;
    }
    return nil ;
}

#pragma UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AreaModel * model = self.dataS[indexPath.row];
    AddressType tempType = 0 ;
    if (self.addressType==Country) {
        tempType = Province;
        self.addressModel.country = model.name;
        self.addressModel.province=nil;
        self.addressModel.city=nil;
        self.addressModel.cantonal=nil;
        
        
    }else if (self.addressType == Province){
        tempType =  City;
        
        self.addressModel.province=model.name;
        self.addressModel.city=nil;
        self.addressModel.cantonal=nil;
       
        
    }else if (self.addressType == City){
        tempType  = Cantonal;
        self.addressModel.city = model.name;
        self.addressModel.cantonal=nil;
        
        
    }else if (self.addressType == Cantonal){
        self.addressModel.cantonal=model.name;
    }
    

    [self gotListWithAreaType:tempType areaID:model.ID succell:^( id responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]]&&[responseObject count]>0) {
            //赋值给下一个控制器 ,设置addressType 和 areaID, 并跳转
            ChooseAreaVC * provinceVC = [[ChooseAreaVC alloc]init];
            provinceVC.areaID = model.ID;
            provinceVC.dataS = responseObject;
            provinceVC.addressType = tempType;
            provinceVC.addressModel = self.addressModel.copy;
            /////////////
            /** 改 */
            
            ////////////
            provinceVC.delegate =self ;
            [self.navigationController pushViewController:provinceVC animated:YES];
            
        }else{
            //直接返回

            [self transitionDataBackWithChoosedAreaModel:model];
            if ([self.delegate respondsToSelector:@selector(removeFromeSupercontroller)]) {
                [self.delegate removeFromeSupercontroller];
            }
            [self.navigationController popViewControllerAnimated:YES];

        }
    } failure:^(NSError *error) {
        AlertInVC(@"网络延迟,请重试");
    }];

}
-(void)removeFromeSupercontroller{
    if ([self.delegate respondsToSelector:@selector(removeFromeSupercontroller)]) {
        [self.delegate removeFromeSupercontroller];
    }
    [self removeFromParentViewController];
    
}
-(void)choosedAddressWithModel:(AMCellModel*)addressModel{
    self.addressModel = addressModel;
    if ([self.delegate respondsToSelector:@selector(choosedAddressWithModel:)]) {
        [self.delegate choosedAddressWithModel:addressModel];
    }
}
-(void)transitionDataBackWithChoosedAreaModel:(AreaModel*)areaModel
{
    if ([self.delegate respondsToSelector:@selector(choosedAddressWithModel:)]) {
        self.addressModel.area_id = areaModel.ID;
        [self.delegate choosedAddressWithModel:self.addressModel];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataS.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    AreaModel * model = self.dataS[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        
//        return 64*SCALE;
    }
    return 0.00000000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000000001;
}


-(NSMutableArray * )dataS{
    if(_dataS==nil){
        _dataS = [[NSMutableArray alloc]init];
 
    }
    return _dataS;
}


@end
