
//
//  TabBarController.m
//  sayBasketball1.0
//
//  Created by 社会你毅哥 on 15/11/24.
//  Copyright © 2015年 杨毅. All rights reserved.
//

#import "TabBarController.h"
#import "ChatTableViewController.h"
#import "NewsTableViewController.h"
#import "VideoViewController.h"
#import "MyTableViewController.h"
#import "myNavigationViewController.h"
#import "TabBar.h"
@interface TabBarController ()<tabBarDelegate>
@property (nonatomic, weak) TabBar * customTabBar;
@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setuptabbar];
    [self setupAllChildViewControllers];
    // Do any additional setup after loading the view.
}
- (void)setuptabbar{
    TabBar * customTabbar = [[TabBar alloc]init];
    customTabbar.frame = self.tabBar.bounds;
    customTabbar.delegate = self;
    [self.tabBar addSubview:customTabbar];
    self.customTabBar = customTabbar;
}
- (void)tabBar:(TabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to{
    self.selectedIndex = to;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    for (UIView * child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}
- (void)setupAllChildViewControllers{
    ChatTableViewController * chat = [[ChatTableViewController alloc]init];
    [self setupChildViewController:chat title:@"聊天" imageName:nil selectedImageName:nil];
    NewsTableViewController * news = [[NewsTableViewController alloc]init];
    [self setupChildViewController:news title:@"新闻" imageName:nil selectedImageName:nil];
    
    VideoViewController * video = [[VideoViewController alloc]init];
    [self setupChildViewController:video title:@"视频" imageName:nil selectedImageName:nil];
    
    MyTableViewController * my = [[MyTableViewController alloc]init];
    [self setupChildViewController:my title:@"我的" imageName:nil selectedImageName:nil];
}






- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.设置控制器的属性
    childVc.title = title;
    childVc.tabBarItem.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
//     2.包装一个导航控制器
    myNavigationViewController *nav = [[myNavigationViewController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
//    [self addChildViewController:childVc];
    //添加tabbar内部的按钮
    [self.customTabBar addTabbarButtonWithItem:childVc.tabBarItem];    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
