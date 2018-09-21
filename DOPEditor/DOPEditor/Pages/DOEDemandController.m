//
//  DOEDemandController.m
//  DOPEditor
//
//  Created by 丁治文 on 2018/9/21.
//  Copyright © 2018年 tinswin. All rights reserved.
//

#import "DOEDemandController.h"
#import "WCSections.h"
#import "DOEDemandsModels.h"
#import "DOEDataBase.h"
#import "DOEDemandAddController.h"

typedef NS_ENUM(NSInteger, kSectionType) {
    kSectionTypeAddDemand,
    kSectionTypeDemandsList,
};

typedef NS_ENUM(NSInteger, kRowType) {
    kRowTypeAddDemand,
    kRowTypeDemandsList,
};

@interface DOEDemandController ()<
UITableViewDataSource,
UITableViewDelegate>

@property (strong, nonatomic) WCSections *sections;
@property (strong, nonatomic) NSArray<DOEUserDemand *> *userDemands;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation DOEDemandController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self addSubviews];
    self.app_name = @"小嘩";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadData];
}

- (void)addSubviews {
    [self.view addSubview:self.tableView];
}

- (void)queryDataBase {
    self.userDemands = [DOEDataBase selectUserDemandsWithAppName:self.app_name listLevel:self.list_level];
}

- (void)loadSections {
    WCSections *sections = [[WCSections alloc] init];
    if (self.userDemands && self.userDemands.count) {
        [sections addSectionKey:kSectionTypeDemandsList rowKey:kRowTypeDemandsList rowSamesCount:self.userDemands.count];
    } else {
        [sections addSectionKey:kSectionTypeAddDemand rowKey:kRowTypeAddDemand];
    }
    self.sections = sections;
}

- (void)reloadData {
    [self queryDataBase];
    [self loadSections];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.sectionSamesCountOfAll;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    WCSection *sec = [self.sections sectionWithIndexPathSection:section];
    return sec.rowSamesCountOfAll;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WCRow *row = [self.sections rowWithIndexPath:indexPath];
    switch (row.rowKey) {
        case kRowTypeAddDemand: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kRowTypeAddDemand"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"kRowTypeAddDemand"];
            }
            cell.textLabel.text = @"您还未添加任何需求,请点击添加吧 +";
            return cell;
        }
            break;
        case kRowTypeDemandsList: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kRowTypeDemandsList"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"kRowTypeDemandsList"];
            }
            DOEUserDemand *udmenad = self.userDemands[row.rowSamesIndex];
            cell.textLabel.text = udmenad.demand.name;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@\n%@", udmenad.demand.comment, udmenad.demand.uuid];
            return cell;
        }
            break;
        default:
            break;
    }
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"defualtCell"];
    return cell;
}

#pragma mark - UITableViewDataDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![self validateAndRequestAppName]) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
    
    WCRow *row = [self.sections rowWithIndexPath:indexPath];
    switch (row.rowKey) {
        case kRowTypeAddDemand: {
            DOEDemandAddController *addVC = [[DOEDemandAddController alloc] init];
            addVC.app_name = self.app_name;
            addVC.list_level = self.list_level;
            addVC.last_user_demand_path = self.user_demand_path;
            addVC.navigationItem.title = @"添加需求";
            [self.navigationController pushViewController:addVC animated:NO];
        }
            break;
        case kRowTypeDemandsList: {
            DOEUserDemand *udmand = self.userDemands[row.rowSamesIndex];
            NSString *nextDemandPath = [NSString stringWithFormat:@"%@/%@", self.user_demand_path?:@"", udmand.demand.name];
            DOEDemandController *nextVC = [[DOEDemandController alloc] init];
            nextVC.app_name = self.app_name;
            nextVC.list_level = self.list_level + 1;
            nextVC.user_demand_path = nextDemandPath;
            nextVC.navigationItem.title = [NSString stringWithFormat:@"%@:%@", self.app_name, nextDemandPath];
            [self.navigationController pushViewController:nextVC animated:YES];
        }
            break;
            
        default:
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Bussiness

- (BOOL)validateAndRequestAppName {
    if (!self.app_name) {
        return NO;
    }
    return YES;
}

#pragma mark - Getters

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,
                                                                   [UIScreen mainScreen].bounds.size.width,
                                                                   [UIScreen mainScreen].bounds.size.height)
                                                  style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
