//
//  AttentionBrandVC.m
//  b2c
//
//  Created by wangyuanfei on 3/30/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "AttentionBrandVC.h"
#import "ABrandModel.h"
#import "ABrandCell.h"
@interface AttentionBrandVC ()<UITableViewDelegate,UITableViewDataSource>
/**数据源数组*/
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *table;



@end

@implementation AttentionBrandVC
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
        
    }
    return _dataArray;
}
- (UITableView *)table{
    if (_table == nil) {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, self.startY, screenW, screenH - self.startY) style:UITableViewStylePlain];
        [self.view addSubview:_table];
    }
    _table.delegate = self;
    _table.dataSource = self;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_table registerClass:[ABrandCell class] forCellReuseIdentifier:@"ABrandCell"];
    return _table;
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, self.startY, screenW, screenH -self.startY)];
//    webView.scalesPageToFit = YES;
//    
//    [self.view addSubview:webView];
    
    

    //
    // Do any additional setup after loading the view.
}



#pragma mark -- tableView的代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ABrandCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ABrandCell" forIndexPath:indexPath];
    cell.brandModel = [[ABrandModel alloc] init];
    return cell;
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [[SkipManager shareSkipManager] skipByVC:self urlStr:nil title:nil action:@"ShopStoreController"];
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
