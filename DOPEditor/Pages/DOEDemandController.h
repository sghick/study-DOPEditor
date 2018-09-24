//
//  DOEDemandController.h
//  DOPEditor
//
//  Created by 丁治文 on 2018/9/21.
//  Copyright © 2018年 tinswin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DOEDemandController : UIViewController

@property (copy  , nonatomic) NSString *app_name;
@property (copy  , nonatomic) NSString *user_demand_path;
@property (assign, nonatomic) NSInteger list_level;

- (void)reloadData;

@end
