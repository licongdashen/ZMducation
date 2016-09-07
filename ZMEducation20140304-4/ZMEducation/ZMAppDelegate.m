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
    
    
    self.isdownfinsh = NO;
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    self.fileArray = [[NSMutableArray alloc] initWithCapacity:10];

    ZMLoginViewController* loginViewController = [[ZMLoginViewController alloc] init];
    //ZMMdlCmpVCtrl * loginViewController = [[ZMMdlCmpVCtrl alloc]init];
    UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    [navigationController setNavigationBarHidden:YES];
    [self.window setRootViewController:navigationController];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.currentDownloadArray = [[NSMutableArray alloc]initWithCapacity:20];

    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if (![userDefaults objectForKey:@"hasDownloadedDictArray"]) {
        
        [userDefaults setValue:self.hasDownloadedDictArray forKey:@"hasDownloadedDictArray"];
    }
    self.hasDownloadedDictArray = [[NSMutableArray alloc]initWithArray:[userDefaults objectForKey:@"hasDownloadedDictArray"]];
    
    
    NSFileManager* fileManager =[NSFileManager defaultManager];

    
    


    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYYMMdd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];

    for (NSDictionary *dic in self.hasDownloadedDictArray) {
        if ([dateString intValue] - [dic[@"time"] intValue] >= 15) {
            for (NSString *str in dic[@"files"]) {
                
                BOOL isDelete = [fileManager removeItemAtPath:str error:nil];
                
                NSLog(@"%d",isDelete);
            }
        }
    }
    
    NSLog(@"...........................%@",self.hasDownloadedDictArray);
    
    ASINetworkQueue *que = [[ASINetworkQueue alloc] init];
    self.netWorkQueue = que;
    [que release];
    [self.netWorkQueue reset];
    [self.netWorkQueue setShowAccurateProgress:NO];

    
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
//        [self setUserDict:nil];
//        [(UINavigationController*)[self.window rootViewController] popToRootViewControllerAnimated:YES];
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

-(void)request1
{
    if (self.currentDownloadLength > 0) {
        //NSLog(@"还有文件没有下载完成");
        return;
    }else{
        self.currentDownloadLength = [self.fileArray count];
        
        //初始化Documents路径
        NSString * docPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        //初始化临时文件路径
        NSString *tempFolderPath = [docPath stringByAppendingPathComponent:@"temp"];
        //创建文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //判断temp文件夹是否存在
        BOOL fileExists = [fileManager fileExistsAtPath:tempFolderPath];
        if (!fileExists) {//如果不存在则创建,因为下载时,不会自动创建文件夹
            [fileManager createDirectoryAtPath:tempFolderPath
                   withIntermediateDirectories:YES
                                    attributes:nil
                                         error:nil];
        }
        
        //发送下载请求
        for (NSDictionary * pdfDict in self.fileArray) {
            
            NSLog(@"pdf info : %@",pdfDict);
            
            
            NSString* unitURL = [[[pdfDict valueForKey:@"unitURL"] componentsSeparatedByString:@"/"] lastObject];
            
            NSString * pdfID = [[unitURL componentsSeparatedByString:@"."] firstObject];
            //NSString *filePath = [userDocPath stringByAppendingPathComponent:unitURL];
            NSString *tempFilePath = [tempFolderPath stringByAppendingPathComponent:unitURL];
            
            
            //NSString *filePath = [[self.downloadArray objectAtIndex:index] objectForKey:@"URL"];
            NSLog(@"tempFilePath=%@",tempFilePath);
            //初始下载路径
            //NSURL *url = [NSURL URLWithString:filePath];
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kHttpRequestURL,[pdfDict valueForKey:@"unitURL"]]];
            //设置下载路径
            self.request = [[ASIHTTPRequest alloc] initWithURL:url];
            //设置ASIHTTPRequest代理
            self.request.delegate = self;
            //初始化保存ZIP文件路径
            NSString *savePath = [docPath stringByAppendingPathComponent:unitURL];
            //初始化临时文件路径
            NSString *tempPath = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"temp/%@.temp",unitURL]];
            //设置文件保存路径
            [self.request setDownloadDestinationPath:savePath];
            //设置临时文件路径
            [self.request setTemporaryFileDownloadPath:tempPath];
            //设置进度条的代理,
            //            [request setDownloadProgressDelegate:progressView];
            //设置是是否支持断点下载
            [self.request setAllowResumeForFileDownloads:YES];
            //设置基本信息
            [self.request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:pdfID,@"pdfID",nil]];
            NSLog(@"UserInfo=%@",self.request.userInfo);
            //添加到ASINetworkQueue队列去下载
            [self.netWorkQueue addOperation:self.request];
            //收回request
            //                [self.request release];
            
            [self.netWorkQueue go];
            [self.currentDownloadArray addObject:savePath];
            
        }
        
        
    }

}

