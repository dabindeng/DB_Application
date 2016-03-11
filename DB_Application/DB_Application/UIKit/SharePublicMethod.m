//
//  SharePublicMethod.m
//  ep_iphone_witkey
//
//  Created by epwk on 15/7/29.
//  Copyright (c) 2015年 EP. All rights reserved.
//

#import "SharePublicMethod.h"
#import "sys/utsname.h"


#include <sys/socket.h> //MAC
#include <sys/sysctl.h>
#include <sys/stat.h>
#include <net/if.h>
#include <net/if_dl.h>

#define NSMaxiumRange         ((NSRange){.location=                   0UL, .length=    NSUIntegerMax})

struct utsname systemInfo;

@implementation SharePublicMethod




// 1988-01-01 或 19880101  计算年龄
+ (NSInteger)getAgeWithTimeStr:(NSString *)timeStr
{
    NSString *formatStr = @"YYYY-MM-dd";
    if ([timeStr rangeOfString:@"-"].length == 0)
        formatStr = @"YYYYMMdd";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:formatStr];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSDate* date = [formatter dateFromString:timeStr];
    NSInteger sec = [date timeIntervalSinceNow];
    int age = trunc(sec/(60*60*24))/365 * -1;
    
    return age;
}

//获取文件大小
+ (long long)fileSizeAtPath:(NSString*)filePath
{
    struct stat st;
    if(lstat([filePath cStringUsingEncoding:NSUTF8StringEncoding], &st) == 0){
        return st.st_size;
    }
    
    return 0;
}





@end
