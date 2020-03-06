//
//  selectcategaryView.m
//  TTmall
//
//  Created by 0 on 16/1/27.
//  Copyright © 2016年 Footway tech. All rights reserved.
//

#import "HSelectSpecView.h"
#import "FlowLayout.h"
#import "HSpecItem.h"
#import "HSepcModel.h"
#import "HSelectSpecHeader.h"
#import "HSelectSpecFooter.h"
#import "LoginNavVC.h"
#import "b2c-Swift.h"
#import "EditAddressVC.h"

#import "HSepcSubModel.h"
#import "HSepcSubTypeDetailModel.h"
#import "HSpecSubGoodsDeatilModel.h"
#import "HBuyNumberFooter.h"
@interface HSelectSpecView()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIAlertViewDelegate,sizeAndColorDelegate,BuyNumDelegate,UIAlertViewDelegate, EditAddressVCDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UICollectionView *collectionView;

/**头部view*/
@property (nonatomic, assign) typeofView typeOfView;

@property (nonatomic, strong) FlowLayout *flowLayout;



/////////////////////////////////////////////////////////////
/**头部透明按钮*/
@property (nonatomic, weak) UIButton *topHiddenBtn;
@property (nonatomic, weak) UIView *midelView;
@property (nonatomic, weak) UIImageView *goodsImageView;
@property (nonatomic, weak) UIButton *cancleBtn;
@property (nonatomic, weak) UILabel *describeLabel;
@property (nonatomic, weak) UILabel *resetpriceLabel;

@property (nonatomic, strong) HSepcModel *resetSepcModel;
@property (nonatomic, strong) HSpecSubGoodsDeatilModel *resetSpecSubGoodsDetailModel;
@property (nonatomic, weak) UIView *targetView;
@property (nonatomic, assign) BOOL isScreenShot;

@property (nonatomic, assign) NSInteger kSemiModalOverlayTag;
@property (nonatomic, assign) NSInteger KSemiModalSecondOverlayTag;
@property (nonatomic, assign) NSInteger kSemiModalScreenshotTag;

@property (nonatomic, assign) NSInteger kSemiModalModalViewTag;
@property (nonatomic, assign) NSInteger kSemiModalDismissButtonTag;
@property (nonatomic, copy) NSString *researed;
@property (nonatomic, strong) UIButton *resetAddCarBtn;
@property (nonatomic, strong) UIButton *resetBuyBtn;
@property (nonatomic, assign) BOOL isNow;
@property (nonatomic, strong) UIButton *resetTrueBtn;

