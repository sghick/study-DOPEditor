//
//  DOEDemandsModels.h
//  DOPEditor
//
//  Created by 丁治文 on 2018/9/21.
//  Copyright © 2018年 tinswin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>

@interface DOEDemandsModels : NSObject

@end

@interface DOEDemand : NSObject

@property (copy  , nonatomic) NSString *uuid;
@property (copy  , nonatomic) NSString *name;
@property (copy  , nonatomic) NSString *comment;

@end

@interface DOEUserDemand : NSObject

@property (copy  , nonatomic) NSString *app_name;
@property (assign, nonatomic) NSInteger list_level;
@property (copy  , nonatomic) NSString *demand_uuid;
@property (copy  , nonatomic) NSString *demand_path;
@property (strong, nonatomic) DOEDemand *demand;

@end
