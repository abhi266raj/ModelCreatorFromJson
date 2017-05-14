//
//  ViewController.m
//  ModelCreatorFromJson
//
//  Created by Abhiraj Kumar on 5/8/17.
//  Copyright © 2017 Indivisual. All rights reserved.
//

#import "ViewController.h"
#import "JSONModelCreater.h"

static NSString *defaultMessage = @"Enter Json here";
@interface ViewController ()
@property (weak) IBOutlet NSScrollView *Content;
@property (weak) IBOutlet NSTextField *textField;
@property (weak) IBOutlet NSTextField *MessageBox;
@property (unsafe_unretained) IBOutlet NSTextView *textView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.automaticQuoteSubstitutionEnabled = NO;
    
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
        NSError* error = nil;
        NSMutableDictionary* jsonData = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:&error]];
        NSString *fileName = self.textField.stringValue;
        if (!fileName){
            fileName = @"FileName";
        }
        if (jsonData){
        JSONModelCreater *modelCreator = [[JSONModelCreater alloc]initWithDictionary:jsonData andModelName:fileName];
        [modelCreator createModel];
        }
        if (!jsonData){
            self.MessageBox.stringValue =error.localizedDescription;
        }else{
            self.MessageBox.stringValue = @"File Created";
        }
        
    }
    
}
    @end
