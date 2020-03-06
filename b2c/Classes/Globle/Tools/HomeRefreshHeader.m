//
//  HomeRefreshHeader.m
//  TTmall
//
//  Created by wangyuanfei on 2/17/16.
//  Copyright © 2016 Footway tech. All rights reserved.
//

#import "HomeRefreshHeader.h"

@interface HomeRefreshHeader()
@property (weak, nonatomic) UILabel *label;
@property (weak, nonatomic) UISwitch *s;
@property (weak, nonatomic) UIImageView *logo;
@property (weak, nonatomic) UIActivityIndicatorView *loading;

@end


@implementation HomeRefreshHeader

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 88;
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor darkGrayColor];
    label.font = [UIFont boldSystemFontOfSize:10];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;

    UIImageView *logo = [UIImageView  new];
//    NSURL * u =[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"loading.gif" ofType:nil]];
    logo.image = [UIImage sd_animatedGIFNamed:@"loading"];
//    [logo sd_setImageWithURL:u];
//    [logo sd_setImageWithURL:u placeholderImage:nil options:SDWebImageCacheMemoryOnly];

    
    logo.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:logo];
    self.logo = logo;

}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    CGSize  labelSize =  [self.label.text sizeWithFont:self.label.font];
//    self.label.frame = self.bounds;
    CGFloat margin = 10;
    self.label.frame = CGRectMake((self.bounds.size.width-labelSize.width)/2, self.bounds.size.height-labelSize.height-margin, labelSize.width, labelSize.height);
        self.logo.bounds = CGRectMake(0, 0, self.bounds.size.width, 50);
    CGSize logoSize = self.logo.bounds.size;
    self.logo.frame=CGRectMake((self.bounds.size.width-logoSize.width)/2, self.bounds.size.height-labelSize.height-logoSize.height-margin-margin*0.2, logoSize.width, logoSize.height);

//    self.logo.center = CGPointMake(self.mj_w * 0.5, - self.logo.mj_h + 30);
    
//    self.loading.center = CGPointMake(self.mj_w - 30, self.mj_h * 0.5);
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    /**
     普通闲置状态
    MJRefreshStateIdle = 1,
   松开就可以进行刷新的状态
    MJRefreshStatePulling,
    正在刷新中的状态
    MJRefreshStateRefreshing,
   即将刷新的状态
    MJRefreshStateWillRefresh,
   所有数据加载完毕，没有更多的数据了
    MJRefreshStateNoMoreData
     */
    switch (state) {
        case 1:
            [self.loading stopAnimating];
            [self.s setOn:NO animated:YES];
            self.label.text = @"下拉刷新";
            self.logo.hidden = YES;
            break;
        case 2:
            [self.loading stopAnimating];
            [self.s setOn:YES animated:YES];
            self.label.text = @"松开立即刷新";
            self.logo.hidden = YES;
            break;
        case 3:
            [self.s setOn:YES animated:YES];
            self.label.text = @"正在刷新...";
            [self.loading startAnimating];
            self.logo.hidden = NO ;
            break;
        default:
            break;
    }
    [self.label sizeToFit];
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    // 1.0 0.5 0.0
    // 0.5 0.0 0.5
//    CGFloat red = 1.0 - pullingPercent * 0.5;
//    CGFloat green = 0.5 - 0.5 * pullingPercent;
//    CGFloat blue = 0.5 * pullingPercent;
//    self.label.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
