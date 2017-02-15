//
//  HMSparkButton.h
//  HeroAnimation
//
//  Created by hongyu on 2017/2/4.
//  Copyright © 2017年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMSparkButton : UIButton

// 点赞
- (void)likeBounce:(NSTimeInterval)duration;
// 取消
- (void)unlikeBounce:(NSTimeInterval)duration;
// 粒子动画
- (void)animate;

@end
