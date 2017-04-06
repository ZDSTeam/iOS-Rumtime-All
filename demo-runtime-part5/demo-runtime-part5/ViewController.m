//
//  ViewController.m
//  demo-runtime-part4
//
//  Created by 融数 on 17/4/5.
//  Copyright © 2017年 tf-demos. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
@interface ViewController ()
{
    NSObject *_property0;
    UIView *_property1;
    UIViewController *_property2;
    float _property3;
    int _property4;
}
@property (nonatomic,strong)NSObject *_property5;
@property (nonatomic,  weak)UIView   *property6;
@property (nonatomic,strong)UIViewController *property7;

@property (nonatomic,assign)float property8;
@property (nonatomic,assign)int property9;
@property (nonatomic,strong,readonly)UIViewController *property10;
@property (nonatomic,readwrite)UIViewController *property11;
@property (nonatomic,  copy)NSString *property12;
@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //class获取--获取整个属性列表(只获取属性不获取变量)
    /**
     *  1.获取所有属性
     *  2.获取的属性名和你代码写的一样,获取出来的属性名不自动添加下划线
     */
    unsigned int copyPropertyListCount = 0;
    objc_property_t *propertys = class_copyPropertyList([self class], &copyPropertyListCount);
    for (NSInteger i = 0; i < copyPropertyListCount; i++) {
        objc_property_t property = propertys[i];
        const char *name = property_getName(property);
        const char *attributes = property_getAttributes(property);
        
        NSLog(@">>>>>>>>0:%@:%@",
              [NSString stringWithUTF8String:name],
              [NSString stringWithUTF8String:attributes]);
    }
    free(propertys);
}
@end

