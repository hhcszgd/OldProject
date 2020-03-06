//
//  GDTextView.m
//  b2c
//
//  Created by wangyuanfei on 7/24/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
/**
 自定义输入框
 */

#import "GDTextView.h"
#import "GDTextAttachment.h"
@implementation GDTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"重新赋值了");
//    self.sendText = attributedText.copy;
}
-(NSString *)sendStr{
    NSMutableString *string = [NSMutableString string];
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        GDTextAttachment * attach = attrs[@"NSAttachment"];
        if (attach) { // 如果是带有附件的富文本
            [string appendString:attach.desc];
            LOG(@"_%@_%d_%@",[self class] , __LINE__,attach);
        } else { // 普通的文本
            // 截取range范围的普通文本
            NSString *substr = [self.attributedText attributedSubstringFromRange:range].string;
            [string appendString:substr];
            LOG(@"_%@_%d_%@",[self class] , __LINE__,substr);
        }
        
    }];
    return string;
}


@end
