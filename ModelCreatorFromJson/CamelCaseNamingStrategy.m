//
//  CamelCaseNamingStrategy.m
//  ModelCreatorFromJson
//
//  Created by Abhiraj Kumar on 5/13/17.
//  Copyright © 2017 Indivisual. All rights reserved.
//

#import "CamelCaseNamingStrategy.h"

@implementation CamelCaseNamingStrategy

-(NSString*)fileName:(NSString *)string{
    return [self myUnderscoresToCamelCase:string firstCharacterCapital:true];
}

-(NSString *)variableName:(NSString *)string{
    return [self myUnderscoresToCamelCase:string firstCharacterCapital:false];
    
}


-(NSString *)myUnderscoresToCamelCase:(NSString *)underscores firstCharacterCapital:(bool)isFirstCharCapital {
    NSMutableString *output = [NSMutableString string];
    BOOL makeNextCharacterUpperCase = isFirstCharCapital;
    for (NSInteger idx = 0; idx < [underscores length]; idx += 1) {
        unichar c = [underscores characterAtIndex:idx];
        if (c == '_') {
            makeNextCharacterUpperCase = YES;
        } else if (makeNextCharacterUpperCase) {
            [output appendString:[[NSString stringWithCharacters:&c length:1] uppercaseString]];
            makeNextCharacterUpperCase = NO;
        } else {
            [output appendFormat:@"%C", c];
        }
    }
    return output;
}



@end