@end
@implementation HSelectSpecView
- (instancetype)initWithFrame:(CGRect)frame typeofView:(typeofView)type goods_id:(NSString *)goodID{
    self = [super initWithFrame:frame];
    if (self) {
        self.researed = @"1";  
        self.isNow = YES;
        self.kSemiModalOverlayTag = 10001;
        self.kSemiModalScreenshotTag = 10002;
        self.kSemiModalModalViewTag = 10003;
        self.kSemiModalDismissButtonTag = 10004;
        self.KSemiModalSecondOverlayTag = 10005;
        [self presentSemi:goodID];
        self.typeOfView = type;
        [self resetContainer];
    }
    return self;
}
- (void)presentSemi:(NSString *)goods_id{
    if ([self.delegate respondsToSelector:@selector(viewWillDisappear:)]) {
        [self.delegate viewWillDisPlay];
    }
    [[UserInfo shareUserInfo] gotGoodsSpecWithgoods_id:goods_id succes:^(ResponseObject *responseObject) {
        HSepcModel *spec = [HSepcModel mj_objectWithKeyValues:responseObject.data];
         [self filteringTheNullDataInTheDataSource:spec];
        self.resetSepcModel = spec;
        
       
        //如果选中的数组中没有数据
        if (self.resetSelectIndexPath.count < 1) {
            NSLog(@"%@, %d ,%@",[self class],__LINE__,self.resetSelectIndexPath);

            if ([self.delegate respondsToSelector:@selector(viewEndDisPlay)]) {
                [self.delegate viewEndDisPlay];
            }
            AlertInSubview(@"卖家没有设置规格，如购买请联系卖œ家")
            return ;
        }
        for (NSIndexPath *index in self.resetSelectIndexPath) {
            if (index.length == 0) {
                [self dealDefaultSelectIndexpath:self.resetSepcModel.spec];
                return;
            }
        }
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:self.resetSepcModel.spec];
        self.flowLayout.dataArr = self.dataArray;
        self.describeLabel.text = self.resetSepcModel.short_name;
        

        [self searchGoodsDetailModelInGoodsDetailArr:^(HSpecSubGoodsDeatilModel *specSubGoodsDetailModel) {
            
        }];
        
        [self.collectionView reloadData];
        if (self.block) {
            self.block();
        }
        
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)searchGoodsDetailModelInGoodsDetailArr:(void(^)(HSpecSubGoodsDeatilModel *specSubGoodsDetailModel))complited{
    HSepcSubTypeDetailModel *goodsDetailSpec1;
    HSepcSubTypeDetailModel *goodsDetailSpec2;
    HSepcSubTypeDetailModel *goodsDetailSpec3;
    HSepcSubTypeDetailModel *goodsDetailSpec4;
    HSepcSubTypeDetailModel *goodsDetailSpec5;

    self.resetSpecSubGoodsDetailModel = [[HSpecSubGoodsDeatilModel alloc] init];
    
    for (NSInteger i = 0; i < self.resetSelectIndexPath.count; i++) {
        NSIndexPath *index = self.resetSelectIndexPath[i];
        HSepcSubModel * sepcSubModel = self.resetSepcModel.spec[index.section];
        HSepcSubTypeDetailModel *sepcSubTypeDetailModel = sepcSubModel.typeDetail[index.item];
        switch (i) {
            case 0:
            {
                goodsDetailSpec1 = sepcSubTypeDetailModel;
            }
                break;
            case 1:
            {
                goodsDetailSpec2 = sepcSubTypeDetailModel;
            }
                break;
            case 2:
            {
                goodsDetailSpec3 = sepcSubTypeDetailModel;
            }
                break;
            case 3:
            {
                goodsDetailSpec4 = sepcSubTypeDetailModel;
            }
                break;
            case 4:
            {
                goodsDetailSpec5 = sepcSubTypeDetailModel;
            }
                break;
                
            default:
                break;
        }
        
    }
    
    for (HSpecSubGoodsDeatilModel *goodsDetailModel in self.resetSepcModel.goodsDeatil) {
        BOOL bo;
        switch (self.resetSelectIndexPath.count) {
            case 1:
            {
                BOOL one = [goodsDetailSpec1.quality isEqualToString:goodsDetailModel.spec1];

                bo = one;
            }
                break;
            case 2:
            {
                BOOL one = [goodsDetailSpec1.quality isEqualToString:goodsDetailModel.spec1];
                BOOL two = [goodsDetailSpec2.quality isEqualToString:goodsDetailModel.spec2];

                bo = one && two;
            }
                break;
            case 3:
            {
                BOOL one = [goodsDetailSpec1.quality isEqualToString:goodsDetailModel.spec1];
                BOOL two = [goodsDetailSpec2.quality isEqualToString:goodsDetailModel.spec2];
                BOOL three = [goodsDetailSpec3.quality isEqualToString:goodsDetailModel.spec3];

                bo = one && two && three;
            }
                break;
            case 4:
            {
                BOOL one = [goodsDetailSpec1.quality isEqualToString:goodsDetailModel.spec1];
                BOOL two = [goodsDetailSpec2.quality isEqualToString:goodsDetailModel.spec2];
                BOOL three = [goodsDetailSpec3.quality isEqualToString:goodsDetailModel.spec3];
                BOOL four = [goodsDetailSpec4.quality isEqualToString:goodsDetailModel.spec4];
                bo = one && two && three && four;
            }
                break;
            case 5:
            {
                BOOL one = [goodsDetailSpec1.quality isEqualToString:goodsDetailModel.spec1];
                BOOL two = [goodsDetailSpec2.quality isEqualToString:goodsDetailModel.spec2];
                BOOL three = [goodsDetailSpec3.quality isEqualToString:goodsDetailModel.spec3];
                BOOL four = [goodsDetailSpec4.quality isEqualToString:goodsDetailModel.spec4];
                BOOL fifve = [goodsDetailSpec5.quality isEqualToString:goodsDetailModel.spec5];
                bo = one && two && three && four && fifve;
            }
                break;
                
            default:
                break;
        }
        
        if (bo) {
            self.resetSpecSubGoodsDetailModel.spec1 = goodsDetailModel.spec1;
            self.resetSpecSubGoodsDetailModel.spec2 = goodsDetailModel.spec2;
            self.resetSpecSubGoodsDetailModel.spec3 = goodsDetailModel.spec3;
            self.resetSpecSubGoodsDetailModel.spec4 = goodsDetailModel.spec4;
            self.resetSpecSubGoodsDetailModel.spec5 = goodsDetailModel.spec5;
            self.resetSpecSubGoodsDetailModel.image = goodsDetailModel.image;
            self.resetSpecSubGoodsDetailModel.price = goodsDetailModel.price;
            self.resetSpecSubGoodsDetailModel.sub_id =  goodsDetailModel.sub_id;
            
            NSLog(@"%@, %d ,%@",[self class],__LINE__,ImageUrlWithString(goodsDetailModel.image));
            [self.goodsImageView sd_setImageWithURL:ImageUrlWithString(goodsDetailModel.image) placeholderImage:placeImage options:SDWebImageCacheMemoryOnly];
            self.describeLabel.text = self.resetSepcModel.short_name;
            self.resetpriceLabel.attributedText = [goodsDetailModel.price dealhomePricefirstFont:[UIFont systemFontOfSize:zkqScale * 10] lastfont:[UIFont systemFontOfSize:10]];
            complited(goodsDetailModel);
            return;
        }
        
    }
    
}

//处理没有默认选中的情况
- (void)dealDefaultSelectIndexpath:(NSMutableArray *)sepcSubModelArr{
    if ([self.resetSepcModel.goodsDeatil isKindOfClass:[NSArray class]] ||[self.resetSepcModel.goodsDeatil isKindOfClass:[NSMutableArray class]]) {
        NSMutableArray *goodsDetailArr = self.resetSepcModel.goodsDeatil;
        
        for (NSInteger i = 0; i < sepcSubModelArr.count; i++) {
            HSepcSubModel *sepcSubModel = sepcSubModelArr[i];
            for (NSInteger j = 0; j < sepcSubModel.typeDetail.count; j++) {
                HSepcSubTypeDetailModel *sepcSubTypeDetailModel = sepcSubModel.typeDetail[j];
                BOOL isBreak = NO;
                for (NSInteger k = 0; k < goodsDetailArr.count; k++) {
                    HSpecSubGoodsDeatilModel *specSubGoodsDeatilModel = goodsDetailArr[k];
                    switch (i) {
                        case 0:
                        {
                            if ([specSubGoodsDeatilModel.spec1 isEqualToString:sepcSubTypeDetailModel.quality]) {
                                if (![specSubGoodsDeatilModel.reserced isKindOfClass:[NSNull class]] && specSubGoodsDeatilModel.reserced) {
                                    NSInteger stock = [specSubGoodsDeatilModel.reserced integerValue];
                                    if (stock > 0) {
                                        isBreak = YES;
                                        [self.resetSelectIndexPath replaceObjectAtIndex:i withObject:[NSIndexPath indexPathForItem:j inSection:i]];
                                    }
                                    
                                    
                                    
                                }
                            }
                        }
                            break;
                        case 1:
                        {
                            NSIndexPath *firthIndex = self.resetSelectIndexPath[0];
                            HSepcSubModel *firstSepcSubModel = sepcSubModelArr[firthIndex.section];
                            HSepcSubTypeDetailModel * firstSepcSubTypeDetailModel = firstSepcSubModel.typeDetail[firthIndex.item];
                            
                            BOOL oneBool = [firstSepcSubTypeDetailModel.quality isEqualToString:specSubGoodsDeatilModel.spec1];
                            BOOL twoBool = [specSubGoodsDeatilModel.spec2 isEqualToString:sepcSubTypeDetailModel.quality];
                            if (oneBool && twoBool) {
                                NSInteger stock = [specSubGoodsDeatilModel.reserced integerValue];
                                if (stock > 0) {
                                    isBreak = YES;
                                    [self.resetSelectIndexPath replaceObjectAtIndex:i withObject:[NSIndexPath indexPathForItem:j inSection:i]];
                                }
                            }
                            
                            
                            
                            
                        }
                            break;
                        case 2:
                        {
                            NSIndexPath *firthIndex = self.resetSelectIndexPath[0];
                            HSepcSubModel *firstSepcSubModel = sepcSubModelArr[firthIndex.section];
                            HSepcSubTypeDetailModel * firstSepcSubTypeDetailModel = firstSepcSubModel.typeDetail[firthIndex.item];
                            
                            NSIndexPath *secondIndex = self.resetSelectIndexPath[1];
                            HSepcSubModel *secondSepcSubModel = sepcSubModelArr[secondIndex.section];
                            HSepcSubTypeDetailModel * secondSepcSubTypeDetailModel = secondSepcSubModel.typeDetail[secondIndex.item];
                            
                            
                            BOOL oneBool = [firstSepcSubTypeDetailModel.quality isEqualToString:specSubGoodsDeatilModel.spec1];
                            BOOL twoBool = [secondSepcSubTypeDetailModel.quality isEqualToString:specSubGoodsDeatilModel.spec2];
                            BOOL threeBool = [specSubGoodsDeatilModel.spec3 isEqualToString:sepcSubTypeDetailModel.quality];
                            if (oneBool && twoBool && threeBool) {
                                NSInteger stock = [specSubGoodsDeatilModel.reserced integerValue];
                                if (stock > 0) {
                                    isBreak = YES;
                                    [self.resetSelectIndexPath replaceObjectAtIndex:i withObject:[NSIndexPath indexPathForItem:j inSection:i]];
                                }
                            }
                        }
                            break;
                        case 3:
                        {
                            NSIndexPath *firthIndex = self.resetSelectIndexPath[0];
                            HSepcSubModel *firstSepcSubModel = sepcSubModelArr[firthIndex.section];
                            HSepcSubTypeDetailModel * firstSepcSubTypeDetailModel = firstSepcSubModel.typeDetail[firthIndex.item];
                            
                            NSIndexPath *secondIndex = self.resetSelectIndexPath[1];
                            HSepcSubModel *secondSepcSubModel = sepcSubModelArr[secondIndex.section];
                            HSepcSubTypeDetailModel * secondSepcSubTypeDetailModel = secondSepcSubModel.typeDetail[secondIndex.item];
                            
                            NSIndexPath *thirdIndex = self.resetSelectIndexPath[2];
                            HSepcSubModel *thirdSepcSubModel = sepcSubModelArr[thirdIndex.section];
                            HSepcSubTypeDetailModel * thirdSepcSubTypeDetailModel = thirdSepcSubModel.typeDetail[thirdIndex.item];
                            
                            
                            
                            BOOL oneBool = [firstSepcSubTypeDetailModel.quality isEqualToString:specSubGoodsDeatilModel.spec1];
                            BOOL twoBool = [secondSepcSubTypeDetailModel.quality isEqualToString:specSubGoodsDeatilModel.spec2];
                            BOOL threeBool = [thirdSepcSubTypeDetailModel.quality isEqualToString:specSubGoodsDeatilModel.spec3];
                            
                            BOOL fourBool = [sepcSubTypeDetailModel.quality isEqualToString:specSubGoodsDeatilModel.spec4];
                            if (oneBool && twoBool && threeBool && fourBool) {
                                NSInteger stock = [specSubGoodsDeatilModel.reserced integerValue];
                                if (stock > 0) {
                                    isBreak = YES;
                                    [self.resetSelectIndexPath replaceObjectAtIndex:i withObject:[NSIndexPath indexPathForItem:j inSection:i]];
                                }
                            }
                        }
                            break;
                        case 4:
                        {
                            NSIndexPath *firthIndex = self.resetSelectIndexPath[0];
                            HSepcSubModel *firstSepcSubModel = sepcSubModelArr[firthIndex.section];
                            HSepcSubTypeDetailModel * firstSepcSubTypeDetailModel = firstSepcSubModel.typeDetail[firthIndex.item];
                            
                            NSIndexPath *secondIndex = self.resetSelectIndexPath[1];
                            HSepcSubModel *secondSepcSubModel = sepcSubModelArr[secondIndex.section];
                            HSepcSubTypeDetailModel * secondSepcSubTypeDetailModel = secondSepcSubModel.typeDetail[secondIndex.item];
                            
                            NSIndexPath *thirdIndex = self.resetSelectIndexPath[2];
                            HSepcSubModel *thirdSepcSubModel = sepcSubModelArr[thirdIndex.section];
                            HSepcSubTypeDetailModel * thirdSepcSubTypeDetailModel = thirdSepcSubModel.typeDetail[thirdIndex.item];
                            NSIndexPath *fourIndex = self.resetSelectIndexPath[3];
                            HSepcSubModel *fourSepcSubModel = sepcSubModelArr[fourIndex.section];
                            HSepcSubTypeDetailModel * fourSepcSubTypeDetailModel = fourSepcSubModel.typeDetail[thirdIndex.item];
                            
                            
                            BOOL oneBool = [firstSepcSubTypeDetailModel.quality isEqualToString:specSubGoodsDeatilModel.spec1];
                            BOOL twoBool = [secondSepcSubTypeDetailModel.quality isEqualToString:specSubGoodsDeatilModel.spec2];
                            BOOL threeBool = [thirdSepcSubTypeDetailModel.quality isEqualToString:specSubGoodsDeatilModel.spec3];
                            BOOL fourBool = [fourSepcSubTypeDetailModel.quality isEqualToString:specSubGoodsDeatilModel.spec4];
                            BOOL fiveBool = [sepcSubTypeDetailModel.quality isEqualToString:specSubGoodsDeatilModel.spec5];
                            if (oneBool && twoBool && threeBool && fourBool && fiveBool) {
                                NSInteger stock = [specSubGoodsDeatilModel.reserced integerValue];
                                if (stock > 0) {
                                    isBreak = YES;
                                    [self.resetSelectIndexPath replaceObjectAtIndex:i withObject:[NSIndexPath indexPathForItem:j inSection:i]];
                                }
                            }
                        }
                            break;
                        default:
                            break;
                    }
                    if (isBreak) {
                        break;
                    }
                    
                    
                }
                if (isBreak) {
                    break;
                }
                
                
                
                
                
            }
            
        }
        
        
        
    }
    
    
}


- (NSMutableArray *)resetSelectIndexPath{
    if (_resetSelectIndexPath == nil) {
        _resetSelectIndexPath = [[NSMutableArray alloc] init];

        for (NSInteger i = 0; i < self.resetSepcModel.spec.count; i++) {
            HSepcSubModel *sepcSubModel = self.resetSepcModel.spec[i];
            NSIndexPath *selectIndex = [[NSIndexPath alloc] init];
            
            for (NSInteger j = 0; j < sepcSubModel.typeDetail.count; j++) {
                
                HSepcSubTypeDetailModel *sepcSubTypeDetailModel = sepcSubModel.typeDetail[j];
                if ([sepcSubTypeDetailModel.defaultSelect isEqualToString:@"1"]) {
                    sepcSubTypeDetailModel.isSelect = YES;
                    selectIndex = [NSIndexPath indexPathForItem:j inSection:i];
                    
                   
                }else{
                    sepcSubTypeDetailModel.isSelect = NO;
                    
                }
                
            }
            [_resetSelectIndexPath addObject:selectIndex];
        }
        
    }

    return _resetSelectIndexPath;
}

//过滤数据源中的数据
- (void)filteringTheNullDataInTheDataSource:(HSepcModel *)spec{
    if ([spec.spec isKindOfClass:[NSArray class]]) {
        NSMutableArray *sectionArr = [NSMutableArray array];
        for (NSInteger i = 0; i < spec.spec.count; i++) {
            HSepcSubModel *sepcSubModel = spec.spec[i];
            BOOL isAdd = NO;
            NSMutableArray *rowArr = [NSMutableArray array];
            
            if ([sepcSubModel.typeDetail isKindOfClass:[NSArray class]]) {
                
                for (NSInteger j = 0; j < sepcSubModel.typeDetail.count; j++) {
                    HSepcSubTypeDetailModel *sepcSubTypeDeatilModel = sepcSubModel.typeDetail[j];
                    if (sepcSubTypeDeatilModel.quality && ![sepcSubTypeDeatilModel.quality isKindOfClass:[NSNull class]]) {
                        [rowArr addObject:sepcSubTypeDeatilModel];
                        isAdd = YES;
                    }
                }
                
                sepcSubModel.typeDetail = rowArr;
                if (isAdd) {
                    [sectionArr addObject:sepcSubModel];
                }
            
            }
            
            
        }
        
        spec.spec = sectionArr;

    }
}
#pragma mark 从父视图中删除
- (void)viewRemoveFormSuperView:(UIButton *)btn{
    [self searchGoodsDetailModelInGoodsDetailArr:^(HSpecSubGoodsDeatilModel *specSubGoodsDetailModel) {
        
        if ([self.delegate respondsToSelector:@selector(selectGoodsDetailModel:)]) {
            self.resetSpecSubGoodsDetailModel.reserced = self.researed;
            [self.delegate selectGoodsDetailModel:self.resetSpecSubGoodsDetailModel];
        }
    }];
    if ([self.delegate respondsToSelector:@selector(sentSelectIndexPathArr:)]) {
        [self.delegate performSelector:@selector(sentSelectIndexPathArr:) withObject:self.resetSelectIndexPath];
        
    }
   
 
    if (self.isScreenShot) {
        UIView *screenShotView = [self.targetView viewWithTag:self.kSemiModalScreenshotTag];
        [screenShotView.layer addAnimation:[self animationGroupForward:NO] forKey:@"hidden"];
    }
    
    UIView *overlay = [self.targetView viewWithTag:self.kSemiModalOverlayTag];
    UIView *semiView = [self.targetView viewWithTag:self.kSemiModalModalViewTag];
    
    [UIView animateWithDuration:0.5 animations:^{
        if (self.isScreenShot) {
            
            UIView *secondOverlay = [self.targetView viewWithTag:self.KSemiModalSecondOverlayTag];
            
            secondOverlay.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
            
        }else{
            overlay.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        }
        semiView.frame = CGRectMake(0, screenH, screenW, screenH);
    } completion:^(BOOL finished) {
        
        BOOL bo = (self.resetTrueBtn == btn) || (self.resetAddCarBtn == btn);
        //点击按钮之后只有添加购物车成功后才会走页面小时方法
        if (bo) {
            AlertInSubview(@"添加购物车成功");
            if ([self.delegate respondsToSelector:@selector(viewHiddenAndBeginAnimation)]) {
                [self.delegate performSelector:@selector(viewHiddenAndBeginAnimation)];
            }
        }else{
            if ([self.delegate respondsToSelector:@selector(addshopCarfail)]) {
                [self.delegate performSelector:@selector(addshopCarfail)];
            }
        }
        if ([self.delegate respondsToSelector:@selector(viewEndDisPlay)]) {
            [self.delegate performSelector:@selector(viewEndDisPlay)];
        }
        if (self.isScreenShot) {
            UIView *secondOverlay = [overlay viewWithTag:self.KSemiModalSecondOverlayTag];
            [secondOverlay removeFromSuperview];
        }
        [semiView removeFromSuperview];
        [overlay removeFromSuperview];
        
    }];
    
    
    
    
    
}

- (void)presentSemiView:(UIView *)semiView backView:(UIView *)backview target:(UIView *)target ScreenShot:(BOOL)isScreenShot{
    self.targetView = target;
    self.isScreenShot = isScreenShot;
    if (![self.targetView.subviews containsObject:semiView]) {
        UIView *overlay = backview;
        if (overlay == nil) {
            overlay = [[UIView alloc] init];
            
        }
        overlay.frame = CGRectMake(0, 0, screenW, screenH);
        
        overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        overlay.tag = self.kSemiModalOverlayTag;
        [overlay setIsAccessibilityElement:NO];

        if (self.isScreenShot) {
            overlay.backgroundColor = [UIColor blackColor];
            UIImageView *imageView = [self addOrUpdateParentScreenshotInView:overlay target:self.targetView];
            CALayer *blacklayer = [CALayer layer];
            blacklayer.frame = CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height);
            blacklayer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3].CGColor;
            [imageView.layer addSublayer:blacklayer];
            [imageView.layer addAnimation:[self animationGroupForward:true] forKey:@"push"];
            UIView *secondOverlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH)];
            [overlay addSubview:secondOverlay];
            secondOverlay.tag = self.KSemiModalSecondOverlayTag;
            secondOverlay.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
            
        }else {
            overlay.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        }
        
        [self.targetView addSubview:overlay];
        [self.targetView addSubview:semiView];
        semiView.tag = self.kSemiModalModalViewTag;
        
        semiView.backgroundColor = [UIColor clearColor];
        semiView.frame = CGRectMake(0, screenH, screenW, screenH);
        [UIView animateWithDuration:0.5 animations:^{
            if (self.isScreenShot) {
                UIView *secondOverlay = [overlay viewWithTag:self.KSemiModalSecondOverlayTag];
                secondOverlay.backgroundColor  = [[UIColor blackColor] colorWithAlphaComponent:0.0];
            }else{
                overlay.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
            }
            semiView.frame = CGRectMake(0, 0, screenW, screenH);
            
            
        }];
        
        
        
    }
}
- (CATransform3D )transform1{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0/900;
    transform = CATransform3DScale(transform, 0.9, 0.9, 1);
    CGFloat angle = 15.0 * M_PI/180.0;
    transform = CATransform3DRotate(transform, angle, 1, 0, 0);
    return transform;
}

