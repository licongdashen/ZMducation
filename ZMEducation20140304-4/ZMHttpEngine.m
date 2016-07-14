//
//  ZMHttpEngine.m
//  ZMEducation
//
//  Created by Hunter Li on 13-4-24.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import "ZMHttpEngine.h"
#import "ASIFormDataRequest.h"
#import "ZMConfig.h"
#import "JSONKit.h"

@implementation ZMHttpEngine
@synthesize delegate = _delegate;

-(void)requestWithDict:(NSDictionary*)infoDict{
    NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/rs/invoke",kHttpRequestURL]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    //设置编码格式
    NSString *charset = (NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    [request addRequestHeader:@"Content-Type" value:[NSString stringWithFormat:@"application/json; charset=%@",charset]];
    NSArray* keys = [infoDict allKeys];
    for(NSString* key in keys){
        NSString* value = [infoDict valueForKey:key];
        [request setPostValue:value forKey:key];
    }
    
    NSLog(@"\n request \n%@",infoDict);
    
    [_delegate httpEngineDidBegin:self];
    [request setCompletionBlock:^{
        NSLog(@"\n response \n%@",request.responseString);
        
        NSDictionary *responseDict  = [request.responseString objectFromJSONString];
        [_delegate httpEngine:self didSuccess:responseDict];
    }];
    
    [request setFailedBlock:^{
        NSLog(@"\n\n%@", request.error);

        [_delegate httpEngine:self didFailed:@"服务器连接失败"];
    }];
    
    [request startAsynchronous];

    [pool release];
}

@end
