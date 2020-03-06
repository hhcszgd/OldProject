//
//  BuyNumCell.m
//  TTmall
//
//  Created by 0 on 16/3/7.
//  Copyright © 2016年 Footway tech. All rights reserved.
//

#import "HBuyNumberItem.h"

@interface HBuyNumberItem()<UITextFieldDelegate>
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UIButton *subtructButton;
@property (nonatomic, strong) UIButton *addButton;


@end
@implementation HBuyNumberItem
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
        [self.contentView addSubview:_backView];
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
//        self.contentView.backgroundColor = randomColor;
        
        
        UILabel *titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            
        }];
        [titleLabel sizeToFit];

        [titleLabel configmentfont:[UIFont systemFontOfSize:13 * zkqScale] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:NSTextAlignmentCenter cornerRadius:0 text:@"数量"];
       
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(self.contentView.mas_left).offset(10);
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
    if ([self.countLabel.text integerValue] < 2) {
        self.subtructButton.enabled = NO;
        return;
    }
    NSString *count = [NSString stringWithFormat:@"%ld",[self.countLabel.text integerValue] - 1];
    self.countLabel.text = count;
    
}
- (void)add:(UIButton *)button{
    self.subtructButton.enabled = YES;
    if ([self.countLabel.text integerValue] == [_storeCount integerValue]) {
        if ([self.delegate respondsToSelector:@selector(addNumberOfStore)]) {
            self.addButton.enabled = NO;
            [self.delegate performSelector:@selector(addNumberOfStore) withObject:nil];
        }
        return;
    }
    NSString *count = [NSString stringWithFormat:@"%ld",[self.countLabel.text integerValue] + 1];
    self.countLabel.text = count;
   
}




////显示键盘
//- (void)keyboadWillShow:(NSNotification *)notification{
//    UIWindow *window = [[UIApplication sharedApplication].delegate window];
//    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, screenH, screenW, 40)];
//    _backView.backgroundColor = [UIColor redColor];
//    
//    UIButton *endBtn = [[UIButton alloc] initWithFrame:CGRectMake(screenW - 60, 5, 50, 30)];
//    [endBtn setBackgroundColor:[UIColor blueColor]];
//    [endBtn addTarget:self action:@selector(endButton:) forControlEvents:UIControlEventTouchUpInside];
//    [endBtn setTitle:@"完成" forState:UIControlStateNormal];
//    [_backView addSubview:endBtn];
//    
//    
//    [window addSubview:_backView];
//    NSDictionary *dic = [notification userInfo];
//    CGSize keyboardSize = [[dic objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
//    //键盘弹上来的时间
//    CGFloat duration = [[dic objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
//    
//    UICollectionView *collectionView = (UICollectionView *)self.nextResponder;
//    [UIView animateWithDuration:duration animations:^{
//        collectionView.contentInset = UIEdgeInsetsMake(-keyboardSize.height- 40, 0, 0, 0);
//        
//        _backView.frame = CGRectMake(0, screenH - keyboardSize.height - 40, screenW, 40);
//        
//    }];
//    
//    
//}
////键盘消失
//- (void)keyboardWillHide:(NSNotification *)notification{
//    NSDictionary *dic = [notification userInfo];
////    CGSize keyboardSize = [[dic objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
//    //键盘弹上来的时间
//    CGFloat duration = [[dic objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
//    
//    UICollectionView *collectionView = (UICollectionView *)self.nextResponder;
//    [UIView animateWithDuration:duration animations:^{
//        _backView.frame = CGRectMake(0, screenH, screenW, 40);
//        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    }];
//}
//完成按钮的方法。
//- (void)endButton:(UIButton *)button{
//    [_textField resignFirstResponder];
//}

- (void)dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}




@end
