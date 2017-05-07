//
//  ViewController.m
//  ModelCreatorFromJson
//
//  Created by Abhiraj Kumar on 5/8/17.
//  Copyright © 2017 Indivisual. All rights reserved.
//

#import "ViewController.h"
#import "JSONModelCreater.h"

@interface ViewController ()
@property (weak) IBOutlet NSScrollView *Content;

@property (unsafe_unretained) IBOutlet NSTextView *textView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    
    // Update the view, if already loaded.
}

- (IBAction)generateTheJsonFile:(id)sender {
    
    NSString *content = [[_textView textStorage]string];
    NSData *data =  [content dataUsingEncoding:NSUTF8StringEncoding];
    if (data){
        NSMutableDictionary* jsonData = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:data
                                                                                                                      options:kNilOptions
                                                                                                                        error:nil]];
        
        JSONModelCreater *modelCreator = [[JSONModelCreater alloc]initWithDictionary:jsonData andModelName:@"Model"];
        [modelCreator createModel];
        
        if (!jsonData){
            NSLog (@"Wrong foramt");
        }
        
    }
    
}
    @end
