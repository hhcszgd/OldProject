//
//  BlankCell.m
//  b2c
//
//  Created by wangyuanfei on 7/29/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "BlankCell.h"

@implementation BlankCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO ;
    }
    return self;
}
@end
