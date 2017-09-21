//
//  AFNetApiClient.m
//  DB_Application
//
//  Created by epwk on 16/4/18.
//  Copyright © 2016年 DBAPP. All rights reserved.
//

#import "AFNetApiClient.h"
#import "API_Header.h"



@implementation AFNetApiClient

+(AFNetApiClient *)ShareClient{
    static AFNetApiClient *shareClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareClient = [[AFNetApiClient alloc] initWithBaseURL:[NSURL URLWithString:kAPIBASEURL]];
        shareClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        [shareClient.reachabilityManager startMonitoring];
        shareClient.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    return  shareClient;
}

//解析JSON报文
- (void)parseResponseData:(id)responseData
                  success:(RequestSuccess)successBlock
                  failure:(RequestFailure)failureBlock
{
    if (responseData == nil) {
        failureBlock(@[], -1 ,@"请求错误！"); //没有JSON报文
    } else {
        id dataJson = [responseData objectForKey:@"data"];
        if (dataJson)
        {
            int status = [[responseData objectForKey:@"status"] intValue];
            NSString *msg = [responseData objectForKey:@"msg"];
            
            NSLog(@"data === %@,status === %@,msg === %@", dataJson, @(status), msg);
            
            if(status <= 0)
            {
                failureBlock(dataJson, status, msg);
            }else
            {
                successBlock(dataJson, status, msg);
            }
        }
    }
}


/*
 *  网络请求
 *
 *  @para path API接口地址
 *  @para parameters JSON数据
 *  @para successBlock 请求成功回调
 *  @para failureBlock 请求失败回调
 */
