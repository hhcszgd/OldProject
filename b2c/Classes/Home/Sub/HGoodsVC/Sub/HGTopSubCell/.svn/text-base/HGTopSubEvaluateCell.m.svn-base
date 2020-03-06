//
//  HGTopSubEvaluateCell.m
//  b2c
//
//  Created by 0 on 16/4/25.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HGTopSubEvaluateCell.h"
#import "HGTopSubEDetailCell.h"
#import "HGTopSubETopBar.h"
#import "HGTopSubEModel.h"
#import "HGTopSubGoodsESubModel.h"
#import "CustomFRefresh.h"


@interface HGTopSubEvaluateCell()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
/**查看全部评价*/
/**好评*/
/**中平*/
/**差评*/
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, copy) NSString *goodsID;
@property (nonatomic, assign) NSInteger evluate;

@property (nonatomic, strong) HGTopSubETopBar *beforeSelectBar;
@property (nonatomic, strong) NSMutableArray *topNavDataArr;
@property (nonatomic, strong) NSMutableArray *topNavViewArr;
@property (nonatomic, strong) CustomFRefresh *refreshF;

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) UIButton *scrowTop;
@property (nonatomic, strong) UIView *topView;
/**没有评价的时候显示的页面*/
@property (nonatomic, strong) UIView *overView;
@end
@implementation HGTopSubEvaluateCell


- (NSMutableArray *)topNavDataArr{
    if (_topNavDataArr == nil) {
        _topNavDataArr = [[NSMutableArray alloc] init];
        
    }
    return _topNavDataArr;
}
- (NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (NSMutableArray *)topNavViewArr{
    if (_topNavViewArr == nil) {
        _topNavViewArr = [[NSMutableArray alloc] init];
        
    }
    return _topNavViewArr;
}

- (UIButton *)scrowTop{
    if (_scrowTop == nil) {
        _scrowTop = [[UIButton alloc] init];
        [self.contentView addSubview:_scrowTop];
        [_scrowTop addTarget:self action:@selector(scrowToTop:) forControlEvents:UIControlEventTouchUpInside];
        [_scrowTop setBackgroundImage:[UIImage imageNamed:@"btn_Top"] forState:UIControlStateNormal];
        _scrowTop.hidden = YES;
    }
    return _scrowTop;
}
- (UIView *)topView{
    if (_topView == nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, 57 * SCALE)];
        [self.contentView addSubview:_topView];
        _topView.backgroundColor = [UIColor whiteColor];
        CGFloat left = 20;
        CGFloat inter = (screenW - 20 * 2 - 4 * 60 * SCALE)/3.0;
        for (NSInteger i =0 ; i < 4; i++) {
            HGTopSubETopBar *bar = [[HGTopSubETopBar alloc] initWithFrame:CGRectMake(inter * i + left + i * 60* SCALE, 13, 60 * SCALE, 30 * SCALE)];
            bar.tag = i + 1;
            [bar addTarget:self action:@selector(checkDifferentEvaluate:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 0) {
                bar.selected = YES;
                self.beforeSelectBar = bar;
            }
            [_topView addSubview:bar];
            [self.topNavViewArr addObject:bar];
        }
        
    }
    return _topView;
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 57* SCALE + 10, screenW, self.bounds.size.height - 57* SCALE - 10)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 100;
        [_tableView registerClass:[HGTopSubEDetailCell class] forCellReuseIdentifier:@"HGTopSubEDetailCell"];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.refreshF = [CustomFRefresh footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        
        
        [self.contentView addSubview:_tableView];
    }
    return _tableView;
}
- (UIView *)overView{
    if (_overView == nil) {
        _overView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, self.frame.size.height)];
        [self.contentView addSubview:_overView];
        UIImageView *noCommentImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenW, self.frame.size.height)];
        noCommentImage.image = [UIImage imageNamed:@"icon_wuping"];
        [_overView addSubview:noCommentImage];
        _overView.backgroundColor = [UIColor whiteColor];
    }
    return _overView;
}

/**滑动到顶部*/
- (void)scrowToTop:(UIButton *)btn{
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //默认请求全部评价的数据
        self.evluate = 1;
        self.page = 1;
        //是否第一次运行
        self.isFirst = YES;
        self.contentView.backgroundColor = BackgroundGray;
        self.topView.backgroundColor = [UIColor whiteColor];
        self.tableView.backgroundColor = [UIColor whiteColor];
       
        [self.scrowTop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-40);
            make.width.equalTo(@(44));
            make.height.equalTo(@(44));
        }];
        
        
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HGTopSubEDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HGTopSubEDetailCell" forIndexPath:indexPath];
    cell.eModel = self.dataArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setData:(NSMutableArray *)data{
//     LOG(@"%d,%@",__LINE__,[data lastObject])
//    self.dataArr = [data lastObject];
//    LOG(@"%@,%d,%@",[self class], __LINE__,self.isFirst? @"Yes":@"NO")
//    if ((self.dataArr.count == 0) && self.isFirst) {
//        self.isFirst = NO;
//        self.overView.backgroundColor = [UIColor whiteColor];
//    }
//    if (self.dataArr.count  < 3 ) {
//        self.tableView.mj_footer = nil;
//    }
//    self.topNavDataArr = [data firstObject];
//    [self configmentNavWithData];
//    
//    [self.tableView reloadData];
}

