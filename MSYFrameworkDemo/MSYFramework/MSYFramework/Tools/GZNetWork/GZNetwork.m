//
//  GZNetwork.m
//  TianYouXiLogin
//
//  Created by iOS on 16/6/27.
//  Copyright © 2016年 iOS. All rights reserved.
//

#import "GZNetwork.h"

@implementation GZNetwork

+(void)requesetWithData:(NSString *)url bodyData:(NSData *)data completeBlock:(CompletioBlock)block{
    NSMutableURLRequest *mutableRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [mutableRequest setHTTPMethod:@"POST"];
    [mutableRequest setHTTPBody:data];
    NSURLSession *urlSession=[NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask=[urlSession dataTaskWithRequest:mutableRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                block(nil,response,error);
            });
            
        }else{
            NSDictionary *content = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                block(content,response,error);
            });
            
        }
    }];
    [dataTask resume];
}

+(void)requesetWithUrl:(NSString *)url completeBlock:(CompletioBlock)block
{
    NSURLRequest *urlRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSession *urlSession=[NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask=[urlSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            block(nil,response,error);
        }else{
            NSDictionary *content = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            block(content,response,error);
        }
    }];
    [dataTask resume];
}


@end
