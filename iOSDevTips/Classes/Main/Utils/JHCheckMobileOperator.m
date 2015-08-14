//
//  JHCheckMobileOperator.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/14.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHCheckMobileOperator.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>


// 中国NetworkCode
#define NetworkCode 460

@implementation JHCheckMobileOperator

+ (NSString *)checkMobileOperator {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = info.subscriberCellularProvider;
    NSString *carrierName = carrier.carrierName;// 运营商名称
    NSString *mobileCountryCode = carrier.mobileCountryCode;// 运营商国家编号
    NSString *mobileNetworkCode = carrier.mobileNetworkCode;// 运营商编号
    if (!mobileNetworkCode) {
        return @"查询不到运营商";
    }
    if ([mobileCountryCode intValue] == NetworkCode) { // 中国
        if ([carrierName rangeOfString:@"联通"].length>0 || [mobileNetworkCode isEqualToString:@"01"] || [mobileNetworkCode isEqualToString:@"06"]) {
            return @"中国联通";
        } else if ([carrierName rangeOfString:@"移动"].length>0 || [mobileNetworkCode isEqualToString:@"00"] || [mobileNetworkCode isEqualToString:@"02"] || [mobileNetworkCode isEqualToString:@"07"]){
            return @"中国移动";
        } else if ([carrierName rangeOfString:@"电信"].length>0 || [mobileNetworkCode isEqualToString:@"03"] || [mobileNetworkCode isEqualToString:@"05"]){
            return @"中国电信";
        } else if ([carrierName rangeOfString:@"铁通"].length>0 || [mobileNetworkCode isEqualToString:@"20"]){
            return @"中国铁通";
        }
    }
    return [self statusBarCheckMobileOperator];
}

/**
 *  对于美版或者日版卡贴iPhone，检测到的CTCarrier并非sim卡信息，此时就需要通过StatusBar实时检测当前网络运行商
 *
 */
+ (NSString *)statusBarCheckMobileOperator {
    NSArray *subviews = [[[[UIApplication sharedApplication] valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
    UIView *serviceView = nil;
    Class serviceClass = NSClassFromString([NSString stringWithFormat:@"UIStat%@Serv%@%@", @"usBar", @"ice", @"ItemView"]);
    for (UIView *subview in subviews) {
        if([subview isKindOfClass:[serviceClass class]]) {
            serviceView = subview;
            break;
        }
    }
    if (serviceView) {
        NSString *carrierName = [serviceView valueForKey:[@"service" stringByAppendingString:@"String"]];
        if ([carrierName rangeOfString:@"联通"].length>0) {
            return @"中国联通";
        } else if ([carrierName rangeOfString:@"移动"].length>0){
            return @"中国移动";
        } else if ([carrierName rangeOfString:@"电信"].length>0){
            return @"中国电信";
        } else if ([carrierName rangeOfString:@"铁通"].length>0){
            return @"中国铁通";
        }
        return @"查询不到运营商";
    } else {
        return @"查询不到运营商";
    }
}

@end
