//
//  TabBar.m
//  sayBasketball1.0
//
//  Created by 社会你毅哥 on 15/11/24.
//  Copyright © 2015年 杨毅. All rights reserved.
//

#import "TabBar.h"
#import "TabBarButton.h"

@interface TabBar ()
@property (nonatomic, weak)TabBarButton * selectButton;
@end
@implementation TabBar
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//       
//        if (!iOS7) {
//            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
//        }
        
    }
    return self;
}
- (void)addTabbarButtonWithItem:(UITabBarItem *)item{
    TabBarButton * button = [[TabBarButton alloc]init];
    [self addSubview:button];
    button.item = item;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchDown)];
    if (self.subviews.count == 1) {
        [self buttonClick:button];
    }
}
- (void)buttonClick:(TabBarButton *)sender{
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectButton.tag to:sender.tag];
    }
    self.selectButton.selected = NO;
    sender.selected = YES;
    self.selectButton = sender;
}
-(void)layoutSubviews{
    [super layoutSubviews];
   
    //设置按钮的frame
    
    CGFloat buttonw = self.frame.size.width/self.subviews.count;
    CGFloat buttonh = self.frame.size.height;
    for (NSInteger i = 0; i< self.subviews.count; i++) {
        //1.quchu按钮
        UIButton *button =  self.subviews[i];
        
        button.frame = CGRectMake(buttonw *i, 0, buttonw, buttonh);
        button.tag = i;
    }
    
}

@end
