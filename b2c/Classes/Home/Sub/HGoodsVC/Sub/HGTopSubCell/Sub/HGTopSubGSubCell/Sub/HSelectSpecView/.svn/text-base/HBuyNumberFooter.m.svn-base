//
//  HBuyNumberFooter.m
//  b2c
//
//  Created by 0 on 16/5/31.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HBuyNumberFooter.h"


@interface HBuyNumberFooter()<UITextFieldDelegate>
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UIButton *subtructButton;
@property (nonatomic, strong) UIButton *addButton;


@end
@implementation HBuyNumberFooter
- (UILabel *)countLabel{
    if (_countLabel == nil) {
        _countLabel = [[UILabel alloc] init];
        [self.backView addSubview:_countLabel];
        [_countLabel configmentfont:[UIFont systemFontOfSize:13 * zkqScale] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:0 text:@"1"];
        
    }
    return _countLabel;
}
- (UIView *)backView{
    if (_backView == nil) {
        _backView = [[UIView alloc] init];
        [self addSubview:_backView];
        _backView.layer.cornerRadius = 2 * zkqScale;
        _backView.layer.masksToBounds = YES;
        _backView.layer.borderColor = [[UIColor colorWithHexString:@"f4f4f4"] CGColor];
        _backView.layer.borderWidth = 1;
    }
    return _backView;
}
- (UIButton *)subtructButton{
    if (_subtructButton == nil) {
        _subtructButton = [[UIButton alloc] init];
        [self.backView addSubview:_subtructButton];
        [_subtructButton setImage:[UIImage imageNamed:@"but_minus_normal"] forState:UIControlStateNormal];
        [_subtructButton setImage:[UIImage imageNamed:@"but_minus_disable"] forState:UIControlStateDisabled];
        
        [_subtructButton addTarget:self action:@selector(subtruct:) forControlEvents:UIControlEventTouchUpInside];
        _subtructButton.layer.borderColor = [[UIColor colorWithHexString:@"f4f4f4"] CGColor];
        _subtructButton.layer.borderWidth = 1;
        _subtructButton.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    }
    return _subtructButton;
}
- (UIButton *)addButton{
    if (_addButton == nil) {
        _addButton = [[UIButton alloc] init];
        [self.backView addSubview:_addButton];
        [_addButton setImage:[UIImage imageNamed:@"bg_add_normal"] forState:UIControlStateNormal];
        [_addButton setImage:[UIImage imageNamed:@"bg_add_disable"] forState:UIControlStateDisabled];
        [_addButton addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
        _addButton.layer.borderWidth = 1;
        _addButton.layer.borderColor = [[UIColor colorWithHexString:@"f4f4f4"] CGColor];
        _addButton.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    }
    return _addButton;
}



- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        UILabel *titleLabel = [[UILabel alloc] init];
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(10);
            make.left.equalTo(self.mas_left).offset(10);
            
        }];
        [titleLabel sizeToFit];
        
        [titleLabel configmentfont:[UIFont systemFontOfSize:13 * zkqScale] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:NSTextAlignmentCenter cornerRadius:0 text:@"数量"];
        
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.top.equalTo(titleLabel.mas_bottom).offset(9);
            make.width.equalTo(@(86 * zkqScale));
            make.height.equalTo(@(26 * zkqScale));
            
        }];
        [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self.backView);
            make.width.equalTo(self.addButton.mas_height);
        }];
        [self.subtructButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self.backView);
            make.width.equalTo(self.subtructButton.mas_height);
        }];
        [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.backView);
            make.left.equalTo(self.subtructButton.mas_right).offset(0);
            make.right.equalTo(self.addButton.mas_left).offset(0);
        }];
        
        
        
        
        //        //显示数字的框
        //        UITextField *textField = [[UITextField alloc] init];
        //        _textField = textField;
        //        [self.contentView addSubview:textField];
        //
        //        [subtructButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.right.equalTo(textField.mas_left).offset(-1);
        //            make.centerY.equalTo(textField.mas_centerY);
        //             make.width.equalTo(@(30));
        //            make.height.equalTo(@(30));
        //        }];
        //        [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.equalTo(textField.mas_right).offset(1);
        //            make.centerY.equalTo(textField.mas_centerY);
        //             make.width.equalTo(@(30));
        //            make.height.equalTo(@(30));
        //        }];
        //
        //
        //
        //        textField.backgroundColor = [UIColor whiteColor];
        //        textField.font = [UIFont systemFontOfSize:15];
        //        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.centerY.equalTo(self.contentView.mas_centerY);
        //            make.centerX.equalTo(self.contentView.mas_centerX).offset(100);
        //             make.width.equalTo(@(30));
        //            make.height.equalTo(@(30));
        //        }];
        //        textField.text = @"1";
        //        textField.textAlignment = NSTextAlignmentCenter;
        //        textField.delegate = self;
        //        textField.backgroundColor = [UIColor whiteColor];
        //        textField.keyboardType = UIKeyboardTypeNumberPad;
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboadWillShow:) name:UIKeyboardWillShowNotification object:nil];
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
        
    }
    return self;
}

- (void)subtruct:(UIButton *)button{
    self.addButton.enabled = YES;
    NSString *count = [NSString stringWithFormat:@"%ld",[self.countLabel.text integerValue] - 1];
    self.countLabel.text = count;
    if ([self.delegate respondsToSelector:@selector(subtructNumberOfStoreWith:)]) {
        [self.delegate performSelector:@selector(subtructNumberOfStoreWith:) withObject:self.countLabel.text];
    }
    if ([self.countLabel.text integerValue] < 2) {
        self.subtructButton.enabled = NO;
        return;
    }
    
    
}
- (void)add:(UIButton *)button{
    if ([self.countLabel.text isEqualToString:self.storeCount]) {
        button.enabled = NO;
        if ([self.delegate respondsToSelector:@selector(addNumberOfStoreWith:)]) {
            [self.delegate performSelector:@selector(addNumberOfStoreWith:) withObject:self.storeCount];
        }
        return;
    }else{
        self.subtructButton.enabled = YES;
    }
    NSString *count = [NSString stringWithFormat:@"%ld",[self.countLabel.text integerValue] + 1];
    self.countLabel.text = count;

    if ([self.countLabel.text integerValue] == [self.storeCount integerValue]) {
        if ([self.delegate respondsToSelector:@selector(addNumberOfStoreWith:)]) {
            self.addButton.enabled = NO;
            [self.delegate performSelector:@selector(addNumberOfStoreWith:) withObject:self.storeCount];
        }
        return;
    }else{
        if ([self.delegate respondsToSelector:@selector(addNumberOfStoreWith:)]) {
            
            [self.delegate performSelector:@selector(addNumberOfStoreWith:) withObject:self.countLabel.text];
        }
    }
    
    
    
}

- (void)setStoreCount:(NSString *)storeCount{
    if ([storeCount isEqualToString:@"1"]) {
        self.addButton.enabled = NO;
        self.subtructButton.enabled = NO;
    }else if ([storeCount isEqualToString:@"0"]) {
        self.countLabel.text = @"0";
        self.addButton.enabled = NO;
        self.subtructButton.enabled = NO;
    }else{
        //每次变换规格的时候都将数量变成1
        self.countLabel.text = @"1";
        self.addButton.enabled = YES;
        self.subtructButton.enabled = NO;
    }
    
}


- (void)dealloc{
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

@end
