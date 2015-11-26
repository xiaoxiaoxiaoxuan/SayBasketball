//
//  TabBarButton.h
//  sayBasketball1.0
//
//  Created by 社会你毅哥 on 15/11/24.
//  Copyright © 2015年 杨毅. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "UIImage+MJ.h"
//#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
// 获得RGB颜色
#define IWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface TabBarButton : UIButton
@property (nonatomic, strong)UITabBarItem * item;
@end
