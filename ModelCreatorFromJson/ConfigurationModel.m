//
//  ConfigurationModel.m
//  ModelCreatorFromJson
//
//  Created by Abhiraj Kumar on 5/13/17.
//  Copyright © 2017 Indivisual. All rights reserved.
//

#import "ConfigurationModel.h"
#import "OutputLangugaeObjectiveC.h"
#import "CamelCaseNamingStrategy.h"


@implementation ConfigurationModel

-(id)init{
    self  = [super init];
    if (self){
        self.langugeObject = [[OutputLangugaeObjectiveC alloc]init];
        self.algorithmStrategy = [[CamelCaseNamingStrategy alloc]init];
    }
    return self;
}


-(NSString *)outputPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *returnString = [[NSString alloc]initWithFormat:@"%@/JSONModelCreator",documentsDirectory ];
    return returnString;
}

@end
