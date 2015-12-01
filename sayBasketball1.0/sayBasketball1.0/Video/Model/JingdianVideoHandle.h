//
//  JingdianVideoHandle.h
//  sayBasketball1.0
//
//  Created by lanou3g on 15/11/30.
//  Copyright © 2015年 杨毅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JingdianVideoModel.h"

@interface JingdianVideoHandle : NSObject

+ (instancetype)defaultJingdianVideoHandle;

- (void)loadDataWithString:(NSString *)urlString;

- (NSInteger)countOfJingdianCell;

- (JingdianVideoModel *)jingdianViewModelWithIndex:(NSInteger)index;

@end