- (CATransform3D )transform2{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = [self transform1].m34;
    transform = CATransform3DTranslate(transform, 0, screenH * (-0.08), 0);
    transform = CATransform3DScale(transform, 0.8, 0.8, 1);
    return transform;
}
- (CAAnimationGroup *)animationGroupForward:(BOOL)_froward{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:[self transform1]];
    animation.duration = 0.3;
    animation.fillMode = kCAFillModeForwards;
    [animation setRemovedOnCompletion:NO];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation2.toValue = [NSValue valueWithCATransform3D:_froward? [self transform2] : CATransform3DIdentity];
    animation2.beginTime = animation.duration;
    animation2.duration = animation.duration;
    animation2.fillMode = kCAFillModeForwards;
    [animation2 setRemovedOnCompletion:NO];
    
    
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.fillMode = kCAFillModeForwards;
    [group setRemovedOnCompletion:NO];
    group.duration = animation.duration * 2;
    group.animations = @[animation, animation2];
    return group;
    
    
    
}
- (UIImageView*)addOrUpdateParentScreenshotInView:(UIView *)superView target:(UIView *)targetview{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(screenW, screenH), YES, 0);
    [targetview drawViewHierarchyInRect:CGRectMake(0, 0, screenW, screenH) afterScreenUpdates:NO];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH)];
    imageView.image = image;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    imageView.tag = self.kSemiModalScreenshotTag;
    [superView addSubview:imageView];
    
    return imageView;
    
    
}
- (void)resetContainer{
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH * 0.35)];
    [self addSubview:btn1];
    self.topHiddenBtn = btn1;
    self.topHiddenBtn.alpha = 1.0;
    [self.topHiddenBtn addTarget:self action:@selector(viewRemoveFormSuperView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.topHiddenBtn.bounds.size.height, screenW, 100)];
    [self addSubview:view1];
    self.midelView = view1;
    self.midelView.backgroundColor = BackgroundGray;
    self.midelView.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.midelView.layer.shadowOffset = CGSizeMake(0, 3);
