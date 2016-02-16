//
//  ViewController.m
//  PlayingCard
//
//  Created by Pavlo Cretsu on 11/19/15.
//  Copyright © 2015 Pasha Cretsu. All rights reserved.
//

#import "ViewController.h"
#import "CardMatchingGame.h"

@interface ViewController ()

@property (strong, nonatomic) Deck *deck;
@property (nonatomic, strong) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end


@implementation ViewController

- (void)viewDidLoad {
    
    NSDictionary *dict = @{@"a":@"Angela", @"t":@"Tom", @"g":@"Ginger"};
    
    for (id key in dict) {
        
        id val = dict[key];
        
        if ([val isKindOfClass:[NSString class]]) {
            
            NSLog(@"dict[%@] = %@", key, val);
            
        }
    }
    
    NSMutableAttributedString *str = [self.scoreLabel.attributedText mutableCopy];
    
    [str setAttributes:@{
                         NSFontAttributeName            : [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline],
                         NSForegroundColorAttributeName : [UIColor greenColor],
                         NSStrokeWidthAttributeName     : @-5,
                         NSStrokeColorAttributeName     : [UIColor redColor],
                         NSUnderlineStyleAttributeName  : @(NSUnderlineStyleNone),
                         NSBackgroundColorAttributeName : [[UIColor yellowColor] colorWithAlphaComponent:0.3]
                         }
                 range:NSMakeRange(0, self.scoreLabel.text.length)];
    
    self.scoreLabel.attributedText = str;
    
    NSLog(@"arr = %@", [dict allValues]);
}

- (CardMatchingGame *) game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
    }
    return _game;
}

- (Deck *)deck
{
    if (!_deck) {
        _deck = [self createDeck];
    }
    return _deck;
}

- (Deck *)createDeck //abstract
{
    return nil;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game choseCardAtIndex:cardIndex];
    [self updateUI];
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        
        [cardButton setEnabled:!card.isMatched];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
}

- (NSString *) titleForCard:(Card *)card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *) backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"card-front" : @"card-back"];
}

@end
