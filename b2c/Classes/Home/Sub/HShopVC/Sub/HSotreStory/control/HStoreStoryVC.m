//
//  HStoreStoryVC.m
//  b2c
//
//  Created by 0 on 16/3/31.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HStoreStoryVC.h"
#import "HStoreStoryCell.h"
#import "HStoreStoryModel.h"
#import "HStoreStoryDetailVC.h"
@interface HStoreStoryVC ()<UITableViewDataSource, UITableViewDelegate>
/**设置UI*/
@property (nonatomic, strong) UITableView *table;
/**数据源*/
@property (nonatomic, strong) NSMutableArray *dataArray;
/**店铺id*/
@property (nonatomic, assign) NSInteger shop_id;
/**提示框*/
@property (nonatomic, strong) UIAlertController *aleartVC;

@end

@implementation HStoreStoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(messageCountChanged) name:MESSAGECOUNTCHANGED object:nil];

    NSString *shopID = self.keyParamete[@"paramete"];
    self.sellerUser = self.keyParamete[@"sellerUser"];

    self.shop_id = [shopID integerValue];
    [self configmentUI];
    [self requestData];
    // Do any additional setup after loading the view.
}
#pragma mark -- 请求数据
- (void)requestData{
    [[UserInfo shareUserInfo] gotShopSotryDataWithShopID:self.shop_id success:^(ResponseObject *responseObject) {
        NSLog(@"%@, %d ,%@",[self class],__LINE__,responseObject.data);

        [self.dataArray removeAllObjects];
        [self analyseDataWith:responseObject];
        [self.table reloadData];
        
    } failure:^(NSError *error) {
        [self showTheViewWhenDisconnectWithFrame:CGRectMake(0, self.startY, screenW, screenH - self.startY)];
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestData];
}

#pragma mark -- 分析数据
- (void)analyseDataWith:(ResponseObject*)responseObject{
    //判断返回的数组是不是空
    if (!responseObject.data) {
        UIAlertController *aleartVC = [UIAlertController alertControllerWithTitle:@"卖家没有写店铺故事" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *aleartAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self navigationBack];
        }];
        [aleartVC addAction:aleartAction];
        [self presentViewController:aleartVC animated:YES completion:^{
            
        }];
        
    }else{
        if ([responseObject.data isKindOfClass:[NSArray class]]) {
            NSArray *objectArr = responseObject.data;
            for (NSDictionary *dic in objectArr) {
                if (!dic[@"items"]) {
                    UIAlertController *aleartVC = [UIAlertController alertControllerWithTitle:@"卖家没有写店铺故事" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *aleartAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [self navigationBack];
                    }];
                    [aleartVC addAction:aleartAction];
                    [self presentViewController:aleartVC animated:YES completion:^{
                        
                    }];
                }else{
                    //items是存在的。判断数组里面有没有值
                    NSArray *itemsArr = dic[@"items"];
                    if (itemsArr.count == 0) {
                        UIAlertController *aleartVC = [UIAlertController alertControllerWithTitle:@"卖家没有写店铺故事" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                        
                        UIAlertAction *aleartAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            [self navigationBack];
                        }];
                        [aleartVC addAction:aleartAction];
                        [self presentViewController:aleartVC animated:YES completion:^{
                            
                        }];
                    }
                    for (NSDictionary *itemDic in itemsArr) {
                        HStoreStoryModel *storyModel = [HStoreStoryModel mj_objectWithKeyValues:itemDic];
                        [self.dataArray addObject:storyModel];
                    }
                }
            }
        }
    }
}
-(void)navigationBack
{
    [self.navigationController popViewControllerAnimated:YES];
    //    [[KeyVC shareKeyVC] popViewControllerAnimated:YES];
}

#pragma mark -- 重新连接
-(void)reconnectClick:(UIButton *)sender{
    [self.dataArray removeAllObjects];
    [[UserInfo shareUserInfo] gotShopSotryDataWithShopID:self.shop_id success:^(ResponseObject *responseObject) {
        [self.dataArray removeAllObjects];
        [self analyseDataWith:responseObject];
        [self.table reloadData];
        [self removeTheViewWhenConnect];
    } failure:^(NSError *error) {
        
    }];
}






- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}



#pragma mark --  设置导航栏中间的view
- (void)configmentMidleView{
    self.naviTitle = @"店铺故事";
}

- (UITableView *)table{
    if (_table == nil) {
         _table = [[UITableView alloc] initWithFrame:CGRectMake(0, self.startY, screenW, screenH - self.startY) style:UITableViewStylePlain];
        [_table registerClass:[HStoreStoryCell class] forCellReuseIdentifier:@"HStoreStoryCell"];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_table setShowsVerticalScrollIndicator:NO];
        _table.rowHeight = 46 * SCALE;
        [self.view addSubview:_table];
    }
    return _table;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HStoreStoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HStoreStoryCell" forIndexPath:indexPath];
    cell.storeModel = self.dataArray[indexPath.row];
    
    return cell;
}



#pragma mark --跳转到故事详情页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HStoreStoryModel *storyModel = self.dataArray[indexPath.row];
    storyModel.keyParamete = @{@"paramete":storyModel.url};
    [[SkipManager shareSkipManager] skipByVC:self withActionModel:storyModel];
}
- (void)configmentUI{
    self.table.delegate = self;
    self.table.dataSource = self;
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

@end
