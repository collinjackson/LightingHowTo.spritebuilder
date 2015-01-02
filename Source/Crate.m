//
//  Crate.m
//  LightingHowTo
//
//  Created by Collin Jackson on 1/1/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Crate.h"

@implementation Crate
{
    CCSprite *_stripe;
    CCLabelBMFont *_label;
    FireworkColor _fireworkColor;
}

@synthesize fireworkColor;

-(void)didLoadFromCCB
{
    _stripe.visible = NO;
}

-(void)setFireworkColor:(FireworkColor)color
{
    _fireworkColor = color;
    CCEffect *effect = nil;
    _stripe.visible = YES;
    switch (color) {
        case FireworkColorNone:
            _stripe.visible = NO;
        case FireworkColorRed:
            break;
        case FireworkColorGreen:
            effect = [CCEffectHue effectWithHue:90];
            break;
        case FireworkColorBlue:
            effect = [CCEffectHue effectWithHue:-130];
            break;
        case FireworkColorYellow:
            effect = [CCEffectHue effectWithHue:60];
            break;
        case FireworkColorWhite:
            effect = [CCEffectBrightness effectWithBrightness:1.0];
            break;
        default:
            break;
    }
    _stripe.effect = effect;
}
@end
