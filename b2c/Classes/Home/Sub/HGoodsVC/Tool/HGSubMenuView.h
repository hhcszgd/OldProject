//
//  HGSubMenuView.h
//  b2c
//
//  Created by 0 on 16/5/18.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//子菜单
@protocol HGSubMenuViewDelegate <NSObject>
/**根据跳转到指定的页面*/
- (void)HGSubMenuViewActionToTatargWithIndexPath:(NSIndexPath *)indexPath;

@end
#import <UIKit/UIKit.h>

@interface HGSubMenuView : ActionBaseView<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *menuTable;
- (instancetype)initWithFrame:(CGRect)frame withDataArr:(NSArray *)menuArr backFrame:(CGRect)backFrame;
@property (nonatomic, strong) UIImageView  *topImage;
@property (nonatomic, weak) id <HGSubMenuViewDelegate>delegate;
@end
