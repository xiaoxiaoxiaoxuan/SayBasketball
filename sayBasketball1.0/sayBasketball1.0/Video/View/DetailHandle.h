//
//  DetailHandle.h
//  sayBasketball1.0
//
//  Created by lanou3g on 15/11/27.
//  Copyright © 2015年 杨毅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailVideoModel.h"

@interface DetailHandle : NSObject

+ (instancetype)defaultDetailHandle;

- (void)loadDataWithUrlString:(NSString *)urlString;

- (NSInteger)countOfCell;

- (DetailVideoModel *)detailViewModelWithIndex:(NSInteger)index;

- (NSString *)videoPic;
@end
