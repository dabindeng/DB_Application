//
//  SharePublicMethod.h
//  ep_iphone_witkey
//
//  Created by epwk on 15/7/29.
//  Copyright (c) 2015年 EP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharePublicMethod : NSObject

// 1988-01-01 或 19880101  计算年龄
+ (NSInteger)getAgeWithTimeStr:(NSString *)timeStr;

//获取文件大小
+ (long long)fileSizeAtPath:(NSString*)filePath;


@end
