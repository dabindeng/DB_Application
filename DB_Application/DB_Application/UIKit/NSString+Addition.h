//
//  NSString+Addition.h
//  BossmailQ
//
//  Created by Mac on 15/7/29.
//  Copyright (c) 2015年 zengxusheng. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (Addition)

//随机字符串
+ (NSString *)randomString;

/*
 *  生成id,避免重复情况
 */
+ (unsigned long)createTransId;

//获取build
+ (NSString *)getVersionBuild;

+ (NSString *)getShortVersionBuild;

//判断是否时整形
- (BOOL)isPureInt;

//判断是否为浮点形
- (BOOL)isPureFloat;

//是否是纯数字
+ (BOOL)isNumText:(NSString *)str;

//分割 非标准字符
- (NSArray *)splitWithCharacters:(NSString*)str;

//分割字符串
- (NSArray *)splitWithString:(NSString*)y;

//分割邮箱地址
- (NSArray *)seperateEmailAddress;

//替换回车、换行、制表符 为空格
- (NSString *)stringByDeletingNewLines;

//压缩空格
- (NSString *)compressWhiteSpace;

//去掉首尾空白符
- (NSString *)trim;

/*
 * 判断指定字符串是否空字符串（null、都是'\n'、都是' '，这些都算空字符串）
 */
+ (BOOL)isNullString:(NSString *)string;

//判断中文
- (BOOL)isContrainChineseStr;

//手机号码验证
+ (BOOL)checkPhoneNumInput:(NSString *)text;
//判断邮箱
+ (BOOL)validateEmail:(NSString *)candidate;

//判断是否包含sub字符串
- (BOOL)isContainString:(NSString*)sub;

//去掉sub字符串
- (NSString *)stringByDeletingString:(NSString *)sub;

/*
 *  校验字符串的第一个可见字符是否为中文
 */
- (BOOL)isFirstLetterChinese;

#pragma -mark  MIME type

//根据后缀名生成mime type
+ (NSString *)MIMETypeWithFileExtension:(NSString *)extension;

//获取文件mime
+ (NSString*)fileMIMEType:(NSString *)file;

+ (NSString *)localFileMIMEType:(NSString *)file;

#pragma mark - MAC MD5 -

//md5
- (NSString *)md5;

//获取MAC地址
+ (NSString *)getMACAddress;



// 十六进制转换为普通字符串的。
+ (NSString *)stringFromHexString:(NSString *)hexString;

// 正常号转银行卡号 － 增加4位间的空格
-(NSString *)normalNumToBankNum;

// 银行卡号转正常号 － 去除4位间的空格
-(NSString *)bankNumToNormalNum;

+ (NSString *)filterHTML:(NSString *)html;

+ (NSString *)fileName;

+ (NSString *)getBidCashWithCashId:(int)cashId;

//获取当前日期
+(NSString *)getCurrentDate;

//本地utf8字符串转成网页utf8字符串（带%）
+ (NSString*)InetUTF8String:(NSString*)string;

//获得设备型号
+ (NSString*)getDeviceModelString;

//获得当前时间戳
+ (NSString *)getCurrentTimeIntervalStr;

// 清除前后空格
+ (NSString *)clearSpace:(NSString *)text;

//获取app版本号
+ (NSString *)getApplicationVersion;


@end
