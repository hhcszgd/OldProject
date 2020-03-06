//
//  PTableView.m
//  b2c
//
//  Created by wangyuanfei on 3/26/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "PTableView.h"
#import "PTableHeaderView.h"
#import "PTableHeaderModel.h"
@interface PTableView()<PTableHeaderViewDelegate>
//@property(nonatomic,assign)CGSize  trueSize ;
@property(nonatomic,assign)CGSize  tableHeaderContainerViewSize ;
@property(nonatomic,weak)PTableHeaderView * tempTableHeader ;

@end

@implementation PTableView

-(CGSize )tableHeaderContainerViewSize{
    return CGSizeMake(screenW, 225*SCALE);
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self=[super initWithFrame:frame style:style]) {
        

        PTableHeaderView * header  =  [[PTableHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.tableHeaderContainerViewSize.width, self.tableHeaderContainerViewSize.height)];
        header.TableHeaderDelegate = self;
        self.tempTableHeader = header;
        self.tableHeaderView= header;
        self.separatorStyle=UITableViewCellSeparatorStyleNone;
        self.showsVerticalScrollIndicator=NO;
        self.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 0.000001)];//防止底部留白
        self.sectionFooterHeight=0.00000001;//防止底部留白

    }
    return self;
}
//-(void)actionWithTableHeaderComponent:(ActionBaseView *)sender{
//    if ([self.PTableViewDelegate respondsToSelector:@selector(actionWithTableViewComponent:)]) {
//        [self.PTableViewDelegate actionWithTableViewComponent:sender];
//    }
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,sender.model.actionKey)
//
//}
-(void)actionWithTableHeaderComponent:(ActionBaseView *)sender{
    if ([self.PTableViewDelegate respondsToSelector:@selector(actionWithModel:)]) {
        [self.PTableViewDelegate actionWithModel:sender.model];
    }
    //    LOG(@"_%@_%d_%@",[self class] , __LINE__,sender.model.actionKey)
    
}

-(void)setTableHeaderModel:(PTableHeaderModel *)tableHeaderModel{
    _tableHeaderModel=tableHeaderModel;
    self.tempTableHeader.pTableHeaderModel=tableHeaderModel;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
