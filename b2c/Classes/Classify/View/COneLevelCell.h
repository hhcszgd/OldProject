//
//  COneLevelCell.h
//  b2c
//
//  Created by 0 on 16/4/22.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BaseCell.h"
#import "ClassifyFirstLevelModel.h"
@interface COneLevelCell : BaseCell
@property (nonatomic, strong) ClassifyFirstLevelModel *firsLevelModel;
/**一级分类文字*/
@property (nonatomic, strong) UILabel *classLabel;
/**被选中的图标*/
@property (nonatomic, strong) UIView *leftView;
@end
