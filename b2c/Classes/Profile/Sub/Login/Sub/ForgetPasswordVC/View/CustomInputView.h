//
//  CustomInputView.h
//  b2c
//
//  Created by wangyuanfei on 16/6/7.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//
/**
 @property(nonatomic) UIKeyboardType keyboardType;                         // default is UIKeyboardTypeDefault
 @property(nonatomic) UIKeyboardAppearance keyboardAppearance;             // default is UIKeyboardAppearanceDefault
 @property(nonatomic) UIReturnKeyType returnKeyType;   */
#import <UIKit/UIKit.h>

@class CustomInputView;

@protocol CustomInputViewDelegate <NSObject>

-(void)customInputTextFieldShouldReturn:(CustomInputView*)customInputView;

@end

@interface CustomInputView : UIView
@property(nonatomic,weak)id <CustomInputViewDelegate> CustomInputDelegate ;
@property(nonatomic,copy)NSString * tipsTitle ;
@property(nonatomic,copy)NSString * inputPlaceholder ;
@property(nonatomic,copy)NSString * inputText ;
@property(nonatomic,copy,readonly)NSString * currentText ;
//@property(nonatomic,strong)UIColor * backColor ;
@property(nonatomic,assign)CGFloat  leftWidth ;
@property(nonatomic,strong)UIFont * textFont ;
@property(nonatomic,strong)UIFont * currentFont ;
@property(nonatomic,strong)UIColor * tipTitleColor ;
@property(nonatomic,strong,readonly)UIColor * inputTextColor ;
@property(nonatomic,assign)UIReturnKeyType  customReturenType ;
@property(nonatomic,assign) UIKeyboardType customKeyboardType;
@property(nonatomic,assign) BOOL secureTextEntry;

@end
