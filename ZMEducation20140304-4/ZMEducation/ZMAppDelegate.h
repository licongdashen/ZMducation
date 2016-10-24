//
//  ZMAppDelegate.h
//  ZMEducation
//
//  Created by Hunter Li on 13-4-24.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMConfig.h"
#import "ZMHttpEngine.h"
#import "ASINetworkQueue.h"

@interface ZMAppDelegate : UIResponder <UIApplicationDelegate,ZMHttpEngineDelegate,ASIHTTPRequestDelegate>{

}

@property(strong, nonatomic) UIWindow *window;
@property(nonatomic, retain) NSMutableDictionary* userDict;

@property(nonatomic, strong) NSString *str;

@property(nonatomic, strong) NSMutableArray* fileArray;

@property(nonatomic, retain) ASINetworkQueue* netWorkQueue;
@property(nonatomic, retain) ASIHTTPRequest *request;
@property(nonatomic, retain) NSString * grade;
@property(nonatomic, retain) NSString * course;
@property(nonatomic, retain) NSString * sort;
@property(nonatomic, retain) NSString *courseSort;
@property(nonatomic, retain) NSMutableArray* currentDownloadArray;

@property(nonatomic, retain) NSMutableArray * hasDownloadedDictArray;


@property(nonatomic, retain) NSDictionary* M001Dict;

@property(nonatomic, retain) NSString *nametf;

@property int currentDownloadLength;

@property(nonatomic, retain) NSString * fileCache;
@property(nonatomic, retain) NSString * picCache;

@property (nonatomic, strong) NSString *isjinru;

@property BOOL isdownfinsh;

+(ZMAppDelegate *)App;

-(void)request1;
@end
