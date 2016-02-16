//
//  PlayingsCardGameViewController.m
//  PlayingCard
//
//  Created by Pavlo Cretsu on 11/27/15.
//  Copyright © 2015 Pasha Cretsu. All rights reserved.
//

#import "PlayingsCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingsCardGameViewController ()

@end



@implementation PlayingsCardGameViewController



- (Deck *)createDeck {
    
    return [PlayingCardDeck new];
    
}



@end
