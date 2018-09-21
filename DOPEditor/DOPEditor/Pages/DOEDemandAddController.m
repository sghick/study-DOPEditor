//
//  DOEDemandAddController.m
//  DOPEditor
//
//  Created by 丁治文 on 2018/9/21.
//  Copyright © 2018年 tinswin. All rights reserved.
//

#import "DOEDemandAddController.h"
#import "DOEDemandsModels.h"
#import "DOEDataBase.h"

@interface DOEDemandAddController ()

@end

@implementation DOEDemandAddController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    DOEDemand *demand = [[DOEDemand alloc] init];
    demand.uuid = [NSUUID UUID].UUIDString;
    demand.name = @"首页";
    demand.comment = @"大首页逻辑";
    
    NSString *user_demand_path = [NSString stringWithFormat:@"%@/%@", self.last_user_demand_path?:@"", demand.name];
    DOEUserDemand *userDemand = [[DOEUserDemand alloc] init];
    userDemand.app_name = self.app_name;
    userDemand.list_level = self.list_level;
    userDemand.demand_path = user_demand_path;
    userDemand.demand_uuid = demand.uuid;
    userDemand.demand = demand;
    
    [DOEDataBase insertOrReplaceUserDemands:@[userDemand]];
    
    [self.navigationController popViewControllerAnimated:NO];
}

@end
