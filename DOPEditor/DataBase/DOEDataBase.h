//
//  DOEDataBase.h
//  DOPEditor
//
//  Created by 丁治文 on 2018/9/21.
//  Copyright © 2018年 tinswin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DOEDemand;
@class DOEUserDemand;
@interface DOEDataBase : NSObject


#pragma mark - DOEUserDemand

+ (BOOL)insertOrReplaceUserDemands:(NSArray<DOEUserDemand *> *)user_demands;
+ (NSArray<DOEUserDemand *> *)selectUserDemandsWithAppName:(NSString *)app_name
                                                  listLevel:(NSInteger)list_level;
+ (BOOL)deleteUserDemandByAppName:(NSString *)app_name
                         listLevel:(NSInteger)list_level
                        demandUUID:(NSString *)demand_uuid;

@end
