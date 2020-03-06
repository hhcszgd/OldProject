//
//  GCCell.m
//  b2c
//
//  Created by 0 on 16/4/8.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "GCCell.h"
#import "HSearchgoodsListVC.h"
#import "GCSimilargoodsVC.h"
#import "b2c-Swift.h"
@interface GCCell()
/**图片*/
@property (nonatomic, strong) UIImageView *gcImageView;
/**介绍*/
@property (nonatomic, strong) UILabel *gcTitleLabel;
/**价格*/
@property (nonatomic, strong) UILabel *gcPriceLabel;
/**找相似*/
@property (nonatomic, strong) ActionBaseView *gcFindSimilarity;

@end
@implementation GCCell

/**懒加载baseView让*/



- (UIImageView *)gcImageView{
    if (_gcImageView == nil) {
        _gcImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_gcImageView];
    }
    return _gcImageView;
}
- (UILabel *)gcTitleLabel{
    if (_gcTitleLabel == nil) {
        _gcTitleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_gcTitleLabel];
    }
    return _gcTitleLabel;
}
- (UILabel *)gcPriceLabel{
    if (_gcPriceLabel == nil) {
        _gcPriceLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_gcPriceLabel];
    }
    return _gcPriceLabel;
}
- (ActionBaseView *)gcFindSimilarity{
    if (_gcFindSimilarity == nil) {
        _gcFindSimilarity = [[ActionBaseView alloc] init];
        [self.contentView addSubview:_gcFindSimilarity];
    }
    return _gcFindSimilarity;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configmentUI];
    }
    return self;
}

- (void)configmentUI{
    //布局gcImageView
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.width.equalTo(@(screenW));
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.lessThanOrEqualTo(@(screenW));
    }];
    
    [self.gcImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
        make.width.equalTo(@(80));
        make.height.equalTo(self.gcImageView.mas_width);
        
    }];
    self.gcImageView.image = [UIImage imageNamed:@"lottery_withoutChannce"];
//    self.gcImageView.backgroundColor = randomColor;
    //布局gcTitleLabel
    [self.gcTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //让gctitlelabel根据照片布局
        make.top.equalTo(self.gcImageView.mas_top).offset(5);
        make.left.equalTo(self.gcImageView.mas_right).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-5);

    }];
    [self.gcTitleLabel sizeToFit];
    [self.gcTitleLabel setNumberOfLines:2];
   //根据字体确定两行字的高度
    NSString *str = @"我";
    CGSize fontSize = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    
    //布局价格label
    [self.gcPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.gcTitleLabel.mas_top).offset(5 + fontSize.height * 2 + 1);
        make.left.equalTo(self.gcImageView.mas_right).offset(5);
        
    }];
    [self.gcPriceLabel sizeToFit];
    //布局找相似
    [self.gcFindSimilarity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.gcTitleLabel.mas_top).offset(10 + fontSize.height *2 +1);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
         make.width.equalTo(@(40));
        make.height.equalTo(@(30));
    }];
    [self.gcFindSimilarity addTarget:self action:@selector(findAimilarity:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *findLabel = [[UILabel alloc] init];
    [self.gcFindSimilarity addSubview:findLabel];
    [findLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.gcFindSimilarity);
    }];
    [findLabel configmentfont:[UIFont systemFontOfSize:13] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:0 text:@"找相似"];
    //line
    UIView *lineView = [[UIView alloc] init];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(0);
         make.width.equalTo(@(screenW + 80));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
        make.height.equalTo(@(1));
    }];
    lineView.backgroundColor = BackgroundGray;
}

- (void)layoutSubviews{
    
}
- (void)setGcModel:(GCModel *)gcModel{
    _gcModel = gcModel;
    LOG(@"%@,%d,%@",[self class], __LINE__,gcModel.full_name)
    
    
    
    [self.gcTitleLabel configmentfont:[UIFont systemFontOfSize:13] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:gcModel.short_name];
    [self.gcPriceLabel configmentfont:[UIFont systemFontOfSize:12] textColor:[UIColor redColor] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:[NSString stringWithFormat:@"￥%@",gcModel.price]];
    
    
}
//跳转到找相似页面
- (void)findAimilarity:(ActionBaseView *)actionView{
#pragma mark 使用keyVC跳转到了相似产品页面
    HSearchgoodsListVC *similarVC = [[HSearchgoodsListVC alloc] init];
    similarVC.classifyID = 3102;
//    [[KeyVC shareKeyVC] pushViewController:similarVC animated:YES];
    [[GDKeyVC share] presentViewController:similarVC animated:YES  completion:nil ];
}
@end