//    self.midelView.layer.shadowOpacity = 1;
//    self.midelView.layer.shadowRadius = 5;
    
    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
    [self.midelView addSubview:image1];
    self.goodsImageView = image1;
    self.goodsImageView.backgroundColor = [UIColor whiteColor];
    self.goodsImageView.layer.shadowRadius = 5;
    self.goodsImageView.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.goodsImageView.layer.shadowOffset = CGSizeMake(0, 3);
//    self.goodsImageView.layer.shadowOpacity = 1;
//    self.goodsImageView.layer.borderColor = [[UIColor blackColor] CGColor];
    self.goodsImageView.layer.cornerRadius = 6;
    self.goodsImageView.layer.masksToBounds = YES;
    self.goodsImageView.layer.borderWidth = 0.5;
    self.goodsImageView.backgroundColor = [UIColor whiteColor];
    //取消按钮
    
    UIButton *btn2 = [[UIButton alloc] init];
    [self.midelView addSubview:btn2];
    self.cancleBtn = btn2;
    [self.cancleBtn addTarget:self action:@selector(cancleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancleBtn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
    self.cancleBtn.adjustsImageWhenHighlighted = false;
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.midelView.mas_top);
        make.right.equalTo(self.midelView.mas_right);
        make.width.equalTo(@(44));
        make.height.equalTo(@(44));
    }];
    
    //商品描述
    UILabel *label1 = [[UILabel alloc] init];
    [label1 configmentfont:[UIFont systemFontOfSize:13 * zkqScale] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@""];
    [label1 setNumberOfLines:2];
    [label1 sizeToFit];
    [self.midelView addSubview:label1];
    self.describeLabel = label1;
    [self.describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.midelView.mas_top).offset(10);
        make.left.equalTo(self.goodsImageView.mas_right).offset(5);
        make.right.equalTo(self.cancleBtn.mas_left).offset(-5);
    }];
    
    //商品价格
    UILabel *label2 = [[UILabel alloc] init];
    [label2 configmentfont:[UIFont systemFontOfSize:14* zkqScale] textColor:THEMECOLOR backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@""];
    [label2 sizeToFit];
    [self.midelView addSubview:label2];
    self.resetpriceLabel = label2;
    [self.resetpriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.describeLabel.mas_bottom).offset(5);
        make.left.equalTo(self.goodsImageView.mas_right).offset(5);
    }];
    
    
    
    
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.midelView.mas_bottom).offset(0);
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-50);
    }];
    
    
    
    switch (self.typeOfView) {
        case haveTwobtn:
        {
            [self addSubview:self.resetAddCarBtn];
            [self addSubview:self.resetBuyBtn];
            [self.resetAddCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.collectionView.mas_bottom).offset(0);
                make.left.equalTo(self.mas_left).offset(0);
                make.right.equalTo(self.resetBuyBtn.mas_left).offset(0);
                make.bottom.equalTo(self.mas_bottom).offset(0);
                make.width.equalTo(self.resetBuyBtn);
            }];
            
            //布局添加购物车按钮
            
            //布局立即购买按钮
            [self.resetBuyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.collectionView.mas_bottom).offset(0);
                make.right.equalTo(self.mas_right).offset(0);
                make.bottom.equalTo(self.mas_bottom).offset(0);
            }];
        }
            break;
        case addToShopCar:{
            [self addSubview:self.resetTrueBtn];
            [self.resetTrueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.collectionView.mas_bottom);
                make.left.bottom.right.equalTo(self);
            }];
            
        }
            break;
        case ToPayControl:
        {
            [self addSubview:self.resetBuyBtn];
            [self.resetBuyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.bottom.right.equalTo(self);
                make.top.equalTo(self.collectionView.mas_bottom);
                
            }];
        }
        default:
            break;
    }
    
    
    
    
    
}

