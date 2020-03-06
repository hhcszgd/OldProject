//
//  ClassifyBaseVC.h
//  b2c
//
//  Created by wangyuanfei on 3/23/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "BaseVC.h"
#import "CSearchBtn.h"
#import "HNaviCompose.h"
#import "HCellComposeModel.h"
@interface ClassifyBaseVC : SecondBaseVC
@property (nonatomic, strong)HNaviCompose  *messageButton;
-(void)message:(ActionBaseView*)sender;
@end
