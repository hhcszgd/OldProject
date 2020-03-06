//
//  HGMoreView.m
//  b2c
//
//  Created by 0 on 16/4/29.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//


#import "HGMoreView.h"
#import "HGSubMenuView.h"
@interface HGMoreView()<HGSubMenuViewDelegate>
/**子菜单栏*/
@property (nonatomic, strong) HGSubMenuView *menu;
/**父控制器*/
@property (nonatomic, weak) SecondBaseVC *fatherVC;
/**数据源*/
@property (nonatomic, strong) NSArray *dataArr;
/**cell的高度*/
@property (nonatomic, assign) CGFloat height;
@end
@implementation HGMoreView
- (UIImageView *)moreView{
    if (_moreView == nil) {
        _moreView = [[UIImageView alloc] init];
        [self addSubview:_moreView];
    }
    return _moreView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *image = [UIImage imageNamed:@"icon_more"];
        self.moreView.frame = CGRectMake((frame.size.width - image.size.width)/2.0, (frame.size.height-image.size.height)/2.0, image.size.width, image.size.height);
        self.moreView.image = image;
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame withDataArr:(NSArray *)menuArr fatherVC:(SecondBaseVC *)vc cellHeihgt:(CGFloat)cellHeight{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *image = [UIImage imageNamed:@"icon_more"];
        self.moreView.frame = CGRectMake((frame.size.width - image.size.width)/2.0, (frame.size.height-image.size.height)/2.0, image.size.width, image.size.height);
        self.moreView.image = image;
        [self addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        self.fatherVC = vc;
        self.dataArr = menuArr;
        self.height = cellHeight;
        
    }
    return self;
}
- (void)click{
    
    if (!self.selected) {
        HGSubMenuView *menuView = [[HGSubMenuView alloc] initWithFrame:CGRectMake(screenW -110, self.fatherVC.startY, 100, self.height * self.dataArr.count + 7.5) withDataArr:self.dataArr backFrame:CGRectMake(0, self.fatherVC.startY, screenW, screenH - self.fatherVC.startY)];
        menuView.menuTable.rowHeight = self.height;
        menuView.delegate = self;
        [self.fatherVC.view addSubview:menuView];
        self.menu = menuView;
        self.selected = YES;
    }else{
        self.selected = NO;
        [self.menu removeFromSuperview];
    }
    LOG(@"%@,%d,%@",[self class], __LINE__,@"弹出商品列表")
}

- (void)HGSubMenuViewActionToTatargWithIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.delegate respondsToSelector:@selector(HGMoreViewActionToTatargWithIndexPath:)]) {
        [self.delegate performSelector:@selector(HGMoreViewActionToTatargWithIndexPath:) withObject:indexPath];
    }
}

@end
