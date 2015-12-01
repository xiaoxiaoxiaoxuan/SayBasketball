//
//  DetailTableViewCell.h
//  sayBasketball1.0
//
//  Created by lanou3g on 15/11/27.
//  Copyright © 2015年 杨毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailVideoModel.h"

@interface DetailTableViewCell : UITableViewCell

- (void)bindCellWithDetailViewModel:(DetailVideoModel *)detailViewModel;

@end
