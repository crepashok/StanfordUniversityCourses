//
//  Card.m
//  PlayingCard
//
//  Created by Pavlo Cretsu on 11/19/15.
//  Copyright © 2015 Pasha Cretsu. All rights reserved.
//

#import "Card.h"

@implementation Card

@synthesize contents = _contents;

- (NSString *)contents {
    return _contents;
}

- (void)setContents:(NSString *)contents {
    _contents = contents;
}

- (int) match:(NSArray *)otherCards {
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    return score;
}
@end
