#import <Foundation/Foundation.h>
#import "JSONModelCreater.h"
#import "ConfigurationModel.h"


@implementation JSONModelCreater


-(id)initWithDictionary:(NSDictionary*)dictionary andModelName:(NSString*)modelName{
    self = [super init];
    if (self){
        self.jsonDictionary = dictionary;
        self.configuration = [[ConfigurationModel alloc]init];
         self.modelName = [self fileNameAccordingToAlgorithm:modelName];
    }
    return self;
}


-(void)createModel{
    [self updateModelUsingDictionary:self.jsonDictionary andModelName:self.modelName];
}


-(NSString*)fileNameAccordingToAlgorithm:(NSString*)string{
    return [self.configuration.algorithmStrategy fileName:string];
}


-(NSString*)variableNameAccordingToAlgorithm:(NSString *)string{
    return [self.configuration.algorithmStrategy variableName:string];
    
}



-(bool)checkIfFileWithModelNameExists:(NSString*)string{
    NSFileManager *fileManger = [NSFileManager defaultManager];
    NSString *currentpath = [self getPathToWriteTheFile];
    NSString *pathh = [[NSString alloc]initWithFormat:@"%@/%@.h",currentpath,string];
    NSString *pathm = [[NSString alloc]initWithFormat:@"%@/%@.m",currentpath,string];
    return ([fileManger fileExistsAtPath:pathh] && [fileManger fileExistsAtPath:pathm]);
}


-(NSString *)pathForFilewithModelName:(NSString*)string{
    NSString* currentpath = [self getPathToWriteTheFile];;
    NSString *path = [[NSString alloc]initWithFormat:@"%@/%@",currentpath,string];
    return path;
    
}

-(NSString*)pathForNewCreatedFileWithModelName:(NSString*)string{
    NSString *currentpath = [self getPathToWriteTheFile];
    NSString *path = [[NSString alloc]initWithFormat:@"%@/%@",currentpath,string];
    int fileCount = [self.configuration.langugeObject countOfFileToBeCreated];
    for (int i=0;i<fileCount;i++){
        NSString* extension =  [self.configuration.langugeObject extensionOfFileNameAtIndex:i];
        NSString *filePath = [[NSString alloc]initWithFormat:@"%@/%@%@",currentpath,string,extension];
        [[NSFileManager defaultManager] createFileAtPath:filePath
                                                contents:nil
                                              attributes:nil];
    }
    
    
    return path;
    
}

-(void)updateModelUsingDictionary:(NSDictionary*)dictionary andModelName:(NSString*)string{
    
    NSString *modelName = [self fileNameAccordingToAlgorithm:string];
    NSString *pathForModelFile;
    if ([self checkIfFileWithModelNameExists:modelName]){
        pathForModelFile = [self pathForFilewithModelName:modelName];
    }else{
        pathForModelFile = [self pathForNewCreatedFileWithModelName:modelName];
        NSLog (@"Going to craete a file");
    }
    [self updateModelUsingDictionary:dictionary andFilePath:pathForModelFile andModelName:string];
    
    for (NSString* key in dictionary){
        id object = dictionary[key];
        NSLog (@"Class of object %@ , %@", key ,[object class]);
        if ([object isKindOfClass:[NSDictionary class]]){
            [self updateModelUsingDictionary:object  andModelName:key];
        }
        
        if ([object isKindOfClass:[NSArray class]]){
            for (id element in (NSArray*)object){
                if ([element isKindOfClass:[NSDictionary class]]){
                    [self updateModelUsingDictionary:element andModelName:[self.configuration.algorithmStrategy fileName:key]];
                 }
            }
        }
    }
    
}


-(void)updateModelUsingDictionary:(NSDictionary*)dictionary andFilePath:(NSString*)filePath andModelName:modelName{
    
    NSMutableDictionary *dictionaryUsingModifiedKey = [[NSMutableDictionary alloc]init];
    for (id key in dictionary){
        NSString* modifiedKey = [self.configuration.algorithmStrategy variableName:key];
        dictionaryUsingModifiedKey[modifiedKey] = dictionary[key];
    }
    
    
    int fileCount = [self.configuration.langugeObject countOfFileToBeCreated];
    for (int i = 0; i<fileCount; i++){
    NSString *fileContent = [self.configuration.langugeObject contentOfFileToBeWrittenAtIndex:i withDictionary:dictionaryUsingModifiedKey andModelName:modelName];
        NSString *resultFilePath = [[NSString alloc]initWithFormat:@"%@%@",filePath,[self.configuration.langugeObject extensionOfFileNameAtIndex:i] ];
        [fileContent writeToFile:resultFilePath
                       atomically:NO
                         encoding:NSStringEncodingConversionAllowLossy
                            error:nil];
    }
}






-(NSString*)getPathToWriteTheFile{
    return self.configuration.outputPath;
}


@end


