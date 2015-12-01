//
//  VideoViewController.m
//  sayBasketball1.0
//
//  Created by lanou3g on 15/11/26.
//  Copyright © 2015年 杨毅. All rights reserved.
//

#import "VideoViewController.h"
#import "VideoTableViewCell.h"
#import "WebViewController.h"
#import "VideoHandle.h"
#import "DetailViewController.h"
#import "DetailHandle.h"
#import "JingdianVideoHandle.h"
#import "MJRefresh.h"

@interface VideoViewController ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UISegmentedControl *seg;
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UITableView *zuixinVideoTableView; // 最新视屏
@property (nonatomic, strong)UITableView *jingdianVideoTableView; // 经典视屏
@property (nonatomic, strong)UITableView *jiaoxueVideoTableView; // 教学视屏


@end

static NSDate *date = nil;
static NSInteger count = 1;
@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.zuixinVideoTableView reloadData];
//    [self.jingdianVideoTableView reloadData];
//    [self.jiaoxueVideoTableView reloadData];
    
    [self p_setupView];
    
    self.jingdianVideoTableView.scrollsToTop = YES;
    self.zuixinVideoTableView.scrollsToTop = YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.scrollView.delegate = self;
    
    self.seg.selectedSegmentIndex = 0;
    
    [self.seg addTarget:self action:@selector(segAction:) forControlEvents:(UIControlEventValueChanged)];
    // 添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishLoadAction) name:@"loadVideoData" object:nil];

    // 获得当前时间
    NSDate *now = [NSDate date];
    date = now;
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *dateStr = [dateFormatter stringFromDate:now];
    // 拼接字符串

    NSString *urlString = [NSString stringWithFormat:@"http://m.zhibo8.cc/json/video/nba/%@.json",dateStr];
    // 去单例类解析数据
    [[VideoHandle defaultVideoHandel] loadNewVideoDataWithUrlString:urlString];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishLoadJingdianAction) name:@"finishLoadData" object:nil];
    [[JingdianVideoHandle defaultJingdianVideoHandle] loadDataWithString:@"http://www.lanqiure.com/review/news/GetIndexNews?pageNo=1&pageSize=20"];
    
    __block typeof(self)tSelf = self;
    [self.zuixinVideoTableView addLegendHeaderWithRefreshingBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [tSelf.zuixinVideoTableView reloadData];
            [tSelf.zuixinVideoTableView.header endRefreshing];
        });
    }];
    [self.zuixinVideoTableView addLegendFooterWithRefreshingBlock:^{
        // 模拟延迟
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSTimeInterval interval = -24 * 3600;
            date = [date initWithTimeInterval:interval sinceDate:date];
            NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *dateStr = [dateFormatter stringFromDate:date];
            NSString *urlString = [NSString stringWithFormat:@"http://m.zhibo8.cc/json/video/nba/%@.json", dateStr];
            [[VideoHandle defaultVideoHandel] loadNewVideoDataWithUrlString:urlString];
            [tSelf.zuixinVideoTableView.footer endRefreshing];
            // 结束刷新
            [tSelf.zuixinVideoTableView.footer endRefreshing];
        });
    }];
    
    
    [self.jingdianVideoTableView addLegendHeaderWithRefreshingBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [tSelf.jingdianVideoTableView reloadData];
            [tSelf.jingdianVideoTableView.header endRefreshing];
        });
        
        
    }];
    [self.jingdianVideoTableView addLegendFooterWithRefreshingBlock:^{
       
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            count++;
            NSString *urlString = [NSString stringWithFormat:@"http://www.lanqiure.com/review/news/GetIndexNews?pageNo=%ld&pageSize=20", count];
            [[JingdianVideoHandle defaultJingdianVideoHandle] loadDataWithString:urlString];
            [tSelf.jingdianVideoTableView.footer endRefreshing];
        });
        
        
        
    }];
    

    
    // Do any additional setup after loading the view.
}

- (void)finishLoadAction
{
    [self.zuixinVideoTableView reloadData];
}

- (void)finishLoadJingdianAction
{
    [self.jingdianVideoTableView reloadData];
}

