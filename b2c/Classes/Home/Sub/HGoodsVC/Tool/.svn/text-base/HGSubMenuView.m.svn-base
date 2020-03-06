//
//  HGSubMenuView.m
//  b2c
//
//  Created by 0 on 16/5/18.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HGSubMenuView.h"
#import "HGSubMenuCell.h"
@interface HGSubMenuView()
@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, assign) CGRect  menuFrame;
@end
@implementation HGSubMenuView
- (UITableView *)menuTable{
    if (_menuTable == nil) {
        _menuTable = [[UITableView alloc] initWithFrame:CGRectMake(self.frame.size.width -self.menuFrame.size.width - 10, 8.5, self.menuFrame.size.width, self.menuFrame.size.height -8.5) style:UITableViewStylePlain];
        [self addSubview:_menuTable];
        _menuTable.delegate = self;
        _menuTable.dataSource = self;
        _menuTable.layer.cornerRadius = 6;
        _menuTable.layer.masksToBounds = YES;
        _menuTable.bounces = NO;
        _menuTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _menuTable.showsVerticalScrollIndicator = NO;
        [_menuTable registerClass:[HGSubMenuCell class] forCellReuseIdentifier:@"HGSubMenuCell"];
    }
    return _menuTable;
}
- (UIImageView *)topImage{
    if (_topImage == nil) {
        _topImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width -40, 0, 14, 8.5)];
        [self addSubview:_topImage];
        _topImage.image = [UIImage imageNamed:@"bg_more_triangle"];
    }
    return _topImage;
}




- (instancetype)initWithFrame:(CGRect)frame withDataArr:(NSArray *)menuArr backFrame:(CGRect)backFrame{
    self = [super initWithFrame:backFrame];
    if (self) {
        self.menuFrame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
        self.arr = menuArr;
        self.topImage.backgroundColor = [UIColor clearColor];
        self.menuTable.backgroundColor = [UIColor clearColor];
        [self addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HGSubMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HGSubMenuCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.menuTitle.text = self.arr[indexPath.row];
    if (self.arr.count == (indexPath.row +1)) {
        cell.lineView.backgroundColor = [[UIColor colorWithHexString:@"000000"] colorWithAlphaComponent:0.6];
        
    }else{
        cell.lineView.backgroundColor =[UIColor clearColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"哈哈")
    if ([self.delegate respondsToSelector:@selector(HGSubMenuViewActionToTatargWithIndexPath:)]) {
        [self.delegate performSelector:@selector(HGSubMenuViewActionToTatargWithIndexPath:) withObject:indexPath];
    }
}
- (void)click:(ActionBaseView *)action{
    [self removeFromSuperview];
}



@end
