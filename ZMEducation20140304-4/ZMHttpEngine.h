//
//  ZMHttpEngine.h
//  ZMEducation
//
//  Created by Hunter Li on 13-4-24.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//


@class ZMHttpEngine;

@protocol ZMHttpEngineDelegate <NSObject>

-(void)httpEngineDidBegin:(ZMHttpEngine*)httpEngine;
-(void)httpEngine:(ZMHttpEngine*)httpEngine didSuccess:(NSDictionary*)responseDict;
-(void)httpEngine:(ZMHttpEngine*)httpEngine didFailed:(NSString*)failResult;

@end

#import <Foundation/Foundation.h>

@interface ZMHttpEngine : NSObject

@property(nonatomic, assign) id<ZMHttpEngineDelegate> delegate;

-(void)requestWithDict:(NSDictionary*)infoDict;

@end
