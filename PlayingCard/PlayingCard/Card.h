//
//  Card.h
//  PlayingCard
//
//  Created by Pavlo Cretsu on 11/19/15.
//  Copyright © 2015 Pasha Cretsu. All rights reserved.
//

@import Foundation;

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

//To override this property, we have to use new name
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

- (int) match:(NSArray *)otherCards;

@end