#pragma mark ASIHTTPRequestDelegate method
//ASIHTTPRequestDelegate,下载之前获取信息的方法,主要获取下载内容的大小，可以显示下载进度多少字节
-(void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders{
    
    NSLog(@"didReceiveResponseHeaders-%@",[responseHeaders valueForKey:@"Content-Length"]);
    
    
    NSLog(@"contentlength=%f",request.contentLength/1024.0/1024.0);
    NSString * pdfID = [request.userInfo objectForKey:@"pdfID"] ;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    float tempConLen = [[userDefaults objectForKey:[NSString stringWithFormat:@"pdf_%@_contentLength",pdfID]] floatValue];
    NSLog(@"tempConLen=%f",tempConLen);
    //如果没有保存,则持久化他的内容大小
    if (tempConLen == 0 ) {//如果没有保存,则持久化他的内容大小
        [userDefaults setObject:[NSNumber numberWithFloat:request.contentLength/1024.0/1024.0] forKey:[NSString stringWithFormat:@"pdf_%@_contentLength",pdfID]];
    }
}

-(void) requestFinished:(ASIHTTPRequest *)request{
    NSString * pdfID = [request.userInfo objectForKey:@"pdfID"] ;
    
    self.currentDownloadLength--;
    
    NSLog(@"%@.pdf has been downloaded!",pdfID);
    NSLog(@"还有%d文件没有下载完成",self.currentDownloadLength);
    
    if (self.currentDownloadLength == 0) {
        //将当前选择的年级和课程加入userDefault中
        
        //currentDownloadLength = [fileArray count];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        self.hasDownloadedDictArray = [[NSMutableArray alloc]initWithArray:[userDefaults objectForKey:@"hasDownloadedDictArray"]];
        
        NSDate *currentDate = [NSDate date];//获取当前时间，日期
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYYMMdd"];
        NSString *dateString = [dateFormatter stringFromDate:currentDate];
        
        NSDictionary * currentGradeAndCourse = [[NSDictionary alloc]initWithObjectsAndKeys:dateString,@"time",self.grade,@"grade",
                                                self.course,@"course",self.currentDownloadArray,@"files",[(ZMAppDelegate*)[UIApplication sharedApplication].delegate fileArray],@"filesinfo",self.sort,@"sort",self.courseSort,@"courseSort",nil];
        for (NSDictionary *dic in self.hasDownloadedDictArray) {
            if ([dic[@"course"] isEqualToString:currentGradeAndCourse[@"course"]]) {
                [self.hasDownloadedDictArray removeObject:dic];
                break;
            }
        }
        
        [self.hasDownloadedDictArray addObject:currentGradeAndCourse];
        [userDefaults setValue:self.hasDownloadedDictArray forKey:@"hasDownloadedDictArray"];
        
        NSLog(@"%@",[userDefaults objectForKey:@"hasDownloadedDictArray"]);
        
        self.isdownfinsh = YES;
    }
    
}

@end
