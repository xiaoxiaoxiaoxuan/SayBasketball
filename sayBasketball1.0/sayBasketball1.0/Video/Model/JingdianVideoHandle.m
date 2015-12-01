//
//  JingdianVideoHandle.m
//  sayBasketball1.0
//
//  Created by lanou3g on 15/11/30.
//  Copyright © 2015年 杨毅. All rights reserved.
//

#import "JingdianVideoHandle.h"
#import "JingdianVideoModel.h"

@interface JingdianVideoHandle()

@property (nonatomic, strong)NSMutableArray *array;

@end

@implementation JingdianVideoHandle

+ (instancetype)defaultJingdianVideoHandle
{
    static dispatch_once_t onceToken;
    static JingdianVideoHandle *handle = nil;
    dispatch_once(&onceToken, ^{
        if (handle == nil) {
            handle = [[JingdianVideoHandle alloc] init];
            handle.array = [NSMutableArray array];
        }
    });
    return handle;
}

- (void)loadDataWithString:(NSString *)urlString
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
            
            for (NSDictionary *dict in dic[@"recommend"]) {
                JingdianVideoModel *model = [[JingdianVideoModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                
                if ([model.resourceType isEqualToString:@"2"]) {
                    [self.array addObject:model];
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"finishLoadData" object:nil];
                
            });
            
        }];
        [task resume];
    });
}

- (NSInteger)countOfJingdianCell
{
    return self.array.count;
}

- (JingdianVideoModel *)jingdianViewModelWithIndex:(NSInteger)index
{
    return self.array[index];
}

@end
