//
//  PlayingCard.m
//  PlayingCard
//
//  Created by Pavlo Cretsu on 11/19/15.
//  Copyright © 2015 Pasha Cretsu. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit; //Because we provide setter AND getter
@synthesize rank = _rank; //Because we provide setter AND getter


// Override parent getter
- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

- (int)match:(NSArray *)otherCards {
    int score = 0;
    if ([otherCards count] == 1) {
        id firstCard = [otherCards firstObject];
        if ([firstCard isKindOfClass:[PlayingCard class]]) {
            PlayingCard *otherCard = (PlayingCard *)firstCard;
            if ([self.suit isEqualToString:otherCard.suit]) {
                score = 1;
            } else if (self.rank == otherCard.rank) {
                score = 4;
            }
        }
    }
    return score;
}


+ (NSArray *)validSuits {
    return @[@"♠️", @"♣️", @"♥️", @"♦️"]; //Obj-c array sugar
}

- (void)setSuit:(NSString *)suit {
    if([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank {
    return [[self rankStrings] count] - 1;
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}


@end
