//
//  ViewController.m
//  HYNetworkType
//
//  Created by 胡杨 on 2017/4/27.
//  Copyright © 2017年 net.fitcome.www. All rights reserved.
//

#import "ViewController.h"
#import <objc/message.h>

@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self ivalList];
    
    [self dataNetworkType];
    
}

- (void)dataNetworkType {
    UIApplication *application = [UIApplication sharedApplication];
    NSArray *children = [[[application valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            id type = [child valueForKeyPath:@"dataNetworkType"];
            NSLog(@" type class is %@, value is %@", [type class], type);
            //  经过测试，发现，可能的值为 1，2，3，5 分别对应的网络状态是2G、3G、4G及WIFI。 当没有网络时，隐藏UIStatusBarDataNetworkItemView，无法获取dataNetworkType值
        }
    }
    
}

- (void)ivalList {
    // 状态栏是由当前app控制的，首先获取当前app
    UIApplication *app = [UIApplication sharedApplication];
    // 遍历当前app的所有属性，找到关于状态栏的
    unsigned int outCount = 0;
    Ivar *ivars = class_copyIvarList(app.class, &outCount);
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivars[i];
        printf("|  %s \n", ivar_getName(ivar));
    }
    
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            NSLog(@" class %@", [child class]);
            unsigned int outCount = 0;
            Ivar *ivars = class_copyIvarList([child class], &outCount);
            
            for (int i = 0; i < outCount; i++) {
                Ivar ivar = ivars[i];
                printf("-- %s \n", ivar_getName(ivar));
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
