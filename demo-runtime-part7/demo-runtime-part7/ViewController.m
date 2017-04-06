//
//  ViewController.m
//  demo-runtime-part7
//
//  Created by 融数 on 17/4/6.
//  Copyright © 2017年 tf-demos. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
@interface ViewController ()

@end
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    方法      方法名     方法实现
//    method0  method0   method0
//    method1  method1   method1
//    method2  method2   method2
    [self method0];
    Method result0 = class_getInstanceMethod([self class], @selector(method0));
    Method result1 = class_getInstanceMethod([self class], @selector(method1));
    Method result2 = class_getInstanceMethod([self class], @selector(method2));
    method_setImplementation(result0, method_getImplementation(result1));
    
//    方法      方法名     方法实现
//    method0  method0   method1
//    method1  method1   method1
//    method2  method2   method2
    [self method0];
    method_exchangeImplementations(result1, result2);
    
//    方法      方法名     方法实现
//    method0  method0   method1
//    method1  method1   method2
//    method2  method2   method1
    [self method1];
}

-(void)method0{
    NSLog(@">>>>>>>>0:%s",__func__);
}
-(void)method1{
    NSLog(@">>>>>>>>1:%s",__func__);
}
-(void)method2{
    NSLog(@">>>>>>>>2:%s",__func__);
}
@end
