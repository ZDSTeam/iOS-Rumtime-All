//
//  ViewController+TFExtension.m
//  demo-runtime-part1
//
//  Created by 融数 on 17/4/4.
//  Copyright © 2017年 tf-demos. All rights reserved.
//

#import "ViewController+TFExtension.h"

#import <objc/runtime.h>
#define TF_SYNTHESIZE_CATEGORY_PROPERTY_RETAIN(GETTER,SETTER) TF_SYNTHESIZE_CATEGORY_PROPERTY(GETTER,SETTER,OBJC_ASSOCIATION_RETAIN_NONATOMIC,id)
#define TF_SYNTHESIZE_CATEGORY_PROPERTY_COPY(GETTER,SETTER)   TF_SYNTHESIZE_CATEGORY_PROPERTY(GETTER,SETTER,OBJC_ASSOCIATION_COPY,id)
#define TF_SYNTHESIZE_CATEGORY_PROPERTY_ASSIGN(GETTER,SETTER) TF_SYNTHESIZE_CATEGORY_PROPERTY(GETTER,SETTER,OBJC_ASSOCIATION_ASSIGN,id)
#define TF_SYNTHESIZE_CATEGORY_PROPERTY_BLOCK(GETTER,SETTER,TYPE)   TF_SYNTHESIZE_CATEGORY_PROPERTY(GETTER,SETTER,OBJC_ASSOCIATION_COPY,TYPE)

#define TF_SYNTHESIZE_CATEGORY_PROPERTY(GETTER,SETTER,objc_AssociationPolicy,TYPE)\
- (TYPE)GETTER{return objc_getAssociatedObject(self, @selector(GETTER));}\
- (void)SETTER:(TYPE)obj{objc_setAssociatedObject(self, @selector(GETTER), obj, objc_AssociationPolicy);}

@interface ViewController ()<UITextViewDelegate>
{
    NSArray  *_property4;
}
@property (nonatomic,strong)NSArray  *property5;
@end


@implementation ViewController (TFExtension)

TF_SYNTHESIZE_CATEGORY_PROPERTY_RETAIN(property5, setProperty5);

-(void)method0{}
-(void)method1{}
@end
