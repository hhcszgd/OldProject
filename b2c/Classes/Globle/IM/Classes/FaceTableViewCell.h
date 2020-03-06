//
//  FaceTableViewCell.h
//  IOSCim
//
//  Created by apple apple on 11-7-13.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FaceTableViewCell : UITableViewCell 
{
	BOOL notRepeat;
	NSMutableArray *faceButtons;
	id delegate;
	BOOL isLast;
}


@property (nonatomic, retain) id delegate;


- (void)build:(NSInteger)row;

@end
