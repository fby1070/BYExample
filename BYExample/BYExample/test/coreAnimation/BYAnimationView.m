//
//  BYAnimationView.m
//  BYExample
//
//  Created by 付宝阳 on 2017/6/14.
//  Copyright © 2017年 付宝阳. All rights reserved.
//

#import "BYAnimationView.h"

@interface BYAnimationView()

@property (nonatomic, strong) CAShapeLayer *topLineLayer;
@property (nonatomic, strong) CAShapeLayer *bottomLineLayer;
@property (nonatomic, strong) CAShapeLayer *changedLayer;
@end


static const CGFloat kStep1Duration = 0.5;
static const CGFloat kStep2Duration = 0.5;
static const CGFloat kStep3Duration = 5.0;
static const CGFloat kStep4Duration = 5.0;
//big
static const CGFloat Raduis = 50.0f;
static const CGFloat lineWidth = 50.0f;
static const CGFloat lineGapHeight = 10.0f;
static const CGFloat lineHeight = 8.0f;

//static const CGFloat kStep1Duration = 0.5;
//static const CGFloat kStep2Duration = 0.5;
//static const CGFloat kStep3Duration = 5.0;
//static const CGFloat kStep4Duration = 5.0;

#define kTopY       Raduis - lineGapHeight
#define kCenterY    kTopY + lineGapHeight + lineHeight
#define kBottomY    kCenterY + lineGapHeight + lineHeight
#define Radians(x)  (M_PI * (x) / 180.0)


@implementation BYAnimationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (void)startAnimation {
    [self initLayers];
    [self animationStep1];
}

- (void)initLayers {
    _topLineLayer = [CAShapeLayer layer];
    _bottomLineLayer = [CAShapeLayer layer];
    _changedLayer = [CAShapeLayer layer];
    
    
    CALayer *topLayer = [CALayer layer];
    topLayer.frame = CGRectMake((self.bounds.size.width + lineWidth)/2, kTopY, lineWidth, lineHeight);
    [self.layer addSublayer:topLayer];
    
    CALayer *bottomLayer = [CALayer layer];
    bottomLayer.frame = CGRectMake((self.bounds.size.width + lineWidth)/2, kBottomY, lineWidth, lineHeight);
    [self.layer addSublayer:bottomLayer];
    
    [_topLineLayer setStrokeColor:[[UIColor whiteColor] CGColor]];
    _topLineLayer.contentsScale = [UIScreen mainScreen].scale;
    _topLineLayer.lineWidth = lineHeight ;
    _topLineLayer.lineCap = kCALineCapRound;
    _topLineLayer.position = CGPointMake(0,0);
    
    [_bottomLineLayer setStrokeColor:[[UIColor whiteColor] CGColor]];
    _bottomLineLayer.contentsScale = [UIScreen mainScreen].scale;
    _bottomLineLayer.lineWidth = lineHeight;
    _bottomLineLayer.lineCap = kCALineCapRound;

    
    [_changedLayer setStrokeColor:[[UIColor whiteColor] CGColor]];
    _changedLayer.contentsScale = [UIScreen mainScreen].scale;
    _changedLayer.lineWidth = lineHeight;
    _changedLayer.lineCap = kCALineCapRound;
//    _changedLayer.position = CGPointMake(0, 0);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(-lineWidth, 0)];
    _topLineLayer.path = path.CGPath;
    
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(-lineWidth, 0)];
    _bottomLineLayer.path = path.CGPath;
    
    CGFloat startOriginX = self.center.x - lineWidth /2.0;
    CGFloat endOriginX = self.center.x + lineWidth /2.0;

    
    CGMutablePathRef solidChangedLinePath =  CGPathCreateMutable();
    //被改变的layer实线
    CGPathMoveToPoint(solidChangedLinePath, NULL, startOriginX, kCenterY);
    CGPathAddLineToPoint(solidChangedLinePath, NULL, endOriginX, kCenterY);
    [_changedLayer setPath:solidChangedLinePath];
    CGPathRelease(solidChangedLinePath);
    
    [topLayer addSublayer:_topLineLayer];
    [bottomLayer addSublayer:_bottomLineLayer];
    [self.layer addSublayer:_changedLayer];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
    if ([[anim valueForKey:@"animationName"] isEqualToString:@"animationStep1"]) {
        NSLog(@"动画1结束");
        [self animationStep2];
    }
    
    if ([[anim valueForKey:@"animationName"] isEqualToString:@"animationStep2"]) {
        NSLog(@"动画2结束");
    }
}


