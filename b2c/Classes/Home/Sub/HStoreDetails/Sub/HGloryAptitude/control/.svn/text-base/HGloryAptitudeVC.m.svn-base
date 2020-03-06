//
//  HGloryAptitudeVC.m
//  b2c
//
//  Created by 0 on 16/3/31.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HGloryAptitudeVC.h"
#import "HStoreAptiudeCell.h"
#import "HStoreAptitudeModel.h"
@interface HGloryAptitudeVC ()<UITableViewDataSource, UITableViewDelegate,HindleFromSuperView>
@property (nonatomic, strong) UITableView *table;
/**数据源*/
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation HGloryAptitudeVC
- (UITableView *)table{
    if (_table == nil) {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, self.startY, screenW, screenH - self.startY)];
        [self.view addSubview:_table];
    }
    return _table;
}
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    for (NSInteger i = 0; i < 10; i++) {
        HStoreAptitudeModel *model = [[HStoreAptitudeModel alloc] init];
        model.imageUrl = @"http://img4.duitang.com/uploads/item/201603/09/20160309222243_N5rzT.thumb.700_0.jpeg";
        [self.dataArray addObject:model];
    }
    [self configmentUI];
    // Do any additional setup after loading the view.
}
- (void)configmentUI{
    [self.table registerClass:[HStoreAptiudeCell class] forCellReuseIdentifier:@"HStoreAptiudeCell"];
    self.table.estimatedRowHeight = 100;
    self.table.rowHeight = UITableViewAutomaticDimension;
    self.table.delegate = self;
    self.table.dataSource = self;
    
}
#pragma mark -- table的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HStoreAptiudeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HStoreAptiudeCell" forIndexPath:indexPath];
    cell.backgroundColor = randomColor;
    cell.model = self.dataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    GCollectionView *collection = [[GCollectionView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH) withIndexPath:indexPath withArr:self.dataArray];
    collection.delegate = self;
    [window addSubview:collection];
}
#pragma mark -- 消失
- (void)hindleView:(GCollectionView *)gcollection{
    [gcollection removeFromSuperview];
}



#pragma mark --  设置导航栏中间的view
- (void)configmentMidleView{
    self.naviTitle = @"荣誉资质";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
