//
//  ViewController.m
//  demo-runtime-part2
//
//  Created by 融数 on 17/4/4.
//  Copyright © 2017年 tf-demos. All rights reserved.
//

#import "ViewController.h"
#import <objc/message.h>
@interface ViewController ()<UITableViewDataSource>
{
    NSArray *_property0;
    NSArray *property1;
}
@property (nonatomic,strong)UIColor *property2;

@end

@implementation ViewController

//get方法
NSString *attribute0Getter(id classInstance, SEL _cmd) {
    Ivar ivar = class_getInstanceVariable([classInstance class], "_attribute0");//获取变量,如果没获取到说明不存在
    return object_getIvar(classInstance, ivar);
}

//set方法
void attribute0Setter(id classInstance, SEL _cmd, NSString *newName) {
    Ivar ivar = class_getInstanceVariable([classInstance class], "_attribute0");//获取变量,如果没获取到说明不存在
    id oldName = object_getIvar(classInstance, ivar);
    if (oldName != newName) object_setIvar(classInstance, ivar, [newName copy]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加--为动态创建类添加变量
    /**
     * 1.只能给动态创建的类添加变量也就是用 objc_allocateClassPair 创建的类
     * 2.添加变量只能在函数 objc_allocateClassPair 和 class_getInstanceVariable 之间添加才有效
     */
    Class CreatClass0 = objc_allocateClassPair([NSObject class], "CreatClass0", 0);
    class_addIvar(CreatClass0, "_attribute0", sizeof(NSString *), log(sizeof(NSString *)), "i");
    Ivar ivar = class_getInstanceVariable(CreatClass0, "_attribute0");//获取变量,如果没获取到说明不存在
    NSLog(@">>>>>>>>0:%@",[NSString stringWithUTF8String:ivar_getName(ivar)]);
    objc_registerClassPair(CreatClass0);
    NSLog(@"\n");
    
    
    //添加--为动态创建的类添加变量然后添加属性,类和变量和属性都是动态创建的
    /**
     * 1.各个属性:暂时不知道
     * 2.下面这个反驳了上面的第二标,这个证明id不是不会报错,规律是如果id调用的是系统的类的方法,那么就不会报错,
     详细介绍:上面的@selector(name) 和 @selector(setName:) name是好多系统类都有方法,所以id会认为本身代表的是那个类
     所以不会报错,但是如果你硬写一个完全没有的方法,它就会报错
     * 3.添加属性不用再objc_registerClassPair之前,因为添加属性其实就是添加变量的set 和 get方法而已
     * 4.添加的属性和变量不能用kvc设置值和取值
     */
    
    objc_property_attribute_t type2 = { "T", "@\"NSString\"" };
    objc_property_attribute_t ownership2 = { "C", "" }; // C = copy
    objc_property_attribute_t backingivar2  = { "V", "_attribute0" };
    objc_property_attribute_t attrs2[] = { type2, ownership2, backingivar2 };
    class_addProperty(CreatClass0, "_attribute0", attrs2, 3);
    
    SEL getter = NSSelectorFromString(@"attribute0");
    SEL setter = NSSelectorFromString(@"setAttribute0:");
    BOOL suc0 = class_addMethod(CreatClass0, getter, (IMP)attribute0Getter, "@@:");
    BOOL suc1 = class_addMethod(CreatClass0, setter, (IMP)attribute0Setter, "v@:@");
    NSLog(@">>>>>>>>3:%@:%@",@(suc0),@(suc1));
    id idclass = [[CreatClass0 alloc]init];
    NSLog(@">>>>>>>>1:%@",[idclass performSelector:getter withObject:nil]);
    [idclass performSelector:setter withObject:@"为动态创建类先添加变量再添加属性"];
    NSLog(@">>>>>>>>2:%@",[idclass performSelector:getter withObject:nil]);
    //class获取--获取整个类的实例方法的方法列表
    /**
     *  1.获取所有实例方法,不包含静态方法
     *  2.不获取父类的方法
     *  3.隐式的get set 方法也能获取到
     *  4.关于Method的更多用法参考Class2类
     */
    unsigned int copycopyMethodListCount = 0;
    Method *methods = class_copyMethodList([self class], &copycopyMethodListCount);
    for (NSInteger i = 0; i < copycopyMethodListCount; i++) {
        Method method = methods[i];
        SEL name = method_getName(method);
        NSLog(@">>>>>>>>2:copyMethodList:%@",NSStringFromSelector(name));
    }
    free(methods);//释放
    NSLog(@"\n");
    
    BOOL result0 = class_addProtocol([self class], NSProtocolFromString(@"UITableViewDelegate"));
    NSLog(@">>>>>>>>3:添加协议：%@",@(result0));
    //添加--协议
    /**
     * 1.class_addProtocol  参数含义:第一个:要添加协议的类,第二个:协议对象
     * 2.获取协议列表具体细节参照Class1里的内容
     */
    unsigned int copyProtocolListCount = 0;
    Protocol * __unsafe_unretained *protocals = class_copyProtocolList([self class], &copyProtocolListCount);
    for (NSInteger i = 0; i < copyProtocolListCount; i++) {
        Protocol * protocal = protocals[i];
        const char *name = protocol_getName(protocal);
        NSLog(@">>>>>>>>4:copyProtocolList:%s",name);
    }
    free(protocals);//释放
    NSLog(@"\n");
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{return 0;}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{return nil;}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