- (void)postWithPath:(NSString *)path
          parameters:(NSDictionary *)parameters
             success:(RequestSuccess)successBlock
             failure:(RequestFailure)failureBlock
{
    NSMutableDictionary *paras = [NSMutableDictionary dictionaryWithDictionary:parameters];
//    NSDictionary *tempParas = @{@"source" : AppSourceInfo};
//    if (UserInfo) {
//        [paras addEntriesFromDictionary:@{@"access_token":UserInfo[@"access_token"]}];
//    }
    
    //系统自动切换环境
#if defined(DEBUG)||defined(_DEBUG) //测试
     NSLog(@"path:%@, parameters:%@",path, paras);
//    [paras addEntriesFromDictionary:@{@"debug":@"1"}];//线上正式 debug
#endif
    
//    [paras addEntriesFromDictionary:tempParas];
   
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    // post请求
    [self POST:path parameters:paras constructingBodyWithBlock:^(id  _Nonnull formData) {
        // 拼接data到请求体，这个block的参数是遵守AFMultipartFormData协议的。
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 这里可以获取到目前的数据请求的进度
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 请求成功，解析数据
        if (successBlock) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
            [self parseResponseData:dic success:^(id dataDict, int status, NSString *msg) {
                successBlock(dataDict, status, msg);
            } failure:^(id dataDict, int status, NSString *msg) {
                failureBlock(dataDict, status, msg);
            }];
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        //系统自动切换环境
#if defined(DEBUG)||defined(_DEBUG) //测试
         NSLog(@"%@", [error localizedDescription]);
#endif
       
        if (failureBlock) {
            if (![[[AFNetApiClient ShareClient] reachabilityManager] isReachable]) {
                failureBlock(@[], -9999 ,@"无网络,请检查网络设置!");
            }
            else
                failureBlock(@[], -999 ,@"RequestError");  //请求失败，约定返回“RequestError”，用来区分显示加载失败或者自定义提示
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
}

/*
 *  上传附件
 *
 *  @para path API接口地址
 *  @para parameters JSON数据
 *  @para formName 图片表单名称数组
 *  @para successBlock 请求成功回调
 *  @para failureBlock 请求失败回调
 */
- (void)uploadFiles:(NSArray *)avatarArray
               path:(NSString *)path
 formPhotoNameArray:(NSArray *)formPhotoNameArray
         parameters:(NSDictionary *)parameters
            progress:(UploadProgress)Progress
            success:(RequestSuccess)successBlock
            failure:(RequestFailure)failureBlock
{
    __block NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    NSMutableArray *picArray = [[NSMutableArray alloc] initWithArray:avatarArray];
    NSMutableArray *picNameArray = [[NSMutableArray alloc] initWithArray:formPhotoNameArray];
    NSData *imageData;
    if (formPhotoNameArray.count > 0) {
        if ([[formPhotoNameArray firstObject] rangeOfString:@"mp3"].location != NSNotFound) {//判断是否存在语音 附件
            [picArray removeObjectAtIndex:0];
            [picNameArray removeObjectAtIndex:0];
        }
        for (UIImage *avatar in picArray)
        {
            imageData = UIImageJPEGRepresentation(avatar, 1);
            [dataArray addObject:imageData];
        }
        
    }
    NSMutableDictionary *paras = [NSMutableDictionary dictionaryWithDictionary:parameters];
//    NSDictionary *tempParas = @{@"source" : AppSourceInfo};
//    if (UserInfo) {
//        [paras addEntriesFromDictionary:@{@"access_token":UserInfo[@"access_token"]}];
//    }
//    
//    //系统自动切换环境
//#if defined(DEBUG)||defined(_DEBUG) //测试
//    [paras addEntriesFromDictionary:@{@"debug":@"1"}];//线上正式 debug
//#endif
//    
//    [paras addEntriesFromDictionary:tempParas];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSLog(@"path:%@, parameters:%@, formPhotoNameArray:%@",path, paras, formPhotoNameArray);
    [self POST:path parameters:paras constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        int i = 0;
        for (NSData *formImageData in dataArray)
        {
            [formData appendPartWithFileData:formImageData name:picNameArray[i] fileName:picNameArray[i] mimeType:@"image/jpeg"];
            i++;
        }
        
        if (formPhotoNameArray.count > 0) {
            if ([[formPhotoNameArray firstObject] rangeOfString:@"mp3"].location != NSNotFound) {
                [formData appendPartWithFileURL:[NSURL fileURLWithPath:[avatarArray firstObject] isDirectory:NO] name:[formPhotoNameArray firstObject] error:nil];// 只有 一个语音附件
            }
        }

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (Progress) {
            Progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);;
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            //解析返回的报文
            [self parseResponseData:responseObject success:^(id dataDict, int status, NSString *msg) {
                successBlock(dataDict, status, msg);
            } failure:^(id dataDict, int status, NSString *msg) {
                failureBlock(dataDict, status, msg);
            }];
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            if (![[[AFNetApiClient ShareClient] reachabilityManager] isReachable]) {
                failureBlock(@[], -9999 ,@"无网络,请检查网络设置!");
            }
            else
                failureBlock(@[], -999 ,@"RequestError");  //请求失败，约定返回“RequestError”，用来区分显示加载失败或者自定义提示
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];}

/*
 *  上传图片
 *
 *  @para path API接口地址
 *  @para parameters JSON数据
 *  @para formName 图片表单名称数组
 *  @para successBlock 请求成功回调
 *  @para failureBlock 请求失败回调
 */
- (void)uploadPhoto:(NSArray *)avatarArray
               path:(NSString *)path
 formPhotoNameArray:(NSArray *)formPhotoNameArray
         parameters:(NSDictionary *)parameters
           progress:(UploadProgress)Progress
            success:(RequestSuccess)successBlock
            failure:(RequestFailure)failureBlock
{
    __block NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    NSData *imageData;
    for (UIImage *avatar in avatarArray)
    {
        imageData = UIImageJPEGRepresentation(avatar, 1);
        [dataArray addObject:imageData];
    }
    
    NSMutableDictionary *paras = [NSMutableDictionary dictionaryWithDictionary:parameters];
//    NSDictionary *tempParas = @{@"source" : AppSourceInfo};
//    if (UserInfo) {
//        [paras addEntriesFromDictionary:@{@"access_token":UserInfo[@"access_token"]}];
//    }
//    //系统自动切换环境
//#if defined(DEBUG)||defined(_DEBUG) //测试
//    [paras addEntriesFromDictionary:@{@"debug":@"1"}];//线上正式 debug
//#endif
//    
//    [paras addEntriesFromDictionary:tempParas];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSLog(@"path:%@, parameters:%@, formPhotoNameArray:%@",path, paras, formPhotoNameArray);
    [self POST:path parameters:paras constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        int i = 0;
        for (NSData *formImageData in dataArray)
        {
            [formData appendPartWithFileData:formImageData name:formPhotoNameArray[i] fileName:[NSString stringWithFormat:@"%@.jpeg",formPhotoNameArray[i]] mimeType:@"image/jpeg"];
            i++;
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (Progress) {
            Progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);;
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            //解析返回的报文
            [self parseResponseData:responseObject success:^(id dataDict, int status, NSString *msg) {
                successBlock(dataDict, status, msg);
            } failure:^(id dataDict, int status, NSString *msg) {
                failureBlock(dataDict, status, msg);
            }];
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            if (![[[AFNetApiClient ShareClient] reachabilityManager] isReachable]) {
                failureBlock(@[], -9999 ,@"无网络,请检查网络设置!");
            }
            else
                failureBlock(@[], -999 ,@"RequestError");  //请求失败，约定返回“RequestError”，用来区分显示加载失败或者自定义提示
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
}


//取消网络请求
- (void)cancleOperation
{
    [[AFNetApiClient ShareClient].operationQueue cancelAllOperations];
}

//任务大厅 任务列表
- (void)requestTaskListWithParams:(NSDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure
{
    [self postWithPath:kAPITalentList parameters:params success:^(id dataDict, int status, NSString *msg) {
        success(dataDict, status, msg);
    } failure:^(id dataDict, int status, NSString *msg) {
        failure(dataDict, status, msg);
    }];
}

//认证
- (void)requestAuthWithParams:(NSDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure
{
    [self postWithPath:kAPIAuth parameters:params success:^(id dataDict, int status, NSString *msg) {
        success(dataDict, status, msg);
    } failure:^(id dataDict, int status, NSString *msg) {
        failure(dataDict, status, msg);
    }];
}

//充值
- (void)requestChargeWithParams:(NSDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure
{
    [self postWithPath:kAPICharge parameters:params success:^(id dataDict, int status, NSString *msg) {
        success(dataDict, status, msg);
    } failure:^(id dataDict, int status, NSString *msg) {
        failure(dataDict, status, msg);
    }];
}

//转账
- (void)requestPayWithParams:(NSDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure
{
    [self postWithPath:kAPIPay parameters:params success:^(id dataDict, int status, NSString *msg) {
        success(dataDict, status, msg);
    } failure:^(id dataDict, int status, NSString *msg) {
        failure(dataDict, status, msg);
    }];
}

//提现
- (void)requestTakeMoneyWithParams:(NSDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure
{
    [self postWithPath:kAPITakeMoney parameters:params success:^(id dataDict, int status, NSString *msg) {
        success(dataDict, status, msg);
    } failure:^(id dataDict, int status, NSString *msg) {
        failure(dataDict, status, msg);
    }];
}


//授权
- (void)requestAuthorizationWithParams:(NSDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure
{
    [self postWithPath:kAPIAuthorization parameters:params success:^(id dataDict, int status, NSString *msg) {
        success(dataDict, status, msg);
    } failure:^(id dataDict, int status, NSString *msg) {
        failure(dataDict, status, msg);
    }];
}






@end