- (void)cancleBtnClick:(UIButton *)btn{
    
    [self viewRemoveFormSuperView:btn];
}





////数据源数组
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (ActionBaseView *)topView{
    if (_topView == nil) {
        _topView = [[ActionBaseView alloc] init];
        [self addSubview:_topView];
    }
    return _topView;
}
- (UIView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] init];
        [self addSubview:_bottomView];
    }
    return _bottomView;
}
- (FlowLayout *)flowLayout{
    if (_flowLayout == nil) {
        _flowLayout = [[FlowLayout alloc] init];
        [_flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    }
    return _flowLayout;
}
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        
        
         _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, screenW, 300) collectionViewLayout:self.flowLayout];
        self.flowLayout.dataArr = self.dataArray;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.bounces = YES;
        
        
        [_collectionView registerClass:[HSpecItem class] forCellWithReuseIdentifier:@"HSpecItem"];
        
        [_collectionView registerClass:[HSelectSpecHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HSelectSpecHeader"];
        [_collectionView registerClass:[HSelectSpecFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"HSelectSpecFooter"];
        [_collectionView registerClass:[HBuyNumberFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"HBuyNumberFooter"];
        _collectionView.backgroundColor = [UIColor whiteColor];
        
    }
    return _collectionView;
}
- (UIButton *)resetAddCarBtn{
    if (_resetAddCarBtn == nil) {
        _resetAddCarBtn = [[UIButton alloc] init];
        [_resetAddCarBtn setBackgroundColor:[UIColor colorWithHexString:@"f8bb18"]];
        [_resetAddCarBtn addTarget:self action:@selector(resetaddshopCar:) forControlEvents:UIControlEventTouchUpInside];
        [_resetAddCarBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        [_resetAddCarBtn.titleLabel setFont:[UIFont systemFontOfSize:15 * zkqScale]];
        [_resetAddCarBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    }
    return _resetAddCarBtn;
}

- (UIButton *)resetBuyBtn{
    if (_resetBuyBtn == nil) {
        _resetBuyBtn = [[UIButton alloc] init];
        [_resetBuyBtn setBackgroundColor:[UIColor colorWithHexString:@"ff621c"]];
        [_resetBuyBtn addTarget:self action:@selector(resetbuyButton:) forControlEvents:UIControlEventTouchUpInside];
        [_resetBuyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        [_resetBuyBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
        [_resetBuyBtn.titleLabel  setFont:[UIFont systemFontOfSize:15 *zkqScale]];
    }
    return _resetBuyBtn;
}

- (UIButton *)resetTrueBtn{
    if (_resetTrueBtn== nil) {
        _resetTrueBtn = [[UIButton alloc] init];
        
        [_resetTrueBtn addTarget:self action:@selector(resettrueBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_resetTrueBtn setTitle:@"确定" forState:UIControlStateNormal];
        
        [_resetTrueBtn.titleLabel setFont:[UIFont systemFontOfSize:15 * zkqScale]];
        [_resetTrueBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
        [_resetTrueBtn setBackgroundColor:[UIColor colorWithHexString:@"ff621c"]];
    }
    return _resetTrueBtn;
}
- (void)resettrueBtn:(UIButton *)btn{
    //确定是加入购物车
    self.resetSpecSubGoodsDetailModel.reserced = self.researed;
    if ([UserInfo shareUserInfo].isLogin) {
        [[UserInfo shareUserInfo] addShopingCarWithGoods_id:self.resetSepcModel.goods_id goodsNum:[self.researed integerValue] sub_id:[self.resetSpecSubGoodsDetailModel.sub_id integerValue]now:@"0" Success:^(ResponseObject *response) {
            
            
            [self viewRemoveFormSuperView:btn];
        } failure:^(NSError *error) {
            if ([self.delegate respondsToSelector:@selector(addshopCarfail)]) {
                [self.delegate performSelector:@selector(addshopCarfail)];
            }
        }];
    }else{
        LoginNavVC *login = [[LoginNavVC alloc] initLoginNavVC];
//        [[KeyVC shareKeyVC] presentViewController:login animated:YES completion:nil];
        [[GDKeyVC share] presentViewController:login animated:YES  completion:nil ];

    }
    
    
}

- (void)resetaddshopCar:(UIButton *)btn{
    self.resetSpecSubGoodsDetailModel.reserced = self.researed;
    if ([UserInfo shareUserInfo].isLogin) {
        [[UserInfo shareUserInfo] addShopingCarWithGoods_id:self.resetSepcModel.goods_id goodsNum:[self.researed integerValue] sub_id:[self.resetSpecSubGoodsDetailModel.sub_id integerValue]now:@"0" Success:^(ResponseObject *response) {
            
            
            [self viewRemoveFormSuperView:btn];
        } failure:^(NSError *error) {
            if ([self.delegate respondsToSelector:@selector(addshopCarfail)]) {
                [self.delegate performSelector:@selector(addshopCarfail)];
            }
        }];
    }else{
        LoginNavVC *login = [[LoginNavVC alloc] initLoginNavVC];
        //        [[KeyVC shareKeyVC] presentViewController:login animated:YES completion:nil];
        [[GDKeyVC share] presentViewController:login animated:YES  completion:nil ];
        
    }
}
- (void)resetbuyButton:(UIButton *)btn{
    self.resetSpecSubGoodsDetailModel.reserced = self.researed;
    
    if ([UserInfo shareUserInfo].isLogin) {
        [self gotAddressSuccess:^{
            [[UserInfo shareUserInfo] addShopingCarWithGoods_id:self.resetSepcModel.goods_id goodsNum:[self.researed integerValue] sub_id:[self.resetSpecSubGoodsDetailModel.sub_id integerValue]now:@"1" Success:^(ResponseObject *response) {
                if (response.status < 0) {
                    
                    AlertInSubview(response.msg)
                }else{
                    [self gotAddressSuccess:^{
                        //添加购物车成功之后
                        SVCGoods *vcGoods = [[SVCGoods alloc] init];
                        vcGoods.ID = response.data[@"cart_id"];
                        
                        vcGoods.number = [self.resetSpecSubGoodsDetailModel.reserced integerValue];
                        vcGoods.price = [self.resetSpecSubGoodsDetailModel.price integerValue];
                        vcGoods.shop_id = [self.resetSepcModel.shop_id integerValue];
                        ConfirmOrderVC *confirmOrder = [[ConfirmOrderVC alloc] init];
                        NSMutableArray *arr = [NSMutableArray array];
                        [arr addObject:vcGoods];
                        confirmOrder.goodsIDs = arr;
                        self.resetBuyBtn.enabled = YES;
                        
                        [self.fatherVC.navigationController pushViewController:confirmOrder animated:YES];
                        [self viewRemoveFormSuperView:nil];
                    } failure:^{
                        
                    }];
                    
                }
                
                
            } failure:^(NSError *error) {
                if ([self.delegate respondsToSelector:@selector(addshopCarfail)]) {
                    [self.delegate performSelector:@selector(addshopCarfail)];
                }
            }];
        } failure:^{
            
        }];
    }else{
        LoginNavVC *login = [[LoginNavVC alloc] initLoginNavVC];
        //        [[KeyVC shareKeyVC] presentViewController:login animated:YES completion:nil];
        [[GDKeyVC share] presentViewController:login animated:YES  completion:nil ];
        
    }
    
}


/** 判断地址是否为空 */
-(void)gotAddressSuccess:(void(^)())success failure:(void(^)())failure{
    [[UserInfo shareUserInfo] gotAddressSuccess:^(ResponseObject *responseObject) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
        if (responseObject.data && [responseObject.data isKindOfClass:[NSArray class]]) {
            if ([responseObject.data count]>0) {
                //正常弹出确认订单
                success();
            }else{
                //弹出添加地址
                self.resetBuyBtn.enabled = YES;
                [self viewRemoveFormSuperView:nil];
                [self noticeAddAddress];
//                if ([self.delegate respondsToSelector:@selector(noticeAddAddress)]) {
//                    [self.delegate performSelector:@selector(noticeAddAddress)];
//                }
            }
            
        }else{
            //弹出添加地址
            self.resetBuyBtn.enabled = YES;
            [self viewRemoveFormSuperView:nil];
            [self noticeAddAddress];
//            if ([self.delegate respondsToSelector:@selector(noticeAddAddress)]) {
//                [self.delegate performSelector:@selector(noticeAddAddress)];
//            }
        }
        
        
    } failure:^(NSError *error) {
        
        LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
    }];
    
    
}

-(void)noticeAddAddress
{
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"您还没有添加收货地址\n请先添加收货地址" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //弹出添加地址控制器
        EditAddressVC * cv = [[EditAddressVC alloc]initWithActionStyle:Adding];
        cv.delegate=self;
        [self.fatherVC.navigationController pushViewController:cv animated:YES];
        
    }];
    UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:sure];
    [alertVC addAction:cancle];
    [self.fatherVC presentViewController:alertVC animated:YES completion:nil];
}



#pragma mark - tableviewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    HSepcSubModel *sepcSubModel = self.dataArray[section];
    
    return sepcSubModel.typeDetail.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HSpecItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HSpecItem" forIndexPath:indexPath];
    //给cell相应的值
    HSepcSubModel *specSub = self.dataArray[indexPath.section];
    NSArray *array = specSub.typeDetail;
    
    
    if (self.isNow) {
        HSepcSubTypeDetailModel *sepcSubTypeDetailModel = array[indexPath.item];
        HSepcSubTypeDetailModel *sepcSubTypeDetailSpec1;
        HSepcSubTypeDetailModel *sepcSubTypeDetailSpec2;
        HSepcSubTypeDetailModel *sepcSubTypeDetailSpec3;
        HSepcSubTypeDetailModel *sepcSubTypeDetailSpec4;
        HSepcSubTypeDetailModel *sepcSubTypeDetailSpec5;
        
        for (NSIndexPath *index in self.resetSelectIndexPath) {
            NSLog(@"%@, %d ,%@",[self class],__LINE__,index);
            NSLog(@"%@, %d ,%@",[self class],__LINE__,indexPath);


            if (index.section != indexPath.section) {
                HSepcSubModel *sepcSubModel = self.dataArray[index.section];
                HSepcSubTypeDetailModel *sepcSubDetailModel = sepcSubModel.typeDetail[index.item];
                switch (index.section) {
                    case 0:
                    {
                        sepcSubTypeDetailSpec1 = sepcSubDetailModel;
                    }
                        break;
                    case 1:
                    {
                        sepcSubTypeDetailSpec2 = sepcSubDetailModel;
                    }
                        break;
                    case 2:
                    {
                        sepcSubTypeDetailSpec3 = sepcSubDetailModel;
                    }
                        break;
                    case 3:
                    {
                        sepcSubTypeDetailSpec4 = sepcSubDetailModel;
                    }
                        break;
                    case 4:
                    {
                        sepcSubTypeDetailSpec5 = sepcSubDetailModel;
                    }
                        break;
                        
                    default:
                        break;
                }
            }else{
                HSepcSubTypeDetailModel *sepcSubDetailModel = array[indexPath.item];
                switch (index.section) {
                    case 0:
                    {
                        sepcSubTypeDetailSpec1 = sepcSubDetailModel;
                    }
                        break;
                    case 1:
                    {
                        sepcSubTypeDetailSpec2 = sepcSubDetailModel;
                    }
                        break;
                    case 2:
                    {
                        sepcSubTypeDetailSpec3 = sepcSubDetailModel;
                    }
                        break;
                    case 3:
                    {
                        sepcSubTypeDetailSpec4 = sepcSubDetailModel;
                    }
                        break;
                    case 4:
                    {
                        sepcSubTypeDetailSpec5 = sepcSubDetailModel;
                    }
                        break;
                        
                    default:
                        break;
                }
            }
            
            HSepcSubModel *sepcSubModel = self.dataArray[index.section];
            HSepcSubTypeDetailModel *sepcSubTypeDetailModel = sepcSubModel.typeDetail[index.item];
            sepcSubTypeDetailModel.isSelect = YES;
            
            
        }
        NSLog(@"%@, %d ,%@",[self class],__LINE__,sepcSubTypeDetailSpec1.quality);
        NSLog(@"%@, %d ,%@",[self class],__LINE__,sepcSubTypeDetailSpec2.quality);
        NSLog(@"%@, %d ,%@",[self class],__LINE__,sepcSubTypeDetailSpec3.quality);
        NSLog(@"%@, %d ,%@",[self class],__LINE__,sepcSubTypeDetailSpec4.quality);
        NSLog(@"%@, %d ,%@",[self class],__LINE__,sepcSubTypeDetailSpec5.quality);
        
        
        for (HSpecSubGoodsDeatilModel *goodsDetailModel in self.resetSepcModel.goodsDeatil) {
            BOOL bo;
            switch (self.resetSelectIndexPath.count) {
                case 1:
                {
                    BOOL one = [sepcSubTypeDetailSpec1.quality isEqualToString:goodsDetailModel.spec1];
                    
                    bo = one;
                }
                    break;
                case 2:
                {
                    BOOL one = [sepcSubTypeDetailSpec1.quality isEqualToString:goodsDetailModel.spec1];
                    BOOL two = [sepcSubTypeDetailSpec2.quality isEqualToString:goodsDetailModel.spec2];
                    
                    bo = one && two;
                }
                    break;
                case 3:
                {
                    BOOL one = [sepcSubTypeDetailSpec1.quality isEqualToString:goodsDetailModel.spec1];
                    BOOL two = [sepcSubTypeDetailSpec2.quality isEqualToString:goodsDetailModel.spec2];
                    BOOL three = [sepcSubTypeDetailSpec3.quality isEqualToString:goodsDetailModel.spec3];
                    
                    bo = one && two && three;
                }
                    break;
                case 4:
                {
                    BOOL one = [sepcSubTypeDetailSpec1.quality isEqualToString:goodsDetailModel.spec1];
                    BOOL two = [sepcSubTypeDetailSpec2.quality isEqualToString:goodsDetailModel.spec2];
                    BOOL three = [sepcSubTypeDetailSpec3.quality isEqualToString:goodsDetailModel.spec3];
                    BOOL four = [sepcSubTypeDetailSpec4.quality isEqualToString:goodsDetailModel.spec4];
                    bo = one && two && three && four;
                }
                    break;
                case 5:
                {
                    BOOL one = [sepcSubTypeDetailSpec1.quality isEqualToString:goodsDetailModel.spec1];
                    BOOL two = [sepcSubTypeDetailSpec2.quality isEqualToString:goodsDetailModel.spec2];
                    BOOL three = [sepcSubTypeDetailSpec3.quality isEqualToString:goodsDetailModel.spec3];
                    BOOL four = [sepcSubTypeDetailSpec4.quality isEqualToString:goodsDetailModel.spec4];
                    BOOL fifve = [sepcSubTypeDetailSpec5.quality isEqualToString:goodsDetailModel.spec5];
                    bo = one && two && three && four && fifve;
                }
                    break;
                    
                default:
                    break;
            }
            
            if (bo) {
                
                sepcSubTypeDetailModel.reserced = goodsDetailModel.reserced;
                
                break;
            }
            
        }
        cell.fatherView = collectionView;
        cell.deatilModel = sepcSubTypeDetailModel;
    }else{
        
        
        

    }
    cell.delegate = self;
   
    return cell;
}

#pragma mark - BuyNumDelegate的代理方法
- (void)addNumberOfStoreWith:(NSString *)num{
    self.goodsDetailModel.reserced = num;
    self.researed = num;
    self.resetSpecSubGoodsDetailModel.reserced = num;
    LOG(@"%@,%d,%@",[self class], __LINE__,self.goodsDetailModel.reserced)
}
#pragma mark -- 减少商品
- (void)subtructNumberOfStoreWith:(NSString *)num{
    self.goodsDetailModel.reserced = num;
    self.researed = num;
    self.resetSpecSubGoodsDetailModel.reserced = num;
     LOG(@"%@,%d,%@",[self class], __LINE__,self.goodsDetailModel.reserced)
}



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *view = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        
        HSelectSpecHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HSelectSpecHeader" forIndexPath:indexPath] ;
        HSepcSubModel *specSub = self.dataArray[indexPath.section];
        
        headerView.title = specSub.type;
        view = headerView;
        
    }else{
        
        if (indexPath.section == (self.dataArray.count - 1)) {
            HBuyNumberFooter *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"HBuyNumberFooter" forIndexPath:indexPath];
            footer.delegate = self;
            
            //都被选中的话
            if (self.isNow) {
                [self searchGoodsDetailModelInGoodsDetailArr:^(HSpecSubGoodsDeatilModel *specSubGoodsDetailModel) {
                    footer.storeCount = specSubGoodsDetailModel.reserced;
                }];
            }else{
                
            }

            
            
            
            return footer;
            
        }else{
           HSelectSpecFooter *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"HSelectSpecFooter" forIndexPath:indexPath];
            footer.backgroundColor = [UIColor colorWithHexString:@"e4e4e4"];
            return footer;
        }
        
        
    }
    
    return view;
}

