//
//  DOEDataBase.m
//  DOPEditor
//
//  Created by 丁治文 on 2018/9/21.
//  Copyright © 2018年 tinswin. All rights reserved.
//

#import "DOEDataBase.h"
#import <WECDataBase/WECDBLib.h>
#import "DOEDemandsModels.h"

@implementation DOEDataBase

#pragma mark - DOEUserDemand

+ (BOOL)insertOrReplaceUserDemands:(NSArray<DOEUserDemand *> *)user_demands {
    return [DOEUserDemand insertOrReplace:user_demands primaryKeys:@[@"app_name",
                                                                     @"list_level",
                                                                     @"demand_uuid"]];
}
+ (NSArray<DOEUserDemand *> *)selectUserDemandsWithAppName:(NSString *)app_name
                                                  listLevel:(NSInteger)list_level {
    if (!app_name) {
        return nil;
    }
    NSString *where = @"WHERE app_name=(?) AND list_level=(?)";
    return [DOEUserDemand selectWhere:where paramsArray:@[app_name,@(list_level)]];
}
+ (BOOL)deleteUserDemandByAppName:(NSString *)app_name
                         listLevel:(NSInteger)list_level
                        demandUUID:(NSString *)demand_uuid {
    if (!app_name) {
        return NO;
    }
    if (!demand_uuid) {
        return NO;
    }
    NSString *where = @"WHERE app_name=(?) AND list_level=(?) AND demand_uuid=(?)";
    return [DOEUserDemand deleteWhere:where paramsArray:@[app_name,@(list_level),demand_uuid]];
}

@end
