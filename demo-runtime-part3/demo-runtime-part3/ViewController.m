//
//  ViewController.m
//  demo-runtime-part3
//
//  Created by 融数 on 17/4/5.
//  Copyright © 2017年 tf-demos. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
@interface ViewController ()<UITableViewDelegate>

@end
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self method0];
    BOOL result0 = class_replaceMethod([self class], @selector(method0), (IMP)method1, NULL);
    NSLog(@">>>>>>>>2:%@",@(result0));
    [self method0];
    NSLog(@"\n");
    
    BOOL result1 = class_conformsToProtocol([self class], NSProtocolFromString(@"UITableViewDelegate"));
    BOOL result2 = class_conformsToProtocol([self class], NSProtocolFromString(@"UITableViewDataSource"));
    BOOL result3 = class_addProtocol([self class], NSProtocolFromString(@"UITableViewDataSource"));
    NSLog(@">>>>>>>>3:%@",@(result1));
    NSLog(@">>>>>>>>4:%@",@(result2));
    NSLog(@">>>>>>>>5:%@",@(result3));
    
    BOOL result4 = class_conformsToProtocol([self class], NSProtocolFromString(@"UITableViewDelegate"));
    BOOL result5 = class_conformsToProtocol([self class], NSProtocolFromString(@"UITableViewDataSource"));
    
    NSLog(@">>>>>>>>6:%@",@(result4));
    NSLog(@">>>>>>>>7:%@",@(result5));
    NSLog(@"\n");
    
    BOOL result6 = class_isMetaClass([self class]);
    NSLog(@">>>>>>>>8:%@",@(result6));
    
    BOOL result7 = class_respondsToSelector([self class], @selector(method0));
    NSLog(@">>>>>>>>9:%@",@(result7));
    BOOL result8 = class_respondsToSelector([self class], @selector(method1));
    NSLog(@">>>>>>>>10:%@",@(result8));
    
    
}

-(void)method0{
    NSLog(@">>>>>>>>0");

}
void method1(){
    NSLog(@">>>>>>>>1");
}
+(void)method1{
    NSLog(@">>>>>>>>0");
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
