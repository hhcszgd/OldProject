//
//  HGDetailBaseVC.m
//  b2c
//
//  Created by 0 on 16/4/22.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HGDetailBaseVC.h"
#import "HSepcSubModel.h"
#import "HSepcSubTypeDetailModel.h"
#import "b2c-Swift.h"
@interface HGDetailBaseVC ()<GDMenuBtnDelegate>

@end

@implementation HGDetailBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configmentNa];
    
}

/**设置导航栏*/
- (void)configmentNa{
    //更多按钮
    
    GDMenuBtn *moreBtn = [[GDMenuBtn alloc] initWithFrame:CGRectMake(0, 0, 44, 43) dataArr:@[@{@"image": @"", @"title": @"首页"}, @{@"image": @"", @"title": @"搜索"}, @{@"image": @"", @"title": @"消息"}, @{@"image": @"", @"title": @"收藏"}] point:CGPointMake(screenW - 30 * SCALE, 56)];
    moreBtn.secondFatherVC = self;
    moreBtn.delegate = self;

    self.scroll = [[GNavScroll alloc] initWithFrame:CGRectMake(115 * SCALE, 20, screenW - 110* SCALE -115* SCALE, 44)];
    [self.scroll setScrollEnabled:NO];
    self.scroll.contentSize = CGSizeMake(0, 88);
    self.scroll.showsVerticalScrollIndicator = NO;
    self.titleView.frame = CGRectMake(0, 0, screenW - 225 * SCALE, 44);
    [self.scroll addSubview:self.titleView];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 44, screenW - 225 * SCALE, 44)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:15* SCALE];
    titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    titleLabel.text = @"图文详情";
    [self.scroll addSubview:titleLabel];
    //添加titleView
    self.navigationCustomView = self.scroll;
    
    LOG(@"%@,%d,%@",[self class], __LINE__,self.shopCarBtn)
    self.navigationBarRightActionViews = @[self.shopCarBtn,moreBtn];
}

//跳转到购物车页面
- (void)toShopCar{
    
}

- (void)buy{
    
}
- (void)collection:(UIButton *)btn{
    
}
- (void)consult {
    
}
- (UILabel *)shelvesLabel{
    if (_shelvesLabel == nil) {
        _shelvesLabel = [[UILabel alloc] init];
        [self.view addSubview:_shelvesLabel];
        [_shelvesLabel configmentfont:[UIFont systemFontOfSize:14 * SCALE] textColor:[UIColor whiteColor] backColor:[UIColor colorWithHexString:@"b2b2b2"] textAligement:1 cornerRadius:0 text:@""];
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] init];
        [_shelvesLabel addGestureRecognizer:tap];
        _shelvesLabel.userInteractionEnabled = YES;
    }
    return _shelvesLabel;
}


