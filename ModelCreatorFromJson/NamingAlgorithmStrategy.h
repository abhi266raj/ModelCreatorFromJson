//
//  NamingAlgorithmStrategy.h
//  ModelCreatorFromJson
//
//  Created by Abhiraj Kumar on 5/13/17.
//  Copyright © 2017 Indivisual. All rights reserved.
//

#ifndef NamingAlgorithmStrategy_h
#define NamingAlgorithmStrategy_h


@protocol NamingAlgorithmStrategy

-(NSString*)fileName:(NSString*)string;
-(NSString*)variableName:(NSString *)string;

@end

#endif /* NamingAlgorithmStrategy_h */
