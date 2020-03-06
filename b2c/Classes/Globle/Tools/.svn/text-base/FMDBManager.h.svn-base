//
//  FMDBManager.h
//  b2c
//
//  Created by 0 on 16/5/30.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BaseModel.h"
#import "FMdataBase.h"
#import "HSpecSubGoodsDeatilModel.h"
@interface FMDBManager : BaseModel
//创建一个数据库
+ (id)sharFMDBMabager;
//根据sql语句创建一个表
- (void)createTableWithSqlStr;
/**查询数据*/
- (void)selectWithSql:(NSString *)sql result:(void(^)(id paramete))result;
/**插入数据*/
- (void)insertData:(NSArray *)dataArr;
/**删除数据*/
- (void)deleteAllData;
/**查询规格表中有没有数据*/
- (void)judgeDataResult:(void(^)(BOOL b))b;
@end
