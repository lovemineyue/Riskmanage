//
//  HttpAfntool.h
//  WestCar
//
//  Created by apple on 2017/3/21.
//  Copyright © 2017年 陈鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "AFNetworking.h"
#import <AFNetworking/AFNetworking.h>
@interface HttpAfntool : NSObject
+(void)PostWithUrlstr:(NSString *)urlStr param:(NSDictionary *)param success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;



+(void)GetWithUrlstr:(NSString *)urlStr param:(NSDictionary *)param success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;


+(void)getPublickUrlstr:(NSString *)publickUrlStr param:(NSDictionary *)param success:(void (^)(id json,NSString * publickey,NSString *other))success failure:(void (^)(NSError *error))failure;
+(void)PublickWithsuccess:(void (^)(id json,NSString * publick,NSString *other))success failure:(void (^)(NSError *error))failure;

+(void)uploadWithUrl:(NSString *)url Image:(UIImage*)image WithImName:(NSString *)name Withsucess:(void (^)(id json))sucess AndFinish:(void (^)(id task, NSError *))finish;
// 添加get -Authorization
+(void)addAuthorizationGetWithsurltr:(NSString *)urlStr param:(id)param success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;

// 添加Post -Authorization
+(void)addAuthorizationPostWithsurltr:(NSString *)urlStr param:(id)param success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;

+(void)GetUrl:(NSString *)urlStr param:(id)param success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
@end
