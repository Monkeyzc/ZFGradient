//
//  ZFGradientLabel.m
//  ZFGradientCircle
//
//  Created by zhaofei on 2017/3/24.
//  Copyright © 2017年 zbull. All rights reserved.
//

#import "ZFGradientLabel.h"
#import "NSDecimalNumber+Help.h"

@interface ZFGradientLabel()
@property (nonatomic, assign, readwrite) double startValue;
@property (nonatomic, assign, readwrite) double endValue;

@property (nonatomic, strong, readwrite) CADisplayLink *timer;


@property (nonatomic, assign, readwrite) NSTimeInterval progressTimeInterval;
@property (nonatomic, assign, readwrite) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic, assign, readwrite) NSTimeInterval totalTimeInterval;

@end

@implementation ZFGradientLabel

- (void)drawRect:(CGRect)rect {
    CGSize textSize = [self.text sizeWithAttributes:@{NSFontAttributeName: self.font}];
    CGRect textRect = CGRectMake(0, 0, textSize.width, textSize.height);
    
    // 将文字画到conttext
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    [self.textColor set];
    [self.text drawWithRect:rect options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.font} context: NULL];
    
    // 翻转坐标, 上下颠倒
    CGContextTranslateCTM(contextRef, 0.0f, rect.size.height - (rect.size.height - textSize.height) * 0.5);
    CGContextScaleCTM(contextRef, 1.0f, -1.0f);
    
    CGImageRef alphaMask = NULL;
    alphaMask = CGBitmapContextCreateImage(contextRef);
    CGContextClearRect(contextRef, rect);
    

    CGFloat locations[] = {0.0, 0.5, 0.7, 1.0};
    
    CGContextClipToMask(contextRef, textRect, alphaMask);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // 设置渐变色数组 和 locations = NULL
    
    CGGradientRef gradientRef = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)self.gradientColors, locations);
    
    CGPoint startPoint;
    CGPoint endPoint;
    
    switch (self.gradientDirection) {
        case GradientDirectionHorizontal: {
            // (0, 0) -> (1, 0);
            startPoint = CGPointMake(textRect.origin.x, textRect.origin.y);
            endPoint = CGPointMake(textRect.origin.x + textRect.size.width, textRect.origin.y);
            break;
        }
        case GradientDirectionVertical: {
            // (0, 0) -> (0, 1);
            startPoint = CGPointMake(textRect.origin.x, textRect.origin.y);
            endPoint = CGPointMake(textRect.origin.x, textRect.origin.y + textRect.size.height);
            break;
        }
            
            // TODO: need fix
        case GradientDirectionOppositeAngle: {
            // (0, 0) -> (1, 1);
            startPoint = CGPointMake(textRect.origin.x, textRect.origin.y);
            endPoint = CGPointMake(textRect.origin.x + textRect.size.width, textRect.origin.y + textRect.size.height);
            break;
        }
        default:
        {
            // (0, 0) -> (1, 0);
            startPoint = CGPointMake(textRect.origin.x, textRect.origin.y);
            endPoint = CGPointMake(textRect.origin.x + textRect.size.width, textRect.origin.y);
            break;
        }

    }
    
    CGContextDrawLinearGradient(contextRef, gradientRef, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    
    
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradientRef);
    CFRelease(alphaMask);
}

- (void)startCountingAnimationWithStartValue: (double)startValue endValue: (double)endValue duration: (NSTimeInterval)duration {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    self.startValue = startValue;
    self.endValue = endValue;
    
    self.progressTimeInterval = 0;
    self.totalTimeInterval = duration;
    self.lastUpdateTimeInterval = [NSDate timeIntervalSinceReferenceDate];
    
    
    CADisplayLink *timer = [CADisplayLink displayLinkWithTarget: self selector:@selector(updateValue:)];
    [timer addToRunLoop:[NSRunLoop mainRunLoop] forMode: NSRunLoopCommonModes];
    self.timer = timer;
}

- (void)updateValue: (CADisplayLink *)timer {
    NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
    self.progressTimeInterval += now - self.lastUpdateTimeInterval;
    self.lastUpdateTimeInterval = now;
    
    if (self.progressTimeInterval >= self.totalTimeInterval) {
        [self.timer invalidate];
        self.timer = nil;
        self.progressTimeInterval = self.totalTimeInterval;
    }
    
    self.text = [NSDecimalNumber formatCurrencyWithNumber: [NSString stringWithFormat:@"%f", [self currentValue]] currencySymbol:@"$"];
    
    [self sizeToFit];
    self.center = self.superview.center;
}

- (double)currentValue {
    if (self.progressTimeInterval >= self.totalTimeInterval) {
        return self.endValue;
    }
    
    double percent = self.progressTimeInterval / self.totalTimeInterval;
    
//    double pow(double x, double y）;计算以x为底数的y次幂
    double updateValue = pow(percent, 3.0);
    
    return self.startValue + (updateValue * (self.endValue - self.startValue));
}

@end
