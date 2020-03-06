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
        self.contentView.backgroundColor = BackgroundGray;
        [self.aptiudeImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.height.equalTo(@(0));
        }];
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(self.aptiudeImage.mas_bottom).offset(10);
        }];
        
    }
    return self;
}
- (void)setAptutudeModel:(HStoreAptitudeModel *)aptutudeModel{
    
    NSURL *iamgeUrl = ImageUrlWithString(aptutudeModel.image);
    
    [self.aptiudeImage sd_setImageWithURL:iamgeUrl placeholderImage:placeImage options:SDWebImageCacheMemoryOnly completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        CGFloat porpert = image.size.height* 1.0/image.size.width;
        if (porpert == 0) {
            [self.aptiudeImage mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(screenW - 40));
            }];
            
        }
        if (porpert > 1.0) {
            [self.aptiudeImage mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@((screenW - 40) * porpert));
            }];
        }
        
        if (porpert  < 1.0) {
            [self.aptiudeImage mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@((screenW - 40) * porpert));
            }];
        }
    }];
    
}

@end
