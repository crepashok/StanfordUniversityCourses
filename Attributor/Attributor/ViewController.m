//
//  ViewController.m
//  Attributor
//
//  Created by Pavlo Cretsu on 11/26/15.
//  Copyright © 2015 Pasha Cretsu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *headline;
@property (weak, nonatomic) IBOutlet UITextView *body;
@property (weak, nonatomic) IBOutlet UIButton *outlineButton;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:self.outlineButton.currentTitle];
    
    [title setAttributes:@{
                           NSStrokeWidthAttributeName : @3,
                           NSStrokeColorAttributeName : self.outlineButton.tintColor
                           }
                   range:NSMakeRange(0, title.length)];
    
    [self.outlineButton setAttributedTitle:title forState:UIControlStateNormal];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self usePrefferredFonts];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(prefferredFontsChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
}


- (void) prefferredFontsChanged:(NSNotification *)notification
{
    [self usePrefferredFonts];
}


- (void) usePrefferredFonts
{
    self.body.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.headline.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}


- (IBAction)changeBodySelectionColorToMatchBackgroundOfButton:(UIButton *)sender
{
    [self.body.textStorage addAttribute:NSForegroundColorAttributeName
                                  value:sender.backgroundColor
                                  range:self.body.selectedRange];
}


- (IBAction)outlineBodySelection {
    [self.body.textStorage addAttributes:@{
                                           NSStrokeWidthAttributeName: @-3,
                                           NSStrokeColorAttributeName: [UIColor blackColor]
                                           }
                                   range:self.body.selectedRange];
}


- (IBAction)unoutlineBodySelection {
    [self.body.textStorage removeAttribute:NSStrokeWidthAttributeName
                                     range:self.body.selectedRange];
}

@end
