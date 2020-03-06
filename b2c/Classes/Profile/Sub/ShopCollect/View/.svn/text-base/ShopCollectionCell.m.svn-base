//
//  ShopCollectionCell.m
//  TTmall
//
//  Created by 0 on 16/3/18.
//  Copyright © 2016年 Footway tech. All rights reserved.
//

#import "ShopCollectionCell.h"

@interface ShopCollectionCell()
@property (nonatomic, strong) UIImageView *logo;
@property (nonatomic, strong) UILabel *full_name;
@property (nonatomic, strong) UILabel *newcount;
@property (nonatomic, strong) UILabel *shangxin;
@property (nonatomic, strong) ShopCollectionRightButton *button;



@end
@implementation ShopCollectionCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//店铺logo

- (UIImageView *)logo{
    if (_logo == nil) {
        _logo = [[UIImageView alloc] init];
        [self.contentView addSubview:_logo];
    }
    return _logo;
}
//店铺全名
- (UILabel *)full_name{
    if (_full_name == nil) {
        _full_name = [UILabel new];
        [self.contentView addSubview:_full_name];
        [_full_name configmentfont:[UIFont systemFontOfSize:15] textColor:[UIColor blackColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@""];
        [_full_name sizeToFit];
    }
    return _full_name;
}
//- (UILabel *)shangxin{
//    if (_shangxin == nil) {
//        _shangxin = [UILabel new];
//        [self.contentView addSubview:_shangxin];
//    }
//    return _shangxin;
//}
//- (UILabel *)newcount{
//    if ( _newcount == nil) {
//        _newcount = [UILabel new];
//        [self.contentView addSubview:_newcount];
//    }
//    return _newcount;
//}

- (ShopCollectionRightButton *)button{
    if (_button == nil) {
        _button = [[ShopCollectionRightButton alloc] init];
        [self.contentView addSubview:_button];
        [_button addTarget:self action:@selector(clearButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_button setTitle:@"收起" forState:UIControlStateNormal];
        [_button setTitle:@"放下" forState:UIControlStateSelected];
    }
    return _button;
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        

        self.button.backgroundColor = [UIColor whiteColor];
        
        [self.logo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
            make.width.equalTo(self.logo.mas_height);
        }];
        
        [self.full_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.logo.mas_right).offset(10);
            make.right.equalTo(self.button.mas_left).offset(0);
        }];
        

        
        
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self.contentView);
            make.width.equalTo(@(screenW/5.0));
            make.height.equalTo(@(90));
            
        }];
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(screenW));
            
        }];
        
        
        
       
    }
    return self;
}



- (void)clearButtonClick:(ShopCollectionRightButton *)button{
    button.selected = !button.selected;
    NSIndexPath *indexPath = [_tableView indexPathForCell:self];
    if (_myBlock == nil) {
        
    }else{
        _myBlock(indexPath);
    }
    

    
}

- (void)setModel:(SCModel *)model{
    _model = model;
    NSURL *url = ImageUrlWithString(model.logo);
    [self.logo sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"accountBiiMap"]options:SDWebImageCacheMemoryOnly];
    self.full_name.text = model.full_name;
    
//    self.button.backgroundColor = randomColor;
    
    
    
}



@end
