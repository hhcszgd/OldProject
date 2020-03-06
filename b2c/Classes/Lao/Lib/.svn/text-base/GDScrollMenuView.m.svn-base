//
//  GDScrollMenuView.m
//  NewsDemo
//
//  Created by wangyuanfei on 2/26/16.
//  Copyright © 2016 wy. All rights reserved.
//

#import "GDScrollMenuView.h"
#import "MyCollectionViewCell.h"
#define channelW (self.scrollView.contentSize.width/self.channels.count)
#define MAXSCALE  1.7
#define blablabla (MAXSCALE-1)
//#define composeW 80
#define myCollectionWidth self.myCollectionView.bounds.size.width
//#define contentCollectionView myCollectionView
@interface GDScrollMenuView ()<UICollectionViewDelegate,UICollectionViewDataSource>
/** item 和 菜单选项的个数 */
@property(nonatomic,assign)NSInteger  count ;
/** 上一个按钮 */
@property(nonatomic,weak)UIButton * oldBtn ;
/** 当前按钮 */
@property(nonatomic,weak)UIButton * currentChannelLabel ;
/** 上一个item对应的偏移量 */
@property(nonatomic,assign)CGPoint  contentCollectionViewOldOffset ;
/** 当前按钮的上一个按钮 */
@property(nonatomic,weak)      UIButton * leftChannelLabel;
/** 当前按钮的下一个按钮 */
@property(nonatomic,weak)  UIButton * rightChannelLabel;
@property(nonatomic,assign)BOOL  isMAX ;
/** 滑动条 */
@property(nonatomic,weak)UIView * slider ;
@end

@implementation GDScrollMenuView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor grayColor];
        UIScrollView * scrollView = [[UIScrollView alloc]init];
        self.scrollView=scrollView;
        [scrollView setScrollEnabled:YES];
        [self addSubview:self.scrollView];
        

            }
    return self;
}
-(CGFloat)composeW{
    if (_composeW==0) {
        _composeW=80;
    }
    return _composeW ;
}

-(CGSize)sliderSize{
    if (_sliderSize.width== 0 || _sliderSize.height ==0) {
        _sliderSize = CGSizeMake(66, 2);
    }
    return _sliderSize;
}
-(void)setupMyCollectionView
{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGRect rect = [self.GDaDtaSource collectionFrameInscrollMenuView:self];
    layout.itemSize = CGSizeMake(rect.size.width ,rect.size.height);
    layout.minimumLineSpacing=0;
    layout.minimumInteritemSpacing=0;
    UICollectionView * collectinView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    collectinView.dataSource=self;
    self.myCollectionView=collectinView;
    collectinView.showsHorizontalScrollIndicator = NO ;
    collectinView.pagingEnabled=YES;
    collectinView.delegate=self;
    collectinView.bounces=NO;
    collectinView.backgroundColor = [UIColor redColor];
    [collectinView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    UIViewController * vc = (UIViewController*)self.GDaDtaSource;
    [vc.view addSubview:collectinView];
}
-(void)setGDaDtaSource:(id<GDScrollMenuViewDataSource>)GDaDtaSource{
    _GDaDtaSource = GDaDtaSource ;
    
    for (int i = 0 ; i<self.count; i++) {
        if ([self.GDaDtaSource  respondsToSelector:@selector(titleOfEveryoneInMenuView:index:)]) {
            UIButton * channelLabel = [[UIButton alloc]init];
            [channelLabel setTitle:[self.GDaDtaSource titleOfEveryoneInMenuView:self  index:i] forState:UIControlStateNormal];
            if ([self.GDaDtaSource respondsToSelector:@selector(imageOfEveryoneInMenuView:index:)]) {
                [channelLabel setImage:[self.GDaDtaSource imageOfEveryoneInMenuView:self index:i] forState:UIControlStateNormal];
            }
            [channelLabel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.scrollView addSubview:channelLabel];
            [channelLabel addTarget:self action:@selector(currentbuttonClick:) forControlEvents:UIControlEventTouchUpInside];
            channelLabel.tag = i;
        }
    }
    
    //添加////////////////////////
    UIView * slider = [[UIView alloc]init];
    self.slider = slider;
    [self.scrollView addSubview:slider];
    slider.backgroundColor = THEMECOLOR;
    slider.bounds = CGRectMake(0, 0, self.sliderSize.width, self.sliderSize.height);
    
    //////////////////
    
    
    self.scrollView.contentSize = CGSizeMake(self.count*self.composeW, 0);
    self.currentIndex=0;
    [self setupMyCollectionView];
    [self setupFrame];

}
-(void)setupFrame
{
    self.scrollView.frame= self.bounds;
    for (int i = 0 ; i<self.count; i++) {
        if ([self.GDaDtaSource  respondsToSelector:@selector(titleOfEveryoneInMenuView:index:)]) {
            UIButton * channelLabel = self.scrollView.subviews[i];
            CGFloat channelLabelW = self.composeW;
            CGFloat channelLabelH = self.bounds.size.height*0.6;
            CGFloat channelLableY = (self.bounds.size.height - channelLabelH)*0.5;
            CGFloat channelLableX = 0;
            channelLableX = i * channelLabelW;
            channelLabel.frame = CGRectMake(channelLableX, channelLableY, channelLabelW, channelLabelH);
        }
    }
    self.myCollectionView.frame=[self.GDaDtaSource collectionFrameInscrollMenuView:self];
    self.slider.center = CGPointMake(self.composeW/2, self.scrollView.bounds.size.height-self.slider.bounds.size.height/2);
}
#pragma mark 点击按钮

-(void)currentbuttonClick:(UIButton *)sender
{
    self.currentIndex = sender.tag;
    if ([self.GDaDtaSource respondsToSelector:@selector(scrollMenuView:WithTargetIndex:oldIndex:)]) {
        [self.GDaDtaSource scrollMenuView:self WithTargetIndex:_currentIndex oldIndex:self.oldBtn.tag];
    }

    [self.myCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:sender.tag inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];//改变相应item的偏移量, 再反过来利用偏移量来改变来改变scrollView的偏移量 , 接着看scrollViewDidScroll:这个方法的执行

}
-(NSInteger)count{
    if ([self.GDaDtaSource respondsToSelector:@selector(numberOfComposeInScrollMenuView:)]) {
        _count = [self.GDaDtaSource numberOfComposeInScrollMenuView:self];
        return _count;
    }else{
        return 0;
    }

}


#pragma CollectionViewDatasource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.count;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyCollectionViewCell * cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.item%2==0) {
        cell.backgroundColor = [UIColor greenColor];
    }else{
        cell.backgroundColor= [UIColor redColor];
    }
    if ([self.GDaDtaSource respondsToSelector:@selector(contentViewInScrollMenuView:index:)]) {
        cell.showView = [self.GDaDtaSource contentViewInScrollMenuView:self index:indexPath.item];
    }
    cell.backgroundView.userInteractionEnabled=YES;
    return cell;
}

