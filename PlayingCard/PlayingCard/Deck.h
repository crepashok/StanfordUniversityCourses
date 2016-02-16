//
//  Deck.h
//  PlayingCard
//
//  Created by Pavlo Cretsu on 11/19/15.
//  Copyright © 2015 Pasha Cretsu. All rights reserved.
//

@import Foundation;

#import "Card.h"

@interface Deck : NSObject

-(void)addCard:(Card *)card atTop:(BOOL)atTop;
-(void)addCard:(Card *)card;

-(Card *)drawRandomCard;

@end