- (void)animationStep1{
    
    _changedLayer.strokeEnd = 0.4;
    CABasicAnimation *strokeAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    strokeAnimation.toValue = [NSNumber numberWithFloat:0.4f];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    pathAnimation.toValue = [NSNumber numberWithFloat:-10];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = [NSArray arrayWithObjects:strokeAnimation, pathAnimation, nil ];
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animationGroup.duration = kStep1Duration;
    animationGroup.delegate = self;
    animationGroup.removedOnCompletion = YES;
    [animationGroup setValue:@"animationStep1" forKey:@"animationName"];
    [_changedLayer addAnimation:animationGroup forKey:nil];
}

- (void)animationStep2 {
    CABasicAnimation *translationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translate.x"];
    translationAnimation.fromValue = @(-10);
    translationAnimation.toValue = @(0.2 * lineWidth);
    
    _changedLayer.strokeEnd = 0.8;
    CABasicAnimation *strockAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strockAnimation.fromValue = @0.4f;
    strockAnimation.toValue = @0.8f;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[translationAnimation, strockAnimation];
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animationGroup.duration = kStep2Duration;
    animationGroup.delegate = self;
    animationGroup.removedOnCompletion = YES;
    [animationGroup setValue:@"animationStep2" forKey:@"animationName"];
    [_changedLayer addAnimation:animationGroup forKey:nil];
    
}

- (void)animationStep3 {
    _changedLayer = [CAShapeLayer layer];
    _changedLayer.fillColor = [[UIColor clearColor] CGColor];
    _changedLayer.strokeColor = [[UIColor whiteColor] CGColor];
    _changedLayer.contentsScale = [UIScreen mainScreen].scale;
    _changedLayer.lineWidth = lineWidth;
    _changedLayer.lineCap = kCALineCapRound;
    [self.layer addSublayer:_changedLayer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 画贝塞尔曲线 圆弧
    [path moveToPoint:CGPointMake(self.center.x +  lineWidth/2.0 , kCenterY)];
    
    //30度,经过反复测试，效果最好
    CGFloat angle = Radians(30);
    CGFloat endPointX = self.center.x + Raduis * cos(angle);
    CGFloat endPointY = kCenterY - Raduis * sin(angle);
    
    CGFloat startPointX = self.center.x + lineWidth/2.0;
    CGFloat startPointY = kCenterY;
    
    CGFloat controlPointX = self.center.x + Raduis *acos(angle);
    CGFloat controlPointY = kCenterY;
    
    //三点曲线
    [path addCurveToPoint:CGPointMake(endPointX, endPointY)
            controlPoint1:CGPointMake(startPointX, startPointY)
            controlPoint2:CGPointMake(controlPointX, controlPointY)];
    
    
    //组合path 路径
    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.center.x, kCenterY)
                                                         radius:Raduis
                                                     startAngle:2 * M_PI - angle
                                                       endAngle:M_PI - angle
                                                      clockwise:NO];
    
    UIBezierPath *path2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.center.x, kCenterY)
                                                         radius:Raduis
                                                     startAngle:M_PI *3/2 - (M_PI_2 -angle)
                                                       endAngle:-M_PI_2 - (M_PI_2 -angle)
                                                      clockwise:NO];
    [path appendPath:path2];
    _changedLayer.path = path.CGPath;
    
    
    //平移量
    CGFloat toValue = lineWidth *(1- cos(M_PI_4)) /2.0;
    //finished 最终状态
    CGAffineTransform transform1 = CGAffineTransformMakeRotation(-M_PI_4);
    CGAffineTransform transform2 = CGAffineTransformMakeTranslation(-toValue, 0);
    CGAffineTransform transform3 = CGAffineTransformMakeRotation(M_PI_4);
    
}
@end










