//
//  CustomInputView.m
//  b2c
//
//  Created by wangyuanfei on 16/6/7.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "CustomInputView.h"

@interface CustomInputView()<UITextFieldDelegate>

@property(nonatomic,weak)UILabel * tipsLabel ;
@property(nonatomic,weak)UITextField * inputTextField ;
@property(nonatomic,weak)UIView * bottomLine ;

@end

@implementation CustomInputView
/** 
 @property(nonatomic,assign)UIReturnKeyType  customReturenType ;
 @property(nonatomic,assign) UIKeyboardType customKeyboardType;
 */
-(void)setCustomKeyboardType:(UIKeyboardType)customKeyboardType{
    self.inputTextField.keyboardType = customKeyboardType;
}
-(void)setCustomReturenType:(UIReturnKeyType)customReturenType{
    self.inputTextField.returnKeyType = customReturenType;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        UILabel * tipsLabel = [[UILabel alloc]init];
        tipsLabel.textColor = MainTextColor;
        self.tipsLabel = tipsLabel;
        [self addSubview:tipsLabel];
        
        
        UITextField * inputTextField = [[UITextField alloc]init];
        [self addSubview:inputTextField];
        inputTextField.delegate = self;
        self.inputTextField = inputTextField;
        self.inputTextField.enablesReturnKeyAutomatically = YES;
        inputTextField.textColor = MainTextColor;
        
        UIView * bottomLine = [[UIView alloc]init];
        bottomLine.backgroundColor= BackgroundGray;
        self.bottomLine = bottomLine;
        [self addSubview:bottomLine];
        
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat margin = 10 ;
    CGFloat bottomH = 1 ;
    self.tipsLabel.frame = CGRectMake(margin, 0, self.leftWidth, self.bounds.size.height-bottomH);
    CGFloat inputTextFieldX = CGRectGetMaxX(self.tipsLabel.frame)+margin;
    self.inputTextField.frame = CGRectMake(inputTextFieldX, 0, self.bounds.size.width-inputTextFieldX, self.bounds.size.height-bottomH);
    self.bottomLine.frame =CGRectMake(0, self.bounds.size.height-bottomH, self.bounds.size.width, bottomH);
    
}
#pragma mark 输入框代理，点击return 按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.CustomInputDelegate respondsToSelector:@selector(customInputTextFieldShouldReturn:)]) {
        [self.CustomInputDelegate customInputTextFieldShouldReturn:self];
    }
    //判断输入的是否为验证图片中显示的验证码
//    if ([self.inputTextField.text isEqualToString:self.authCodeView.authCodeStr])
//    {
//        //正确弹出警告款提示正确
//        UIAlertView *alview = [[UIAlertView alloc] initWithTitle:@"恭喜您 ^o^" message:@"验证成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alview show];
//    }
//    else
//    {
//        //验证不匹配，验证码和输入框抖动
//        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
//        anim.repeatCount = 1;
//        anim.values = @[@-20,@20,@-20];
//        //        [authCodeView.layer addAnimation:anim forKey:nil];
//        [self.inputTextField.layer addAnimation:anim forKey:nil];
//    }
    
    return YES;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setInputText:(NSString *)inputText{
    _inputText = inputText.copy;
    self.inputTextField.text=_inputText;
}
-(void)setTipsTitle:(NSString *)tipsTitle{
    _tipsTitle = tipsTitle.copy;
    self.tipsLabel.text = _tipsTitle;
}
-(NSString *)currentText{
    return self.inputTextField.text;
}
-(void)setInputPlaceholder:(NSString *)inputPlaceholder{
    _inputPlaceholder = inputPlaceholder.copy;
    self.inputTextField.placeholder = _inputPlaceholder;
}
-(void)setTipTitleColor:(UIColor *)tipTitleColor{
    _tipTitleColor = tipTitleColor;
    self.tipsLabel.textColor = _tipTitleColor;
}
-(void)setInputTextColor:(UIColor *)inputTextColor{
    _inputTextColor = inputTextColor;
    self.inputTextField.textColor = _inputTextColor;
}
-(void)setTextFont:(UIFont *)textFont{
    _textFont = textFont ;
    self.tipsLabel.font = _textFont;
    self.inputTextField.font = _textFont;
}
-(UIFont *)currentFont{
    if (self.tipsLabel.font) {
        return self.tipsLabel.font;
    }else{
        return  [UIFont systemFontOfSize:17];
    }
}
-(void)setSecureTextEntry:(BOOL)secureTextEntry{
    _secureTextEntry = secureTextEntry;
    self.inputTextField.secureTextEntry = secureTextEntry;
}
@end