#pragma mark - 实现cell的代理方法
- (void)cateCarycell:(HSpecItem *)cateGaryitem atIndexPath:(NSIndexPath *)indexPath button:(UIButton *)button{
    //之前点击的按钮
    
    if (self.isNow) {
        NSIndexPath *beforeIndex = self.resetSelectIndexPath[indexPath.section];
        HSepcSubModel *sepcSubModell = self.resetSepcModel.spec[beforeIndex.section];
        
        if (beforeIndex.item != indexPath.item) {
            HSpecItem *item = (HSpecItem *)[self.collectionView cellForItemAtIndexPath:beforeIndex];
            [item.button setSelected:NO];
            HSepcSubTypeDetailModel *beforeSelectSepcSubTypeModel = sepcSubModell.typeDetail[beforeIndex.item];
            beforeSelectSepcSubTypeModel.isSelect = NO;
            
        }
        [cateGaryitem.button setSelected:YES];
        self.resetSelectIndexPath[indexPath.section] = indexPath;
        HSepcSubTypeDetailModel *sepcSubTypeDetailModel = sepcSubModell.typeDetail[indexPath.item];
        sepcSubTypeDetailModel.isSelect = YES;
        [self searchGoodsDetailModelInGoodsDetailArr:^(HSpecSubGoodsDeatilModel *specSubGoodsDetailModel) {
            [self.goodsImageView sd_setImageWithURL:ImageUrlWithString(specSubGoodsDetailModel.image) placeholderImage:placeImage options:SDWebImageCacheMemoryOnly];
            self.resetpriceLabel.attributedText = [specSubGoodsDetailModel.price dealhomePricefirstFont:[UIFont systemFontOfSize:zkqScale * 10] lastfont:[UIFont systemFontOfSize:10]];
            
            
        }];
        
        
        
    }else{
        
    }
   
    [self.collectionView reloadData];

}


-(void)dealloc{
    LOG(@"%@,%d,%@",[self class], __LINE__,@" specview销毁")
}
@end
