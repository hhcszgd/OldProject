//
//  AskAndfeedTopView.h
//  b2c
//
//  Created by 张凯强 on 16/7/9.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//



#import "ActionBaseView.h"
/**用来标记view的位置*/
typedef enum {
    /**左边位置的按钮*/
    leftAcionView = 0,
    rightActionView
}viewFrame;
@protocol AskAndfeedTopViewDelegate <NSObject>

/**按钮的点击代理方法*/
- (void)askAndfeedTopView:(id)object;

@end


@interface AskAndfeedTopView : ActionBaseView
/**左边按钮的标题*/
@property (nonatomic, strong)UILabel * leftTitleLabel;
/**右边按钮的标题*/
@property (nonatomic,strong) UILabel *rightTitleLabel;
/**根据viewFrame属性来确定控件中别选中的时候下划线的位置*/
@property (nonatomic, weak) id <AskAndfeedTopViewDelegate>delegate;
@end
