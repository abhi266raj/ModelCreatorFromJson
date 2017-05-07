//
//  OutputLangugaeObjectiveC.m
//  ModelCreatorFromJson
//
//  Created by Abhiraj Kumar on 5/13/17.
//  Copyright © 2017 Indivisual. All rights reserved.
//

#import "OutputLangugaeObjectiveC.h"

@implementation OutputLangugaeObjectiveC

-(int)countOfFileToBeCreated{
    return 2;
}

-(NSString*)extensionOfFileNameAtIndex:(int)index{
    if (index == 0){
        return @".h";
    }else{
        return @".m";
    }
}


-(NSString*)stringToBeWrittenInFileForPropertyName:(NSString *)property class:(Class)objectClass andIndex:(int)index{
    if (index >0){
        return @"";
    }
    NSString *variableName = property;
    Class itemClass = objectClass;
    NSString *string = @"Error";
    NSLog (@"ItemClass %@",itemClass);
    if ([itemClass isSubclassOfClass:[NSString class]]){
        string = [[NSString alloc]initWithFormat:@"@property (nonatomic,strong) NSString * %@",variableName];
    }
    
    if ([itemClass isSubclassOfClass:[NSNumber class]]){
        string = [[NSString alloc]initWithFormat:@"@property (nonatomic,strong) NSNumber * %@",variableName];
    }
    
    if ([itemClass isSubclassOfClass:[NSDictionary class]]){
        string = [[NSString alloc]initWithFormat:@"@property (nonatomic,strong) NSDictionary * %@",variableName];
    }
    
    if ([itemClass isSubclassOfClass:[NSArray class]]){
        string = [[NSString alloc]initWithFormat:@"@property (nonatomic,strong) NSArray * %@",variableName];
    }
    return string;
    
}



-(NSString*)contentOfFileToBeWrittenAtIndex:(int)index withDictionary:(NSDictionary*)dict andModelName:modelName{
    NSMutableSet *set = [[NSMutableSet alloc]init];
    for (NSString* key in dict){
        id object = dict[key];
        NSLog (@"Set of object %@ , %@", key ,[object class]);
        [set addObject:[self stringToBeWrittenInFileForKey:key value:object index:index] ];
        //NSLog (@"%@",set);
    }
    return [self outputStringWrittenFromSet:set index:index andModelName:modelName];
}


-(NSString*)outputStringWrittenFromSet:(NSSet*)set index:(int)index andModelName:modelName{
    NSMutableString *outputString = [[NSMutableString alloc]init];
    [outputString appendString:[self
                                headerBeforeMainContentForFileAtIndex:index forClassName:modelName]];
    [outputString appendString:@"\n"];
    if (index == 0){
        for (NSString* item in set){
            [outputString appendString:item];
            [outputString appendString:@";\n"];
        }
    }
    [outputString appendString:[self footerAfterMainContentForFileAtIndex:index forClassName:modelName]];
    return outputString;
    
    
    
}

-(NSString*)stringToBeWrittenInFileForKey:(NSString*)key value:(id)value index:(int)index{
    Class itemClass = [value class];
    NSString *variableName = key;
    //[self variableNameAccordingToAlgorithm:key];
    return [self stringToBeWrittenInFileForPropertyName:variableName class:itemClass andIndex:index];
}



-(NSString *)headerBeforeMainContentForFileAtIndex:(int)index forClassName:(NSString*)string{
    if (index ==0){
        return [self headerForHfileForClassName:string];
    }else{
        return [self headerForMfileForClassName:string];
    }
}
-(NSString*) footerAfterMainContentForFileAtIndex:(int)index forClassName:(NSString*)string{
    if (index == 0){
        return [self footerForHfileForClassName:string];
    }else{
        return [self footerForMfileForClassName:string];
    }
}

-(NSString *)headerForHfileForClassName:(NSString*)string{
    return [[NSString alloc]initWithFormat:@"%@@interface %@ : NSObject\n",[self getComment],string ];
}

-(NSString *)headerForMfileForClassName:(NSString*)string{
    return [[NSString alloc]initWithFormat:@"%@@implementation %@\n",[self getComment],string ];
}

-(NSString *)footerForHfileForClassName:(NSString*)string{
    return @"\n@end\n";
    
}

-(NSString *)footerForMfileForClassName:(NSString*)string{
    return @"\n@end\n";
}


-(NSString*)getComment{
    return  [[NSMutableString alloc ]initWithString:@"/*\nModel Created By Source Creator\n*/\n"];
}




@end
