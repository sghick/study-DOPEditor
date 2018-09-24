//
//  DOETabRootController.m
//  DOPEditor
//
//  Created by 丁治文 on 2018/9/21.
//  Copyright © 2018年 tinswin. All rights reserved.
//

#import "DOETabRootController.h"
#import "DOEDemandController.h"

@interface DOETabRootController ()

@end

@implementation DOETabRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    DOEDemandController *demand = [[DOEDemandController alloc] init];
    UINavigationController *navDemand = [[UINavigationController alloc] initWithRootViewController:demand];
    navDemand.tabBarItem.title = @"需求";
    
    self.viewControllers = @[navDemand];
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
