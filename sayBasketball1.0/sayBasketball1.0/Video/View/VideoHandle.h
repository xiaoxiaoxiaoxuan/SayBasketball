//
//  VideoHandle.h
//  sayBasketball1.0
//
//  Created by lanou3g on 15/11/27.
//  Copyright © 2015年 杨毅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "newVideoModel.h"

@interface VideoHandle : NSObject

+ (instancetype)defaultVideoHandel;

- (void)loadNewVideoDataWithUrlString:(NSString *)urlString;

- (NSInteger)countOfCell;

- (newVideoModel *)newVideoModelWithIndex:(NSInteger)index;

@end
