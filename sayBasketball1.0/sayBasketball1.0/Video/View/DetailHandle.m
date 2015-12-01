//
//  DetailHandle.m
//  sayBasketball1.0
//
//  Created by lanou3g on 15/11/27.
//  Copyright © 2015年 杨毅. All rights reserved.
//

#import "DetailHandle.h"
#import "DetailVideoModel.h"

@interface DetailHandle()

@property (nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation DetailHandle


+ (instancetype)defaultDetailHandle
{
    static dispatch_once_t onceToken;
    static DetailHandle *detailHandle = nil;
    dispatch_once(&onceToken, ^{
        
        detailHandle = [[DetailHandle alloc] init];
        
    });
    return detailHandle;
}

- (void)loadDataWithUrlString:(NSString *)urlString
{
    self.dataArray = [NSMutableArray array];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
            
            for (NSDictionary *dict in dic[@"channel"]) {
                
                DetailVideoModel *model = [[DetailVideoModel alloc] init];
                
                [model setValuesForKeysWithDictionary:dict];
                
                [self.dataArray addObject:model];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"loadDetailData" object:nil];
                
            });
            
        }];
        [task resume];
        
    });
  
}

- (NSInteger)countOfCell
{
    return self.dataArray.count;
}

- (DetailVideoModel *)detailViewModelWithIndex:(NSInteger)index
{
    return self.dataArray[index];
}
// 返回图片地址
- (NSString *)videoPic
{
    return [self.dataArray[0] img];
}

@end
