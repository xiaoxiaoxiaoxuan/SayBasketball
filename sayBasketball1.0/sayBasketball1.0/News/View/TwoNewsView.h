//
//  TwoNewsView.h
//  sayBasketball1.0
//
//  Created by 社会你毅哥 on 15/11/26.
//  Copyright © 2015年 杨毅. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^block)(NSInteger);
@interface TwoNewsView : UIView
@property (nonatomic, copy) block myBlock;

- (void) setButtonClicked: (NSInteger)index;
@end
