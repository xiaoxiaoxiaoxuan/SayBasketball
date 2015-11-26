//
//  myNavigationViewController.m
//  sayBasketball1.0
//
//  Created by 社会你毅哥 on 15/11/24.
//  Copyright © 2015年 杨毅. All rights reserved.
//

#import "myNavigationViewController.h"

@interface myNavigationViewController ()

@end

@implementation myNavigationViewController

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
         viewController.hidesBottomBarWhenPushed = YES;
    }
   
    [super pushViewController:viewController animated:animated];
}

@end
