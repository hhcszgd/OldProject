//
//  GoodsTopCollection.m
//  b2c
//
//  Created by 张凯强 on 2017/3/10.
//  Copyright © 2017年 www.16lao.com. All rights reserved.
//

@interface GoodsTopCollection : UICollectionView< UIGestureRecognizerDelegate>

@end
@implementation GoodsTopCollection

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        
    }
    return self;
}





- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if ([self panBack:gestureRecognizer]) {
        return YES;
    }
    return NO;
}
- (BOOL)panBack:(UIGestureRecognizer *)gestureRecognizer{
    CGFloat location_c = 100;
    if (gestureRecognizer == self.panGestureRecognizer) {
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint point = [pan translationInView:self];
        NSLog(@"%@, %d ,%@",[self class],__LINE__,NSStringFromCGPoint(point));

        UIGestureRecognizerState state = gestureRecognizer.state;
        if ((state == UIGestureRecognizerStateBegan)|| (state == UIGestureRecognizerStatePossible)) {
            CGPoint location = [gestureRecognizer locationInView:self];
            NSLog(@"%@, %d ,%@",[self class],__LINE__,NSStringFromCGPoint(location));

            if (point.x >= 0 && location.x <= location_c && self.contentOffset.x <= 0) {
                return YES;
            }
        }
    }
    return NO;
}

@end
