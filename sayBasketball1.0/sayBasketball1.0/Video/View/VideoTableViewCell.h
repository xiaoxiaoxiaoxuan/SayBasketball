//
//  VideoTableViewCell.h
//  sayBasketball1.0
//
//  Created by lanou3g on 15/11/26.
//  Copyright © 2015年 杨毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "newVideoModel.h"
#import "JingdianVideoModel.h"

@interface VideoTableViewCell : UITableViewCell

- (void)bindWithNewVideoModel:(newVideoModel *)newVideoModel;
- (void)bindWithJingdianVideoModel:(JingdianVideoModel *)jingdianVideoModel;



@end
