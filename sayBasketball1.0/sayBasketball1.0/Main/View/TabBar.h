//
//  TabBar.h
//  sayBasketball1.0
//
//  Created by 社会你毅哥 on 15/11/24.
//  Copyright © 2015年 杨毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TabBar;
@protocol tabBarDelegate <NSObject>

-(void)tabBar:(TabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to;

@end


@interface TabBar : UIView
- (void)addTabbarButtonWithItem:(UITabBarItem *)item;
@property (nonatomic,weak)id<tabBarDelegate>delegate;
@end
