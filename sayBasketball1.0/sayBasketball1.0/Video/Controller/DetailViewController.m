//
//  DetailViewController.m
//  sayBasketball1.0
//
//  Created by lanou3g on 15/11/27.
//  Copyright © 2015年 杨毅. All rights reserved.
//

#import "DetailViewController.h"
#import "VideoTableViewCell.h"
#import "DetailHandle.h"
#import "DetailTableViewCell.h"
#import "WebViewController.h"

@interface DetailViewController ()<UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, strong)UITableView *tableView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self p_setupView];
    
    
    [self.tableView registerClass:[DetailTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishLoadDataAction) name:@"loadDetailData" object:nil];
    
    NSString *urlString = [NSString stringWithFormat:@"http://m.zhibo8.cc/m/android/json/nba/2015/%@.json", self.fileName];
    
    [[DetailHandle defaultDetailHandle] loadDataWithUrlString:urlString];
    
    
    
    // Do any additional setup after loading the view.
}
- (void)finishLoadDataAction
{
    [self.tableView reloadData];
}

- (void)p_setupView
{
    self.tableView = [[UITableView alloc] init];
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[VideoTableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[DetailHandle defaultDetailHandle] countOfCell];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    DetailVideoModel *model = [[DetailHandle defaultDetailHandle] detailViewModelWithIndex:indexPath.row];
    
    [cell bindCellWithDetailViewModel:model];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WebViewController *webVC = [[WebViewController alloc] init];
    DetailVideoModel *model = [[DetailHandle defaultDetailHandle] detailViewModelWithIndex:indexPath.row];
    webVC.VideoUrlString = model.url;
    [self.navigationController pushViewController:webVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
