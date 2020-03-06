//
//  ChatTreesViewCell.m
//  IOSCim
//
//  Created by fei lan on 14-9-26.
//  Copyright (c) 2014年 CIMForIOS. All rights reserved.
//

#define marginW 10
#define marginTB 15
#define headImageSize 50
#define rightLabelWidth 50
#define nameLabelHeight 30
#define timeLabelHeight 30
#define contentLabelHeight 20
#define messageNumLabelHeight 20


#import "ChatTreesViewCell.h"
#import "UserDataManage.h"
#import "GroupDataManage.h"
#import "Tool.h"
#import "AsynImageView.h"

@implementation ChatTreesViewCell {
    AsynImageView *headImageView;
    UILabel *chatNameLabel;
    UILabel *chatContentLabel;
    UILabel *messageTimeLabel;
    UILabel *messageNumLabel;
    UserData *curUser;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

//初始化界面
- (void)initView {
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];
    backView.backgroundColor = [UIColor clearColor];
    self.backgroundView = backView;
    
    CGRect mainRect = [Tool screenRect];
    
    //头像
    headImageView = [[AsynImageView alloc] initWithFrame:CGRectMake(marginW, marginTB, headImageSize, headImageSize)];
    headImageView.layer.borderWidth = 1;
    headImageView.layer.borderColor = [Tool colorWithHexString:@"CCCCCC"].CGColor;
    headImageView.layer.cornerRadius = 4;
    headImageView.layer.masksToBounds = YES;
    headImageView.backgroundColor = [UIColor clearColor];
    
    CGFloat textWidth = mainRect.size.width - headImageSize - rightLabelWidth - 5 * marginW;
    //名称
    chatNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(2 * marginW + headImageSize, marginW, textWidth, nameLabelHeight)];
    chatNameLabel.textColor = [Tool colorWithHexString:@"9ab3c9"];
    chatNameLabel.font = [UIFont boldSystemFontOfSize:16];
    chatNameLabel.backgroundColor = [UIColor clearColor];
    
    //内容
    chatContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(2 * marginW + headImageSize, marginW + nameLabelHeight, textWidth, contentLabelHeight)];
    chatContentLabel.textColor = [Tool colorWithHexString:@"9a9b9d"];
    chatContentLabel.font = [UIFont systemFontOfSize:14];
    chatContentLabel.backgroundColor = [UIColor clearColor];
    
    //时间
    messageTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(3 * marginW + headImageSize + textWidth, marginW, rightLabelWidth, timeLabelHeight)];
    messageTimeLabel.textColor = [Tool colorWithHexString:@"9a9b9d"];
    messageTimeLabel.font = [UIFont systemFontOfSize:12];
    messageTimeLabel.textAlignment = NSTextAlignmentCenter;
    messageTimeLabel.backgroundColor = [UIColor clearColor];
    
    //信息数
    messageNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(3 * marginW + headImageSize + textWidth, marginW + timeLabelHeight, rightLabelWidth, messageNumLabelHeight)];
    messageNumLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    messageNumLabel.layer.borderWidth = 1;
    messageNumLabel.layer.cornerRadius = messageNumLabelHeight / 2;
    messageNumLabel.layer.masksToBounds = YES;
    messageNumLabel.textAlignment = NSTextAlignmentCenter;
    messageNumLabel.textColor = [UIColor whiteColor];
    messageNumLabel.backgroundColor = [Tool colorWithHexString:@"eb6876"];
    
    [self.contentView addSubview:headImageView];
    [self.contentView addSubview:chatNameLabel];
    [self.contentView addSubview:chatContentLabel];
    [self.contentView addSubview:messageTimeLabel];
    [self.contentView addSubview:messageNumLabel];
}
- (void)awakeFromNib {}

