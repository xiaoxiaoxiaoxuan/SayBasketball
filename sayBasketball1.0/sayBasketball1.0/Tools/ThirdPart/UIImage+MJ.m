//
//  UIImage+MJ.m
//  微博
//
//  Created by lanou3g on 15/11/20.
//  Copyright © 2015年 笨蛋一号后卫. All rights reserved.
//

#import "UIImage+MJ.h"
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

@implementation UIImage (MJ)
+ (UIImage *)imageWithName:(NSString *)name
{
    if (iOS7) {
        NSString *newName = [name stringByAppendingString:@"_os7"];
        UIImage *image = [UIImage imageNamed:newName];
        if (image == nil) { // 没有_os7后缀的图片
            image = [UIImage imageNamed:name];
        }
        return image;
    }
    
    // 非iOS7
    return [UIImage imageNamed:name];
}

+ (UIImage *)resizedImageWithName:(NSString *)name
{
    UIImage *image = [self imageWithName:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

@end
