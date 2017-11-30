//
//  ViewController.m
//  AnnimationDemo
//
//  Created by Chan on 2017/5/5.
//  Copyright © 2017年 Chan. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageView.clipsToBounds = YES;
    _imageView.layer.cornerRadius = _imageView.frame.size.height / 2;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    UIBezierPath *path = [UIBezierPath new];
    //红色填充
    UIColor *redColor = [UIColor redColor];
    [redColor  set];
    [path fill];
    
    UIColor *orangeColor = [UIColor orangeColor];
    [orangeColor set];
    [path stroke];
    
    //移动到初始化点
    [path  moveToPoint:_imageView.center];
    //添加一个圆弧
    [path addArcWithCenter:_imageView.center
                    radius:100
                startAngle:0
                  endAngle:M_PI * 2
                 clockwise:YES];
    [path fill];
    //三级曲线 终点、拐点1、拐点2
    [path  addCurveToPoint:CGPointMake([UIScreen  mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) controlPoint1:CGPointMake(0, 0) controlPoint2:CGPointMake(400, 400)];
    [path stroke];
    //CAKeyfrmaAnimation关键帧动画
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
#warning 更简便的方法就是通过path 代替values
    /*CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(100, 100, [UIScreen mainScreen].bounds.size.width - 200, [UIScreen mainScreen].bounds.size.height - 200));*/
    keyframeAnimation.path = path.CGPath;
    keyframeAnimation.duration = 5.0;
    keyframeAnimation.speed = 2.0;
//    keyframeAnimation.repeatCount = FLT_MAX;
    keyframeAnimation.removedOnCompletion =YES;
    keyframeAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_imageView.layer addAnimation:keyframeAnimation forKey:@"keyframeAnimation"];
}

@end
