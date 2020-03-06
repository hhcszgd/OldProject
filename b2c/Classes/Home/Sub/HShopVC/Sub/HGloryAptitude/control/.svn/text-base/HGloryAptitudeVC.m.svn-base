//
//  HGloryAptitudeVC.m
//  b2c
//
//  Created by 0 on 16/3/31.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HGloryAptitudeVC.h"
#import "HStoreAptiudeItem.h"
#import "HStoreAptitudeModel.h"
@interface HGloryAptitudeVC ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,HindleFromSuperView>

/**数据源*/
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger shop_id;

@property (nonatomic, strong) UICollectionView *col;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UIButton *scrowTop;
/**提示文字*/
@property (nonatomic, strong) UILabel *promoptLabel;

@end


@implementation HGloryAptitudeVC

- (UILabel *)promoptLabel{
    if (_promoptLabel == nil) {
        _promoptLabel = [[UILabel alloc] init];
        [self.view addSubview:_promoptLabel];
        [_promoptLabel configmentfont:[UIFont boldSystemFontOfSize:15 * SCALE] textColor:[UIColor colorWithHexString:@"999999"] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:0 text:@"亲， 店家没有资质"];
    }
    return _promoptLabel;
}

- (UICollectionViewFlowLayout *)flowLayout{
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [_flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    }
    return _flowLayout;
}

- (UICollectionView *)col{
    if (_col == nil) {
        _col = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.startY, screenW, screenH - self.startY) collectionViewLayout:self.flowLayout];
        _col.delegate = self;
        _col.dataSource = self;
        [_col registerClass:[HStoreAptiudeItem class] forCellWithReuseIdentifier:@"HStoreAptiudeItem"];
        [self.view addSubview:_col];
    }
    return _col;
}

- (UIButton *)scrowTop{
    if (_scrowTop == nil) {
        _scrowTop = [[UIButton alloc] init];
        [self.view addSubview:_scrowTop];
        [_scrowTop addTarget:self action:@selector(scrowToTop:) forControlEvents:UIControlEventTouchUpInside];
        [_scrowTop setBackgroundImage:[UIImage imageNamed:@"btn_Top"] forState:UIControlStateNormal];
        _scrowTop.hidden = YES;
    }
    return _scrowTop;
}
/**滑动到顶部*/
- (void)scrowToTop:(UIButton *)btn{
    
    [self.col scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HStoreAptiudeItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HStoreAptiudeItem" forIndexPath:indexPath];
    
    cell.aptutudeModel = self.dataArray[indexPath.item];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    HStoreAptitudeModel *model = self.dataArray[indexPath.item];
    
    if (model.width && model.height) {
        CGFloat width = [model.width floatValue];
        CGFloat height = [model.height floatValue];
        CGFloat proport = height/width;
        return CGSizeMake(screenW, proport * screenW);
    }else{
        return CGSizeMake(screenW, screenW);
    }
        
  
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(10, 0, 0, 0);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    BrowsePicturesView *collection = [[BrowsePicturesView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH) withIndexPath:indexPath withArr:self.dataArray];
    collection.delegate = self;
    [window addSubview:collection];
}







- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(messageCountChanged) name:MESSAGECOUNTCHANGED object:nil];

    self.automaticallyAdjustsScrollViewInsets = NO;
    NSString *shopID = self.keyParamete[@"paramete"];
    self.shop_id = [shopID integerValue];
    self.sellerUser = self.keyParamete[@"sellerUser"];

    [self configmentUI];

    
    [self requestData];
    
    
        // Do any additional setup after loading the view.
}
#pragma mark -- 请求数据
- (void)requestData{
    [[UserInfo shareUserInfo]gotSHopAptitudeDataWithShopID:self.shop_id success:^(ResponseObject *responseObject) {
        [self analyseDatawith:responseObject];
        LOG(@"%@,%d,%@",[self class], __LINE__,responseObject.data)
        [self.col reloadData];
    } failure:^(NSError *error) {
        [self showTheViewWhenDisconnectWithFrame:CGRectMake(0, self.startY, screenW, screenH - self.startY)];
    }];
}
#pragma mark -- 分析数据
- (void)analyseDatawith:(ResponseObject*)responseObject{
    if (![responseObject.data isKindOfClass:[NSNull class]]) {
        NSLog(@"%@, %d ,%@",[self class],__LINE__,responseObject.data);

        if ([responseObject.data isKindOfClass:[NSArray class]]) {
            if ([responseObject.data count] == 0) {
                self.promoptLabel.frame = CGRectMake(0, self.startY, screenW, screenH - self.startY);
                
            }
            
            for (NSDictionary *dic in responseObject.data) {
                LOG(@"%@,%d,%@",[self class], __LINE__,dic[@"items"])
                if (dic[@"items"] && [dic[@"items"] isKindOfClass:[NSArray class]]) {
                    
                    NSArray *data = dic[@"items"];
                    for (NSDictionary *dict in data) {
                        HStoreAptitudeModel *aptutudeModel = [HStoreAptitudeModel mj_objectWithKeyValues:dict];
                        [self.dataArray addObject:aptutudeModel];
                    }
                    if (self.dataArray.count == 0) {
                        self.promoptLabel.frame = CGRectMake(0, self.startY, screenW, screenH - self.startY);
                    }
                }else{
                    self.promoptLabel.frame = CGRectMake(0, self.startY, screenW, screenH - self.startY);
                }
                
            }
        }
    }else{
        self.promoptLabel.frame = CGRectMake(0, self.startY, screenW, screenH - self.startY);
    }
    
}
/**有选择的挑选数据加入数据源中*/
- (BOOL)selectWantDataAddDataArrayWithKey:(NSString *)key{
    if ([key isEqualToString:@"qualification"]) {
        return YES;
    }else if ([key isEqualToString:@"nav"]) {
        return YES;
    }else if ([key isEqualToString:@"active"]) {
        return YES;
    }else if ([key isEqualToString:@"coupons"]) {
        return YES;
    }else if ([key isEqualToString:@"goods"]) {
        return YES;
    }
    return NO;
}

- (void)configmentUI{
    self.col.backgroundColor = BackgroundGray;
    
}


#pragma mark -- 消失
- (void)hindleView:(BrowsePicturesView *)gcollection{
    [gcollection removeFromSuperview];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark --  设置导航栏中间的view
- (void)configmentMidleView{
    self.naviTitle = @"荣誉资质";
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
