//
//  PlayingCardDeck.m
//  PlayingCard
//
//  Created by Pavlo Cretsu on 11/19/15.
//  Copyright © 2015 Pasha Cretsu. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

-(instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        for (NSString *suit in [PlayingCard validSuits]) {
            
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                
                id card = [[PlayingCard alloc] init];
                
                if ([card isKindOfClass:[PlayingCard class]]) {
                    PlayingCard *otherCard = (PlayingCard *)card;
                    otherCard.rank = rank;
                    otherCard.suit = suit;
                    [self addCard:otherCard];
                }
            }
        
        }
        
    }
    
    return self;
}

@end
