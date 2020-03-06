//
//  GDPicturnPreviewCell.h
//  b2c
//
//  Created by WY on 17/2/16.
//  Copyright © 2017年 www.16lao.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GDPicturnPreviewCell;
@protocol GDPicturnPreviewCellDelegate <NSObject>

-(void)oneTapOnView:(GDPicturnPreviewCell*)view;

@end
//typedef      void(^oneTapHandle)() ;
@interface GDPicturnPreviewCell : UICollectionViewCell
//@property(nonatomic,weak)UIImageView * imgView ;
@property(nonatomic,strong)UIImage * img ;
@property(nonatomic,weak)id  <GDPicturnPreviewCellDelegate> delegate ;
@end
