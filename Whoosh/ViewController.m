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
@property (strong, nonatomic) IBOutlet UIButton *sender;
- (IBAction)button:(UIButton *)sender;


@property (strong, nonatomic) NSMutableArray *sentences;

@property (strong, nonatomic) IBOutlet UILabel *firstLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label1Constraint;

@property (strong, nonatomic) IBOutlet UILabel *secondLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *secondLabelConstraint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sentences = [[NSMutableArray alloc] init];
    self.sender = [[UIButton alloc] init];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self resetState];
}

- (void) resetState {
    [self.firstLabel setText:nil];
    [self.secondLabel setText:nil];
    [self.sender setTitle:@"" forState:UIControlStateNormal];
    self.textField.hidden = NO;
    self.sender.hidden = NO;
}

- (void)animateLabels {
    self.textField.hidden = YES;
    self.sender.hidden = YES;
    CGFloat firstLabelInitialConstant = self.label1Constraint.constant;
    CGFloat firstLabelTargetConstant = firstLabelInitialConstant + self.view.frame.size.width + 65;
    CGFloat secondLabelInitialConstant = self.secondLabelConstraint.constant;
    CGFloat secondLabelTargetConstant = secondLabelInitialConstant + self.view.frame.size.height + 30;
    [UIView animateWithDuration:10
                     animations:^{
                         self.label1Constraint.constant = firstLabelTargetConstant;
                         self.secondLabelConstraint.constant = secondLabelTargetConstant;
                         [self.view layoutSubviews];
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             self.label1Constraint.constant = firstLabelInitialConstant;
                             self.secondLabelConstraint.constant = secondLabelInitialConstant;
                             [self resetState];
                         } else {
                             NSLog(@"Whoa!");
                         };
                     }
     ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
        [self animateLabels];
        [sender setTitle:@"" forState:UIControlStateNormal];
    } else {
        NSString *sentenceForLabel = [NSString stringWithFormat:@"%@", _textField.text];
        [self.sentences addObject:sentenceForLabel];
        NSString *tap = [NSString stringWithFormat:@"Sentences stored:  %@.\n\n", @(self.sentences.count)];
        [sender setTitle:tap forState:UIControlStateNormal];
        [self.textField setText:@""];
    }
}
@end
