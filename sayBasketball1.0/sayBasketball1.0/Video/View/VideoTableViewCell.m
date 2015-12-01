//
//  VideoTableViewCell.m
//  sayBasketball1.0
//
//  Created by lanou3g on 15/11/26.
//  Copyright © 2015年 杨毅. All rights reserved.
//

#import "VideoTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface VideoTableViewCell()

@property (nonatomic, strong)UIImageView *cellImageView; // cell上的图片
@property (nonatomic, strong)UILabel *titleLabel; // 标题
@property (nonatomic, strong)UILabel *timeLabel; // 时间


@end

@implementation VideoTableViewCell

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
    self.titleLabel.textColor = [UIColor colorWithRed:0.498f green:0.498f blue:0.498f alpha:1.00f];
    // self.titleLabel.backgroundColor = [UIColor yellowColor];
    self.titleLabel.numberOfLines = 0;
    [self addSubview: self.titleLabel];
    
    // timelabel
    self.timeLabel = [[UILabel alloc] init];
    // self.timeLabel.backgroundColor = [UIColor yellowColor];
    self.timeLabel.font = [UIFont systemFontOfSize:14.0f];
    self.timeLabel.textColor = [UIColor grayColor];
    [self addSubview:self.timeLabel];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.cellImageView.frame = CGRectMake(10, 10, 100, 80);
    
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.cellImageView.frame) + 10, CGRectGetMinY(self.cellImageView.frame), self.bounds.size.width - 30 - CGRectGetWidth(self.cellImageView.frame), 55);
    
    self.timeLabel.frame = CGRectMake(CGRectGetMaxX(self.cellImageView.frame) + 10, self.bounds.size.height - 30, 200, 20);
    
}

- (void)bindWithNewVideoModel:(newVideoModel *)newVideoModel
{
//    // 使用占位图，先加一个判断
    if (newVideoModel.picUrlString == nil || [newVideoModel.picUrlString isEqualToString:@"http://tu.qiumibao.com/uploads/day_151023/201510231742339628.png"]) {
        
        self.cellImageView.image = [UIImage imageNamed:@"zhanweitu.jpg"];
        
    }else{
        [self.cellImageView sd_setImageWithURL:[NSURL URLWithString:newVideoModel.picUrlString]];
    }
    
    
    
    self.titleLabel.text = newVideoModel.title;
    // 判断多长时间前
    // 创建时间
    NSString *time = newVideoModel.updatetime;
    // 字符串转化成date类型
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *updateTimes = [dateFormatter dateFromString:time];
    // 当前时间
    NSDate *now = [NSDate date];
    // 时间差
    double timeInterval = [now timeIntervalSinceDate:updateTimes];
    // 多少时间前
    NSString *s = nil;
    if (timeInterval < 60) {
        s = @"刚刚";
    }else{
        if (timeInterval < 3600) {
            int i = timeInterval / 60;
            s = [NSString stringWithFormat:@"%d分钟前", i];
        }else{
            if (timeInterval < 24 * 3600) {
                int i = timeInterval / 3600;
                s = [NSString stringWithFormat:@"%d小时前", i];
            }else{
                if (timeInterval < 7 * 24 * 3600) {
                    int i = timeInterval / (24 * 3600);
                    s = [NSString stringWithFormat:@"%d天前", i];
                }else{
                    if (timeInterval < 30 * 24 * 3600) {
                        int i = timeInterval / (7 * 24 * 3600);
                        s = [NSString stringWithFormat:@"%d周前", i];
                    }else{
                        s = @"很久以前";
                    }
                        
                }
            }
        }
    }
    self.timeLabel.text = s;
}

- (void)bindWithJingdianVideoModel:(JingdianVideoModel *)jingdianVideoModel
{
    [self.cellImageView sd_setImageWithURL:[NSURL URLWithString:jingdianVideoModel.img]];
    self.titleLabel.text = jingdianVideoModel.name;
    self.timeLabel.text = @"经典记录";
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
