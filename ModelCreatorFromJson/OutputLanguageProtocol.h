//
//  OutputLanguageProtocol.h
//  ModelCreatorFromJson
//
//  Created by Abhiraj Kumar on 5/13/17.
//  Copyright © 2017 Indivisual. All rights reserved.
//

#ifndef OutputLanguageProtocol_h
#define OutputLanguageProtocol_h


@protocol OutputLangugeProtocol

-(int)countOfFileToBeCreated;
-(NSString*)extensionOfFileNameAtIndex:(int)index;
-(NSString*)contentOfFileToBeWrittenAtIndex:(int)index withDictionary:(NSDictionary*)dict andModelName:modelName;

@end

#endif /* OutputLanguageProtocol_h */
