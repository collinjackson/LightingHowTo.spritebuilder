//
//  Firework.h
//  LightingHowTo
//
//  Created by Collin Jackson on 1/1/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCNode.h"

typedef enum
{
    FireworkColorNone = 0,
    FireworkColorRed,
    FireworkColorGreen,
    FireworkColorBlue,
    FireworkColorYellow,
    FireworkColorWhite,
} FireworkColor;

@interface Firework : CCNode
@property (nonatomic) FireworkColor fireworkColor;
@end
