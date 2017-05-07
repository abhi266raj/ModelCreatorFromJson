//
//  ConfigurationModel.h
//  ModelCreatorFromJson
//
//  Created by Abhiraj Kumar on 5/13/17.
//  Copyright © 2017 Indivisual. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OutputLanguageProtocol.h"
#import "NamingAlgorithmStrategy.h"

@interface ConfigurationModel : NSObject

@property (nonatomic,strong) id <OutputLangugeProtocol>  langugeObject;
@property (nonatomic,strong) id <NamingAlgorithmStrategy> algorithmStrategy;
@property (nonatomic,strong) NSString *outputPath;

@end
