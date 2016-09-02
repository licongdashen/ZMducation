//
//  ZMLoginViewController.m
//  ZMEducation
//
//  Created by Hunter Li on 13-5-7.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import "ZMLoginViewController.h"

#import "ZMHomeViewController.h"
#import "ZMCourseViewController.h"
#import "UIExpandingTextView.h"

#define kDeviceTokenStringKEY @"DeviceTokenString"
@implementation ZMLoginViewController

-(void)addLabel:(NSString*)text
          frame:(CGRect)frame{
    [self addLabel:text
             frame:frame
     textAlignment:NSTextAlignmentCenter
               tag:0
              size:18.0f
         textColor:[UIColor darkTextColor]
          intoView:self.view];
}

-(void)dealloc{
    [nameTF release];
    [pwTF release];
    
    [super dealloc];
}

-(void)loadView{
    [super loadView];
    
    CGRect bgFrame = CGRectMake(0, 0, 1024, 768);
    UIImage* bgImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Login_bg" ofType:@"png"]];
    UIImageView* bgView = [[UIImageView alloc] initWithFrame:bgFrame];
    [bgView setImage:bgImage];
    [self.view addSubview:bgView];
    [bgView release];
    
    CGRect bg_login_nameFrame = CGRectMake(600, 85, 204, 31);
    UIImage* bg_login_nameImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"LogoName" ofType:@"png"]];
    UIImageView* bg_login_nameView = [[UIImageView alloc] initWithFrame:bg_login_nameFrame];
    [bg_login_nameView setImage:bg_login_nameImage];
    [self.view addSubview:bg_login_nameView];
    [bg_login_nameView release];
    
    CGRect bg_login_logoFrame = CGRectMake(852, 39, 92, 77);
    UIImage* bg_login_logoImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Logo" ofType:@"png"]];
    UIImageView* bg_login_logoView = [[UIImageView alloc] initWithFrame:bg_login_logoFrame];
    [bg_login_logoView setImage:bg_login_logoImage];
    [self.view addSubview:bg_login_logoView];
    [bg_login_logoView release];
    
    UIImage* bg_loginImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"LoginWrap" ofType:@"png"]];
    UIImageView* bg_loginView = [[UIImageView alloc] initWithFrame:CGRectMake(262, 220, 499, 317)];
    [bg_loginView setImage:bg_loginImage];
    [self.view addSubview:bg_loginView];
    [bg_loginView release];
    
    [self addLabel:@"用户名:"
             frame:CGRectMake(320, 305, 100, 31)];

    UIImage* bgNameImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Textarea" ofType:@"png"]];
    UIImageView* bgNameView = [[UIImageView alloc] initWithFrame:CGRectMake(420, 300, 228, 41)];
    [bgNameView setImage:bgNameImage];
    [self.view addSubview:bgNameView];
    [bgNameView release];
    
    nameTF = [[UITextField alloc] initWithFrame:CGRectMake(430, 310, 218, 31)];
    [nameTF setBorderStyle:UITextBorderStyleNone];    
    //[nameTF setDelegate:self];
    [nameTF setPlaceholder:@"请输入用户名"];
    //[nameTF setText:@"t3"];
    //[nameTF setText:@"admin"];
    [nameTF setFont:[UIFont systemFontOfSize:19.0]];
    [nameTF setMinimumFontSize:19.0f];
    [self.view addSubview:nameTF];

    [self addLabel:@"密  码:"
             frame:CGRectMake(320, 368, 100, 31)];

    UIImage* bgPWImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Textarea" ofType:@"png"]];
    UIImageView* bgPWView = [[UIImageView alloc] initWithFrame:CGRectMake(420, 363, 228, 41)];
    [bgPWView setImage:bgPWImage];
    [self.view addSubview:bgPWView];
    [bgPWView release];
    
    pwTF = [[UITextField alloc] initWithFrame:CGRectMake(430, 373, 218, 31)];
    [pwTF setBorderStyle:UITextBorderStyleNone];
    //[pwTF setDelegate:self];
    [pwTF setPlaceholder:@"请输入密码"];
    //[pwTF setText:@"123.com"];
    [pwTF setFont:[UIFont systemFontOfSize:19.0]];
    [pwTF setMinimumFontSize:19.0];
    [pwTF setSecureTextEntry:YES];
    [self.view addSubview:pwTF];
    
    UIButton* loginBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBut setFrame:CGRectMake(420, 440, 207, 47)];
    [loginBut setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"LoginBtn" ofType:@"png"]] forState:UIControlStateNormal];
    [loginBut setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"LoginBtn" ofType:@"png"]] forState:UIControlStateHighlighted];
    [loginBut addTarget:self
                 action:@selector(loginClick:)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBut];
    
    //version
    UILabel * lb_version = [[UILabel alloc]initWithFrame:CGRectMake(0, 720, 1024, 40)];
    lb_version.backgroundColor = [UIColor clearColor];
    lb_version.text = @"V1.0(beta)";
    lb_version.textColor = [UIColor whiteColor];
    lb_version.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:lb_version];
    [lb_version release];
    
    
    
}

-(void)getGrades{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];

    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M003" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}

