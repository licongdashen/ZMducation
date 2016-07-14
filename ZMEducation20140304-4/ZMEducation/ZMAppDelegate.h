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
@interface ZMAppDelegate : UIResponder <UIApplicationDelegate,ZMHttpEngineDelegate>{

}

@property(strong, nonatomic) UIWindow *window;
@property(nonatomic, retain) NSMutableDictionary* userDict;

@property(nonatomic, strong) NSString *str;

+(ZMAppDelegate *)App;
@end
