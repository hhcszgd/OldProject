//
//  FMDBManager.m
//  b2c
//
//  Created by 0 on 16/5/30.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "FMDBManager.h"

@interface FMDBManager()
@property (nonatomic, strong) FMDatabase *dataBase;
@end
@implementation FMDBManager
static FMDatabaseQueue *_queue = nil;



//初始化
+ (id)sharFMDBMabager{
    static id temp = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        temp = [[FMDBManager alloc]init];
    });
    return temp;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        //沙盒路径
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *fdPath = [path stringByAppendingFormat:@"/%@",@"goodSpec.sqlite"];
        LOG(@"%@,%d,%@",[self class], __LINE__,fdPath)
        //打开并且创建数据库
        FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:fdPath];
        _queue = queue;
        
    }
    return self;
}

- (void)createTableWithSqlStr{
    NSString *sql = @"create table if not exists specTable(spec1 text ,spec2 text,spec3 text,spec4 text,spec5 text, reserced text,price text,image text,sub_id text)";
    [_queue inDatabase:^(FMDatabase *db) {
        BOOL isSuccess =[db executeUpdate:sql];
        if (isSuccess) {
            LOG(@"%@,%d,%@",[self class], __LINE__,@"创建表格成功")
            
        }else{
            LOG(@"%@,%d,%@",[self class], __LINE__,@"创建表格失败")
        }
    }];
    
}

- (void)insertData:(NSArray *)dataArr{
    
    
    [_queue inDatabase:^(FMDatabase *db) {
        if ([db open]) {
            
            NSString *sql = @"insert into specTable(spec1,spec2,spec3,spec4,spec5,reserced,price,image,sub_id) values (?,?,?,?,?,?,?,?,?)";
            for (NSInteger i= 0; i < dataArr.count; i++) {
                
                HSpecSubGoodsDeatilModel *goodsDeatilModel = dataArr[i];
                
                BOOL isSuccess = [db executeUpdate:sql,goodsDeatilModel.spec1,goodsDeatilModel.spec2,goodsDeatilModel.spec3,goodsDeatilModel.spec4,goodsDeatilModel.spec5,goodsDeatilModel.reserced,goodsDeatilModel.price,goodsDeatilModel.image,goodsDeatilModel.sub_id];
                if (isSuccess) {
                    LOG(@"%@,%d,%@",[self class], __LINE__,@"添加数据成功")
                }
            }
            
        }
    }];
    
}
- (void)deleteAllData{
    [_queue inDatabase:^(FMDatabase *db) {
        if ([db open]) {
            BOOL isSuccess = [db executeUpdate:@"delete from specTable"];
            if (isSuccess) {
                LOG(@"%@,%d,%@",[self class], __LINE__,@"删除表中所有的数据")
            }
        }
    }];
}
- (void )selectWithSql:(NSString *)sql result:(void(^)(id paramete))result{
     NSMutableArray *dataArr = [[NSMutableArray alloc] init];
    [_queue inDatabase:^(FMDatabase *db) {
        if ([db open]) {
            FMResultSet *re;
            if (sql.length == 0) {
                re = [db executeQuery:[NSString stringWithFormat:@"select * from specTable  %@",sql]];
            }else{
                 re = [db executeQuery:[NSString stringWithFormat:@"select * from specTable where  %@",sql]];
            }
            
           
            
            while ([re next]) {
                
                HSpecSubGoodsDeatilModel *specModel = [[HSpecSubGoodsDeatilModel alloc] init];
                specModel.spec1 = [re stringForColumn:@"spec1"];
                specModel.spec2 = [re stringForColumn:@"spec2"];
                specModel.spec3 = [re stringForColumn:@"spec3"];
                specModel.spec4 = [re stringForColumn:@"spec4"];
                specModel.spec5 = [re stringForColumn:@"spec5"];
                specModel.reserced = [re stringForColumn:@"reserced"];
                specModel.price = [re stringForColumn:@"price"];
                specModel.image = [re stringForColumn:@"image"];
                specModel.sub_id = [re stringForColumn:@"sub_id"];
                [dataArr addObject:specModel];
            }
            
            
        }
        result(dataArr);
    }];
  
    
}
- (void)judgeDataResult:(void (^)(BOOL))b{
    [_queue inDatabase:^(FMDatabase *db) {
        if ([db open]) {
            FMResultSet *rt = [db executeQuery:@"select * from specTable"];
            BOOL isHaveData = NO;
            if ([rt next]) {
                isHaveData = YES;
            }
            b(isHaveData);
        }
        
    }];
}





@end
