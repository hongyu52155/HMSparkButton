//
//  ViewController.m
//  HMSparkButton
//
//  Created by hongyu on 2017/2/15.
//  Copyright © 2017年 Allen. All rights reserved.
//

#import "ViewController.h"
#import "HMSparkButton.h"

static const CGFloat likeBounceTime   = 0.6f;
static const CGFloat unlikeBounceTime = 0.4f;

@interface ViewController ()

@property (nonatomic, strong) HMSparkButton *sparkButton;
@property (assign, nonatomic) BOOL          isLiked;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isLiked        = YES;
    self.sparkButton    = [HMSparkButton buttonWithType:UIButtonTypeCustom];
    [_sparkButton setImage:[UIImage imageNamed:@"like-default"] forState:UIControlStateNormal];
    _sparkButton.frame  = CGRectMake(0, 0, 50, 50);
    _sparkButton.center = self.view.center;
    [_sparkButton addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sparkButton];
}

- (void)likeAction:(UIButton *)button {
    if (_isLiked) {
        [_sparkButton setImage:[UIImage imageNamed:@"liked"] forState:UIControlStateNormal];
        [_sparkButton likeBounce:likeBounceTime];
        [_sparkButton animate];
    } else {
        [_sparkButton setImage:[UIImage imageNamed:@"like-default"] forState:UIControlStateNormal];
        [_sparkButton likeBounce:unlikeBounceTime];
    }
    _isLiked = !_isLiked;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
