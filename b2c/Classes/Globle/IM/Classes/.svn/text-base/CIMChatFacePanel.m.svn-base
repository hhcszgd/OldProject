//
//  CIMChatFacePanel.m
//  IOSCim
//
//  Created by apple apple on 11-9-1.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "CIMChatFacePanel.h"
#import "Config.h"

@implementation CIMChatFacePanel
@synthesize delegate;

- (void)init:(UIScrollView*)view {
	view.scrollEnabled = YES;
	NSInteger faceCount = [Config getFaceCount];
	int cellIndex = 0;
	int rowIndex = 0;
	int buttonSize = 45;
	
	for (int i=0; i<faceCount; i++) {
		if (cellIndex == 7) {
			rowIndex++;
			cellIndex = 0;
		}
		UIButton *faceButton = [[UIButton alloc] initWithFrame:CGRectMake(cellIndex*buttonSize, rowIndex*buttonSize, buttonSize, buttonSize)];
		NSString *faceImageName = [NSString stringWithFormat:@"f%d.gif", i];
		[faceButton setTag:i];
		[faceButton setImage:[UIImage imageNamed:faceImageName] forState:UIControlStateNormal];
		[faceButton addTarget:self action:@selector(clickFaceButton:) forControlEvents:UIControlEventTouchUpInside];
		[view addSubview:faceButton];
		cellIndex++;
	}
	view.contentSize = CGSizeMake(view.frame.size.width, (rowIndex + 3)*buttonSize);
}

- (void)clickFaceButton:(UIButton *)faceButt {
	NSString *faceIndex = [NSString stringWithFormat:@"%d", faceButt.tag];
	[delegate performSelector:@selector(inputFaceMessage:) withObject:faceIndex];
}

@end
