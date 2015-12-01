//
//  TwoNewsView.m
//  sayBasketball1.0
//
//  Created by 社会你毅哥 on 15/11/26.
//  Copyright © 2015年 杨毅. All rights reserved.
//

#import "TwoNewsView.h"

@interface TwoNewsView ()
@property (nonatomic, strong) UIButton * buttonOne;

@property (nonatomic, strong) UIButton * buttonTwo;

@property (nonatomic, strong) UIButton * saveButton;
@end
@implementation TwoNewsView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.buttonOne = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.buttonOne.frame = CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height);
        self.buttonOne.tag = 10000;
        [self.buttonOne addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.buttonOne setTitle:@"新闻" forState:(UIControlStateNormal)];
        self.buttonOne.selected = YES;
        self.buttonOne.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:self.buttonOne];
        
        self.buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
        self.buttonTwo.frame = CGRectMake(self.frame.size.width/2, 0, self.frame.size.width/2, self.frame.size.height);
        [self.buttonTwo setTitle:@"数据" forState:(UIControlStateNormal)];
        self.saveButton = self.buttonOne;
        self.buttonTwo.tag = 10001;
        [self.buttonTwo addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.buttonTwo.selected = YES;
        self.buttonTwo.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview: self.buttonTwo];
    }
    return self;
}
- (void) setButtonClicked:(NSInteger)index{
    UIButton * button = (UIButton *)[self viewWithTag:index + 10000];
    [self buttonAction:button];
}


- (void) buttonAction:(UIButton *) sender{
    if (self.saveButton != sender) {
        sender.selected = !sender.selected;
        self.saveButton.selected = !self.saveButton.selected;
        self.saveButton = sender;
        [UIView animateWithDuration:0.1 animations:^{
        }];
        self.myBlock(sender.tag - 10000);
    }
}


@end
