//
//  AFNetApiClient.h
//  DB_Application
//
//  Created by epwk on 16/4/18.
//  Copyright © 2016年 DBAPP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface AFNetApiClient : AFHTTPSessionManager

typedef void (^RequestSuccess)(id dataDict, int status, NSString *msg);
typedef void (^RequestFailure)(id dataDict, int status, NSString *msg);
/*!
 *
 *  下载进度
 *
 *  @param bytesRead                 已下载的大小
 *  @param totalBytesRead            文件总大小
 *  @param totalBytesExpectedToRead 还有多少需要下载
 */
typedef void (^DownloadProgress)(int64_t bytesRead,
                                    int64_t totalBytesRead);
/*!
 *
 *  上传进度
 *
 *  @param bytesWritten              已上传的大小
 *  @param totalBytesWritten         总上传大小
 */
typedef void (^UploadProgress)(int64_t bytesWritten,
                                  int64_t totalBytesWritten);



+(AFNetApiClient *)ShareClient;
//取消网络请求
- (void)cancleOperation;
//任务大厅 任务列表
- (void)requestTaskListWithParams:(NSDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure;

//认证
- (void)requestAuthWithParams:(NSDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure;

//充值
- (void)requestChargeWithParams:(NSDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure;

//转账
- (void)requestPayWithParams:(NSDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure;

//提现
- (void)requestTakeMoneyWithParams:(NSDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure;

//授权
- (void)requestAuthorizationWithParams:(NSDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure;

@end
