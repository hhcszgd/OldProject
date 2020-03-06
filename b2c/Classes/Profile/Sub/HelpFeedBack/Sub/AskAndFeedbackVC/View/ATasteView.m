//
//  ATasteView.m
//  b2c
//
//  Created by 张凯强 on 16/7/10.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "ATasteView.h"
@interface ATasteView()<UITextViewDelegate>

/**提交按钮*/
@property (strong, nonatomic) UILabel *submit;
/**被选中的按钮*/
@property (strong, nonatomic) UIButton *selectBtn;

/**palceLabel*/
@property (strong, nonatomic) UILabel *placeLabel;
/**数据源*/
@property (strong, nonatomic) NSArray *data;


@end
@implementation ATasteView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame: frame]) {
        self.backgroundColor = BackgroundGray;
    }
    return self;
}



- (UITextView *)textView{
    if (_textView == nil) {
        _textView = [[UITextView alloc] init];
        [self addSubview:_textView];
        _textView.delegate = self;
        _textView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
        [_textView addSubview:self.placeLabel];
        _textView.font =[UIFont systemFontOfSize:14 * SCALE];
        self.placeLabel.frame = CGRectMake(12, 13, 0, 0);
        _textView.returnKeyType = UIReturnKeyDone;
        [self.placeLabel sizeToFit];
    }
    return _textView;
}
- (UILabel *)submit{
    if (_submit == nil) {
        _submit =[[UILabel alloc] init];
        [self addSubview:_submit];
        [_submit configmentfont:[UIFont systemFontOfSize:14 *SCALE] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor colorWithHexString:@"ffffff"] textAligement:1 cornerRadius:3 text:@"提交"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSubmit:)];
        _submit.userInteractionEnabled = YES;
        [_submit addGestureRecognizer:tap];
    }
    return _submit;
}
- (UILabel *)placeLabel{
    if (_placeLabel == nil) {
        _placeLabel = [[UILabel alloc]init];
        [self addSubview:_placeLabel];
        [_placeLabel configmentfont:[UIFont systemFontOfSize:14 *SCALE] textColor:[UIColor colorWithHexString:@"999999"] backColor:[UIColor clearColor] textAligement:1 cornerRadius:0 text:@"请描述一下您的问题"];
    }
    return _placeLabel;
}


- (void)clickSubmit:(UITapGestureRecognizer *)tap{
    NSLog(@"%@, %d ,%@",[self class],__LINE__,@"提交");
    NSLog(@"%@, %d ,%@",[self class],__LINE__,self.textView.text);
    NSLog(@"%@, %d ,%@",[self class],__LINE__,self.data[self.selectBtn.tag]);

    [[UserInfo shareUserInfo] postFeedBackDataWithquestionType:self.data[self.selectBtn.tag] questionDesc:self.textView.text Success:^(ResponseObject *responseObject) {
        NSLog(@"%@, %d ,%@",[self class],__LINE__,responseObject);
        if ([self.delegate respondsToSelector:@selector(back)]) {
            [self.delegate performSelector:@selector(back)];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@, %d ,%@",[self class],__LINE__,error);
        AlertInSubview(@"提交失败，请重复操作");

    }];
    

}

- (void)layoutSubviews{
}




- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.placeLabel.hidden = YES;
    
    
}



- (void)textViewDidChange:(UITextView *)textView{
    
}
- (void)textViewDidChangeSelection:(UITextView *)textView{
    if (textView.text.length > 100) {
        AlertInSubview(@"限制书写100字");
        [textView resignFirstResponder];
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (range.location >= 100) {
        AlertInSubview(@"只能输入100个字");
        [textView resignFirstResponder];
        return NO;
    }
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }else{
        return YES;
    }
    
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length == 0) {
        self.placeLabel.hidden = NO;
    }
}


- (void)setDataArr:(NSArray *)dataArr{
    
    /**组头的高度*/
    CGFloat topMargin = 10;
    /**组委的高度*/
    CGFloat bottomMargin = 10;
    /**每个button之间的间隔*/
    CGFloat margin = 10;//各个button左右之间的宽度
    /**行间距*/
    CGFloat lineMargin = 10;
    /**距离左边屏幕的距离*/
    CGFloat leftPadding = 20;
    /**布局的总宽度*/
    CGFloat totalW = 0;
    /**布局的总高度*/
    CGFloat totalH = 0;
    /**剩余的宽度*/
    CGFloat leaveW = 0;
    
    self.data = dataArr;
    totalW = leftPadding;
    totalH = topMargin;
    for (NSInteger i = 0; i < dataArr.count; i++) {
        NSString *title = dataArr[i];
        leaveW = screenW - 2 * leftPadding - totalW;
        CGSize size = [title sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName, nil]];
        CGSize btnSize = CGSizeMake(size.width + 30, size.height + 12);
        if (btnSize.width > leaveW) {
            totalW = leftPadding;
            totalH += lineMargin + btnSize.height;
        }
        UIButton *button =[[UIButton alloc] initWithFrame:CGRectMake(totalW, totalH, btnSize.width, btnSize.height)];
        button.tag = i;
        [button setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.layer.cornerRadius = 6;
        button.layer.masksToBounds = YES;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setTitle:title forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        button.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
        totalW += margin + btnSize.width;
        if (i == (dataArr.count - 1)) {
            [self btnClick:button];
        }
    }
    CGSize size = [@"我" sizeWithFont:[UIFont systemFontOfSize:14 ] MaxSize:CGSizeMake(100, 30)];
    totalH += bottomMargin + size.height+ 7 * 2 + lineMargin;
    self.textView.frame = CGRectMake(20, totalH, screenW - 40 , 148);
    self.submit.frame = CGRectMake(screenW - 76* SCALE -20, self.textView.frame.size.height + 7 + self.textView.frame.origin.y, 76 * SCALE, 31 * SCALE);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.textView resignFirstResponder];
}



- (void)btnClick:(UIButton *)button{
    button.selected = YES;
    NSLog(@"%@, %d ,%@",[self class],__LINE__,button.selected? @"1":@"0");

    if (self.selectBtn != button) {
        self.selectBtn.selected = NO;
        self.selectBtn.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    }else if ((self.selectBtn == button) &&(button.selected == NO)){
        button.selected = NO;
        [button setBackgroundColor:[UIColor colorWithHexString:@"ffffff"]];
    }
    NSLog(@"%@, %d ,%@",[self class],__LINE__,button.selected? @"1":@"0");

    if (button.selected) {
        self.selectBtn = button;
        button.backgroundColor = THEMECOLOR;
    }
    NSLog(@"%@, %d ,%@",[self class],__LINE__,button.selected? @"1":@"0");
    
}


@end
