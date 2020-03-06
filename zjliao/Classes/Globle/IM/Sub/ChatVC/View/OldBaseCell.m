//
//  OldBaseCell.m
//  zjlao
//
//  Created by WY on 16/11/12.
//  Copyright © 2016年 com.16lao.zjlao. All rights reserved.
//

#import "OldBaseCell.h"
#import "ActionBaseView.h"

@interface OldBaseCell ()

@property(nonatomic,weak)ActionBaseView * actionView ;
@end


@implementation OldBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
