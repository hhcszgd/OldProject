//
//  GDKeyBoard.m
//  b2c
//
//  Created by wangyuanfei on 7/24/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "GDKeyBoard.h"
#import "KBGridViewCell.h"
@interface GDKeyBoard ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,weak)UICollectionView * topBrowContainer ;
@property(nonatomic,weak)UIPageControl * pageControl ;
@end

@implementation GDKeyBoard
//CGFloat
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
//        layout.itemSize = 
        layout.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
        UICollectionView * topBrowContainer = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        topBrowContainer.showsHorizontalScrollIndicator=YES;
        
        topBrowContainer.pagingEnabled = YES;
        [self addSubview:topBrowContainer];
        topBrowContainer.dataSource = self;
        topBrowContainer.delegate  =  self ;
        [topBrowContainer registerClass:[KBGridViewCell class ] forCellWithReuseIdentifier:@"cell"];
        self.topBrowContainer = topBrowContainer;
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    UICollectionViewFlowLayout * layout =  (UICollectionViewFlowLayout * )self.topBrowContainer.collectionViewLayout;
    CGFloat topMargin = 20 ;
    CGFloat bottomMargin = 30 ;
    layout.itemSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height - bottomMargin - topMargin );
    self.topBrowContainer.frame = CGRectMake(0, topMargin, self.bounds.size.width, self.bounds.size.height - bottomMargin - topMargin);
}

//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{return self.allBrowNames.count;}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{return [self.allBrowNames count];}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KBGridViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    NSString * str = (NSString *) self.allBrowNames[indexPath.section][indexPath.item][@"code"];
    cell.groupBrows = self.allBrowNames[indexPath.section];
//    cell.backgroundColor = randomColor;
    return cell;
}

@end
