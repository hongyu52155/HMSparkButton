//
//  HMSparkButton.m
//  HeroAnimation
//
//  Created by hongyu on 2017/2/4.
//  Copyright © 2017年 Allen. All rights reserved.
//

#import "HMSparkButton.h"
#import "HMSparkView.h"

static const CGFloat relativeDurationTime = 0.2;

@interface HMSparkButton ()
@property (strong, nonatomic) HMSparkView *sparkView;
@end

@implementation HMSparkButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self prepareButton];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self prepareButton];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.sparkView.frame = self.bounds;
    [self insertSubview:self.sparkView atIndex:0];
}

- (void)prepareButton
{
    self.clipsToBounds = NO; // 默认是no不裁剪
    self.sparkView     = [HMSparkView new];
    [self insertSubview:self.sparkView atIndex:0];
}

- (void)animate
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.sparkView animate];
    });
}

// likeBouncing animation
- (void)likeBounce:(NSTimeInterval)duration
{
    self.transform = CGAffineTransformIdentity; // 取消一切形变
    [UIView animateKeyframesWithDuration:duration delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:relativeDurationTime animations:^{
            self.transform = CGAffineTransformMakeScale(1.6, 1.6);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:relativeDurationTime animations:^{
            self.transform = CGAffineTransformMakeScale(0.6, 0.6);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.4 relativeDuration:relativeDurationTime animations:^{
            self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.6 relativeDuration:relativeDurationTime animations:^{
            self.transform = CGAffineTransformMakeScale(0.8, 0.8);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:relativeDurationTime animations:^{
            self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
        
    } completion:^(BOOL finished) {
        
    }];
}

// likedBouncing animation
- (void)unlikeBounce:(NSTimeInterval)duration
{
    self.transform = CGAffineTransformIdentity;
    [UIView animateKeyframesWithDuration:duration delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:relativeDurationTime animations:^{
            self.transform = CGAffineTransformMakeScale(0.6, 0.6);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.6 relativeDuration:relativeDurationTime animations:^{
            self.transform = CGAffineTransformMakeScale(0.8, 0.8);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:relativeDurationTime animations:^{
            self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
        
    } completion:^(BOOL finished) {
        
    }];
}



@end
