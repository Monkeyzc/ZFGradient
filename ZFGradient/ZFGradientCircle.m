//
//  ZFGradientCircle.m
//  ZFGradientCircle
//
//  Created by zhaofei on 2017/3/24.
//  Copyright © 2017年 zbull. All rights reserved.
//

#import "ZFGradientCircle.h"
#import "UIColor+Extensions.h"

@interface ZFGradientCircle()
@property (nonatomic, strong, readwrite) CAShapeLayer *shapeLayer;
// 渐变层
@property (nonatomic, strong, readwrite) CAGradientLayer *gradientLayer;
@end

@implementation ZFGradientCircle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame: frame]) {
        
        self.gradientLayer = [[CAGradientLayer alloc] init];
        self.gradientLayer.frame = self.bounds;
        [self.layer addSublayer: self.gradientLayer];
        
        NSArray *colors = @[(id)[[UIColor colorWithHex:0xa3faff] CGColor],
                            (id)[[UIColor colorWithHex:0x009cff] CGColor],
                            (id)[[UIColor colorWithHex:0xffea00] CGColor],
                            (id)[[UIColor colorWithHex:0xff1e00] CGColor],
                            ];
        
        self.gradientLayer.colors = colors;
        
        NSMutableArray *locations = [NSMutableArray array];
        for (float i = 0.0; i <= colors.count; i++) {
            [locations addObject:@(i / colors.count)];
        }
        //    NSLog(@"locations: %@", locations);
        self.gradientLayer.locations = locations;
        
        
        self.gradientLayer.startPoint = CGPointMake(0, 0);
        self.gradientLayer.endPoint = CGPointMake(1, 0);
        
        CGFloat lineWidth = 10;
        
        // 曲线
        
        /*
         * 该方法会创建出一个开放路径, 创建出来的圆弧是圆的一部分. 在默认的坐标系统中, 开始角度 和 结束角度 都是基于单位圆的(看下面这张图). 调用这个方法之后, currentPoint 将会设置为圆弧的结束点.
         * 举例来说: 指定其实角度为0, 指定结束角度为π, 设置 clockwise 属性为 YES, 将会绘制出圆的下半部分.
         * 然而当我们不修改起始角度 和 结束角度, 我们仅仅将 clockwise 角度设置为 NO, 则会绘制出来一个圆的上半部分.
         * @param center:   圆心
         * @param radius: 半径
         * @param startAngle:   起始角度
         * @param endAngle:   结束角度
         * @param clockwise:   是否顺时针绘制
         */
        UIBezierPath *bezierBath = [UIBezierPath bezierPathWithArcCenter: CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5) radius: (self.frame.size.width - lineWidth * 2) * 0.5 startAngle: M_PI_4 * 3 endAngle: M_PI_4 clockwise: YES];
        
        self.shapeLayer = [[CAShapeLayer alloc] init];
        self.shapeLayer.frame = self.bounds;
        self.shapeLayer.path = bezierBath.CGPath;
        
        self.shapeLayer.fillColor =  [[UIColor clearColor] CGColor];
        self.shapeLayer.strokeColor  = [[UIColor blueColor] CGColor];
        self.shapeLayer.lineCap = kCALineCapRound;
        self.shapeLayer.lineWidth = lineWidth;
        
        self.shapeLayer.strokeStart = 0;
        self.shapeLayer.strokeEnd = 1;
        
        [self.gradientLayer setMask: self.shapeLayer];
        
    }
    return self;
}

- (void)drawAnimation {
    double duration = 3;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration  = duration;
    animation.fromValue = @0;
    animation.toValue   = @1;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.shapeLayer addAnimation:animation forKey:@"circleAnimation"];
}

@end