#pragma collectionDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if (!self.isMAX) {
        [self trendsChangeChannelSize];//手动点击频道时调用这个方法  ,利用collection的contentoffset 和比例系数去改变channelScrollview的偏移量
//    }
}

-(void)trendsChangeChannelSize//动态改变频道的大小
{
    CGFloat index =(self.myCollectionView.contentOffset.x/self.myCollectionView.bounds.size.width);
    if (index<0||index==0) {
        index=0;
    }else if (index>self.count-1||index==self.count-1){
        index=self.count-1;
    }
    if (fabs(self.myCollectionView.contentOffset.x/self.myCollectionView.bounds.size.width-self.currentIndex)>1||fabs(self.myCollectionView.contentOffset.x/self.myCollectionView.bounds.size.width-self.currentIndex)==1) {//又滚了一个collectionView的宽度
         NSLog(@"_%d_%@",__LINE__,@"又滚了一瓶");
        self.currentIndex = (int)index;
    }
    float offset=  (self.myCollectionView.contentOffset.x - self.contentCollectionViewOldOffset.x)/myCollectionWidth;//滚动一个item宽度的比例

    self.slider.center = CGPointMake(self.currentChannelLabel.tag * self.composeW+self.composeW/2 + self.composeW*offset, self.scrollView.bounds.size.height-self.slider.bounds.size.height/2);
    
}

-(void)trendsChangeChannelsViewOffset//动态滚动channelView
{
    CGPoint channelViewCurrentOffset;
    if (self.isMAX) {
        channelViewCurrentOffset = CGPointMake(self.composeW*self.currentIndex, 0);
    }else{
    
        channelViewCurrentOffset = CGPointMake(self.scrollView.contentSize.width/ self.myCollectionView.contentSize.width*self.myCollectionView.contentOffset.x, 0);
    }
    
    
    CGPoint headerCriticalPoint = CGPointMake(self.scrollView.bounds.size.width/2-self.composeW/2, 0);
    CGPoint tailCriticalPoint =CGPointMake( self.scrollView.contentSize.width-self.scrollView.bounds.size.width+self.scrollView.bounds.size.width/2-self.composeW/2,0);
    CGPoint targetPoint ;
    if (channelViewCurrentOffset.x>headerCriticalPoint.x && channelViewCurrentOffset.x<tailCriticalPoint.x) {
        
        targetPoint =CGPointMake(channelViewCurrentOffset.x-self.scrollView.bounds.size.width/2+self.composeW/2, 0);
    }else if(channelViewCurrentOffset. x<headerCriticalPoint.x){
        targetPoint =CGPointMake(0,0);
    }else if(channelViewCurrentOffset. x>tailCriticalPoint.x){
        targetPoint =CGPointMake(self.scrollView.contentSize.width-self.scrollView.bounds.size.width, 0);
    }
//    if (self.isMAX) {
        [UIView animateWithDuration:0.5 animations:^{
            self.scrollView.contentOffset=targetPoint;
//            self.slider.center = targetPoint;//添加
        }];
//    }else{

    
//        self.scrollView.contentOffset=targetPoint;
//        self.slider.center = targetPoint;//添加
//    }
//     self.isMAX=NO;
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self trendsChangeChannelsViewOffset];
}

-(void)setCurrentIndex:(NSInteger)currentIndex{
    self.oldBtn=self.scrollView.subviews[self.currentIndex];

    if (currentIndex==0||currentIndex<0) {
        _currentIndex = 0 ;
        self.leftChannelLabel = nil;
        self.rightChannelLabel = self.scrollView.subviews[self.currentIndex+1];
        
    }else if (currentIndex==self.count-1||currentIndex>self.count-1){
        _currentIndex = self.count-1;
        self.rightChannelLabel=nil;
        self.leftChannelLabel=self.scrollView.subviews[self.currentIndex-1];
    }else{
        _currentIndex = currentIndex;
        self.leftChannelLabel  = self.scrollView.subviews[self.currentIndex-1];
        self.rightChannelLabel  = self.scrollView.subviews[self.currentIndex+1];
    }
    self.contentCollectionViewOldOffset =CGPointMake( myCollectionWidth*self.currentIndex, 0)      ;
    self.currentChannelLabel=self.scrollView.subviews[self.currentIndex];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    self.contentCollectionViewOldOffset =self.myCollectionView.contentOffset;
        NSLog(@"滚完");
    [self trendsChangeChannelsViewOffset];
}

@end
