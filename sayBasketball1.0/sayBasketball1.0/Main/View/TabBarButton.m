//
//  TabBarButton.m
//  sayBasketball1.0
//
//  Created by 社会你毅哥 on 15/11/24.
//  Copyright © 2015年 杨毅. All rights reserved.
//

#import "TabBarButton.h"
#define IWTabBarButtonImageRatio 0.6
// 按钮的默认文字颜色
#define  IWTabBarButtonTitleColor  [UIColor blackColor]
// 按钮的选中文字颜色
#define  IWTabBarButtonTitleSelectedColor  IWColor(248, 139, 0)
@implementation TabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self setTitleColor:IWTabBarButtonTitleColor forState:UIControlStateNormal];
        [self setTitleColor:IWTabBarButtonTitleSelectedColor forState:(UIControlStateSelected)];
    }
    return self;
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH =contentRect.size.height * IWTabBarButtonImageRatio;
    return CGRectMake(0, 0, imageW, imageH);
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleY = contentRect.size.height * IWTabBarButtonImageRatio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}
-(void)setItem:(UITabBarItem *)item{
    _item = item;
    
    [self setTitle:item.title forState:(UIControlStateNormal)];
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateSelected];
    [self setBackgroundImage:[UIImage imageNamed:@"tabbar_slider"] forState:(UIControlStateSelected)];
}

@end
