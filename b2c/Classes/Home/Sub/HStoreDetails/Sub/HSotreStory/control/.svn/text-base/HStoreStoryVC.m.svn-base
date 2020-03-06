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
@interface HStoreStoryVC ()<UITableViewDataSource, UITableViewDelegate>
/**设置UI*/
@property (nonatomic, strong) UITableView *table;
/**数据源*/
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation HStoreStoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    for (NSInteger i = 0; i < 25; i++) {
        HStoreStoryModel *model = [[HStoreStoryModel alloc] init];
        model.title = @"你是我的小苹果";
        model.time = @"2125- 11- 08";
        model.count = @"25";
        [self.dataArray addObject:model];
    }
    
    
    [self configmentUI];
    // Do any additional setup after loading the view.
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
        [_table setShowsVerticalScrollIndicator:NO];
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
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}


#pragma mark --跳转到故事详情页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[SkipManager shareSkipManager] skipByVC:self urlStr:nil title:nil action:@"HStoreStoryDetailVC"];
}
- (void)configmentUI{
    self.table.delegate = self;
    self.table.dataSource = self;
    
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
