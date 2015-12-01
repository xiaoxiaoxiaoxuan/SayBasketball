//
//  TableBarViewController.m
//  sayBasketball1.0
//
//  Created by 社会你毅哥 on 15/11/24.
//  Copyright © 2015年 杨毅. All rights reserved.
//

#import "TableBarViewController.h"
#import "ChatTableViewController.h"
#import "NewsTableViewController.h"
#import "VideoViewController.h"
#import "MyTableViewController.h"
@interface TableBarViewController ()

@end

@implementation TableBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ChatTableViewController * chat = [[ChatTableViewController alloc]init];
//    UINavigationController * chatNC = [[UINavigationController alloc]initWithRootViewController:chat];
    chat.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"聊天" image:nil tag:101];
    NewsTableViewController * news = [[NewsTableViewController alloc]init];
//    UINavigationController * newsNC = [[UINavigationController alloc]initWithRootViewController:news];
    news.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"新闻" image:nil tag:102];
    
    VideoViewController * video = [[VideoViewController alloc]init];
//    UINavigationController * videoNC = [[UINavigationController alloc]initWithRootViewController:video];
    video.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"视频" image:nil tag:103];
    
    MyTableViewController * my = [[MyTableViewController alloc]init];
//    UINavigationController * myNC = [[UINavigationController alloc]initWithRootViewController:my];
    my.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:nil tag:104];
    
    self.viewControllers = @[chat,news,video,my];
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
