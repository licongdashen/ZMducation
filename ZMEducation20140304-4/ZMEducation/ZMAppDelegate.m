//
//  ZMAppDelegate.m
//  ZMEducation
//
//  Created by Hunter Li on 13-4-24.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import "ZMAppDelegate.h"
#import "ASIFormDataRequest.h"
#import "ZMLoginViewController.h"
#import "ZMHomeViewController.h"
#import "ZMSwipeViewController.h"


//#import "ZMMdlTravelVCtrl.h"
//#import "ZMMdlZcdVCtrl.h"
//#import "ZMMdlZykVCtrl.h"
//#import "ZMMdlTopicVCtrl.h"
//#import "ZMMdlInteractVCtrl.h"
//#import "ZMMdlExplainVCtrl.h"
//#import "ZMMdlConceptionVCtrl.h"
//#import "ZMMdlCmpVCtrl.h"
//#import "ZMMdlBbsVCtrl.h"
//#import "ZMMdlRuleVCtrl.h"
//#import "ZMMdlSliderVCtrl.h"
#import "ZMMdlStoryVCtrl.h"

@implementation ZMAppDelegate
@synthesize userDict = _userDict;

+(ZMAppDelegate *)App
{
    return (ZMAppDelegate *)[[UIApplication sharedApplication]delegate];
}

