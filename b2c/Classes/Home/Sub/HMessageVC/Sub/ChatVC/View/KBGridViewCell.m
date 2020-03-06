//
//  KBGridViewCell.m
//  b2c
//
//  Created by wangyuanfei on 7/24/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
/**
 每一页表情的cell
 */

#import "KBGridViewCell.h"
#import "BrowCell.h"
#import "BlankCell.h"
#import "KDeleteCell.h"
@interface KBGridViewCell()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,weak)UICollectionView * browContainer ;
//@property(nonatomic,weak)UIButton * deleteButton ;


@end


@implementation KBGridViewCell

NSUInteger hang = 4;
NSUInteger lie = 6 ;
NSUInteger browCountInOnePage = 24 ;



-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = randomColor;
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 0 ;
        layout.minimumInteritemSpacing=0 ;
//        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        //        layout.itemSize =
        layout.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
        UICollectionView * topBrowContainer = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        topBrowContainer.showsHorizontalScrollIndicator=YES;
        topBrowContainer.backgroundColor = [UIColor whiteColor];
        
        topBrowContainer.pagingEnabled = YES;
        [self.contentView addSubview:topBrowContainer];
        topBrowContainer.dataSource = self;
        topBrowContainer.delegate  =  self ;
        [topBrowContainer registerClass:[BrowCell class ] forCellWithReuseIdentifier:@"BrowCell"];
        [topBrowContainer registerClass:[BlankCell class ] forCellWithReuseIdentifier:@"BlankCell"];
        [topBrowContainer registerClass:[KDeleteCell class ] forCellWithReuseIdentifier:@"KDeleteCell"];
        self.browContainer = topBrowContainer;
//        UIButton * deleteButton = [[UIButton alloc]init];
//        self.deleteButton = deleteButton;
//        [self.contentView  addSubview:deleteButton];
//        [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
//        [deleteButton setTitleColor:SubTextColor forState:UIControlStateNormal];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    UICollectionViewFlowLayout * layout =  (UICollectionViewFlowLayout * )self.browContainer.collectionViewLayout;
    layout.itemSize = CGSizeMake(self.bounds.size.width/lie, self.bounds.size.height/hang);
    self.browContainer.frame = self.bounds;
//    self.deleteButton.frame = CGRectMake( self.browContainer.bounds.size.width-self.bounds.size.width/lie, self.browContainer.bounds.size.height-  self.bounds.size.height/hang  , self.bounds.size.width/lie, self.bounds.size.height/hang);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
//    if (self.groupBrows.count%23==0) {
//        return self.groupBrows.count/23+1;
//        
//    }else{
//        return self.groupBrows.count/23 +1;
//    }
   
    return self.groupBrows.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    NSInteger groupCount =  self.groupBrows.count/23 ;
//    if (section<=groupCount) {
//        return 23 ;
//    }else{
//        return self.groupBrows.count%23;
//    }
//    return 24 ;
    LOG(@"_%@_%d_%ld",[self class] , __LINE__,[self.groupBrows[section] count]);
    return [self.groupBrows[section] count];

}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    NSInteger groupCount =  self.groupBrows.count/23 ;
    UICollectionViewCell * cell = nil ;
//    BrowCell *  browCell = ( BrowCell * )cell;
    id model  = self.groupBrows[indexPath.section][indexPath.item];
    if ([model isKindOfClass:[NSDictionary class]]) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BrowCell" forIndexPath:indexPath];
        BrowCell *  browCell = ( BrowCell * )cell;
        browCell.browDict=model;
    }else if([model isKindOfClass:[NSString class]]){
        if ([model isEqualToString:@"delete"]) {
             cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KDeleteCell" forIndexPath:indexPath];
        }else if ([model isEqualToString:@"blank"]){
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BlankCell" forIndexPath:indexPath];
        }
    }

    return cell;
}
-(void)setGroupBrows:(NSArray *)groupBrows{
//    _groupBrows = groupBrows;
    NSInteger sections = groupBrows.count/(browCountInOnePage-1) +1 ;
    NSInteger lastSectionItems = groupBrows.count%(browCountInOnePage-1) ;
    NSMutableArray * bigArr = [NSMutableArray arrayWithCapacity:sections];
    for (int i =0; i< sections; i++) {
        if (i<sections-1) {//前三组
            NSMutableArray * arr = [groupBrows subarrayWithRange:NSMakeRange(i*(browCountInOnePage-1), (browCountInOnePage-1))].mutableCopy;
            [arr addObject:@"delete"];
            [bigArr addObject:arr];
        }else{//最后一组
            NSMutableArray * arr = [groupBrows subarrayWithRange:NSMakeRange(i*(browCountInOnePage-1), lastSectionItems)].mutableCopy;
            for (int j = 0 ; j<browCountInOnePage - lastSectionItems; j++) {
                if (arr.count<browCountInOnePage-1) {
                    
                    [arr addObject:@"blank"];
                }else{
                    [arr addObject:@"delete"];
                }
            }
            [bigArr addObject:arr];
        }
    }
    _groupBrows = bigArr.copy;
    LOG(@"_%@_%d_%@",[self class] , __LINE__,_groupBrows);
    LOG(@"_%@_%d_个数%ld",[self class] , __LINE__,_groupBrows.count);
    LOG(@"_%@_%d_%ld",[self class] , __LINE__,browCountInOnePage);
}

/** UICollectionViewDelegate */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,indexPath);
     id model  = self.groupBrows[indexPath.section][indexPath.item];
    if (indexPath.item%23==0 && indexPath.item>0) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"执行删除");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CUSTOMDELETE" object:nil];
    }else{
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"输入表情");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"INPUTBROW" object:nil userInfo:model];
    }
}




@end
