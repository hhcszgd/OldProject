//
//  PBaseCell.m
//  b2c
//
//  Created by wangyuanfei on 3/30/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "PBaseCell.h"

@implementation PBaseCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return self;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
