//
//  ConfirmOrderNormalCell.m
//  b2c
//
//  Created by wangyuanfei on 16/4/28.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "ConfirmOrderNormalCell.h"
#import "ConfirmOrderNormalCellModel.h"

#import "CustomDetailCell.h"

@interface ConfirmOrderNormalCell ()

@property(nonatomic,weak)CustomDetailCell  * content ;

@end


@implementation ConfirmOrderNormalCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        CustomDetailCell * content = [[CustomDetailCell alloc]init];
        self.content = content;
        [self.contentView addSubview:content];
        
        [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.contentView);
            make.height.equalTo(@55);
        }];
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self); 
            make.bottom.equalTo(self.content.mas_bottom);
        }];
        
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setNormalCellModel:(ConfirmOrderNormalCellModel *)normalCellModel{

    
    _normalCellModel = normalCellModel;
    self.content.leftTitle = normalCellModel.title;
    self.content.showBottomLine = YES;
    self.content.leftTitleFont = [UIFont systemFontOfSize:14];
//    self.content.customDetailCellModel=normalCellModel;
}
@end
