//
//  ViewController.m
//  CTFontCollectionDemo
//
//  Created by 李佳 on 15/12/21.
//  Copyright © 2015年 LiJia. All rights reserved.
//

#import "ViewController.h"
#import <CoreText/CTFontCollection.h>

@interface ViewController ()

@end

@implementation ViewController

//CTFontCollectionRef iOS上能用的API较少，获取属性相关的。。。 好吧。iOS能使用也就只有下面这样玩了。。。。。

- (void)viewDidLoad
{
    [super viewDidLoad];
    CTFontCollectionRef fontColRef = CTFontCollectionCreateFromAvailableFonts(NULL);//获取当前可用的字符集
    
    NSMutableArray* fontNames = [[NSMutableArray alloc] init];
    if (fontColRef)
    {
        //CTFontCollectionCreateMatchingFontDescriptorsSortedWithCallback //获取一个排好序的Descriptors，排序规则自定义。
        CFArrayRef fontDescriptors = CTFontCollectionCreateMatchingFontDescriptors(fontColRef);
        CFIndex count = CFArrayGetCount(fontDescriptors);
        for (CFIndex i = 0; i < count; ++i)
        {
            CTFontDescriptorRef descriptor = (CTFontDescriptorRef)CFArrayGetValueAtIndex(fontDescriptors, i);
            CFTypeRef name = CTFontDescriptorCopyAttribute(descriptor, kCTFontNameAttribute);
            if (name)
            {
                if (CFGetTypeID(name) == CFStringGetTypeID())
                    [fontNames addObject:(__bridge NSString*)name];
                NSLog(@"fontname is %@", (__bridge NSString*)name);
                CFRelease(name);
            }
        }
        CFRelease(fontDescriptors);
    }
    CFRelease(fontColRef);
    
    
    //当然有更加直接的方法。for Mac..
    //CFArrayRef attrs = CTFontCollectionCopyFontAttribute(fontColRef, kCTFontFamilyNameAttribute, kCTFontCollectionCopyDefaultOptions);
}


@end
