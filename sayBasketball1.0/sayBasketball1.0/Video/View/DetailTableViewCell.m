//
//  DetailTableViewCell.m
//  sayBasketball1.0
//
//  Created by lanou3g on 15/11/27.
//  Copyright © 2015年 杨毅. All rights reserved.
//

#import "DetailTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface DetailTableViewCell()

@property (nonatomic, strong)UIImageView *cellImageView; // cell上的图片
@property (nonatomic, strong)UILabel *titleLabel; // 标题

@end

@implementation DetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self p_setupView];
    }
    return self;
}
- (void)p_setupView
{
    // cellImageView
    self.cellImageView = [[UIImageView alloc] init];
    // 占位图
    self.cellImageView.image = [UIImage imageNamed:@"zhanweitu.jpg"];
    [self addSubview:self.cellImageView];
    
    UIImageView *videoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 20, 40, 40)];
    [self.cellImageView addSubview:videoImageView];
    videoImageView.image = [UIImage imageNamed:@"video.png"];
    
    // titleLabel
    self.titleLabel = [[UILabel alloc] init];
    // self.titleLabel.backgroundColor = [UIColor yellowColor];
    self.titleLabel.textColor = [UIColor colorWithRed:0.498f green:0.498f blue:0.498f alpha:1.00f];
    self.titleLabel.numberOfLines = 0;
    [self addSubview: self.titleLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.cellImageView.frame = CGRectMake(10, 10, 100, 80);
    
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.cellImageView.frame) + 10, CGRectGetMinY(self.cellImageView.frame), self.bounds.size.width - 30 - CGRectGetWidth(self.cellImageView.frame), 80);
}

- (void)bindCellWithDetailViewModel:(DetailVideoModel *)detailViewModel
{
    // 使用占位图，先加一个判断
    if (detailViewModel.img == nil || [detailViewModel.img isEqualToString:@"http://tu.qiumibao.com/uploads/day_151023/201510231742339628.png"]) {
        
    }else{
        [self.cellImageView sd_setImageWithURL:[NSURL URLWithString:detailViewModel.img]];
    }
    
    
    NSString *s = nil;
    if ([[detailViewModel.name substringToIndex:1] isEqualToString:@"<"]) {
        NSString *str = [detailViewModel.name substringFromIndex:8];
        NSArray *arr = [str componentsSeparatedByString:@"<"];
        s = arr[0];
    }else{
        s = detailViewModel.name;
    }
    
    self.titleLabel.text = s;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
