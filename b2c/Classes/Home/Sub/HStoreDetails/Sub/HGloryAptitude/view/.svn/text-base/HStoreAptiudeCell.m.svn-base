//
//  HStoreAptiudeCell.m
//  b2c
//
//  Created by 0 on 16/4/5.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HStoreAptiudeCell.h"
#import "HStoreAptitudeModel.h"
@interface HStoreAptiudeCell()
/**资质图片*/
@property (nonatomic, strong) UIImageView *aptiudeImage;
@end
@implementation HStoreAptiudeCell
- (UIImageView *)aptiudeImage{
    if (_aptiudeImage == nil) {
        _aptiudeImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_aptiudeImage];
    }
    return _aptiudeImage;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.aptiudeImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self.contentView);
            make.height.equalTo(@(100));
             make.width.equalTo(@(screenW));
        }];
        
    }
    return self;
}
- (void)setModel:(id)model{
    
    HStoreAptitudeModel *aptitudeModel = model;
    [self.aptiudeImage sd_setImageWithURL:[NSURL URLWithString:aptitudeModel.imageUrl] placeholderImage:[UIImage imageNamed:@"lottery_withoutChannce"]];
 
    CGFloat porpert = self.aptiudeImage.image.size.height *1.0/self.aptiudeImage.image.size.width;

    [self.aptiudeImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.contentView);
        make.height.equalTo(@(porpert * screenW));
         make.width.equalTo(@(screenW));
    }];
}

@end
