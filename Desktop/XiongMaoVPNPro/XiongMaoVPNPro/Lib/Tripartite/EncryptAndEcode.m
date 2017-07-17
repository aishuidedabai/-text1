
//
//  EncryptAndEcode.m
//  XiongMaoJiaSu
//
//  Created by 唐晓波的电脑 on 16/6/7.
//  Copyright © 2016年 ISOYasser. All rights reserved.
//

//加密解密
#import "EncryptAndEcode.h"
#import "AFNetworking.h"
#import "cccc.h"

@implementation EncryptAndEcode
//解密
+(void)httpUrl:(NSString *)url AndPostparameters:(NSDictionary *)parameters block:(void(^)(NSDictionary* responseObject))block
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];//设置相应内容类型
    NSLog(@"%@%@",url,parameters);
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    } progress:^(NSProgress * _Nonnull uploadProgress) {
       
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject1) {
        
      
        NSString *key = @"4cb4e74033fa753935c873e664323486@";
        NSString *str1=[[NSString alloc]initWithData:responseObject1 encoding:NSUTF8StringEncoding];
        NSString *str = [cccc XorDencodeWithKey:key str:str1];
        NSDictionary *responseObject =[self dictionaryWithJsonString:str];
        block(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
         [FormValidator showAlertWithStr:failTipe];
          
        
    }];
}


+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}
@end
