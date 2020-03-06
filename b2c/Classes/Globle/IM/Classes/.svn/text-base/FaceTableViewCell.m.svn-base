//
//  FaceTableViewCell.m
//  IOSCim
//
//  Created by apple apple on 11-7-13.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "FaceTableViewCell.h"
#import "Config.h"
#import "MyNotificationCenter.h"

@implementation FaceTableViewCell
@synthesize delegate;


- (void)build:(NSInteger)row 
{
	NSInteger faceCount = [Config getFaceCount];
	CGFloat contentWidth = self.frame.size.width;
	//NSLog(@"content width is %f", contentWidth);
	
	CGFloat leftPoint = contentWidth / 7;

	if (faceButtons == nil)
	{
		faceButtons = [[NSMutableArray alloc] init];
	}
	
	for (int i=0; i<7; i++) 
	{
		
		if (row*7 + i > faceCount) 
		{
			isLast = YES;
		}
		
		if (!notRepeat)
		{
			UIButton *faceButton = [[UIButton alloc] initWithFrame:CGRectMake(i*leftPoint + 10, 15, 20, 20)];
			[self addSubview:faceButton];
			[faceButtons addObject:faceButton];
		}
		
		NSString *faceImageName = [[NSString alloc] initWithFormat:@"f%d.gif", row*7 + i];
		UIButton *faceButtonInArray = [faceButtons objectAtIndex:i];
		
		if (!isLast)
		{
			[faceButtonInArray setImage:[UIImage imageNamed:faceImageName] 
							   forState:UIControlStateNormal];
			
			NSString *faceIndex = [[NSString alloc] initWithFormat:@"%d", row*7 + i];
			
			[faceButtonInArray setTitle:faceIndex forState:UIControlStateNormal];
			
			[faceButtonInArray addTarget:self
								  action:@selector(clickFaceButton:) 
						forControlEvents:UIControlEventTouchUpInside];
			
		}
	}
	
	notRepeat = YES;
}


- (void)clickFaceButton:(UIButton*)faceButt
{
	NSString *faceIndex = [faceButt titleForState:UIControlStateNormal];
	[delegate performSelector:@selector(inputFaceMessage:) withObject:faceIndex];
	//NSLog(@"%@ ---------", faceIndex);
	//[MyNotificationCenter postNotification:SystemEventChooseFace setParam:faceIndex];
	//[faceIndex release];
}


@end