- (void)p_setupView
{
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 3, 0);
    self.scrollView.pagingEnabled = YES;
    [self.view addSubview:self.scrollView];
    
    self.seg = [[UISegmentedControl alloc] initWithItems:@[@"最新",@"经典",@"教学"]];
    self.seg.frame = CGRectMake(self.view.bounds.size.width / 2.0 - 100, 30, 200, 30);
    self.seg.layer.cornerRadius = 5;
    self.seg.backgroundColor = [UIColor grayColor];
    self.seg.tintColor = [UIColor whiteColor];
    self.seg.momentary = NO;
    // [self.view addSubview:self.seg];
    self.navigationItem.titleView = self.seg;
    
    NSInteger count = 10000;
    
    for (int i = 0; i < 3; i++) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(i * self.view.bounds.size.width, 0, self.view.bounds.size.width, self.scrollView.bounds.size.height - 108) style:(UITableViewStylePlain)];
        tableView.tag = count++;
        [self.scrollView addSubview:tableView];
        
        tableView.delegate = self;
        tableView.dataSource = self;
        
        
        
    }
    self.zuixinVideoTableView = (UITableView *)[self.view viewWithTag:10000];
    [self.zuixinVideoTableView registerClass:[VideoTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.jingdianVideoTableView = (UITableView *)[self.view viewWithTag:10001];
    [self.jingdianVideoTableView registerClass:[VideoTableViewCell class] forCellReuseIdentifier:@"cell1"];
    self.jiaoxueVideoTableView = (UITableView *)[self.view viewWithTag:10002];
    [self.jiaoxueVideoTableView registerClass:[VideoTableViewCell class] forCellReuseIdentifier:@"cell2"];
    
    
}




- (void)segAction:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex) {
        case 0:{
            [UIView animateWithDuration:0.5f animations:^{
                self.scrollView.contentOffset = CGPointMake(sender.selectedSegmentIndex * self.view.bounds.size.width, 0);
            }];
            
            break;
        }
            
        case 1:{
            [UIView animateWithDuration:0.5f animations:^{
                self.scrollView.contentOffset = CGPointMake(sender.selectedSegmentIndex * self.view.bounds.size.width, 0);
            }];
            break;
        }
            
        case 2:{
            [UIView animateWithDuration:0.5f animations:^{
                self.scrollView.contentOffset = CGPointMake(sender.selectedSegmentIndex * self.view.bounds.size.width, 0);
            }];
            break;
        }

            
            
        default:
            break;
    }
}



// scrollViewDelegeta
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    self.seg.selectedSegmentIndex = self.scrollView.contentOffset.x / self.view.bounds.size.width;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.zuixinVideoTableView) {
        return [[VideoHandle defaultVideoHandel] countOfCell];
    }else if (tableView == self.jingdianVideoTableView){
        return [[JingdianVideoHandle defaultJingdianVideoHandle] countOfJingdianCell];
    }else{
        return 10;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.zuixinVideoTableView) {
        VideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
            newVideoModel *model = [[VideoHandle defaultVideoHandel] newVideoModelWithIndex:indexPath.row];

            [cell bindWithNewVideoModel:model];

            return cell;
    }else if (tableView == self.jingdianVideoTableView){
        VideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        // cell.textLabel.text = @"测试数据";
        JingdianVideoModel *model = [[JingdianVideoHandle defaultJingdianVideoHandle] jingdianViewModelWithIndex:indexPath.row];
        
        [cell bindWithJingdianVideoModel:model];
        
        return cell;
    }else{
        VideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        // cell.textLabel.text = @"测试数据";
        return cell;
    }
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

// 进入视屏详情界面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.zuixinVideoTableView) {
        DetailViewController *detailVC = [[DetailViewController alloc] init];
        
        newVideoModel *model = [[VideoHandle defaultVideoHandel] newVideoModelWithIndex:indexPath.row];
        
        detailVC.fileName = model.filename;
        
        [self.navigationController pushViewController:detailVC animated:YES];
    }else if (tableView == self.jingdianVideoTableView){
        
        WebViewController *webVC = [[WebViewController alloc] init];
        JingdianVideoModel *model = [[JingdianVideoHandle defaultJingdianVideoHandle] jingdianViewModelWithIndex:indexPath.row];
        
        webVC.VideoUrlString = [NSString stringWithFormat:@"http://www.lanqiure.com%@",model.resourceHref];
        [self.navigationController pushViewController:webVC animated:YES];
        
    }else{
        
    }
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
