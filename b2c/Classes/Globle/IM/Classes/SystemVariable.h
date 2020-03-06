//
//  SystemVariable.h
//  jzg
//
//  Created by apple on 14-4-5.
//  Copyright (c) 2014年 bzwzdsoft. All rights reserved.
//

#ifndef jzg_SystemVariable_h
#define jzg_SystemVariable_h

#define IS_GTE_IOS6 [[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0

#define IS_GTE_IOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0

#define IS_GTE_IOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0

#define IS_GTE_IPHONE_4   __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0

#endif
