#import "MainScene.h"
#import "Crate.h"
#import "Firework.h"

@implementation MainScene
{
    CCButton *_launchButton;
    CCPhysicsNode *_physicsNode;
    CCLayoutBox *_crateLayoutBox;
    FireworkColor _fireworkColor;
}

- (void)didLoadFromCCB
{
    [self changeColor];
    [self changeNumber];
}

- (void)launchFirework
{
    for (int i = 0; i < _crateLayoutBox.children.count; i++)
    {
        [self scheduleBlock:^(CCTimer *timer) {
            Firework *firework = (Firework*)[CCBReader load:@"Firework"];
            [_physicsNode addChild:firework];
            firework.position = _launchButton.position;
            firework.fireworkColor = _fireworkColor;
            [firework.physicsBody applyImpulse:ccp(CCRANDOM_MINUS1_1()*50, 150.0)];
        } delay:CCRANDOM_0_1() * 0.3];
    }
}

- (void)changeNumber
{
    if (_crateLayoutBox.children.count == 3)
    {
        [_crateLayoutBox removeAllChildren];
    }
    Crate *crate = (Crate*)[CCBReader load:@"Crate"];
    crate.fireworkColor = _fireworkColor;
    [_crateLayoutBox addChild:crate];
}

- (void)changeColor
{
    if (_fireworkColor == FireworkColorWhite)
    {
        _fireworkColor = FireworkColorNone;
    }
    _fireworkColor++;
    for (Crate *crate in _crateLayoutBox.children) {
        crate.fireworkColor = _fireworkColor;
    }
}
@end
