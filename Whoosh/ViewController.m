//
//  ViewController.m
//  Whoosh
//
//  Created by Dan Esrey on 2016/30/08.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>


@property (strong, nonatomic) IBOutlet UITextField *textField;

- (IBAction)button:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UILabel *firstLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *firstLabelTopConstraint;

@property (strong, nonatomic) IBOutlet UILabel *secondLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *secondLabelTopConstraint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason {
    NSLog(@"'%@' in %s at line %d", textField.text, __PRETTY_FUNCTION__, __LINE__);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)button:(UIButton *)sender {
    NSMutableArray *sentences = [NSMutableArray array];
//    NSInteger lastIndex = sentences.count;
 
    NSString *sentenceForLabel = [NSString stringWithFormat:@"%@", _textField.text];
    [sentences addObject:sentenceForLabel];
 
    NSString *tap = [NSString stringWithFormat:@"You have 1 sentence stored.\n\n"];
    [sender setTitle:tap forState:UIControlStateNormal];
    [self.firstLabel setText:sentences[0]];
   
    
    
}
@end
