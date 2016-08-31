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

@property (strong, nonatomic) NSMutableArray *sentences;

@property (strong, nonatomic) IBOutlet UILabel *firstLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *firstLabelTopConstraint;

@property (strong, nonatomic) IBOutlet UILabel *secondLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *secondLabelTopConstraint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.sentences = [[NSMutableArray alloc] init];

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
    if (self.sentences.count == 2) {
        [self.firstLabel setText: self.sentences[0]];
        [self.secondLabel setText: self.sentences[1]];
        [self.sentences removeAllObjects];
        
        CGFloat firstLabelInitialConstant = self.firstLabelTopConstraint.constant;
        CGFloat targetConstant = firstLabelInitialConstant + self.view.frame.size.height;
        NSString *stringReset = [NSString stringWithFormat:@""];
        [sender setTitle:stringReset forState:UIControlStateNormal];

        [UIView animateWithDuration:10
                         animations:^{
                             self.firstLabelTopConstraint.constant = targetConstant;
                             [self.view layoutSubviews];
                         }
         ];
        
    } else {
        NSString *sentenceForLabel = [NSString stringWithFormat:@"%@", _textField.text];
        [self.sentences addObject:sentenceForLabel];
        NSString *tap = [NSString stringWithFormat:@"Sentences stored:  %@.\n\n", @(self.sentences.count)];
        [sender setTitle:tap forState:UIControlStateNormal];
        [self.textField setText:@""];
    }
}
@end
