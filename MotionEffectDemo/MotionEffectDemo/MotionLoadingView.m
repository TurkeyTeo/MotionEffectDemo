//
//  MotionLoadingView.m
//  MotionEffectDemo
//
//  Created by Teo on 2017/5/22.
//

#import "MotionLoadingView.h"


@interface MotionLoadingView ()


@end

@implementation MotionLoadingView



+ (instancetype)showMotionLoadingViewTo:(UIView *)view{
    MotionLoadingView *hud = [[MotionLoadingView alloc] initWithView:view];
    [view addSubview:hud];
    return hud;
}


+ (void)hidenForView:(UIView *)view{
    MotionLoadingView *hud = [self HUDForView:view];
    if (hud != nil) {
       
        // Perform animations
        dispatch_block_t animations = ^{
            hud.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
        };
        
        [UIView animateWithDuration:.8 delay:0. usingSpringWithDamping:.2f initialSpringVelocity:10 options:UIViewAnimationOptionBeginFromCurrentState animations:animations completion:^(BOOL finished) {
            
            [hud removeFromSuperview];
        }];
    }
}


+ (MotionLoadingView *)HUDForView:(UIView *)view {
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            return (MotionLoadingView *)subview;
        }
    }
    return nil;
}


- (id)initWithView:(UIView *)view {
    NSAssert(view, @"View must not be nil.");
    return [self initWithFrame:view.bounds];
}


- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    [self addInterpolatingMotionEffect];
    [self addReplicatorLayer];
    
}


/*! This motion effect maps movement of a particular type (e.g. left/right tilt) to an
 interpolated output between two relative values provided by the client. Uses Core
 Animation's implementation of interpolation for all the standard types.
 */
- (void)addInterpolatingMotionEffect{
    CGFloat effectOffset = 40.f;
    UIInterpolatingMotionEffect *effectX = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    effectX.maximumRelativeValue = @(effectOffset);
    effectX.minimumRelativeValue = @(-effectOffset);
    
    UIInterpolatingMotionEffect *effectY = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    effectY.maximumRelativeValue = @(effectOffset);
    effectY.minimumRelativeValue = @(-effectOffset);
    
    UIMotionEffectGroup *group = [[UIMotionEffectGroup alloc] init];
    group.motionEffects = @[effectX, effectY];
    
    [self addMotionEffect:group];
}


/* The replicator layer creates a specified number of copies of its
 * sublayers, each copy potentially having geometric, temporal and
 * color transformations applied to it.
 */
- (void)addReplicatorLayer{
    CAReplicatorLayer *replicatorL = [CAReplicatorLayer layer];
    replicatorL.bounds = CGRectMake(0, 0, 120, 120);
    replicatorL.backgroundColor = [UIColor colorWithRed:0.5 green:0.6 blue:0.7 alpha:0.5].CGColor;
    replicatorL.cornerRadius = 10.0;
    replicatorL.position = self.center;
    [self.layer addSublayer:replicatorL];
    
    CALayer *dotLayer        = [CALayer layer];
    dotLayer.bounds          = CGRectMake(0, 0, 30, 30);
    dotLayer.position        = CGPointMake(15, replicatorL.frame.size.height/2);
    dotLayer.backgroundColor = [UIColor colorWithRed:0.9 green:0.4 blue:0.2 alpha:0.6].CGColor;
    dotLayer.cornerRadius    = 15;
    
    [replicatorL addSublayer:dotLayer];
    
    replicatorL.instanceCount = 3;
    replicatorL.instanceTransform = CATransform3DMakeTranslation(replicatorL.frame.size.width/3, 0, 0);
    
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration    = 1;
    animation.fromValue   = @1;
    animation.toValue     = @0;
    animation.repeatCount = MAXFLOAT;
    [dotLayer addAnimation:animation forKey:nil];
    
    replicatorL.instanceDelay = 1./3;
}


@end