- (void)dealloc{
    [_window release];
    [_userDict release];
    
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    ZMLoginViewController* loginViewController = [[ZMLoginViewController alloc] init];
    //ZMMdlCmpVCtrl * loginViewController = [[ZMMdlCmpVCtrl alloc]init];
    UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    [navigationController setNavigationBarHidden:YES];
    [self.window setRootViewController:navigationController];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    [loginViewController release];
    [navigationController release];
    
    return YES;
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    //将device token转换为字符串
    NSString *deviceTokenStr = [NSString stringWithFormat:@"%@",deviceToken];
    deviceTokenStr = [[deviceTokenStr substringWithRange:NSMakeRange(0, 72)] substringWithRange:NSMakeRange(1, 71)];
    //保存 device token 令牌,并且去掉空格
    deviceTokenStr = [deviceTokenStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"deviceTokenStr = %@",deviceTokenStr);
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        //将deviceToken保存在NSUserDefaults
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setValue:deviceTokenStr forKey:kDeviceTokenStringKEY];
    });
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"Register Remote Notifications error:{%@}",[error localizedDescription]);
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler
{
    NSLog(@"Receive remote notification : %@",userInfo);
    
    NSString* method = [userInfo valueForKey:@"method"];
    if (application.applicationState == UIApplicationStateActive) {
        if (_userDict) {
            NSString* screenControl = [_userDict valueForKey:@"screenControl"];
            NSString* role = [_userDict valueForKey:@"role"];
            if ([@"03" isEqualToString:role] || [@"04" isEqualToString:role]) {
                if ([@"M011" isEqualToString:method]) {
                    NSString* gradeId  = [userInfo valueForKey:@"gradeId"];
                    NSString* classId  = [userInfo valueForKey:@"classId"];
                    
                    NSLog(@"屏幕控制,年级：%d，班级：%d",[gradeId intValue],[classId intValue]);
                    NSString* screenControlFromRemote = [userInfo valueForKey:@"screenControl"];
                    if ([@"00" isEqualToString:screenControlFromRemote]) {
                        NSLog(@"锁屏:%@",screenControlFromRemote);
                    }else if([@"01" isEqualToString:screenControlFromRemote]){
                        NSLog(@"解开锁屏:%@",screenControlFromRemote);
                    }
                    
                    [_userDict setValue:screenControlFromRemote forKey:@"screenControl"];
                    
                    [[NSNotificationCenter defaultCenter]  postNotificationName:@"screenControlDidChangeNotification"
                                                                         object:nil
                                                                       userInfo:nil];
                }else if ([@"00" isEqualToString:screenControl]) {
                    if([@"M012" isEqualToString:method]){
                        NSString* gradeId  = [userInfo valueForKey:@"gradeId"];
                        NSString* classId  = [userInfo valueForKey:@"classId"];
                        NSString* moduleId  = [userInfo valueForKey:@"moduleId"];
                        NSString* control = [userInfo valueForKey:@"control"];
                        
                        [_userDict setValue:moduleId forKey:@"currentModuleId"];
                        NSLog(@"屏幕控制,年级：%d，班级：%d，模块：%d，操作：%@",[gradeId intValue],[classId intValue],[moduleId intValue],control);
                        
                        if ([@"01" isEqualToString:control]) {
                            NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
                            [requestDict setValue:@"M006" forKey:@"method"];
                            [requestDict setValue:[_userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
                            [requestDict setValue:[_userDict valueForKey:@"currentClassId"] forKey:@"classId"];
                            [requestDict setValue:[_userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
                            [requestDict setValue:moduleId forKey:@"moduleId"];
                            
                            ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
                            [httpEngine setDelegate:self];
                            [httpEngine requestWithDict:requestDict];
                            [httpEngine release];
                            [requestDict release];
                        }else if([@"02" isEqualToString:control]){
                            NSString * controller = @"ZMHomeViewController";
                            if (![NSStringFromClass([self class]) isEqualToString:controller] ) {
                                NSInteger currentIndex = -1;
                                NSArray* arr = [[NSArray alloc] initWithArray:[(UINavigationController*)[self.window rootViewController] viewControllers]];
                                for(int i=0 ; i<[arr count] ; i++){
                                    if([[arr objectAtIndex:i] isKindOfClass:NSClassFromString(controller)]){
                                        currentIndex = i;
                                        break;
                                    }
                                }
                                
                                if (currentIndex == -1) {
                                    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
                                    
                                    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
                                    [requestDict setValue:@"M005" forKey:@"method"];
                                    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
                                    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
                                    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
                                    
                                    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
                                    [httpEngine setDelegate:self];
                                    [httpEngine requestWithDict:requestDict];
                                    [httpEngine release];
                                    [requestDict release];
                                }else{
                                    [(UINavigationController*)[self.window rootViewController] popToViewController:[arr objectAtIndex:currentIndex] animated:YES];
                                }
                                
                                [arr release];
                            }
                        }else if([@"03" isEqualToString:control]){
                            if (_userDict) {
                                NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
                                [requestDict setValue:@"M002" forKey:@"method"];
                                [requestDict setValue:[_userDict valueForKey:@"userId"] forKey:@"userId"];
                                
                                ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
                                [httpEngine setDelegate:self];
                                [httpEngine requestWithDict:requestDict];
                                [httpEngine release];
                                [requestDict release];
                            }
                        }
                    }else if([@"M013" isEqualToString:method]){
                        NSString* gradeId  = [userInfo valueForKey:@"gradeId"];
                        NSString* classId  = [userInfo valueForKey:@"classId"];
                        NSString* moduleId  = [userInfo valueForKey:@"moduleId"];
                        NSString* unitId = [userInfo valueForKey:@"unitId"];
                        NSString* control = [userInfo valueForKey:@"control"];
                        
                        NSLog(@"屏幕控制,年级：%d，班级：%d，模块：%d，单元：%d，操作：%@",[gradeId intValue],[classId intValue],[moduleId intValue],[unitId intValue],control);
                        
                        NSString * controller = @"ZMSwipeViewController";
                        if (![NSStringFromClass([self class]) isEqualToString:controller] ) {
                            NSInteger currentIndex = -1;
                            NSArray* arr = [[NSArray alloc] initWithArray:[(UINavigationController*)[self.window rootViewController] viewControllers]];
                            for(int i=0 ; i<[arr count] ; i++){
                                if([[arr objectAtIndex:i] isKindOfClass:NSClassFromString(controller)]){
                                    currentIndex = i;
                                    break;
                                }
                            }
                            
                            if (currentIndex == -1) {
                                //                                NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
                                //                                [requestDict setValue:@"M006" forKey:@"method"];
                                //                                [requestDict setValue:[_userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
                                //                                [requestDict setValue:[_userDict valueForKey:@"currentClassId"] forKey:@"classId"];
                                //                                [requestDict setValue:[_userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
                                //                                [requestDict setValue:moduleId forKey:@"moduleId"];
                                //
                                //                                ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
                                //                                [httpEngine setDelegate:self];
                                //                                [httpEngine requestWithDict:requestDict];
                                //                                [httpEngine release];
                                //                                [requestDict release];
                            }else{
                                [(UINavigationController*)[self.window rootViewController] popToViewController:[arr objectAtIndex:currentIndex] animated:YES];
                                
                                [[NSNotificationCenter defaultCenter]  postNotificationName:@"unitExplainNotification"
                                                                                     object:nil
                                                                                   userInfo:userInfo];
                            }
                            
                            [arr release];
                        }
                    }else if([@"M014" isEqualToString:method]){
                        NSString* gradeId  = [userInfo valueForKey:@"gradeId"];
                        NSString* classId  = [userInfo valueForKey:@"classId"];
                        NSString* moduleId  = [userInfo valueForKey:@"moduleId"];
                        NSString* unitId = [userInfo valueForKey:@"unitId"];
                        NSString* currentPage = [userInfo valueForKey:@"currentPage"];
                        
                        NSLog(@"屏幕控制,年级：%d，班级：%d，模块：%d，单元：%d，操作：%d",[gradeId intValue],[classId intValue],[moduleId intValue],[unitId intValue],[currentPage intValue]);
                        [[NSNotificationCenter defaultCenter]  postNotificationName:@"PDFExplainNotification"
                                                                             object:nil
                                                                           userInfo:userInfo];
                    }else if([@"M031" isEqualToString:method]){
                        NSString* gradeId  = [userInfo valueForKey:@"gradeId"];
                        NSString* classId  = [userInfo valueForKey:@"classId"];
                        NSString* moduleId  = [userInfo valueForKey:@"moduleId"];
                        NSString* unitId = [userInfo valueForKey:@"unitId"];
                        NSString* control = [userInfo valueForKey:@"playControl"];
                        
                        NSLog(@"屏幕控制,年级：%d，班级：%d，模块：%d，单元：%d，操作：%@",[gradeId intValue],[classId intValue],[moduleId intValue],[unitId intValue],control);
                        
                        [[NSNotificationCenter defaultCenter]  postNotificationName:@"playVideoDidChangeNotification"
                                                                             object:nil
                                                                           userInfo:userInfo];
                    }else if([@"M032" isEqualToString:method]){
                        NSString* gradeId  = [userInfo valueForKey:@"gradeId"];
                        NSString* classId  = [userInfo valueForKey:@"classId"];
                        NSString* moduleId  = [userInfo valueForKey:@"moduleId"];
                        NSString* unitId = [userInfo valueForKey:@"unitId"];
                        NSString* control = [userInfo valueForKey:@"playControl"];
                        
                        NSLog(@"屏幕控制,年级：%d，班级：%d，模块：%d，单元：%d，操作：%@",[gradeId intValue],[classId intValue],[moduleId intValue],[unitId intValue],control);
                        
                        [[NSNotificationCenter defaultCenter]  postNotificationName:@"playAudioDidChangeNotification"
                                                                             object:nil
                                                                           userInfo:userInfo];
                    }
                }else if([@"01" isEqualToString:screenControl]){
                    
                }
            }else if([@"02" isEqualToString:role]){
                if ([@"M002" isEqualToString:method]) {
                    NSString* userName = [userInfo valueForKey:@"userName"];
                    NSLog(@"学员%@退出",userName);
                }
            }
        }
    }
    
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{    
    NSLog(@"Receive remote notification : %@",userInfo);
    
    NSString* method = [userInfo valueForKey:@"method"];
    if (application.applicationState == UIApplicationStateActive) {
        if (_userDict) {
            NSString* screenControl = [_userDict valueForKey:@"screenControl"];
            NSString* role = [_userDict valueForKey:@"role"];
            if ([@"03" isEqualToString:role] || [@"04" isEqualToString:role]) {
                if ([@"M011" isEqualToString:method]) {
                    NSString* gradeId  = [userInfo valueForKey:@"gradeId"];
                    NSString* classId  = [userInfo valueForKey:@"classId"];
                    
                    NSLog(@"屏幕控制,年级：%d，班级：%d",[gradeId intValue],[classId intValue]);
                    NSString* screenControlFromRemote = [userInfo valueForKey:@"screenControl"];
                    if ([@"00" isEqualToString:screenControlFromRemote]) {
                        NSLog(@"锁屏:%@",screenControlFromRemote);
                    }else if([@"01" isEqualToString:screenControlFromRemote]){
                        NSLog(@"解开锁屏:%@",screenControlFromRemote);
                    }
                    
                    [_userDict setValue:screenControlFromRemote forKey:@"screenControl"];
                    
                    [[NSNotificationCenter defaultCenter]  postNotificationName:@"screenControlDidChangeNotification"
                                                                         object:nil
                                                                       userInfo:nil];
                }else if ([@"00" isEqualToString:screenControl]) {
                    if([@"M012" isEqualToString:method]){
                        NSString* gradeId  = [userInfo valueForKey:@"gradeId"];
                        NSString* classId  = [userInfo valueForKey:@"classId"];
                        NSString* moduleId  = [userInfo valueForKey:@"moduleId"];
                        NSString* control = [userInfo valueForKey:@"control"];
                        
                        [_userDict setValue:moduleId forKey:@"currentModuleId"];
                        NSLog(@"屏幕控制,年级：%d，班级：%d，模块：%d，操作：%@",[gradeId intValue],[classId intValue],[moduleId intValue],control);
                       
                        if ([@"01" isEqualToString:control]) {
                            NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
                            [requestDict setValue:@"M006" forKey:@"method"];
                            [requestDict setValue:[_userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
                            [requestDict setValue:[_userDict valueForKey:@"currentClassId"] forKey:@"classId"];
                            [requestDict setValue:[_userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
                            [requestDict setValue:moduleId forKey:@"moduleId"];
                            
                            ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
                            [httpEngine setDelegate:self];
                            [httpEngine requestWithDict:requestDict];
                            [httpEngine release];
                            [requestDict release];
                        }else if([@"02" isEqualToString:control]){                            
                            NSString * controller = @"ZMHomeViewController";
                            if (![NSStringFromClass([self class]) isEqualToString:controller] ) {
                                NSInteger currentIndex = -1;
                                NSArray* arr = [[NSArray alloc] initWithArray:[(UINavigationController*)[self.window rootViewController] viewControllers]];
                                for(int i=0 ; i<[arr count] ; i++){
                                    if([[arr objectAtIndex:i] isKindOfClass:NSClassFromString(controller)]){
                                        currentIndex = i;
                                        break;
                                    }
                                }
                                
                                if (currentIndex == -1) {
                                    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
                                    
                                    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
                                    [requestDict setValue:@"M005" forKey:@"method"];
                                    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
                                    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
                                    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
                                    
                                    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
                                    [httpEngine setDelegate:self];
                                    [httpEngine requestWithDict:requestDict];
                                    [httpEngine release];
                                    [requestDict release];
                                }else{
                                    [(UINavigationController*)[self.window rootViewController] popToViewController:[arr objectAtIndex:currentIndex] animated:YES];
                                }
                                
                                [arr release];
                            }
                        }else if([@"03" isEqualToString:control]){
                            if (_userDict) {
                                NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
                                [requestDict setValue:@"M002" forKey:@"method"];
                                [requestDict setValue:[_userDict valueForKey:@"userId"] forKey:@"userId"];
                                
                                ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
                                [httpEngine setDelegate:self];
                                [httpEngine requestWithDict:requestDict];
                                [httpEngine release];
                                [requestDict release];
                            }
                        }
                    }else if([@"M013" isEqualToString:method]){
                        NSString* gradeId  = [userInfo valueForKey:@"gradeId"];
                        NSString* classId  = [userInfo valueForKey:@"classId"];
                        NSString* moduleId  = [userInfo valueForKey:@"moduleId"];
                        NSString* unitId = [userInfo valueForKey:@"unitId"];
                        NSString* control = [userInfo valueForKey:@"control"];
                        
                        NSLog(@"屏幕控制,年级：%d，班级：%d，模块：%d，单元：%d，操作：%@",[gradeId intValue],[classId intValue],[moduleId intValue],[unitId intValue],control);
                        
                        NSString * controller = @"ZMSwipeViewController";
                        if (![NSStringFromClass([self class]) isEqualToString:controller] ) {
                            NSInteger currentIndex = -1;
                            NSArray* arr = [[NSArray alloc ] initWithArray:[(UINavigationController*)[self.window rootViewController] viewControllers]];
                            for(int i=0 ; i<[arr count] ; i++){
                                if([[arr objectAtIndex:i] isKindOfClass:NSClassFromString(controller)]){
                                    currentIndex = i;
                                    break;
                                }
                            }
                            
                            if (currentIndex == -1) {
//                                NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
//                                [requestDict setValue:@"M006" forKey:@"method"];
//                                [requestDict setValue:[_userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
//                                [requestDict setValue:[_userDict valueForKey:@"currentClassId"] forKey:@"classId"];
//                                [requestDict setValue:[_userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
//                                [requestDict setValue:moduleId forKey:@"moduleId"];
//                                
//                                ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
//                                [httpEngine setDelegate:self];
//                                [httpEngine requestWithDict:requestDict];
//                                [httpEngine release];
//                                [requestDict release];
                            }else{
                                [(UINavigationController*)[self.window rootViewController] popToViewController:[arr objectAtIndex:currentIndex] animated:YES];
                                
                                [[NSNotificationCenter defaultCenter]  postNotificationName:@"unitExplainNotification"
                                                                                     object:nil
                                                                                   userInfo:userInfo];
                            }
                            
                            [arr release];
                        }
                    }else if([@"M014" isEqualToString:method]){
                        NSString* gradeId  = [userInfo valueForKey:@"gradeId"];
                        NSString* classId  = [userInfo valueForKey:@"classId"];
                        NSString* moduleId  = [userInfo valueForKey:@"moduleId"];
                        NSString* unitId = [userInfo valueForKey:@"unitId"];
                        NSString* currentPage = [userInfo valueForKey:@"currentPage"];
                        
                        NSLog(@"屏幕控制,年级：%d，班级：%d，模块：%d，单元：%d，操作：%d",[gradeId intValue],[classId intValue],[moduleId intValue],[unitId intValue],[currentPage intValue]);
                        [[NSNotificationCenter defaultCenter]  postNotificationName:@"PDFExplainNotification"
                                                                             object:nil
                                                                           userInfo:userInfo];
                    }else if([@"M031" isEqualToString:method]){
                        NSString* gradeId  = [userInfo valueForKey:@"gradeId"];
                        NSString* classId  = [userInfo valueForKey:@"classId"];
                        NSString* moduleId  = [userInfo valueForKey:@"moduleId"];
                        NSString* unitId = [userInfo valueForKey:@"unitId"];
                        NSString* control = [userInfo valueForKey:@"playControl"];
                        
                        NSLog(@"屏幕控制,年级：%d，班级：%d，模块：%d，单元：%d，操作：%@",[gradeId intValue],[classId intValue],[moduleId intValue],[unitId intValue],control);
                        
                        [[NSNotificationCenter defaultCenter]  postNotificationName:@"playVideoDidChangeNotification"
                                                                             object:nil
                                                                           userInfo:userInfo];
                    }else if([@"M032" isEqualToString:method]){
                        NSString* gradeId  = [userInfo valueForKey:@"gradeId"];
                        NSString* classId  = [userInfo valueForKey:@"classId"];
                        NSString* moduleId  = [userInfo valueForKey:@"moduleId"];
                        NSString* unitId = [userInfo valueForKey:@"unitId"];
                        NSString* control = [userInfo valueForKey:@"playControl"];
                        
                        NSLog(@"屏幕控制,年级：%d，班级：%d，模块：%d，单元：%d，操作：%@",[gradeId intValue],[classId intValue],[moduleId intValue],[unitId intValue],control);
                        
                        [[NSNotificationCenter defaultCenter]  postNotificationName:@"playAudioDidChangeNotification"
                                                                             object:nil
                                                                           userInfo:userInfo];
                    }
                }else if([@"01" isEqualToString:screenControl]){

                }
            }else if([@"02" isEqualToString:role]){
                if ([@"M002" isEqualToString:method]) {
                    NSString* userName = [userInfo valueForKey:@"userName"];
                    NSLog(@"学员%@退出",userName);
                }
            }
        }
    }
}

-(void)applicationDidBecomeActive:(UIApplication *)application{
    //ios 推送注册
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeBadge
                                                                                             |UIRemoteNotificationTypeSound
                                                                                             |UIRemoteNotificationTypeAlert) categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }

}

- (void)applicationDidEnterBackground:(UIApplication *)application{
    UIApplication *app = [UIApplication sharedApplication];
    UIBackgroundTaskIdentifier taskId = 0;
    
    taskId=[app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask:taskId];
    }];
    
    //系统开启后台任务失败
    if (taskId==UIBackgroundTaskInvalid) {
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        double rt = app.backgroundTimeRemaining;
        while (rt>0) {
            [NSThread sleepForTimeInterval:60];
            rt = app.backgroundTimeRemaining;
        }
    });
    
    [[NSNotificationCenter defaultCenter]  postNotificationName:@"applicationDidEnterBackground"
                                                         object:nil
                                                       userInfo:nil];
    
    if (_userDict) {
        NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
        [requestDict setValue:@"M002" forKey:@"method"];
        [requestDict setValue:[_userDict valueForKey:@"userId"] forKey:@"userId"];

        ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
        [httpEngine setDelegate:self];
        [httpEngine requestWithDict:requestDict];
        [httpEngine release];
        [requestDict release];
    }
    
    [application unregisterForRemoteNotifications];
}

#pragma mark ZMHttpEngineDelegate
-(void)httpEngineDidBegin:(ZMHttpEngine *)httpEngine{}

-(void)httpEngine:(ZMHttpEngine *)httpEngine didSuccess:(NSDictionary *)responseDict{
    NSString* method = [responseDict valueForKey:@"method"];
    NSString* responseCode = [responseDict valueForKey:@"responseCode"];
    if ([@"M002" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        [self setUserDict:nil];
        [(UINavigationController*)[self.window rootViewController] popToRootViewControllerAnimated:YES];
    }else if([@"M005" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        NSMutableArray* moduleArray = [[NSMutableArray alloc] initWithCapacity:0];
        
        NSArray* _moduleArray = [responseDict valueForKey:@"modules"];
        for (int i=0; i<[_moduleArray count]; i++) {
            NSLog(@"module:%@",[_moduleArray objectAtIndex:i]);
            [moduleArray addObject:[_moduleArray objectAtIndex:i]];
        }
        
        ZMHomeViewController* homeView = [[ZMHomeViewController alloc] init];
        [homeView setModuleArray:moduleArray];
        [(UINavigationController*)[self.window rootViewController] pushViewController:homeView animated:YES];
        [homeView release];
        [moduleArray release];
        
    }else if([@"M006" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        NSMutableArray* unitArray = [[NSMutableArray alloc] initWithCapacity:0];
        
        NSArray* _unitArray = [responseDict valueForKey:@"units"];
        //NSLog(@"%@",_unitArray);
        for (int i=0; i<[_unitArray count]; i++) {
            //NSLog(@"-------------------unit:%d",i);
            [unitArray addObject:[_unitArray objectAtIndex:i]];
        }
        
        ZMSwipeViewController* swipeView = [[ZMSwipeViewController alloc] init];
        [swipeView setUnitArray:unitArray];
        [(UINavigationController*)[self.window rootViewController] pushViewController:swipeView animated:YES];
        [swipeView release];
        [unitArray release];
    }else{
        //NSLog(@"UIApplication ZMHttpEngine:%@",@"服务器异常");
    }
}

-(void)httpEngine:(ZMHttpEngine *)httpEngine didFailed:(NSString *)failResult{
    NSLog(@"UIApplication ZMHttpEngine:%@",failResult);
}

@end
