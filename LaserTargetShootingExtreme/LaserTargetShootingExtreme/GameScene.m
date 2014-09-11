//
//  GameScene.m
//  LaserTargetShootingExtreme
//
//  Created by Steven Thompson on 2014-09-08.
//  Copyright (c) 2014 Steven Thompson. All rights reserved.
//

#import "GameScene.h"
#import "UITouch+STRadiusTouch.h"

@interface GameScene ()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) SKLabelNode *scoreLabel;
@property (nonatomic, assign) NSInteger score;

@end

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    self.backgroundColor = [UIColor blackColor];
    
    for (SKNode *child in self.children) {
        if ([child.name isEqualToString:@"scoreLabel"]) {
            self.scoreLabel = (SKLabelNode *)child;
        }
    }
    self.score = 0;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(sendShip:) userInfo:nil repeats:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        // Check for a touch on a node
        SKNode *node = [self nodeAtPoint:location];
        
        if ([node.name isEqualToString:@"ship"]) {
            // We hit a ship!
            [self incrementScore];
            
            [node removeAllActions];
            
            SKEmitterNode *explosion = [[SKEmitterNode alloc] init];
            [explosion setParticleTexture:[SKTexture textureWithImageNamed:@"spark.png"]];
            [explosion setParticleColor:[UIColor brownColor]];
            [explosion setNumParticlesToEmit:300];
            [explosion setParticleBirthRate:450];
            [explosion setParticleLifetime:2];
            [explosion setEmissionAngleRange:360];
            [explosion setParticleSpeed:100];
            [explosion setParticleSpeedRange:50];
            [explosion setXAcceleration:0];
            [explosion setYAcceleration:0];
            [explosion setParticleAlpha:0.8];
            [explosion setParticleAlphaRange:0.2];
            [explosion setParticleAlphaSpeed:-0.5];
            [explosion setParticleScale:0.75];
            [explosion setParticleScaleRange:0.4];
            [explosion setParticleScaleSpeed:-0.5];
            [explosion setParticleRotation:0];
            [explosion setParticleRotationRange:0];
            [explosion setParticleRotationSpeed:0];
            
            [explosion setParticleColorBlendFactor:1];
            [explosion setParticleColorBlendFactorRange:0];
            [explosion setParticleColorBlendFactorSpeed:0];
            [explosion setParticleBlendMode:SKBlendModeAdd];

            explosion.position = CGPointMake(node.frame.size.width/2, node.frame.size.height/2);
            explosion.xScale = 4;
            explosion.yScale = 4;
            [node addChild:explosion];
            
            SKAction *fadeOut = [SKAction fadeOutWithDuration:1.3];
            [node runAction:fadeOut completion:^{
                [node removeFromParent];
            }];
        }
        
        // Show where the touch was
        SKShapeNode *touchLocation = [SKShapeNode shapeNodeWithCircleOfRadius:1];
        touchLocation.fillColor = [UIColor redColor];
        touchLocation.strokeColor = [UIColor redColor];
        
        SKAction *fadeOut = [SKAction fadeOutWithDuration:3];
        [touchLocation runAction:fadeOut completion:^{
            [touchLocation removeFromParent];
        }];
        
        touchLocation.position = location;
        [self addChild:touchLocation];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

- (void)sendShip:(NSTimer *)timer {
    SKSpriteNode *ship = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
    ship.xScale = 0.04;
    ship.yScale = 0.04;
    
    CGFloat xPos = arc4random_uniform(self.view.frame.size.width);
    ship.position = CGPointMake(xPos, -30);
    
    SKAction *move = [SKAction moveToY:self.frame.size.height+30 duration:6];
    [ship runAction:move completion:^{
        [ship removeFromParent];
    }];
    
    ship.name = @"ship";
    
    [self addChild:ship];
}

- (void)incrementScore {
    self.score ++;
    
    self.scoreLabel.text = @(self.score).stringValue;
}

@end
