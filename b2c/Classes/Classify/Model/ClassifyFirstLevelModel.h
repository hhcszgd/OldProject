//
//  ClassifyFirstLevelModel.h
//  b2c
//
//  Created by 0 on 16/4/13.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassifyFirstLevelModel : NSObject<NSCoding>
/**channel*/
@property (nonatomic, copy) NSString *channel;
/**key*/
@property (nonatomic, copy) NSString *key;
/**一级分类数组*/
@property (nonatomic, strong) NSMutableArray *classone;
/**一级分类id，或者是3及分类的id*/
@property (nonatomic, copy) NSString *ID;
/**一级分类的全名classify_name*/
@property (nonatomic, copy) NSString *classify_name;
/**一级分类的actionkey*/
@property (nonatomic, copy) NSString *actionkey;
/**模型是否被选中*/
@property (nonatomic, assign) BOOL isSelected;
/**一级分类中的二三级分类的数组*/
//@property (nonatomic, strong) NSArray *items;
///**三级分类的图片*/
//@property (nonatomic, copy) NSString *img;
///**三级分类的title*/
//@property (nonatomic, copy) NSArray *name;
@end