- (UIButton *)addSHopCar{
    if (_addSHopCar == nil) {
        _addSHopCar = [[UIButton alloc] init];
        [self.view addSubview:_addSHopCar];
        [_addSHopCar setBackgroundColor:[UIColor colorWithHexString:@"ffbc44"]];
        [_addSHopCar setTitle:@"加入购物车" forState:UIControlStateNormal];
        [_addSHopCar setTintColor:[UIColor colorWithHexString:@"ffffff"]];
        _addSHopCar.titleLabel.font = [UIFont systemFontOfSize:15 *SCALE];
        [_addSHopCar addTarget:self action:@selector(addGoodsToShopCar) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addSHopCar;
}
- (void)addGoodsToShopCar{
    
}
- (UIButton *)quickBuy{
    if (_quickBuy == nil) {
        _quickBuy = [[UIButton alloc] init];
        [self.view addSubview:_quickBuy];
        [_quickBuy setBackgroundColor:[UIColor colorWithHexString:@"c456b0"]];
        [_quickBuy addTarget:self action:@selector(buy) forControlEvents:UIControlEventTouchUpInside];
        [_quickBuy setTitle:@"立即购买" forState:UIControlStateNormal];
        _quickBuy.titleLabel.font = [UIFont systemFontOfSize:15 * SCALE];
        [_quickBuy setTintColor:[UIColor colorWithHexString:@"ffffff"]];
        
    }
    return _quickBuy;
}


- (TitleView *)titleView{
    if (_titleView == nil) {
        CGSize statusSize = [[UIApplication sharedApplication] statusBarFrame].size;
        TitleView *titleView = [[TitleView alloc] initWithFrame:CGRectMake(115 * SCALE, statusSize.height, screenW - 110* SCALE -115* SCALE, self.startY - statusSize.height) withTitleArray:@[@"商品",@"详情",@"评价"] withFont:15 ];
        titleView.delegate = self;
        _titleView = titleView;
        
    }
    return _titleView;
}
- (ShopCar *)shopCarBtn{
    if (_shopCarBtn == nil) {
        ShopCar *car = [[ShopCar alloc] initWithFrame:CGRectMake(0, 0, 44, 44) withNum:@"0"];
        [car addTarget:self action:@selector(toShopCar) forControlEvents:UIControlEventTouchUpInside];
        car.numBackColor = [UIColor colorWithHexString:@"c456b0"];
        _shopCarBtn = car;
    }
    return _shopCarBtn;
}

- (UIButton *)collectionBtn{
    if (_collectionBtn == nil) {
        _collectionBtn = [[UIButton alloc] init];
        [self.view addSubview:_collectionBtn];
        _collectionBtn.backgroundColor = [UIColor whiteColor];
        _colsultBtn.adjustsImageWhenHighlighted = NO;
        [_collectionBtn setImage:[UIImage imageNamed:@"icon_earth_collection_nor"] forState:UIControlStateNormal];
        [_collectionBtn setImage:[UIImage imageNamed:@"icon_earth_collection_sel"] forState:UIControlStateSelected];
        
        [_collectionBtn addTarget:self action:@selector(collection:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectionBtn;
}

- (UIButton *)colsultBtn{
    if (_colsultBtn == nil) {
        _colsultBtn = [[UIButton alloc] init];
        [self.view addSubview:_colsultBtn];
        _colsultBtn.backgroundColor = [UIColor whiteColor];
        _colsultBtn.adjustsImageWhenHighlighted = NO;
        //        [_colsultBtn setBackgroundImage:[UIImage imageNamed:@"icon_consult-1"] forState:UIControlStateNormal];
        [_colsultBtn setImage:[UIImage imageNamed:@"icon_goods_consult"] forState:UIControlStateNormal];
        [_colsultBtn addTarget:self action:@selector(consult) forControlEvents:UIControlEventTouchUpInside];
    }
    return _colsultBtn;
}
- (NSMutableArray *)goodsDetailArr{
    if (_goodsDetailArr == nil) {
        _goodsDetailArr = [[NSMutableArray alloc] init];
        
    }
    return _goodsDetailArr;
}
- (NSMutableArray *)goodsInfoDataArr{
    if (_goodsInfoDataArr == nil) {
        _goodsInfoDataArr = [[NSMutableArray alloc] init];
        
    }
    return _goodsInfoDataArr;
}
- (NSMutableArray *)goodsEvluateArr{
    if (_goodsEvluateArr == nil) {
        _goodsEvluateArr = [[NSMutableArray alloc] init];
        
    }
    return _goodsEvluateArr;
}

- (NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}


- (NSMutableArray*)navigationBackArr{
    if (_navigationBackArr == nil) {
        _navigationBackArr = [[NSMutableArray alloc] init];
        
    }
    return _navigationBackArr;
}


- (HSpecSubGoodsDeatilModel *)goodsDetailModel{
    if (_goodsDetailModel == nil) {
        _goodsDetailModel  = [[HSpecSubGoodsDeatilModel alloc] init];
        
        //选中的数量默认是1
        _goodsDetailModel.reserced = @"1";
    }
    return _goodsDetailModel;
}



-(NSMutableArray * )selectIndexPaths{
    if(_selectIndexPaths==nil){
        
        NSMutableArray * arrM = [NSMutableArray arrayWithCapacity:4];
        for (int i = 0 ; i<self.sepcModel.spec.count; i++) {
            HSepcSubModel *subModel = self.sepcModel.spec[i];
            NSIndexPath *indexPath = [[NSIndexPath alloc] init];
            for ( NSInteger j = 0; j < subModel.typeDetail.count ;j++) {
                HSepcSubTypeDetailModel *typeModel = subModel.typeDetail[j];
                if ([typeModel.defaultSelect isEqualToString:@"1"]) {
                    typeModel.isSelect = YES;
                    indexPath = [NSIndexPath indexPathForItem:j inSection:i];
                }else{
                    typeModel.isSelect = NO;
                }
                
            }
            
            [arrM addObject:indexPath];
        }
        
        _selectIndexPaths=arrM;
    }
    return _selectIndexPaths;
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
