//
//  BalanceDetailVC.m
//  b2c
//
//  Created by 0 on 16/4/20.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BalanceDetailVC.h"
#import "BalanceDetailCell.h"
#import "BalanceDetailModel.h"
@interface BalanceDetailVC ()
@property (nonatomic, strong) UITableView *detailTable;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation BalanceDetailVC

- (NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}



- (UITableView *)detailTable{
    if (_detailTable == nil) {
        _detailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, self.startY, screenW ,screenH - self.startY - 40) style:UITableViewStylePlain];
        [self.view addSubview:_detailTable];
        [_detailTable registerClass:[BalanceDetailCell class] forCellReuseIdentifier:@"BalanceDetailCell"];
        _detailTable.rowHeight = UITableViewAutomaticDimension;
        _detailTable.estimatedRowHeight = 80;
        _detailTable.delegate = self;
        _detailTable.dataSource = self;
        _detailTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _detailTable;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    BalanceDetailModel *model = [[BalanceDetailModel alloc] init];
    model.detailTitleLabel = @"消费";
    model.balanceLabel = @"12";
    model.goodsNameLabel = @"麻辣诱惑";
    model.timeLabel = @"2016-03-05";
    model.consumptionLabel = @"-10.9";
    
    [self.dataArr addObject:model];
    
    BalanceDetailModel *model2 = [[BalanceDetailModel alloc] init];
    model2.detailTitleLabel = @"退款至余额";
    model2.balanceLabel = @"10";
    model2.goodsNameLabel  =@"华东强";
    model2.timeLabel = @"2016-03-05";
    model2.consumptionLabel = @"+12.5";
    [self.dataArr addObject:model2];
    self.naviTitle = @"余额明细";
    self.view.backgroundColor = [UIColor whiteColor];
    [self configmentMainUI];
    // Do any additional setup after loading the view.
}
#pragma mark -- 搭建主要UI
- (void)configmentMainUI{
    
    //布局table
    [self.detailTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(self.startY);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BalanceDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BalanceDetailCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.balanceModel = self.dataArr[indexPath.row];
    
    return cell;
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