//填充数据
- (void)initData:(ChatUserStruct *)chatUser {
    NSString *dataId = chatUser.dataId;
    //普通消息
    if ([chatUser.chatType isEqualToString:@"user"]) {
        UserData *user = [UserDataManage getUser:dataId];
        [self initUserData:user];
    //群消息
    } else if ([chatUser.chatType isEqualToString:@"group"]) {
        GroupStruct *group = [GroupDataManage getGroup:dataId];
        [self initGroupStruct:group];
        //未读消息数
        int tipsNumber = [chatUser getUnReadAmount];
        if (tipsNumber > 0) {
            messageNumLabel.text = [NSString stringWithFormat:@"%d", tipsNumber];
            messageNumLabel.hidden = NO;
        } else {
            messageNumLabel.hidden = YES;
        }
    //请求加好友消息
    } else if ([chatUser.chatType isEqualToString:@"addFriendRequest"]) {
        [self userSystemCell:dataId tips:@"用户 %@ 请求加您为好友"];
    //同意加好友消息
    } else if ([chatUser.chatType isEqualToString:@"agreeAddFriend"]) {
        [self userSystemCell:dataId tips:@"用户 %@ 同意加您为好友"];
    //拒绝加好友消息
    } else if ([chatUser.chatType isEqualToString:@"refuseAddFriend"]) {
        [self userSystemCell:dataId tips:@"用户 %@ 拒绝加您为好友"];
    //同意加群消息
    } else if ([chatUser.chatType isEqualToString:@"agreeAddGroup"]) {
        [self groupSystemCell:dataId tips:@"群 {group} 同意了您的加群请求"];
    } else if ([chatUser.chatType isEqualToString:@"refuseAddGroup"]) {
        [self groupSystemCell:dataId tips:@"群 {group} 拒绝了您的加群请求"];
    } else if ([chatUser.chatType isEqualToString:@"dissolveGroup"]) {
        [self groupSystemCell:dataId tips:@"群 {group} 的创建者解散了该群" ];
    } else if ([chatUser.chatType isEqualToString:@"removeMeFromGroup"]) {
        [self groupSystemCell:dataId tips:@"群 {group} 的创建者将您移除了该群"];
    } else if ([chatUser.chatType isEqualToString:@"removeOtherFromGroup"]) {
        NSString *tips = [[NSString alloc] initWithFormat:@"{group} 的创建者将用户 %@ 移出了该群", chatUser.additionalMessage];
        [self groupSystemCell:dataId tips:tips];
    } else if ([chatUser.chatType isEqualToString:@"inviteMeToGroup"]) {
        [self groupSystemCell:dataId tips:@"群 %@ 的创建者将您加入了该群"];
    } else if ([chatUser.chatType isEqualToString:@"addGroupRequest"]) {
        UserData *user = [UserDataManage getUser:chatUser.additionalUserId];
        NSString *tips = [[NSString alloc] initWithFormat:@"用户 %@ 申请加入群 {group}", [user getUserName]];
        [self groupSystemCell:dataId tips:tips];
    }
    
    /*headImageView.image = [UIImage imageNamed:@"SPEAKER_32x32-32.png"];
    chatNameLabel.text = @"用户 测试人员 请求加您为好友";
    messageNumLabel.text = @"5";
    messageNumLabel.hidden = NO;
    messageTimeLabel.text = @"13:00";*/
}

- (void)initUserData:(UserData *)user {
    NSString *headURL = [user getHeadImage];
    headImageView.isGrayImage = NO;
    if ([headURL isEqualToString:@"OfflineHead1.png"] || [headURL isEqualToString:@"DefaultHead.png"]) {
        headImageView.image = [UIImage imageNamed:headURL];
    } else {
        headImageView.isGrayImage = ([user getStatus] == UserStatusOffline);
        headImageView.imageURL = headURL;
    }
    if ([user getStatus] == UserStatusLeave || [user getStatus] == UserStatusBusy) {
        UIImageView *stateIcon = (UIImageView *)[headImageView viewWithTag:-11];
        if (!stateIcon) {
            stateIcon = [[UIImageView alloc] initWithFrame:CGRectMake(headImageView.frame.size.width - 20, headImageView.frame.size.height - 20, 20, 20)];
            stateIcon.tag = -11;
            [headImageView addSubview:stateIcon];
        }
        if ([user getStatus] == UserStatusLeave) {
            stateIcon.image = [UIImage imageNamed:@"status_leave"];
        } else if ([user getStatus] == UserStatusBusy) {
            stateIcon.image = [UIImage imageNamed:@"status_busy"];
        }
    } else {
        UIImageView *stateIcon = (UIImageView *)[headImageView viewWithTag:-11];
        if (stateIcon) {
            [stateIcon removeFromSuperview];
        }
    }
    chatNameLabel.text = [user getUserName];
    chatContentLabel.text = [user idiograph];
    //未读消息数
    if (user.unReadAmount > 0) {
        messageNumLabel.text = [NSString stringWithFormat:@"%d", user.unReadAmount];
        messageNumLabel.hidden = NO;
    } else {
        messageNumLabel.hidden = YES;
    }
    headImageView.userInteractionEnabled = YES;
    headImageView.tag = -1;
}


- (void)initGroupStruct:(GroupStruct *)group {
    headImageView.isGrayImage = NO;
    headImageView.image = [UIImage imageNamed:@"grouphead.png"];
    chatNameLabel.text = group.groupName;
    messageNumLabel.hidden = YES;
}

- (void)userSystemCell:(NSString*)userId tips:(NSString*)tips {
    UserData *user = [UserDataManage getUser:userId];
    headImageView.isGrayImage = NO;
    headImageView.image = [UIImage imageNamed:@"SPEAKER_32x32-32.png"];
    chatNameLabel.text = [[NSString alloc] initWithFormat:tips, [user getUserName]];
}

- (void)groupSystemCell:(NSString*)groupId tips:(NSString*)tips {
    GroupStruct *group = [GroupDataManage getSystemGourpData:groupId];
    headImageView.isGrayImage = NO;
    headImageView.image = [UIImage imageNamed:@"SPEAKER_32x32-32.png"];
    chatNameLabel.text = [tips stringByReplacingOccurrencesOfString:@"{group}" withString:group.groupName];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
