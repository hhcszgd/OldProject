//
//  HApplianceKingCell.m
//  b2c
//
//  Created by 0 on 16/4/7.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HApplianceKingCell.h"
#import "MultiFunctionVIew.h"
#import "HApplianceKingModel.h"
@interface HApplianceKingCell()

/**数据*/
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, assign) CGFloat width;
@end
@implementation HApplianceKingCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _width = (screenW - 2 *viewInterval - 2 *leadMargin)/3.0;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self configmentUI];
    }
    return self;
}

- (NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

- (void)configmentUI{
    for (NSInteger i = 0; i < 3; i++) {
        MultiFunctionVIew *view = [[MultiFunctionVIew alloc] initWithFrame:CGRectMake(leadMargin +i * viewInterval + i * _width, 0, _width, _width +30)];
        [self.contentView addSubview:view];
        [view addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        [self.dataArr addObject:view];
    }
    
}
- (void)setApplianceModel:(HApplianceModel *)applianceModel{
    _kingModel = (HApplianceKingModel *)applianceModel;
    for (NSInteger i = 0; i < self.dataArr.count; i++) {
        MultiFunctionVIew *functionView = _dataArr[i];
        HApplianceKingModel *appliance = [[HApplianceKingModel alloc] init];
        appliance.judge = NO;
        appliance.imageURl = @"http://a.hiphotos.baidu.com/zhidao/pic/item/bba1cd11728b4710d94aae88c2cec3fdfc032308.jpg";
        appliance.titleStr = @"美的中央空调";
        appliance.priceStr = @"  $12.56";
        
        
        functionView.applianceKingModel = appliance;
        
    }
}
#warning 使用KeyVC进行跳转到商品详情页面
- (void)action:(MultiFunctionVIew *)functionView{
    SecondBaseVC *viewController = [[SecondBaseVC alloc] init];
    HApplianceKingModel *model = (HApplianceKingModel *)functionView.applianceKingModel;
    LOG(@"%@,%d,%@",[self class], __LINE__,model)
    [[KeyVC shareKeyVC] pushViewController:viewController animated:YES];
}

@end

