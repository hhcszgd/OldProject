//
//  HSingleadsCell.m
//  b2c
//
//  Created by wangyuanfei on 4/11/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "HSingleadsCell.h"

#import "HCellBaseComposeView.h"


#import "HColorfulSubItem.h"
@interface HSingleadsCell()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) HCellModel *privateModel;
/***/
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *page;
@property(nonatomic,strong)NSTimer * timer ;


@end
@implementation HSingleadsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 6, screenW, 340.0/750.0 * screenW) collectionViewLayout:flowLayout];
        [self.contentView addSubview:self.collectionView];
        flowLayout.minimumLineSpacing = 0;
        CGFloat width = screenW;
        CGFloat height = 340.0/750.0 * screenW;
        flowLayout.itemSize = CGSizeMake(width, height);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self.collectionView registerClass:[HColorfulSubItem class] forCellWithReuseIdentifier:@"HColorfulSubItem"];
        [self.collectionView setShowsHorizontalScrollIndicator:NO];
        [self.collectionView setPagingEnabled:YES];
        [self.page mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
            make.height.equalTo(@(20));
        }];
        
        
    }
    return self;
}
- (UIPageControl *)page{
    if (_page == nil) {
        _page = [[UIPageControl alloc] init];
        [self.contentView addSubview:_page];
        
        [_page setValue:[UIImage imageNamed:@"lunbo"]forKey:@"pageImage"];
        [_page setValue:[UIImage imageNamed:@"xuanzhong"] forKey:@"currentPageImage"];
    }
    return _page;
}
-(void)addTimer{
    if (self.timer == nil) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(startRoll) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    
    ///////////
    // LOG(@"_%d_%@",__LINE__,@"添加了定时器");
}
-(void)removeTimer{
    [self.timer invalidate];
    self.timer=nil;
    // LOG(@"_%d_%@",__LINE__,@"移除了定时器");
}
-(void)startRoll
{
    
    
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    //     LOG(@"_%d_%@",__LINE__,self.timer);
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:1];
    [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    NSInteger nextItem = currentIndexPathReset.item +1;
    NSInteger nextSection = currentIndexPathReset.section;
    if (nextItem==self.cellModel.items.count) {
        nextItem=0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    self.page.currentPage= nextIndexPath.item;
    //  LOG(@"*_* %d *_*%@",__LINE__,nextIndexPath);
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.privateModel.items.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HColorfulSubItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"HColorfulSubItem" forIndexPath:indexPath];
    item.composeModel = self.privateModel.items[indexPath.item];
    return item;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HCellComposeModel *composeModel = self.privateModel.items[indexPath.item];
    if (composeModel.value.length > 0) {
        if ([composeModel.actionKey isEqualToString:@"BaseWebVC"]) {
            
            composeModel.keyParamete=@{@"paramete":composeModel.value};
            
        }else if ([composeModel.actionKey isEqualToString:@"HShopVC"]){
            composeModel.keyParamete=@{@"paramete":composeModel.value};
        }else if ([composeModel.actionKey isEqualToString:@"HGoodsVC"]){
            composeModel.keyParamete=@{@"paramete":composeModel.value};
        }else if ([composeModel.actionKey isEqualToString:@"HSearchgoodsListVC"]){
            composeModel.keyParamete = @{@"paramete":composeModel.value};
        }
    }
    
    
    
    NSDictionary * pragma = @{
                              @"HCellComposeViewModel":composeModel
                              };
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HCellComposeViewClick" object:nil userInfo:pragma];
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"HCellComposeViewClick" object:nil userInfo:@{@"IndividualCellComposeViewModel": }]; 
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{//只有手动拖的时候才会被调用
    NSInteger i = self.cellModel.items.count * 2;
    if (scrollView.contentOffset.x >= (i* screenW)) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:1] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }
    NSInteger j = self.cellModel.items.count - 1;
    if (scrollView.contentOffset.x <= (j * screenW)) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:j inSection:1] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }

    NSInteger k = (NSInteger)(scrollView.contentOffset.x/screenW) - self.cellModel.items.count;
    self.page.currentPage = k;
    
}

