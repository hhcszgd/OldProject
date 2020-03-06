//
//  TotalOrderRefreshHeader.m
//  b2c
//
//  Created by 0 on 16/4/9.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//


#import "TotalOrderRefreshHeader.h"
@interface TotalOrderRefreshHeader()
/**刷新显示的文字*/
@property (nonatomic, strong) UILabel *textLabel;
/**刷新显示的图片*/
@property (nonatomic, strong) UIImageView *logImage;
/**轻量控件，旋转的小菊花*/
@property (nonatomic, strong) UIActivityIndicatorView *loading;
/**开关标示显示是否在刷新过程中*/
@property (nonatomic, strong) UISwitch *isRefresh;

@end
@implementation TotalOrderRefreshHeader

- (UILabel *)textLabel{
    if (_textLabel == nil) {
        _textLabel = [[UILabel alloc] init];
        [self addSubview:_textLabel];
    }
    return _textLabel;
}
- (UIImageView *)logImage{
    if (_logImage == nil) {
        _logImage = [[UIImageView alloc] init];
        [self addSubview:_logImage];
    }
    return _logImage;
}
#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 90;
    [self.textLabel configmentfont:[UIFont systemFontOfSize:12] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:0 text:@"下拉刷新"];
    
    NSURL *imageURl = [NSURL  fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"cat.gif" ofType:nil]];
    [self.logImage sd_setImageWithURL:imageURl placeholderImage:[UIImage imageNamed:@"accountBiiMap"]options:SDWebImageCacheMemoryOnly];
    self.logImage.contentMode = UIViewContentModeScaleAspectFit;
    
    
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    CGSize  labelSize =  [self.textLabel.text sizeWithFont:self.textLabel.font];
    //    self.label.frame = self.bounds;
    CGFloat margin = 10;
    self.textLabel.frame = CGRectMake((self.bounds.size.width-labelSize.width)/2, self.bounds.size.height-labelSize.height-margin, labelSize.width, labelSize.height);
    self.logImage.bounds = CGRectMake(0, 0, self.bounds.size.width, 50);
    CGSize logoSize = self.logImage.bounds.size;
    self.logImage.frame=CGRectMake((self.bounds.size.width-logoSize.width)/2, self.bounds.size.height-labelSize.height-logoSize.height-margin-margin*0.2, logoSize.width, logoSize.height);

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
           
            self.textLabel.text = @"下拉刷新";
            break;
        case 2:
           
            self.textLabel.text = @"松开立即刷新";
            break;
        case 3:
            
            self.textLabel.text = @"正在刷新";
        
            break;
        default:
            break;
    }
    [self.textLabel sizeToFit];
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



@end
