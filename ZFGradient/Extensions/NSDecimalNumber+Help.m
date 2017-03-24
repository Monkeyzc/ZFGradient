//
//  NSDecimalNumber+Help.m
//  Decimal
//
//  Created by zhaofei on 2017/2/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NSDecimalNumber+Help.h"

@implementation NSDecimalNumber (Help)

+ (NSDecimal)getDecimal: (NSString *)operand {
    
    NSDecimal decimal = [[NSDecimalNumber decimalNumberWithString: operand.length ? operand : @"0"] decimalValue];

//    NSDecimal result;
//    NSDecimal baseDecimal = [[NSDecimalNumber decimalNumberWithString:@"100"] decimalValue];
//    NSDecimalMultiply(&result, &decimal, &baseDecimal, NSRoundPlain);
    return decimal;
}

+ (NSDecimalNumber *)addLeftOperand: (NSString *)leftOperand withRightOperand: (NSString *)rightOperand {
    NSDecimal leftDecimal = [self getDecimal: leftOperand];
    NSDecimal rightDecimal = [self getDecimal: rightOperand];
    
    NSDecimal result;
    NSDecimalAdd(&result, &leftDecimal, &rightDecimal, NSRoundPlain);
    
    return [NSDecimalNumber decimalNumberWithDecimal: result];
}

+ (NSDecimalNumber *)subtractLeftOperand: (NSString *)leftOperand withRightOperand: (NSString *)rightOperand {
    
    NSDecimal leftDecimal = [self getDecimal: leftOperand];
    NSDecimal rightDecimal = [self getDecimal: rightOperand];
    
    NSDecimal result;
    NSDecimalSubtract(&result, &leftDecimal, &rightDecimal, NSRoundPlain);
    
    return [NSDecimalNumber decimalNumberWithDecimal: result];
}

+ (NSDecimalNumber *)mutiplyLeftOperand: (NSString *)leftOperand withRightOperand: (NSString *)rightOperand roundingMoude: (NSRoundingMode)roundingMode {
    
    NSDecimal leftDecimal = [self getDecimal: leftOperand];
    NSDecimal rightDecimal = [self getDecimal: rightOperand];
    
    NSDecimal result;
    NSDecimalMultiply(&result, &leftDecimal, &rightDecimal, roundingMode);
    
    return [NSDecimalNumber decimalNumberWithDecimal: result];
}

+ (NSDecimalNumber *)divideLeftOperand: (NSString *)leftOperand withRightOperand: (NSString *)rightOperand roundingMoude: (NSRoundingMode)roundingMode {
    
    NSDecimal leftDecimal = [self getDecimal: leftOperand];
    NSDecimal rightDecimal = [self getDecimal: rightOperand];
    
    NSDecimal result;
    NSDecimalDivide(&result, &leftDecimal, &rightDecimal, roundingMode);
    
    return [NSDecimalNumber decimalNumberWithDecimal: result];
}

// 兑换, fromAmount 只入不舍,  toAmount 只舍不入, exchangeRate = @"1.23899"
+ (NSDecimalNumber *)calculateToAmountWithFromAmount: (NSString *)fromAmount exchangeRate: (NSString *)exchangeRate {
    
    // toAmount = fromAmount * exchangeRate;
    
    // 只舍不入
    NSDecimal divideResult = [[NSDecimalNumber mutiplyLeftOperand: fromAmount withRightOperand: exchangeRate roundingMoude: NSRoundDown] decimalValue];
    
    // 保留两位小数, 进行只舍不入
    NSDecimal result;
    NSDecimalRound(&result, &divideResult, 2, NSRoundDown);
    
    return [NSDecimalNumber decimalNumberWithDecimal: result];
}

+ (NSDecimalNumber *)calculateFromAmountWithToAmount: (NSString *)toAmount exchangeRate: (NSString *)exchangeRate {
    
    // fromAmount = toAmount / exchangeRate;
    
    // 只入不舍
    NSDecimal divideResult = [[NSDecimalNumber divideLeftOperand:toAmount withRightOperand:exchangeRate roundingMoude:NSRoundUp] decimalValue];
    
//    NSDecimal rightOperand = [[NSDecimalNumber decimalNumberWithString:@"10000"] decimalValue];
//    NSDecimalDivide(&divideResult, &divideResult, &rightOperand, NSRoundUp);
    
    // 保留两位小数, 进行只入不舍
    NSDecimal result;
    NSDecimalRound(&result, &divideResult, 2, NSRoundUp);
    
    return [NSDecimalNumber decimalNumberWithDecimal: result];
}

+ (NSString *)formatCurrencyWithNumber:(NSString *)number currencySymbol: (NSString *)currencySymbol {
    NSDecimalNumber *decimalNumber = [[NSDecimalNumber alloc] initWithString: number];
    NSDecimal decimal = decimalNumber.decimalValue;
    
    NSDecimal result;
    NSDecimalRound(&result, &decimal, 2, NSRoundPlain);
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = kCFNumberFormatterCurrencyStyle;
    numberFormatter.currencySymbol = currencySymbol;
    NSString *formatedString = [numberFormatter stringFromNumber:[NSDecimalNumber decimalNumberWithDecimal: result]];
    return formatedString;
}

@end
