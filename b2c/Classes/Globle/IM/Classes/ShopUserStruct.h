//
//  ShopUserStruct.h
//  IOSCim
//
//  Created by apple apple on 11-5-25.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopUserStruct : NSObject {
	NSString *userId;
	NSString *loginId;
	NSString *nickname;
	NSString *idiograph;
	NSString *deptId;
	NSString *parentDeptId;
	NSString *deptName;
}

@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *loginId;
@property (nonatomic, retain) NSString *nickname;
@property (nonatomic, retain) NSString *idiograph;
@property (nonatomic, retain) NSString *deptId;
@property (nonatomic, retain) NSString *parentDeptId;
@property (nonatomic, retain) NSString *deptName;

- (NSString *)getUserName;

@end
