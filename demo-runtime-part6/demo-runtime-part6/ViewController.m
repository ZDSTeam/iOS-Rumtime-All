//
//  ViewController.m
//  demo-runtime-part6
//
//  Created by 融数 on 17/4/5.
//  Copyright © 2017年 tf-demos. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
@interface ViewController ()
@end
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    Method result0 = class_getInstanceMethod([self class], @selector(method0:agu1:agu2:agu3:agu4:agu5:));
    //获取方法名
    //入参: 方法描述结构体Method
    //返回: 方法名SEL
    SEL result1 = method_getName(result0);
    NSLog(@">>>>>>>>0:%@",NSStringFromSelector(result1));
    
    //获取方法实现
    //入参: objc_property_t，attributeName属性的属性键
    //返回: 属性的属性值char数组
    IMP result2 =  method_getImplementation(result0);
    
    //获取方法的属性信息（包括返回值类型，参数类型等等信息）
    //入参: 方法描述结构体Method
    //返回: 属性值char数组
    const char *result3 = method_getTypeEncoding(result0);
    NSLog(@">>>>>>>>2:%@",[NSString stringWithUTF8String:result3]);

    //获取方法的参数个数
    //入参: 方法描述结构体Method
    //返回: 属性的个数
    unsigned int result4 = method_getNumberOfArguments(result0);
    NSLog(@">>>>>>>>3:%ud",result4);
    for (unsigned int i =0 ; i < result4; i++) {
        char result5[1024] = {};
        //获取参数的属性参数
        //入参: 方法描述结构体Method，返回值的容器char数组，容器大小。返回值的类型字符串会被copy到第二个参数里。
        //返回: void
        method_getArgumentType(result0, i, result5, 1024);
        NSLog(@">>>>>>>>4:%s",result5);
    }

    //获取返回值的类型
    //入参: 方法描述结构体Method，返回值的容器char数组，容器大小。返回值的类型字符串会被copy到第二个参数里。
    //返回: void
    char result6[1024] = {};
    method_getReturnType(result0, result6, 1024);
    NSLog(@">>>>>>>>5:%s",result6);

    //获取方法的描述
    //入参: 方法描述结构体Method
    //返回: 方法描述结构体objc_method_description
    //struct objc_method_description {
    //    SEL name;     
    //    char *types;  
    //};
    struct objc_method_description result7 = *method_getDescription(result0);
    NSLog(@">>>>>>>>6:%@:%@",NSStringFromSelector(result7.name),[NSString stringWithUTF8String:result7.types]);
}
-(NSArray *)method0:(NSArray *)agu0
               agu1:(CGFloat)agu1
               agu2:(NSObject *)agu2
               agu3:(NSString *)agu3
               agu4:(CGRect)agu4
               agu5:(UIView *)agu5{
    NSLog(@">>>>>>>>1");
    return @[];
}
@end

