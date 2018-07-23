//
//  HttpAfntool.m
//  WestCar
//
//  Created by apple on 2017/3/21.
//  Copyright © 2017年 陈鹏. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "HttpAfntool.h"
#import <AFNetworking/AFNetworking.h>
#import "NSString+Extension.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "LoginViewController.h"
@implementation HttpAfntool

//post请求
+(void)PostWithUrlstr:(NSString *)urlStr param:(id)param success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *manage = [self manager];
    //添加主机地址
    NSString *Url = [NSString stringWithFormat:@"%s%@",APIMainHost,urlStr];
    [manage POST:Url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
    }];
    
}

+(void)GetWithUrlstr:(NSString *)urlStr param:(id)param success:(void(^)(id json))success failure:(void(^)(NSError *error))failure
{
    AFHTTPSessionManager *manage = [self manager];
    //添加主机地址
    NSString *Url = [NSString stringWithFormat:@"%s%@",APIMainHost,urlStr];

    [manage GET:Url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      
        if (success) {
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                NSString *mes = [responseObject objectForKey:@"message"];
                if ([mes hasPrefix:@"auth error"]) {
                    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
                    LoginViewController *vc = [[LoginViewController alloc]init];
                    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
                    
                    keyWindow.rootViewController = nav;
                    [keyWindow makeKeyWindow];
                }else{
                    success(responseObject);
                }
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}


//添加 publick
+(void)getPublickUrlstr:(NSString *)publickUrlStr param:(NSDictionary *)param success:(void (^)(id _Nullable json, NSString *_Nullable key, NSString *_Nullable oter))success failure:(void (^)(NSError *))failure{
    
    AFHTTPSessionManager *manage = [self manager];
    //添加主机地址
    NSString *PublickUrl = [NSString stringWithFormat:@"%s%@",APIMainHost,APIPublick];
    
    [manage GET:PublickUrl parameters:@{} progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *PKey =responseObject[@"data"][@"SRXK_APP_CAR_PUBLIC_KEY_V1_GLNG"];
        NSString *num = responseObject[@"data"][@"SRXK_APP_CAR_CLIENT_ID_V1_GLNG"];
        if (success) {
               success(responseObject,PKey,num);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

//添加 publick
+(void)PublickWithsuccess:(void (^)(id  _Nullable json,NSString * _Nullable publick,NSString *  _Nullable other))success failure:(void (^)(NSError *error))failure{
    
    AFHTTPSessionManager *manage = [self manager];
    //添加主机地址
    NSString *PublickUrl = [NSString stringWithFormat:@"%s%@",APIMainHost,APIPublick];
    [manage GET:PublickUrl parameters:@{} progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *Key =responseObject[@"data"][@"SRXK_APP_CAR_PUBLIC_KEY_V1_GLNG"];
        NSString *num = responseObject[@"data"][@"SRXK_APP_CAR_CLIENT_ID_V1_GLNG"];
        if (success) {
            success(responseObject,Key,num);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

// 添加Authorization
+(void)addAuthorizationPostWithsurltr:(NSString *)urlStr param:(id)param success:(void(^)(id json))success failure:(void(^)(NSError *error))failure{
    
    NSString *Url = [NSString stringWithFormat:@"%s%@",APIMainHost,urlStr];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [defaults objectForKey:@"dict"];
    
    NSString *str = [NSString stringWithFormat:@"express %@",dict[@"token"]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
     // manager.requestSerializer = [AFJSONRequestSerializer serializer]; // 上传JSON格式
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",nil];
    [manager.requestSerializer setValue:str forHTTPHeaderField:@"Authorization"];
    
  //  manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer]; // AFN会JSON解析返回的数据
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",nil];
 
    [manager POST:Url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                
                NSString *mes = [responseObject objectForKey:@"message"];
                if ([mes hasPrefix:@"auth error"]) {
                    
                    [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
                    
                    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
                    LoginViewController *vc = [[LoginViewController alloc]init];
                    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
                    
                    keyWindow.rootViewController = nav;
                    [keyWindow makeKeyAndVisible];
                }else{
                    success(responseObject);
                }
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        if (failure) {
            failure(error);
        }
    }];
    
}

// 添加 get -Authorization
+(void)addAuthorizationGetWithsurltr:(NSString *)urlStr param:(id)param success:(void(^)(id json))success failure:(void(^)(NSError *error))failure{
    
    NSString *Url = [NSString stringWithFormat:@"%s%@",APIMainHost,urlStr];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [defaults objectForKey:@"dict"];
   
    
    NSString *str = [NSString stringWithFormat:@"express%@",dict[@"token"]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];

     manager.requestSerializer.timeoutInterval = 10.f;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",nil];
    [manager.requestSerializer setValue:str forHTTPHeaderField:@"Authorization"];
    
    // manager.requestSerializer = [AFJSONRequestSerializer serializer]; // 上传JSON格式
    manager.responseSerializer = [AFJSONResponseSerializer serializer]; // AFN会JSON解析返回的数据
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",nil];
    
    [manager GET:Url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                NSString *mes = [responseObject objectForKey:@"message"];
                if ([mes hasPrefix:@"auth error"]) {
                    
                    [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
                    
                    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
                    LoginViewController *vc = [[LoginViewController alloc]init];
                    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
                    
                    keyWindow.rootViewController = nav;
                    [keyWindow makeKeyAndVisible];
                }else{
                    success(responseObject);
                }
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
            NSLog(@"http-error%@",error);
        }
    }];
    
}

+(AFHTTPSessionManager *)manager{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 超时时间
     manager.requestSerializer.timeoutInterval = 10.f;
    // 声明上传的是json格式的参数，需要你和后台约定好，不然会出现后台无法获取到你上传的参数问题
    
        manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式
    //  manager.requestSerializer = [AFJSONRequestSerializer serializer]; // 上传JSON格式
    // 声明获取到的数据格式
    //  manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // AFN不会解析,数据是data，需要自己解析
      manager.responseSerializer = [AFJSONResponseSerializer serializer]; // AFN会JSON解析返回的数据
    // 个人建议还是自己解析的比较好，有时接口返回的数据不合格会报3840错误，大致是AFN无法解析返回来的数据
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",@"text/html",@"text/xml",nil];

//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    return manager;
}

//上传图片(单张)
+(void)uploadWithUrl:(NSString *)url Image:(UIImage*)image WithImName:(NSDictionary *)param  Withsucess:(void (^)(id json))sucess AndFinish:(void (^)(id task, NSError *))finish
{
    NSString *Url = [NSString stringWithFormat:@"%s%@",APIMainHost,url];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [defaults objectForKey:@"dict"];
    
    
    NSString *str = [NSString stringWithFormat:@"express%@",dict[@"token"]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.requestSerializer.timeoutInterval = 10.f;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",nil];
    [manager.requestSerializer setValue:str forHTTPHeaderField:@"Authorization"];
    
    // manager.requestSerializer = [AFJSONRequestSerializer serializer]; // 上传JSON格式
    manager.responseSerializer = [AFJSONResponseSerializer serializer]; // AFN会JSON解析返回的数据
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",nil];
    
    [SVProgressHUD showWithStatus:@"正在上传"];
  //  NSString *postUrl = [NSString stringWithFormat:@"%s%@",APIMainHost,url];//URL
    NSData *imageData = UIImageJPEGRepresentation(image, 0.1);//image为要上传的图片(UIImage)
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:Url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *fileName = [NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]];
        //二进制文件，接口key值，文件路径，图片格式
        if (imageData != nil) {
           [formData appendPartWithFileData:imageData name:param.allValues.firstObject fileName:fileName mimeType:@"image/jpg/png/jpeg"];
        }
 
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    
        NSLog(@"progress=%f",uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         [SVProgressHUD dismiss];
        if (sucess) {
          //  NSString *str1 = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//            NSArray * jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject
//                                                            options:NSJSONReadingAllowFragments
//                                                              error:nil];
//
//            NSString * str = jsonObject.firstObject;

            
            NSArray * arrstr = responseObject;
            if ([arrstr.firstObject isKindOfClass:[NSDictionary class]]) {
                NSDictionary *strDict = arrstr.firstObject;
                NSString *str = [NSString stringWithFormat:@"%@",strDict[@"success"]];
                sucess(str);
            }else{
            NSString * str = arrstr.firstObject;
                sucess(str);
            }
          //  NSData *data =[str dataUsingEncoding:NSUTF8StringEncoding];
            
        }
        //
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
            [SVProgressHUD dismiss];
        
        if (finish) {
         
            finish(task,error);
        }
    }];
}

//
+(void)GetUrl:(NSString *)urlStr param:(id)param success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    
    AFHTTPSessionManager *manage = [self manager];
    
//    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
//     manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",nil];
//    manage.responseSerializer = [AFJSONResponseSerializer serializer]; // AFN会JSON解析返回的数据

    [manage GET:urlStr parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
    }];
    
}
@end