/*
 name : 构思模块
 
 */
-(void)getModules{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    
    //NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    NSMutableDictionary * requestDict = [[NSMutableDictionary alloc]init];
    [requestDict setValue:@"M005" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}

-(IBAction)loginClick:(id)sender{    
    if ([[nameTF text] length] == 0) {
        [self showTip:@"请输入用户名"];
    }else if([[pwTF text] length] == 0){
        [self showTip:@"请输入密码"];
    }else{
        NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
        [requestDict setValue:@"M001" forKey:@"method"];
        [requestDict setValue:[nameTF text] forKey:@"userName"];
        [requestDict setValue:[pwTF text] forKey:@"password"];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString* deviceTokenStr = [userDefaults valueForKey:kDeviceTokenStringKEY];
        //NSString * deviceTokenStr = @"1c0765d62f18470033bfc107d2a49dca922c52d44c0cf52cef9c5ca78a6c9b98";
        [requestDict setValue:deviceTokenStr forKey:@"deviceToken"];
        
        ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
        [httpEngine setDelegate:self];
        [httpEngine requestWithDict:requestDict];
        [httpEngine release];
        [requestDict release];
    }
}

#pragma mark ZMHttpEngineDelegate
-(void)httpEngine:(ZMHttpEngine *)httpEngine didSuccess:(NSDictionary *)responseDict{
    [super httpEngine:httpEngine didSuccess:responseDict];
    
    NSString* method = [responseDict valueForKey:@"method"];
    NSString* responseCode = [responseDict valueForKey:@"responseCode"];
    
    if ([@"M001" isEqualToString:method]) {
        if ([@"00" isEqualToString:responseCode]) {
            NSString* role = [responseDict valueForKey:@"role"];
            
            ((ZMAppDelegate*)[UIApplication sharedApplication].delegate).str = role;
            
            ((ZMAppDelegate*)[UIApplication sharedApplication].delegate).fileCache = [responseDict valueForKey:@"fileCache"];
            ((ZMAppDelegate*)[UIApplication sharedApplication].delegate).picCache = [responseDict valueForKey:@"picCache"];

            if ([@"02" isEqualToString:role]) {//老师
                NSString* userId = [responseDict valueForKey:@"userId"];
                NSString* status = [responseDict valueForKey:@"status"];
                NSString* fullName = [responseDict valueForKey:@"fullName"];
                
                NSMutableDictionary* userDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[nameTF text],@"userName",userId,@"userId",fullName,@"fullName",role,@"role",status,@"status",@"01",@"screenControl",@"1",@"articleMode",nil];
                // add articleMode 1:浏览模式 0:输入模式 20131026
                [(ZMAppDelegate*)[UIApplication sharedApplication].delegate setUserDict:userDict];
                
                [userDict release];
                
                [self getGrades];
            }else if([@"03" isEqualToString:role] || [@"04" isEqualToString:role]){
                //NSString* groupId = [responseDict valueForKey:@"groupId"];
                NSString* currentGradeId = [responseDict valueForKey:@"currentGradeId"];
                NSString* currentCourseId = [responseDict valueForKey:@"currentCourseId"];
                NSString* screenControl = [responseDict valueForKey:@"screenControl"];
                NSString* currentClassId = [responseDict valueForKey:@"classId"];
                NSString* userId = [responseDict valueForKey:@"userId"];
                NSString* status = [responseDict valueForKey:@"status"];
                NSString* fullName = [responseDict valueForKey:@"fullName"];
                
                NSMutableDictionary* userDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[nameTF text],@"userName",userId,@"userId",fullName,@"fullName",role,@"role",currentGradeId,@"currentGradeId",currentCourseId,@"currentCourseId",screenControl,@"screenControl", currentClassId,@"currentClassId",status,@"status",nil];
                [(ZMAppDelegate*)[UIApplication sharedApplication].delegate setUserDict:userDict];
                [userDict release];
                
                [self getModules];
            }
        }else{
            NSString* responseMessage = [responseDict valueForKey:@"responseMessage"];
            [self showTip:responseMessage];
        }
    }else if([@"M003" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        NSArray* _gradeArray = [responseDict valueForKey:@"grades"];
        for (int i=0; i<[_gradeArray count]; i++) {
            NSLog(@"grade:%@",[_gradeArray objectAtIndex:i]);
        }
        
        ZMCourseViewController* courseView = [[ZMCourseViewController alloc] init];
        [courseView setGradeArray:_gradeArray];
        [self.navigationController pushViewController:courseView animated:YES];
        [courseView release];
    }else if([@"M005" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        NSArray* _moduleArray = [responseDict valueForKey:@"modules"];
        //打印构思模块
        for (int i=0; i<[_moduleArray count]; i++) {
            NSLog(@"module:%@",[_moduleArray objectAtIndex:i]);
        }
        
        ZMHomeViewController* homeView = [[ZMHomeViewController alloc] init];
        [homeView setModuleArray:_moduleArray];
        
        [self.navigationController pushViewController:homeView animated:YES];
        [homeView release];
    }else if(![@"00" isEqualToString:responseCode]){
        [self showTip:@"服务器异常"];
    }
}

@end
