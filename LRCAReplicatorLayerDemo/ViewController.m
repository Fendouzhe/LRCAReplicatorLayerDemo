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
    [self followAnimation];
    
}

- (void)musicAnimation{
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.bounds = CGRectMake(0, 0, 200, 100);
    replicatorLayer.position = CGPointMake(self.view.center.x, 100);
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

- (void)activityIndicatorAnimation{
    
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    replicator.backgroundColor = [UIColor grayColor].CGColor;
    [self.view.layer addSublayer:replicator];
    replicator.bounds = CGRectMake(0, 0, 200, 200);
    replicator.position = CGPointMake(self.view.center.x, self.view.center.y-80);
    
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



- (void)followAnimation
{
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer new];
    replicatorLayer.bounds = CGRectMake(0, 0, 280, 280);//self.view.bounds;
    replicatorLayer.backgroundColor = [UIColor colorWithWhite:0 alpha:0.75].CGColor;
    replicatorLayer.position = CGPointMake(self.view.center.x, self.view.center.y+200);
    [self.view.layer addSublayer:replicatorLayer];
    
    CALayer *subLayer = [CALayer new];
    subLayer.bounds = CGRectMake(0, 0, 10, 10);
    subLayer.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0].CGColor;//粉红色
    subLayer.borderColor = [UIColor colorWithWhite:1.0 alpha:1.0].CGColor;
    subLayer.borderWidth = 1.0;
    subLayer.cornerRadius = 5.0;
    subLayer.shouldRasterize = YES;
    subLayer.rasterizationScale = [UIScreen mainScreen].scale;
    [replicatorLayer addSublayer:subLayer];
    
    ///帧动画默认每两点距离动画执行时间一样，距离不同所以速度不同，可以在NSArray<NSNumber *> *keyTimes设置每段距离执行时间
    ///NSArray<CAMediaTimingFunction *> *timingFunctions设置节奏
    CAKeyframeAnimation *move = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    move.path = [self path];
    move.repeatCount = INFINITY;
    move.duration = 4.0;
    //move.autoreverses = YES;
    //move.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [subLayer addAnimation:move forKey:nil];
    
    replicatorLayer.instanceDelay = 0.1;
    replicatorLayer.instanceCount = 20;
    replicatorLayer.instanceColor = [UIColor colorWithRed:0 green:1.0 blue:0 alpha:1.0].CGColor;
    replicatorLayer.instanceGreenOffset = -0.03;// 设置颜色通道的偏移量
}

- (CGPathRef)path
{
    UIBezierPath *bezierPath = [UIBezierPath new];
    [bezierPath moveToPoint:(CGPointMake(31.5, 78.5))];
    [bezierPath addLineToPoint:(CGPointMake(31.5, 23.5))];
    [bezierPath addCurveToPoint:CGPointMake(58.5, 38.5) controlPoint1:CGPointMake(31.5, 23.5) controlPoint2:CGPointMake(62.46, 18.69)];
    [bezierPath addCurveToPoint:CGPointMake(53.5, 45.5) controlPoint1:CGPointMake(57.5, 43.5) controlPoint2:CGPointMake(53.5, 45.5)];
    [bezierPath addLineToPoint:(CGPointMake(43.5, 48.5))];
    [bezierPath addLineToPoint:(CGPointMake(53.5, 66.5))];
    [bezierPath addLineToPoint:(CGPointMake(62.5, 51.5))];
    [bezierPath addLineToPoint:(CGPointMake(70.5, 66.5))];
    [bezierPath addLineToPoint:(CGPointMake(86.5, 23.5))];
    [bezierPath addLineToPoint:(CGPointMake(86.5, 78.5))];
    [bezierPath addLineToPoint:(CGPointMake(31.5, 78.5))];
    [bezierPath addLineToPoint:(CGPointMake(31.5, 71.5))];
    [bezierPath closePath];
    //将路径视图放大3倍
    CGAffineTransform T = CGAffineTransformMakeScale(3.0, 3.0);
    return CGPathCreateCopyByTransformingPath(bezierPath.CGPath, &T);
}





@end