-(void)setCellModel:(HCellModel *)cellModel{
    [super setCellModel:cellModel];
    self.privateModel = cellModel;
    [self.collectionView reloadData];
    
    [self.collectionView setScrollEnabled:NO];
    if (cellModel.items && (cellModel.items.count > 1)) {
        [self addTimer];
        [self.collectionView setScrollEnabled:YES];
        
        NSInteger i = cellModel.items.count;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.collectionView.contentOffset = CGPointMake(i * screenW, 0);
        });
        self.page.numberOfPages = cellModel.items.count;
    }else{
        [self removeTimer];
        [self.collectionView setScrollEnabled:NO];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.collectionView.contentOffset = CGPointMake(0, 0);
        });
        self.page.numberOfPages = 0;
        
    }
   
    
}
@end











































////
////  HSingleadsCell.m
////  b2c
////
////  Created by wangyuanfei on 4/11/16.
////  Copyright © 2016 www.16lao.com. All rights reserved.
////
//
//#import "HSingleadsCell.h"
//
//#import "HCellBaseComposeView.h"
//
//@interface HSingleadsCell()
//
//@property(nonatomic,weak) HCellBaseComposeView *  container;
//@end
//
//@implementation HSingleadsCell
//
///*
//// Only override drawRect: if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//}
//*/
//
//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        
//        
//        
//        HCellBaseComposeView * container = [[HCellBaseComposeView alloc]init];
//        self.container = container;
//        [container addTarget:self action:@selector(composeClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:container];
////        container.backgroundColor = randomColor;
//        //        self.bottomContainer.backgroundColor= randomColor;
//        
//        
//        CGFloat topImageViewH = 93*SCALE ;
//        CGFloat totalTopMargin = 11*SCALE ;
//        
//        [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.contentView).offset(totalTopMargin);
//            make.left.right.equalTo(self.contentView);
//            make.height.equalTo(@(topImageViewH));
//        }];
//        
//        
//        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.equalTo(self);
//            make.bottom.equalTo(self.container);//(totalTopMargin);
//        }];
//
//    }
//    return self;
//}
//
//-(void)composeClick:(HCellBaseComposeView*)sender
//{
//    if (sender.composeModel) {
//        if (sender.composeModel) {
//            //        sender.composeModel.actionKey=@"BaseWebVC";
//            if ([sender.composeModel.actionKey isEqualToString:@"BaseWebVC"]) {
//                sender.composeModel.keyParamete=@{@"paramete":sender.composeModel.link};
//                
//                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"调网页");
//            }else if ([sender.composeModel.actionKey isEqualToString:@"HShopVC"]){
//                /**   model.keyParamete=@{@"paramete":model.shop_id}; */
//                sender.composeModel.keyParamete=@{@"paramete":sender.composeModel.link};
//                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"调店铺");
//            }else if ([sender.composeModel.actionKey isEqualToString:@"HGoodsVC"]){
//                sender.composeModel.keyParamete=@{@"paramete":sender.composeModel.link};
//                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"调详情");
//            }
//            
//            LOG(@"_%@_%d_首页轮播图的actionKey是 --> %@",[self class] , __LINE__,sender.composeModel.actionKey);
//            
//            NSDictionary * pragma = @{
//                                      @"HCellComposeViewModel":sender.composeModel
//                                      };
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"HCellComposeViewClick" object:nil userInfo:pragma];
//        }
//        
//        
//        
//        
////        
////        LOG(@"_%@_%d_首页 单张广告图的actionKey 是 -->%@",[self class] , __LINE__,sender.composeModel.actionKey);
////        sender.composeModel.actionKey=@"BaseWebVC";
////        
////        
////        
////        
////        
////        
////        if (sender.composeModel.link.length>0) {
////            sender.composeModel.keyParamete=@{@"paramete":sender.composeModel.link};
////        }else{
////            sender.composeModel.keyParamete = @{
////                                                @"paramete":@"https://m.baidu.com/?from=844b&vit=fps"
////                                                };
////        }
//  
//        
//    }
//    //    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.composeModel.actionKey)
//}
//-(void)setCellModel:(HCellModel *)cellModel{
//    [super setCellModel:cellModel];
//    self.container.composeModel = cellModel.items.firstObject;
//
//    self.container.backImageURLStr = self.container.composeModel.imgStr;
//
//
//
//    
//}
//@end
