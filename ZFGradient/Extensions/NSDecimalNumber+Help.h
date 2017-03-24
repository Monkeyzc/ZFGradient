//
//  NSDecimalNumber+Help.h
//  Decimal
//
//  Created by zhaofei on 2017/2/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDecimalNumber (Help)

+ (NSString *)formatCurrencyWithNumber:(NSString *)number currencySymbol: (NSString *)currencySymbol;

+ (NSDecimalNumber *)addLeftOperand: (NSString *)leftOperand withRightOperand: (NSString *)rightOperand;

+ (NSDecimalNumber *)subtractLeftOperand: (NSString *)leftOperand withRightOperand: (NSString *)rightOperand;

+ (NSDecimalNumber *)mutiplyLeftOperand: (NSString *)leftOperand withRightOperand: (NSString *)rightOperand roundingMoude: (NSRoundingMode)roundingMode;

+ (NSDecimalNumber *)divideLeftOperand: (NSString *)leftOperand withRightOperand: (NSString *)rightOperand roundingMoude: (NSRoundingMode)roundingMode;

+ (NSDecimalNumber *)calculateFromAmountWithToAmount: (NSString *)toAmount exchangeRate: (NSString *)exchangeRate;
+ (NSDecimalNumber *)calculateToAmountWithFromAmount: (NSString *)fromAmount exchangeRate: (NSString *)exchangeRate;

@end
