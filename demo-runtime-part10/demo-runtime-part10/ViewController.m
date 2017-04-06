//
//  ViewController.m
//  demo-runtime-part10
//
//  Created by 融数 on 17/4/6.
//  Copyright © 2017年 tf-demos. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
@interface ViewController ()<UITableViewDelegate>
{
    NSArray *_property0;
}
@property (nonatomic,strong)NSObject *property1;

@end

@implementation ViewController

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    unsigned int result0 = 0;
    Ivar *result1 = class_copyIvarList([self class], &result0);
    for (unsigned int i = 0; i < result0; i++) {
        Ivar result2 = result1[i];
        //获取变量实例
        //入参:变量所属实例，变量结构体Ivar
        //返回:变量实例
        id result3 = object_getIvar(self, result2);
        NSLog(@">>>>>>>>0:%@",result3);
        NSString *result4 = [NSString stringWithUTF8String:ivar_getName(result2)];
        if ([result4 isEqualToString:@"_property0"]) {
            //给实例设置变量实例
            //入参:要设置变量的实例，变量结构体Ivar，变量值value
            //返回:void
            object_setIvar(self, result2, @[@"0",@"1",@"2",@"3",@"4",@"5"]);
        }else if([result4 isEqualToString:@"_property1"]){
            //给实例设置变量实例
            //入参:要设置变量的实例，变量结构体Ivar，变量值value
            //返回:void
            object_setIvar(self, result2, [[NSObject alloc]init]);
        }
        id result5 = object_getIvar(self, result2);
        NSLog(@">>>>>>>>1:%@",result5);
    }
}
@end
