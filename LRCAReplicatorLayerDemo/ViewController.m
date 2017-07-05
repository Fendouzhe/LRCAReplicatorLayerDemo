//
//  ViewController.m
//  LRCAReplicatorLayerDemo
//
//  Created by 宇中 on 2017/7/5.
//  Copyright © 2017年 广州宇中网络科技有限公司. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self musicAnimation];
    [self activityIndicatorAnimation];
}

- (void)activityIndicatorAnimation{
    
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    replicator.backgroundColor = [UIColor grayColor].CGColor;
    [self.view.layer addSublayer:replicator];
    replicator.bounds = CGRectMake(0, 0, 200, 200);
    replicator.position = self.view.center;
    
    CALayer *subLayer = [CALayer layer];
    [replicator addSublayer:subLayer];
    subLayer.bounds = CGRectMake(0, 0, 14, 14);
    subLayer.position = CGPointMake(replicator.bounds.size.width*0.5, 30);
    subLayer.backgroundColor = [UIColor redColor].CGColor;
    subLayer.cornerRadius = 8;
    
    CFTimeInterval duration = 1.5;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = @(1.0);
    animation.toValue = @(0.1);
    animation.duration = duration;
    animation.repeatCount = INFINITY;
    //animation.autoreverses = YES;
    [subLayer addAnimation:animation forKey:@"transform.scale"];
    
    replicator.instanceCount = 15;
    replicator.instanceDelay = duration/replicator.instanceCount;
    CGFloat angle = M_PI*2/replicator.instanceCount;
    replicator.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1.0);
    
}

- (void)musicAnimation{

    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.bounds = CGRectMake(0, 0, 200, 100);
    replicatorLayer.position = CGPointMake(self.view.center.x, 150);
    replicatorLayer.backgroundColor = [UIColor grayColor].CGColor;
    [self.view.layer addSublayer:replicatorLayer];
    
    CALayer *subLayer = [CALayer layer];
    [replicatorLayer addSublayer:subLayer];
    subLayer.backgroundColor = [UIColor redColor].CGColor;
    subLayer.bounds = CGRectMake(0, 0, 8, 40);
    subLayer.position = CGPointMake(10, 115);
    subLayer.cornerRadius = 2;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation.fromValue = @(subLayer.position.y);
    animation.toValue = @(subLayer.position.y-30);
    animation.repeatCount = INFINITY;
    animation.duration = 0.5;
    animation.autoreverses = YES;
    [subLayer addAnimation:animation forKey:nil];
    
    replicatorLayer.instanceCount = 10;
    replicatorLayer.instanceDelay = 0.33;
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(20, 0, 0);
    replicatorLayer.masksToBounds = YES;//超出部分不显示
}


@end
