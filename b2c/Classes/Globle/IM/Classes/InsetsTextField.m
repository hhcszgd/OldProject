//
//  InsetsTextField.m
//  jzg
//
//  Created by apple on 14-4-9.
//  Copyright (c) 2014年 bzwzdsoft. All rights reserved.
//

#import "InsetsTextField.h"

@implementation InsetsTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
//控制文本所在的的位置，左右缩 10
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 10 , 0 );
}

//控制编辑文本时所在的位置，左右缩 10
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 10 , 0 );
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
