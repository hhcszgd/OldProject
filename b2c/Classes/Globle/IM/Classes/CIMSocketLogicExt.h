//
//  CIMSocketLogicExt.h
//  IOSCim
//
//  Created by apple apple on 11-8-19.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CIMSocketLogic.h"


@interface CIMSocketLogicExt : CIMSocketLogic {

}
- (void)sendAgreeAddFriendMessage:(NSString*)friendId ;
- (void)leaveGroupMessage:(NSString*)groupId;
- (void)dissolveGroupMessage:(NSString*)groupId;
- (void)sendAddGroupRequest:(NSString*)groupId groupMasterId:(NSString*)groupMasterId;
- (void)sendRefuseAddGroupMessage:(NSString*)groupId userId:(NSString*)userId;
- (void)sendAgreeAddGroupMessage:(NSString*)groupId userId:(NSString*)userId;
- (void)sendRefuseAddFriendMessage:(NSString*)friendId;
- (void)sendRequestAddFriendMessage:(NSString*)friendId requestContent:(NSString*)requestContent;
@end
