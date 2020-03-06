//
//  HGTopSubEDetailCell.m
//  b2c
//
//  Created by 0 on 16/5/9.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HGTopSubEDetailCell.h"
#import "SpecSubItemsModel.h"
@interface HGTopSubEDetailCell()<HindleFromSuperView>
@property (nonatomic, weak) UILabel *username;
@property (nonatomic, weak) UILabel *commentTimae;
@property (nonatomic, weak) UILabel *comentDetail;
@property (nonatomic, weak) UILabel *buyTime;

@property (nonatomic, weak) UILabel *secondCommentDetail;
@property (nonatomic, weak) UILabel *secondCommentTime;
@property (nonatomic, weak) UILabel *rankLabel;
@property (nonatomic, weak) UIImageView *userImage;
@property (nonatomic, weak) UIImageView *commentbackImage;
@property (nonatomic, weak) UIImageView *commentTopImage;
@property (nonatomic, strong) HGTopSubEModel *model;
/**卖家回复*/
@property (nonatomic, strong) UILabel *sellerReplyLabel;
@end
@implementation HGTopSubEDetailCell
- (UIImageView *)userImage{
    if (_userImage == nil) {
        UIImageView *userImage = [[UIImageView alloc] init];
        _userImage  = userImage;
        [self.contentView addSubview:userImage];
    }
    return _userImage;
}
- (UILabel *)username{
    if (_username == nil) {
        UILabel *userName = [[UILabel alloc] init];
        _username = userName;
        [self.contentView addSubview:userName];
        [userName configmentfont:[UIFont systemFontOfSize:13 * zkqScale] textColor:[UIColor colorWithHexString:@"999999"] backColor:[UIColor colorWithHexString:@"ffffff"] textAligement:0 cornerRadius:0 text:@""];
        [userName sizeToFit];
    }
    return _username;
}
- (UILabel *)commentTimae{
    if (_commentTimae == nil) {
        UILabel *commentTime = [[UILabel alloc] init];
        _commentTimae = commentTime;
        [self.contentView addSubview:commentTime];
        [commentTime configmentfont:[UIFont systemFontOfSize:12 * zkqScale] textColor:[UIColor colorWithHexString:@"999999"] backColor:[UIColor colorWithHexString:@"ffffff"] textAligement:0 cornerRadius:0 text:@""];
        
        [commentTime sizeToFit];
    }
    
    return _commentTimae;
}
- (UIImageView *)commentTopImage{
    if (_commentTopImage == nil) {
        UIImageView *image = [[UIImageView alloc] init];
        _commentTopImage = image;
        [self.contentView addSubview:image];
        _commentTopImage.image = [UIImage imageNamed:@"icon_evaluate_all_sel"];
        image.contentMode = UIViewContentModeScaleAspectFill| UIViewContentModeLeft;
        image.clipsToBounds = YES;
        
    }
    return _commentTopImage;
}
- (UIImageView *)commentbackImage{
    if (_commentbackImage == nil) {
        UIImageView *image = [[UIImageView alloc] init];
        _commentbackImage = image;
        [self.contentView addSubview:image];
        image.contentMode = UIViewContentModeScaleToFill;
        image.image = [UIImage imageNamed:@"icon_evaluate_all_nor"];
    }
    return _commentbackImage;
}
- (UILabel *)comentDetail{
    if (_comentDetail == nil) {
        UILabel *label = [[UILabel alloc] init];
        _comentDetail = label;
        [self.contentView addSubview:label];
        [label configmentfont:[UIFont systemFontOfSize:13 * zkqScale] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor colorWithHexString:@"ffffff"] textAligement:0 cornerRadius:0 text:@"akdfjklasklfalksjlkfjaslkjflkajsklfjlkajklfdjalkjfklajklfjlkasjlkfjalks;flkaslk"];
        [label sizeToFit];
        [label setNumberOfLines:0];
    }
    return _comentDetail;
}
- (UILabel *)secondCommentTime{
    if (_secondCommentTime == nil) {
        UILabel *label = [[UILabel alloc] init];
        _secondCommentTime = label;
        [self.contentView addSubview:label];
        [label configmentfont:[UIFont systemFontOfSize:11 * zkqScale] textColor:[UIColor colorWithHexString:@"999999"] backColor:[UIColor colorWithHexString:@"ffffff"] textAligement:0 cornerRadius:0 text:@""];
        [label sizeToFit];
    }
    return _secondCommentTime;
}
- (UILabel *)secondCommentDetail{
    if (_secondCommentDetail == nil) {
        UILabel *lable = [[UILabel alloc] init];
        _secondCommentDetail = lable;
        [self.contentView addSubview:lable];
        [lable sizeToFit];
        [lable configmentfont:[UIFont systemFontOfSize:13 *zkqScale] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor colorWithHexString:@"ffffff"] textAligement:0 cornerRadius:0 text:@""];
        [lable setNumberOfLines:0];
    }
    return _secondCommentDetail;
}
- (UILabel *)rankLabel{
    if (_rankLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        _rankLabel = label;
        [self.contentView addSubview:label];
        [label sizeToFit];
        [label configmentfont:[UIFont systemFontOfSize:11 *zkqScale] textColor:[UIColor colorWithHexString:@"999999"] backColor:[UIColor colorWithHexString:@"ffffff"] textAligement:0 cornerRadius:0 text:@""];
    }
    return _rankLabel;
}
- (UILabel *)buyTime{
    if (_buyTime == nil) {
        UILabel *label = [[UILabel alloc] init];
        _buyTime = label;
        [self.contentView addSubview:label];
        [label configmentfont:[UIFont systemFontOfSize:11 *zkqScale] textColor:[UIColor colorWithHexString:@"999999"] backColor:[UIColor colorWithHexString:@"ffffff"] textAligement:0 cornerRadius:0 text:@""];
        [label sizeToFit];
    }
    return _buyTime;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}





- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        //布局userimage
        [self.userImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.width.equalTo(@(26 * zkqScale));
            make.height.equalTo(@(26 * zkqScale));
        }];
        
        self.userImage.layer.masksToBounds = YES;
        self.userImage.layer.cornerRadius = 26* zkqScale/2.0;
        //布局username
        //布局
        [self.username mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.userImage);
            make.left.equalTo(self.userImage.mas_right).offset(10);
        }];
        //布局
        [self.commentTimae mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.userImage);
            make.right.equalTo(self.contentView).offset(-10);
        }];
        
        //布局间隔线
        UIView *lineView1 = [[UIView alloc] init];
        [self.contentView addSubview:lineView1];
        lineView1.backgroundColor = BackgroundGray;
        [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.height.equalTo(@(1));
            make.top.equalTo(self.userImage.mas_bottom).offset(9);
            make.width.equalTo(@(screenW));
            
        }];
//        布局图片
        [self.commentbackImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.top.equalTo(lineView1.mas_bottom).offset(10);
             make.width.equalTo(@(103 ));
            make.height.equalTo(@(15 ));
            
        }];
        //布局图片
        [self.commentTopImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.commentbackImage.mas_top).offset(0);
            make.left.equalTo(self.commentbackImage.mas_left).offset(0);
             make.width.equalTo(@(103 ));
            make.height.equalTo(self.commentbackImage.mas_height);
        }];
//
        [self.comentDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.commentbackImage.mas_bottom).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);

            
        }];
//        
        [self.secondCommentTime mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.top.equalTo(self.comentDetail.mas_bottom).offset(25);
            
        }];
        
//
        [self.secondCommentDetail mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.secondCommentTime.mas_bottom).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.width.equalTo(@(screenW - 20));
        }];
        
        [self.rankLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.secondCommentDetail.mas_bottom).offset(25);
            make.left.equalTo(self.contentView.mas_left).offset(10);
        }];
        [self.buyTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rankLabel.mas_bottom).offset(10);
            make.left.equalTo(self.rankLabel.mas_left).offset(0);
        }];
        UIView *lineView2 = [[UIView alloc] init];
        [self.contentView addSubview:lineView2];
        lineView2.backgroundColor = BackgroundGray;
        [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.buyTime.mas_bottom).offset(16);
            make.left.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).offset(0);
            make.height.equalTo(@(10));
        }];
       
        
        
        
        
    }
    return self;
}
- (void)setEModel:(HGTopSubEModel *)eModel{
    
    self.model = eModel;
    if (eModel.items) {
        
        [self.secondCommentTime mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.top.equalTo(self.comentDetail.mas_bottom).offset(5);
            
        }];
        
        //
        [self.secondCommentDetail mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.secondCommentTime.mas_bottom).offset(5);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.width.equalTo(@(screenW - 20));
        }];
        
        [self.rankLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.secondCommentDetail.mas_bottom).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(10);
        }];
    }else{
        [self.secondCommentTime mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.top.equalTo(self.comentDetail.mas_bottom).offset(0);
            
        }];
        
        //
        [self.secondCommentDetail mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.secondCommentTime.mas_bottom).offset(0);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.width.equalTo(@(screenW - 20));
        }];
        
        [self.rankLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.secondCommentDetail.mas_bottom).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(10);
        }];
       
       
        
        

        
    }
    
    NSString *spec = @"类型:";
    
    if (eModel.spec && (eModel.spec.count > 0)) {
        for (SpecSubItemsModel *specModel in eModel.spec) {
            spec = [spec stringByAppendingFormat:@"%@  ",specModel.spec_val];
        }
    }else{
        spec= @"";
    }
    self.secondCommentTime.text = eModel.items.add_time;
    self.secondCommentDetail.text = eModel.items.content;
    NSURL *url = ImageUrlWithString(eModel.img);
    [self.userImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"accountBiiMap"] options:SDWebImageCacheMemoryOnly];
    self.username.text = eModel.username;
    self.commentTimae.text = eModel.pubdate;
    self.rankLabel.text = spec;
    self.comentDetail.text = eModel.content;
    self.buyTime.text = eModel.buydate;
    NSString *level = eModel.level;
    NSInteger proport = [level integerValue];
    CGFloat proportion = proport/5.0;
    [self.commentTopImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.commentbackImage.mas_top).offset(0);
        make.left.equalTo(self.commentbackImage.mas_left).offset(0);
        make.width.equalTo(@(103  * proportion));
        make.height.equalTo(self.commentbackImage.mas_height);
    }];
    
    
}

- (void)layoutSubviews{
    
}
@end
