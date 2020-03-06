//
//  GroupDataManage.h
//  IOSCim
//
//  Created by apple apple on 11-7-6.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GroupStruct.h"

@interface GroupDataManage : NSObject {

}

+ (void)addGroup:(GroupStruct*)group;
+ (void)removeGroup:(NSString*)groupId;
+ (NSMutableArray*)getMyGroups;
+ (GroupStruct*)getGroup:(NSString*)groupId;
+ (GroupStruct *)getSystemGourpData:(NSString*)groupId;
+ (BOOL)isMyGroup:(NSString*)groupId;
+ (void)saveSystemGroupData:(GroupStruct*)group;
+ (void)clearGroupData;
+ (void)clearData ;
@end
