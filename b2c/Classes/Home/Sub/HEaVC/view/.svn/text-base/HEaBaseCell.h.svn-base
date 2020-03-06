//
//  HEaBaseCell.h
//  b2c
//
//  Created by 0 on 16/5/4.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//





#import <UIKit/UIKit.h>
#import "HEaBaseModel.h"
typedef enum {
    cellStyleIsSmall = 0,
    cellStyleIsBig
}HEaCellStyle;
typedef enum {
    //厂家直销
    directCellStyle = 0,
    //特许
    franchiseCellStyle,
    //女婴管
    babyCellStyle,
    //电器城
    eaCellStyle,
    //民族兄妹
    nationCellStyle
}cellStyle;


@interface HEaBaseCell : UICollectionViewCell
@property (nonatomic, assign) NSInteger line;
/**列数*/
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, strong) CustomCollectionModel *customModel;
@property (nonatomic, strong) HEaBaseModel *baseModel;
@property (nonatomic, assign) HEaCellStyle cellStyle;
/**不同频道中cell的样式*/
@property (nonatomic, assign) cellStyle channelCellStyle;

@end
