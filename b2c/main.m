//
//
//  main.m
//  b2c
//
//  Created by wangyuanfei on 3/22/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        [OneAPM startWithApplicationToken: @"82CD2D66B536DBEEBBF2EBD7AD59065F21"];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        
    }
}
