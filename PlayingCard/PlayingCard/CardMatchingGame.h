//
//  CardMatchingGame.h
//  PlayingCard
//
//  Created by Pavlo Cretsu on 11/20/15.
//  Copyright © 2015 Pasha Cretsu. All rights reserved.
//

@import Foundation;

#import "Deck.h"

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

- (void)choseCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;

@end
