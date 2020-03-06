//
//  ATasteView.h
//  b2c
//
//  Created by 张凯强 on 16/7/10.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

@protocol ATasteViewDelegate <NSObject>

- (void)back;

@end

#import <UIKit/UIKit.h>

@interface ATasteView : UIView
/**详细的体验内容*/
@property (strong, nonatomic) UITextView *textView;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, weak) id <ATasteViewDelegate>delegate;
@end
