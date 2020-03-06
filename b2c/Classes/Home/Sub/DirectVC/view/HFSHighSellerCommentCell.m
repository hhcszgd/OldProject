//
//  HFSHighSellerCommentCell.m
//  b2c
//
//  Created by 0 on 16/4/6.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HFSHighSellerCommentCell.h"

@interface HFSHighSellerCommentCell()
@property (nonatomic, strong) UIImageView *heightImage;
@property (nonatomic, strong) UILabel *full_name;


@end
@implementation HFSHighSellerCommentCell
- (UIImageView *)heightImage{
    if (_heightImage == nil) {
        _heightImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_heightImage];
    }
    return _heightImage;
}
- (UILabel *)full_name{
    if (_full_name == nil) {
         _full_name = [[UILabel alloc] init];
        
        [self.contentView addSubview:_full_name];
        [_full_name configmentfont:[UIFont systemFontOfSize:12 * SCALE] textColor:[UIColor colorWithHexString:@"ffffff"] backColor:[[UIColor colorWithHexString:@"000000"] colorWithAlphaComponent:0.6] textAligement:1 cornerRadius:0.4 text:@""];
    }
    return _full_name;
}



- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self configmentUI];
    }
    return self;
}
- (void)configmentUI{
    [self.heightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.top.equalTo(self.contentView);
    }];
    [self.full_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.equalTo(@(20));
    }];
}
- (void)setCustomModel:(CustomCollectionModel *)customModel{
    if ([customModel.img isEqualToString:@"xxxxxx"]) {
        self.heightImage.image = [UIImage imageNamed:@"zhekouqu"];
    }else{
        NSURL *url = ImageUrlWithString(customModel.img);
        [self.heightImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"accountBiiMap"]options:SDWebImageCacheMemoryOnly];
    }
    self.full_name.text = customModel.short_name;
   
    
}
-(void)dealloc{
//    LOG(@"%@,%d,%@",[self class], __LINE__,@"销毁")
}


@end
