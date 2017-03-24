//
//  ZFGradientLabel.h
//  ZFGradientCircle
//
//  Created by zhaofei on 2017/3/24.
//  Copyright © 2017年 zbull. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GradientDirection) {
    GradientDirectionHorizontal, // 水平
    GradientDirectionVertical,   // 垂直
    GradientDirectionOppositeAngle, // 对角线
};

@interface ZFGradientLabel : UILabel

/**
 渐变色 反向
 */
@property (nonatomic, assign, readwrite) GradientDirection gradientDirection;
@property (nonatomic, strong, readwrite) NSArray *gradientColors;

- (void)startCountingAnimationWithStartValue: (double)startValue endValue: (double)endValue duration: (NSTimeInterval)duration;

@end
