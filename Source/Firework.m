//
//  Firework.m
//  LightingHowTo
//
//  Created by Collin Jackson on 1/1/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Firework.h"
#import "CCPhysics+ObjectiveChipmunk.h"

@implementation Firework
{
    CCParticleSystem *_particleSystem;
    CCLightNode *_lightNode;
    CCSprite *_sprite;
    FireworkColor _fireworkColor;
}

-(void)didLoadFromCCB
{
    [_particleSystem stopSystem];
    CCActionSequence *sequence = [CCActionSequence actions:
        [CCActionDelay actionWithDuration:1.0],
        [CCActionCallFunc actionWithTarget:self selector:@selector(explode)],
        [CCActionDelay actionWithDuration:0.1],
        [CCActionCallFunc actionWithTarget:_particleSystem selector:@selector(stopSystem)],
        [CCActionDelay actionWithDuration:1.0],
        [CCActionCallFunc actionWithTarget:self selector:@selector(cleanup)],
        nil];
    [self runAction:sequence];
    [[OALSimpleAudio sharedInstance] playEffect:@"Sounds/launch.wav"];
}

@synthesize fireworkColor;
-(void)setFireworkColor:(FireworkColor)color
{
    _fireworkColor = color;
    CCColor *targetColor;
    switch (color) {
        case FireworkColorRed:
            targetColor = [CCColor colorWithRed:1.0 green:0.0 blue:0.0];
            _sprite.effect = [CCEffectHue effectWithHue:-20];
            break;
        case FireworkColorGreen:
            targetColor = [CCColor colorWithRed:0.0 green:1.0 blue:0.0];
            _sprite.effect = [CCEffectHue effectWithHue:90];
            break;
        case FireworkColorBlue:
            targetColor = [CCColor colorWithRed:0.0 green:0.2 blue:1.0];
            _sprite.effect = [CCEffectHue effectWithHue:-180];
            break;
        case FireworkColorYellow:
            targetColor = [CCColor colorWithRed:1.0 green:1.0 blue:0.0];
            _sprite.effect = [CCEffectHue effectWithHue:60];
            break;
        default:
        case FireworkColorWhite:
            targetColor = [CCColor colorWithRed:1.0 green:1.0 blue:1.0];
            _sprite.effect = [CCEffectSaturation effectWithSaturation:-1.0];
            break;
    }
    _particleSystem.startColor = targetColor;
    _particleSystem.endColor = targetColor;
    _lightNode.color = targetColor;
}

-(void)explode
{
    [self removeChild:_sprite];
    _sprite = nil;
    
    [_particleSystem resetSystem];
    [self schedule:@selector(updateBrightness) interval:0.01];
    [[OALSimpleAudio sharedInstance] playEffect:@"Sounds/explosion.wav"];
}

-(void)updateBrightness
{
    CGFloat intensity = (float)_particleSystem.particleCount / _particleSystem.totalParticles;
    _lightNode.intensity = intensity;
    _lightNode.specularIntensity = intensity / 2;
    _lightNode.ambientIntensity = intensity / 5;
}

-(void)cleanup
{
    [self removeChild:_particleSystem];
    _particleSystem = nil;

    [self removeChild:_lightNode];
    _lightNode = nil;

    [self.physicsNode.space addPostStepBlock:^{
        [self.parent removeChild:self];
    } key:self];
}
@end
