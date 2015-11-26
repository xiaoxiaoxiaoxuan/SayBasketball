//
//  UIImage+MJ.h
//  微博
//
//  Created by lanou3g on 15/11/20.
//  Copyright © 2015年 笨蛋一号后卫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MJ)
/**
 *  加载图片
 *
 *  @param name 图片名
 */
+ (UIImage *)imageWithName:(NSString *)name;

/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;

@end
