//
//  VideoHandle.m
//  sayBasketball1.0
//
//  Created by lanou3g on 15/11/27.
//  Copyright © 2015年 杨毅. All rights reserved.
//

#import "VideoHandle.h"
#import "DetailHandle.h"

@interface VideoHandle()

@property (nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation VideoHandle

+ (instancetype)defaultVideoHandel
{
    static dispatch_once_t onceToken;
    static VideoHandle *videoHandel = nil;
    dispatch_once(&onceToken, ^{
        
        videoHandel = [[VideoHandle alloc] init];
        videoHandel.dataArray = [NSMutableArray array];
        
    });
    return videoHandel;
}

- (void)loadNewVideoDataWithUrlString:(NSString *)urlString
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        
            for (NSDictionary *dict in dic[@"video_arr"]) {
                newVideoModel *model = [[newVideoModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    // 拿到下个界面的url
                    NSString *urlString = [NSString stringWithFormat:@"http://m.zhibo8.cc/m/android/json/nba/2015/%@.json", model.filename];
                    // 解析
                    NSURL *url = [NSURL URLWithString:urlString];
                    NSURLRequest *request = [NSURLRequest requestWithURL:url];
                    NSURLSession *session = [NSURLSession sharedSession];
                    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
                        
                        NSString *s = dic[@"channel"][0][@"img"];
                        model.picUrlString = s;
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"loadVideoData" object:self];
                        
                    }];
                    [task resume];
                });

                [self.dataArray addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"loadVideoData" object:self];
        
            });
            
        }];
        [task resume];

    });
}

- (NSInteger)countOfCell
{
    return self.dataArray.count;
}

- (newVideoModel *)newVideoModelWithIndex:(NSInteger)index
{
    return self.dataArray[index];
}

@end
