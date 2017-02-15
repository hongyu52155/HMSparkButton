//
//  HMSparkView.m
//  HeroAnimation
//
//  Created by hongyu on 2017/2/4.
//  Copyright © 2017年 Allen. All rights reserved.
//

#import "HMSparkView.h"

static const CGFloat particleScale      = 0.06f;
static const CGFloat particleScaleRange = 0.03f;
static const CGFloat animatenum         = 60;
static const CGFloat explodenum         = 500;

@interface HMSparkView ()

@property (strong, nonatomic) CAEmitterLayer *bigBandInLayer;
@property (strong, nonatomic) CAEmitterLayer *bigBandOutLayer;

@end

@implementation HMSparkView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self prepareView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self prepareView];
    }
    return self;
}

- (instancetype)init
{
    if (self = [super initWithFrame:CGRectZero]) {
        [self prepareView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    self.bigBandInLayer.emitterPosition  = center;
    self.bigBandOutLayer.emitterPosition = center;
}

- (void)prepareView
{
    self.clipsToBounds = NO;
    self.userInteractionEnabled = NO;
    UIImage *sparkIcon = [UIImage imageNamed:@"spark.png"];
    // 创建红色形状的粒子
    CAEmitterCell *explosionOutCell = [CAEmitterCell emitterCell];
    // 粒子的名字
    explosionOutCell.name          = @"explosion";
    // 粒子的颜色alpha能改变的范围
    explosionOutCell.alphaRange    = 0.4f;
    // 粒子透明度在生命周期内的改变速度
    explosionOutCell.alphaSpeed    = -1.f;
    explosionOutCell.lifetime      = 0.8f;
    explosionOutCell.lifetimeRange = 0.4f;
    explosionOutCell.birthRate     = 0.f;
    explosionOutCell.velocity      = 50.f;
    explosionOutCell.velocityRange = 8.f;
    explosionOutCell.contents      = (id)[sparkIcon CGImage];
    explosionOutCell.scale         = particleScale;
    explosionOutCell.scaleRange    = particleScaleRange;
    // 创建粒子发射器
    self.bigBandOutLayer           = [CAEmitterLayer layer];
    _bigBandOutLayer.name          = @"emitterLayer";
    _bigBandOutLayer.emitterShape  = kCAEmitterLayerCircle;
    _bigBandOutLayer.emitterMode   = kCAEmitterLayerOutline;
    _bigBandOutLayer.emitterSize   = CGSizeMake(30.0, 0.0);
    _bigBandOutLayer.emitterCells  = @[explosionOutCell];
    _bigBandOutLayer.renderMode    = kCAEmitterLayerOldestFirst;
    _bigBandOutLayer.masksToBounds = NO;
    [self.layer addSublayer:_bigBandOutLayer];
    
    CAEmitterCell *explosionInCell = [CAEmitterCell emitterCell];
    [explosionInCell setName:@"charge"];
    explosionInCell.alphaRange     = 0.4;
    explosionInCell.alphaSpeed     = -1;
    explosionInCell.lifetime       = 0.4;
    explosionInCell.lifetimeRange  = 0.2;
    explosionInCell.birthRate      = 0.0;
    explosionInCell.velocity       = -40.0;
    explosionInCell.velocityRange  = 0.0;
    explosionInCell.contents      = (id)[sparkIcon CGImage];
    explosionInCell.scale         = particleScale;
    explosionInCell.scaleRange    = particleScaleRange;
    
    self.bigBandInLayer            = [CAEmitterLayer layer];
    _bigBandInLayer.name          = @"emitterLayer";
    _bigBandInLayer.emitterShape  = kCAEmitterLayerCircle;
    _bigBandInLayer.emitterMode   = kCAEmitterLayerOutline;
    _bigBandInLayer.emitterSize   = CGSizeMake(30.0, 0.0);
    _bigBandInLayer.emitterCells  = @[explosionInCell];
    _bigBandInLayer.renderMode    = kCAEmitterLayerOldestFirst;
    _bigBandInLayer.masksToBounds = NO;
    [self.layer addSublayer:_bigBandInLayer];
}

- (void)animate
{
    [self.bigBandInLayer setValue:@(animatenum) forKeyPath:@"emitterCells.charge.birthRate"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self explode];
    });
}

- (void)explode
{
    [self.bigBandInLayer setValue:@(0) forKeyPath:@"emitterCells.charge.birthRate"];
    [self.bigBandOutLayer setValue:@(explodenum) forKeyPath:@"emitterCells.explosion.birthRate"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.bigBandOutLayer setValue:@(0) forKeyPath:@"emitterCells.explosion.birthRate"];
    });
}

@end