#pragma mark -- good_id
-(void)setGoods_id:(NSString *)goods_id{
    self.goodsID = goods_id;
    if (self.isFirst) {
        [self requestGoodsEvluateData];
    }
}
#pragma mark --请求商品评价页面的数据
- (void)requestGoodsEvluateData{
    [[UserInfo shareUserInfo] gotEvaluateOfGoodsWithgoodsID:self.goodsID evluation:1 pageNumber:1 success:^(ResponseObject *responseObject) {
        self.isFirst = NO;
        //处理商品评价里面的数据
        [self anlayseGoodsEvluateWithData:responseObject];
        [self.tableView reloadData];
    } failure:^(NSError *error) {

    }];
}
#pragma mark -- 处理商品评价的数据
- (void)anlayseGoodsEvluateWithData:(ResponseObject*)response{

    if (response.status >0) {
        if ([response.data isKindOfClass:[NSArray class]]) {
            NSDictionary *commentDic;
            NSDictionary *numberDic;
            for (NSDictionary *dic in response.data) {
                //处理评价的数据
                if ([dic[@"key"] isEqualToString:@"comment"]) {
                    commentDic = dic;
                    
                }
                //获取topNav的数据
                
                if ([dic[@"key"] isEqualToString:@"number"] &&![dic[@"items"] isEqual:[NSNull class]] &&[dic[@"items"] isKindOfClass:[NSArray class]]) {
                    numberDic = dic;
                    
                }
                
                
            }
            
            
            if ([commentDic[@"items"] isKindOfClass:[NSArray class]] &&![commentDic[@"item"] isEqual:[NSNull class]]) {
                NSArray * arr = commentDic[@"items"];
                //从数组中取出数据
                for (NSDictionary *dic in arr) {
                    HGTopSubEModel *eModel = [HGTopSubEModel mj_objectWithKeyValues:dic];
                    [self.dataArr addObject:eModel];
                }
                if (self.dataArr.count < 1) {
                    self.overView.backgroundColor = [UIColor whiteColor];
                }else{
                    self.tableView.mj_footer = self.refreshF;
                }
            }
            for (NSDictionary *dict in numberDic[@"items"]) {
                HGTopSubESubModel *subModel = [HGTopSubESubModel mj_objectWithKeyValues:dict];
                [self.topNavDataArr addObject:subModel];
            }
            [self configmentNavWithData];

            
            
            
        }
        
        if ([response.data isKindOfClass:[NSDictionary class]]) {
            LOG(@"%@,%d,%@",[self class], __LINE__,@"数据格式改变，")
            return;
        }
        
    }else{
        self.overView.backgroundColor = [UIColor whiteColor];

    }
    
    
}
#pragma mark -- 给导航栏按钮赋值
- (void)configmentNavWithData{
    //给导航按钮赋值
    for (NSInteger i =0 ; i < self.topNavDataArr.count; i++) {
        HGTopSubETopBar *bar = self.topNavViewArr[i];
        bar.subModel = self.topNavDataArr[i];
    }
}



#pragma mark -- 加载更多的数据
- (void)loadMoreData{
    self.page++;
    [self requestData];
    
}

#pragma mark -- 改变导航栏的按钮请求不同的数据
- (void)checkDifferentEvaluate:(HGTopSubETopBar *)bar{
    //防止重复请求数据
    if (self.beforeSelectBar == bar) {
        return;
    }
    self.beforeSelectBar.selected = NO;
    bar.selected = YES;
    self.beforeSelectBar = bar;
    //切换评价的分类
    NSInteger evluate = bar.tag;
    self.evluate = evluate;
    //设置分页
    self.page = 1;
    
    //清空数据源数组
   
    [self requestData];
    
}


#pragma mark -- 数据请求
- (void)requestData{
  
    [[UserInfo shareUserInfo] gotEvaluateOfGoodsWithgoodsID:self.goodsID evluation:self.evluate pageNumber:self.page success:^(ResponseObject *responseObject) {
        [self analyseWithData:responseObject];
    } failure:^(NSError *error) {
        LOG(@"%@,%d,%@",[self class], __LINE__,@"哈哈")
    }];
  
}


#pragma mark -- 数据请求
- (void)analyseWithData:(ResponseObject *)response{

    if (response.status > 0) {
        if ([response.data isKindOfClass:[NSArray class]]) {
            NSDictionary *commentDic;
            for (NSDictionary *dic in response.data) {
                //处理评价的数据
                if ([dic[@"key"] isEqualToString:@"comment"]) {
                    commentDic = dic;
                }
            }
            if (self.page == 1) {
                [self.dataArr removeAllObjects];
                
            }
            if ([commentDic[@"items"] isKindOfClass:[NSArray class]] &&![commentDic[@"item"] isEqual:[NSNull class]]) {
                NSArray * arr = commentDic[@"items"];
                //从数组中取出数据
                for (NSDictionary *dic in arr) {
                    HGTopSubEModel *eModel = [HGTopSubEModel mj_objectWithKeyValues:dic];
                    [self.dataArr addObject:eModel];
                }
                NSLog(@"%@, %d ,%@",[self class],__LINE__,self.dataArr);
                
            }
            
        }
        [self.tableView.mj_footer endRefreshing];
        
    }else{
        if (self.page == 1) {
            [self.dataArr removeAllObjects];
        }
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    
    
    
    [self.tableView reloadData];
    if (self.dataArr.count == 0) {
        //如果没有数据
    }else{
        if (self.page == 1) {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
        
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.tableView.contentOffset.y >   self.contentView.bounds.size.height) {
        self.scrowTop.hidden = NO;
    }else{
        self.scrowTop.hidden = YES;
    }
}
- (void)dealloc{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"销毁")
}


@end
