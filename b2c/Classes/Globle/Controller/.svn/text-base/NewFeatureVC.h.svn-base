//
//  NewFeatureVC.h
//  b2c
//
//  Created by wangyuanfei on 6/24/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "BaseVC.h"
@class NewFeatureVC;
@class NewFeatureCollectionCell ;
@protocol  NewFeatureDelegate<NSObject>

-(void)finishedShowNewFeature:(NewFeatureVC*)newFeatureVC;
-(void)performStart:(NewFeatureCollectionCell*)cell;
@end

@interface NewFeatureVC : BaseVC
@property(nonatomic,weak)id  <NewFeatureDelegate> NewFeatureVCDelegate ;
@end



@interface NewFeatureCollectionCell :UICollectionViewCell

@property(nonatomic,weak)id  <NewFeatureDelegate> NewFeatureCellDelegate ;
@property(nonatomic,copy    )NSString * backImageName;
@property(nonatomic,assign)BOOL  showStartButton ;
@end