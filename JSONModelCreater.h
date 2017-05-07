//
//  JSONModelCreater.h
//  ModelCreatorFromJson
//
//  Created by Abhiraj Kumar on 5/8/17.
//  Copyright © 2017 Indivisual. All rights reserved.
//

 /* JSONModelCreater_h */

#import "ConfigurationModel.h"

@interface JSONModelCreater : NSObject


@property (nonatomic,strong) ConfigurationModel* configuration;
@property (nonatomic,strong) NSDictionary *jsonDictionary;
@property (nonatomic,strong) NSString *modelName;


-(id)initWithDictionary:(NSDictionary*)dictionary andModelName:(NSString*)ModelName;
-(void)createModel;
@end
