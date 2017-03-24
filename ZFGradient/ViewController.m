//
//  ViewController.m
//  ZFGradientCircle
//
//  Created by zhaofei on 2017/3/23.
//  Copyright © 2017年 zbull. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+Extensions.h"

#import "ZFGradientLabel.h"
#import "ZFGradientCircle.h"

@interface ViewController ()

@property (nonatomic, strong, readwrite) ZFGradientCircle *grandientCircle;
@property (nonatomic, strong, readwrite) CAShapeLayer *shapeLayer;

// 渐变层
@property (nonatomic, strong, readwrite) CAGradientLayer *gradientLayer;

@property (nonatomic, strong, readwrite) ZFGradientLabel *gradientLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    
    // 渐变圆弧
    self.grandientCircle = [[ZFGradientCircle alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.grandientCircle.center = self.view.center;
    [self.view addSubview: self.grandientCircle];
    
    NSArray *colors = @[(id)[[UIColor colorWithHex:0xa3faff] CGColor],
                        (id)[[UIColor colorWithHex:0x009cff] CGColor],
                        (id)[[UIColor colorWithHex:0xffea00] CGColor],
                        (id)[[UIColor colorWithHex:0xff1e00] CGColor],
                        ];
    
    // 渐变label
    ZFGradientLabel *gradientLabel = [[ZFGradientLabel alloc] initWithFrame:CGRectMake(self.grandientCircle.frame.size.width * 0.5, self.grandientCircle.frame.size.height * 0.5, 100, 100)];
    
    gradientLabel.text = @"$0.00";
    gradientLabel.font = [UIFont fontWithName:@"Cochin" size:32];
    [gradientLabel sizeToFit];
    gradientLabel.center = self.grandientCircle.center;
    
    gradientLabel.gradientColors = colors;
    gradientLabel.gradientDirection = GradientDirectionOppositeAngle;
    
    self.gradientLabel = gradientLabel;
    [self.view addSubview: gradientLabel];
}

- (IBAction)startAnimation:(id)sender {
    [self.grandientCircle drawAnimation];
    [self.gradientLabel startCountingAnimationWithStartValue:0.78 endValue:102390.13 duration:3];
}

@end
