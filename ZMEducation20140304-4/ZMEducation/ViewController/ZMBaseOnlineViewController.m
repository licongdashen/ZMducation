//
//  ZMBaseOnlineViewController.m
//  ZMEducation
//
//  Created by Hunter Li on 13-5-20.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import "ZMMenuViewController.h"
#import "ZMBaseOnlineViewController.h"
#import "ZMWorkBrowseViewController.h"
#import "ZMWrongViewController.h"
#import "ZMMyFeedbackViewController.h"
#import "ZMTeacherEvaluateViewController.h"
#import "ZMStudyAccumulationViewController.h"
#import "ZMScreenControlViewController.h"
#import "ZMSwipeViewController.h"
#import "ZMGousiSwipeViewController.h"
#import "ZMShitiSwipeViewController.h"
#import "ZMShitiBrowseViewController.h"
#import "ZMMdlZcdVCtrl.h"
#import "ZMMdlZykVCtrl.h"
#import "ZMMdlBbsVCtrl.h" 



//add 20131025

#import "ZMArticleViewController.h"
#import "ZMArticleView01Controller.h"
#import "ZMArticleView02Controller.h"
#import "ZMArticleView03Controller.h"
#import "ZMArticleView04Controller.h"
#import "ZMArticleView05Controller.h"
#import "ZMArticleView06Controller.h"
#import "ZMArticleView07Controller.h"
#import "ZMWriteGuideViewController.h"
#import "ZMCheckItemViewController.h"

//模板 add 20131003
#import "ZMMdlCmpVCtrl.h"
#import "ZMMdlExplainVCtrl.h"
#import "ZMMdlTopicVCtrl.h"
#import "ZMMdlSliderVCtrl.h"
#import "ZMMdlStoryVCtrl.h"
#import "ZMMdlTravelVCtrl.h"
#import "ZMMdlConceptionVCtrl.h"
#import "ZMZuoYeViewController.h"
#import "ZMwodeshoucangViewController.h"
#import "ZMpengyouquanViewController.h"

//add 20131025

@interface ZMBaseOnlineViewController ()<ZMMenuViewCOntrollerDelegate,ZMMdlZcdVCtrlDelegate,ZMGousiSwipeViewControllerDelegate,ZMShitiSwipeViewControllerDelegate>

@property BOOL timuhidden;

@end

@implementation ZMBaseOnlineViewController


-(void)screenLocked{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSString* screenControl = [userDict valueForKey:@"screenControl"];
    NSString* role = [userDict valueForKey:@"role"];
    
    if([@"03" isEqualToString:role] || [@"04" isEqualToString:role]){
        if ([@"00" isEqualToString:screenControl]) {
            return;
        }
    }
}

-(IBAction)backClick:(id)sender{
    [self screenLocked];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setBackgroundView{
    CGRect bgFrame = CGRectMake(0, 0, 1024, 768);
    UIImage* bgImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Menu_bg" ofType:@"png"]];
    UIImageView* bgView = [[UIImageView alloc] initWithFrame:bgFrame];
    [bgView setImage:bgImage];
    [self.view insertSubview:bgView atIndex:0];
    [bgView release];
}

-(void)loadView{
    [super loadView];
    
    self.timuhidden = YES;
    [self setBackgroundView];
}

-(void)menuViewDidStudyAccumulation:(ZMMenuViewController *)viewController{
    [viewController dismissViewControllerAnimated:YES completion:^{
        NSString * controller = @"ZMStudyAccumulationViewController";
        if (![NSStringFromClass([self class]) isEqualToString:controller] ) {
            NSInteger currentIndex = -1;
            NSArray* arr = [[NSArray alloc] initWithArray:[self.navigationController viewControllers]];
            for(int i=0 ; i<[arr count] ; i++){
                if([[arr objectAtIndex:i] isKindOfClass:NSClassFromString(controller)]){
                    currentIndex = i;
                    break;
                }
            }
            
            if (currentIndex == -1) {
                ZMStudyAccumulationViewController* studyAccumulationView = [[ZMStudyAccumulationViewController alloc] init];
                [self.navigationController pushViewController:studyAccumulationView animated:YES];
                [studyAccumulationView release];
            }else{
                [self.navigationController popToViewController:[arr objectAtIndex:currentIndex] animated:YES];
            }
            
            [arr release];
        }
    }];
}

-(void)menuViewDidTeacherEvaluate:(ZMMenuViewController *)viewController{
    [viewController dismissViewControllerAnimated:YES completion:^{
        NSString * controller = @"ZMTeacherEvaluateViewController";
        if (![NSStringFromClass([self class]) isEqualToString:controller] ) {
            NSInteger currentIndex = -1;
            NSArray* arr = [[NSArray alloc] initWithArray:[self.navigationController viewControllers]];
            for(int i=0 ; i<[arr count] ; i++){
                if([[arr objectAtIndex:i] isKindOfClass:NSClassFromString(controller)]){
                    currentIndex = i;
                    break;
                }
            }
            
            if (currentIndex == -1) {
                ZMTeacherEvaluateViewController* teacherEvaluateView = [[ZMTeacherEvaluateViewController alloc] init];
                [self.navigationController pushViewController:teacherEvaluateView animated:YES];
                [teacherEvaluateView release];
            }else{
                [self.navigationController popToViewController:[arr objectAtIndex:currentIndex] animated:YES];
            }
            
            [arr release];
        }
    }];
}

-(void)menuViewDidBrowseWrong:(ZMMenuViewController *)viewController{
    [viewController dismissViewControllerAnimated:YES completion:^{        
        NSString * controller = @"ZMWrongViewController";
        if (![NSStringFromClass([self class]) isEqualToString:controller] ) {
            NSInteger currentIndex = -1;
            NSArray* arr = [[NSArray alloc] initWithArray:[self.navigationController viewControllers]];
            for(int i=0 ; i<[arr count] ; i++){
                if([[arr objectAtIndex:i] isKindOfClass:NSClassFromString(controller)]){
                    currentIndex = i;
                    break;
                }
            }
            
            if (currentIndex == -1) {
                ZMWrongViewController* wrongBrowseView = [[ZMWrongViewController alloc] init];
                [self.navigationController pushViewController:wrongBrowseView animated:YES];
                [wrongBrowseView release];
            }else{
                [self.navigationController popToViewController:[arr objectAtIndex:currentIndex] animated:YES];
            }
            
            [arr release];
        }
    }];
}

-(void)menuViewDidBrowseWorks:(ZMMenuViewController *)viewController{
    [viewController dismissViewControllerAnimated:YES completion:^{                
        NSString * controller = @"ZMWorkBrowseViewController";
        if (![NSStringFromClass([self class]) isEqualToString:controller] ) {
            NSInteger currentIndex = -1;
            NSArray* arr = [[NSArray alloc] initWithArray:[self.navigationController viewControllers]];
            for(int i=0 ; i<[arr count] ; i++){
                if([[arr objectAtIndex:i] isKindOfClass:NSClassFromString(controller)]){
                    currentIndex = i;
                    break;
                }
            }
            
            if (currentIndex == -1) {
                ZMWorkBrowseViewController* workBrowseView = [[ZMWorkBrowseViewController alloc] init];
                [self.navigationController pushViewController:workBrowseView animated:YES];
                [workBrowseView release];
            }else{
                [self.navigationController popToViewController:[arr objectAtIndex:currentIndex] animated:YES];
            }
            
            [arr release];
        }
    }];
}

-(void)menuViewDidBrowseShiti:(ZMMenuViewController *)viewController{
    
    zmvc = viewController;
        CT = examination;
        NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
        NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
        [requestDict setValue:@"M066" forKey:@"method"];
        [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
        [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
        
        ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
        [httpEngine setDelegate:self];
        [httpEngine requestWithDict:requestDict];
        [httpEngine release];
        [requestDict release];
    
    
    
    /*[viewController dismissViewControllerAnimated:YES completion:^{
        NSString * controller = @"ZMShitiBrowseViewController";
        if (![NSStringFromClass([self class]) isEqualToString:controller] ) {
            NSInteger currentIndex = -1;
            NSArray* arr = [[NSArray alloc] initWithArray:[self.navigationController viewControllers]];
            for(int i=0 ; i<[arr count] ; i++){
                if([[arr objectAtIndex:i] isKindOfClass:NSClassFromString(controller)]){
                    currentIndex = i;
                    break;
                }
            }
            
            if (currentIndex == -1) {
               Shiti_Type = 1;
                
                NSMutableDictionary * userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
                NSMutableDictionary * requestDict = [[NSMutableDictionary alloc]init];
                
                [requestDict setValue:@"M061" forKey:@"method"];
                
                [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
                [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
                
                ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
                [httpEngine setDelegate:self];
                [httpEngine requestWithDict:requestDict];
                [httpEngine release];
                [requestDict release];
            }else{
                [self.navigationController popToViewController:[arr objectAtIndex:currentIndex] animated:YES];
            }
            
            [arr release];
        }
    }];*/
   

}

-(void)menuViewDidBrowseMyFeedback:(ZMMenuViewController *)viewController{
    [viewController dismissViewControllerAnimated:YES completion:^{        
        NSString * controller = @"ZMMyFeedbackViewController";
        if (![NSStringFromClass([self class]) isEqualToString:controller] ) {
            NSInteger currentIndex = -1;
            NSArray* arr = [[NSArray alloc] initWithArray:[self.navigationController viewControllers]];
            for(int i=0 ; i<[arr count] ; i++){
                if([[arr objectAtIndex:i] isKindOfClass:NSClassFromString(controller)]){
                    currentIndex = i;
                    break;
                }
            }
            
            if (currentIndex == -1) {
                ZMMyFeedbackViewController* myFeedbackView = [[ZMMyFeedbackViewController alloc] init];
                [self.navigationController pushViewController:myFeedbackView animated:YES];
                [myFeedbackView release];
            }else{
                [self.navigationController popToViewController:[arr objectAtIndex:currentIndex] animated:YES];
            }
            
            [arr release];
        }
    }];
}




//点击班级论坛
-(void)menuViewDidBbs:(ZMMenuViewController *)viewController{
[viewController dismissViewControllerAnimated:YES completion:^{    
    ZMMdlBbsVCtrl * bbsViewCtrl = [[ZMMdlBbsVCtrl alloc]init];
    [self.navigationController pushViewController:bbsViewCtrl animated:YES];
  }];   
}

//关闭小助手
-(void)menuViewDidClose:(ZMMenuViewController *)viewController{
    [viewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//关闭字词典
-(void)zcdViewDidClose:(ZMMdlZcdVCtrl *)viewController{
    [viewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
//关闭资源库
-(void)zykViewDidClose:(ZMMdlZykVCtrl *)viewController{
    [viewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}




//关闭我的构思
-(void)ZMGousiSwipeViewDidClose:(ZMGousiSwipeViewController *)viewController{
    [viewController dismissViewControllerAnimated:YES completion:^{
        
        NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
        [userDict setObject:@"1" forKey:@"articleMode"];
        
    }];
}

//关闭我的试题
-(void)ZMShitiSwipeViewDidClose:(ZMShitiSwipeViewController *)viewController{
    [viewController dismissViewControllerAnimated:YES completion:^{
        
        
        
    }];
}

-(void)menuViewDidScreenControl:(ZMMenuViewController *)viewController{
    [viewController dismissViewControllerAnimated:YES completion:^{        
        NSString * controller = @"ZMScreenControlViewController";
        if (![NSStringFromClass([self class]) isEqualToString:controller] ) {
            NSInteger currentIndex = -1;
            NSArray* arr = [[NSArray alloc] initWithArray:[self.navigationController viewControllers]];
            for(int i=0 ; i<[arr count] ; i++){
                if([[arr objectAtIndex:i] isKindOfClass:NSClassFromString(controller)]){
                    currentIndex = i;
                    break;
                }
            }
            
            if (currentIndex == -1) {
                ZMScreenControlViewController* screenControlView = [[ZMScreenControlViewController alloc] init];
                [self.navigationController pushViewController:screenControlView animated:YES];
                [screenControlView release];
            }else{
                [self.navigationController popToViewController:[arr objectAtIndex:currentIndex] animated:YES];
            }
            
            [arr release];
        }
    }];
}

-(void)menuViewDidLogout:(ZMMenuViewController *)viewController{
    [viewController dismissViewControllerAnimated:YES completion:^{
        NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
        
        NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
        [requestDict setValue:@"M002" forKey:@"method"];
        [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
        
        ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
        [httpEngine setDelegate:self];
        [httpEngine requestWithDict:requestDict];
        [httpEngine release];
        [requestDict release];
    }];
}

//点击第二个菜单按钮：小助手，小助手里面的按钮事件有本页面代理
-(IBAction)menuButXiaozhushouClick:(id)sender{
    ZMMenuViewController* menuView = [[ZMMenuViewController alloc] init];
    [menuView setMenuDelegate:self];
    
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSString* screenControl = [userDict valueForKey:@"screenControl"];
    if ([@"00" isEqualToString:screenControl]) {
        [menuView setScreenControlOn:YES];
    }else{
        [menuView setScreenControlOn:NO];
    }
    
    [self presentViewController:menuView animated:YES completion:NULL];
    [menuView release];
}

//字词典
-(IBAction)menuButZidianClick:(id)sender{
    
    M066 = YES;
    CT = dictionary;
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M066" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
    
    
}


-(void)menuButquanziClick:(id)sender{
    
    ZMpengyouquanViewController *vc = [[ZMpengyouquanViewController alloc]init];
//    [self presentViewController:vc animated:YES completion:NULL];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)menuButshoucangClick:(id)sender{

    ZMwodeshoucangViewController *vc = [[ZMwodeshoucangViewController alloc]init];
    [self presentViewController:vc animated:YES completion:NULL];

}

//我的构思

-(IBAction)menuButGousiClick:(id)sender{
    
    Gousi044_Type = 1; // 直接点我的构思
    
    //先拿到构思列表，然后加载第一个模板
    
    [ZMAppDelegate App].isjinru = @"0";
    [[ZMAppDelegate App].userDict setValue:@"02" forKey:@"currentModuleId"];
    NSMutableDictionary * userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary * requestDict = [[NSMutableDictionary alloc]init];
    
    [requestDict setValue:@"M044" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];

}



//我的试题

-(IBAction)menuButShitiClick:(id)sender{
    
    Shiti_Type = 0;
   
    self.timuhidden = NO;
    CT = shitiyincang;
    
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M066" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
    
}


- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
//    UIButton* menuButquanzi = [UIButton buttonWithType:UIButtonTypeCustom]; //我的构思
//    [menuButquanzi setFrame:CGRectMake(710 - 60 - 60, -5, 44, 68)];
//    [menuButquanzi setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Menu_btn_gousi" ofType:@"png"]] forState:UIControlStateNormal];
//    [menuButquanzi setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Menu_btn_gousi" ofType:@"png"]] forState:UIControlStateHighlighted];
//    [menuButquanzi addTarget:self
//                        action:@selector(menuButquanziClick:)
//              forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:menuButquanzi];
//    self.menuButquanzi = menuButquanzi;
    
    UIButton* menuButshoucang = [UIButton buttonWithType:UIButtonTypeCustom]; //我的构思
    [menuButshoucang setFrame:CGRectMake(710 - 60, -5, 44, 68)];

    [menuButshoucang setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon_aaaa" ofType:@"png"]] forState:UIControlStateNormal];
    [menuButshoucang setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon_aaaa" ofType:@"png"]] forState:UIControlStateHighlighted];
    [menuButshoucang addTarget:self
                     action:@selector(menuButshoucangClick:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:menuButshoucang];
    self.menuButshoucang = menuButshoucang;
    
    UIButton* menuButGousi = [UIButton buttonWithType:UIButtonTypeCustom]; //我的构思
    [menuButGousi setFrame:CGRectMake(710, -5, 44, 68)];
    [menuButGousi setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Menu_btn_gousi" ofType:@"png"]] forState:UIControlStateNormal];
    [menuButGousi setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Menu_btn_gousi" ofType:@"png"]] forState:UIControlStateHighlighted];
    [menuButGousi addTarget:self
                 action:@selector(menuButGousiClick:)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:menuButGousi];
    self.menuButGousi = menuButGousi;
    
    UIButton* menuButShiti = [UIButton buttonWithType:UIButtonTypeCustom]; //我的试题
    [menuButShiti setFrame:CGRectMake(770, -5, 44, 68)];
    [menuButShiti setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Menu_btn_shiti" ofType:@"png"]] forState:UIControlStateNormal];
    [menuButShiti setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Menu_btn_shiti" ofType:@"png"]] forState:UIControlStateHighlighted];
    [menuButShiti addTarget:self
                 action:@selector(menuButquanziClick:)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:menuButShiti];
    self.menuButShiti = menuButShiti;
    
    UIButton* menuButZidian = [UIButton buttonWithType:UIButtonTypeCustom]; //字词典
    [menuButZidian setFrame:CGRectMake(830, -5, 44, 68)];
    [menuButZidian setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Menu_btn_zidian" ofType:@"png"]] forState:UIControlStateNormal];
    [menuButZidian setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Menu_btn_zidian" ofType:@"png"]] forState:UIControlStateHighlighted];
        [menuButZidian addTarget:self
                    action:@selector(menuButZidianClick:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:menuButZidian];
    self.menuButZidian = menuButZidian;
    
    
    
    UIButton* menuButXiaozhushou = [UIButton buttonWithType:UIButtonTypeCustom]; //小助手
    [menuButXiaozhushou setFrame:CGRectMake(890, -5, 44, 68)];
    [menuButXiaozhushou setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Menu_btn_xiaozhushou" ofType:@"png"]] forState:UIControlStateNormal];
    [menuButXiaozhushou setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Menu_btn_xiaozhushou" ofType:@"png"]] forState:UIControlStateHighlighted];
    [menuButXiaozhushou addTarget:self
                action:@selector(menuButXiaozhushouClick:)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:menuButXiaozhushou];
    self.menuButXiaozhushou = menuButXiaozhushou;
    
    UIButton* backBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBut setFrame:CGRectMake(950, 10, 47, 47)];
    [backBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Back_Btn" ofType:@"png"]] forState:UIControlStateNormal];
    [backBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Back_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
    [backBut addTarget:self
                action:@selector(backClick:)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBut];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self
                                              selector:@selector(screenControlDidChange:)
                                                  name:@"screenControlDidChangeNotification"
                                                object:nil];
}

#pragma mark screenControlDidChangeNotification methods
-(void)screenControlDidChange:(NSNotification *)notification{

}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"screenControlDidChangeNotification"
                                                  object:nil];
    
    [super dealloc];
}





#pragma mark ZMHttpEngineDelegate
-(void)httpEngine:(ZMHttpEngine *)httpEngine didSuccess:(NSDictionary *)responseDict{
    [super httpEngine:httpEngine didSuccess:responseDict];
    
    NSString* method = [responseDict valueForKey:@"method"];
    NSString* responseCode = [responseDict valueForKey:@"responseCode"];
    if ([@"M002" isEqualToString:method] && [@"00" isEqualToString:responseCode])
    {
        [(ZMAppDelegate*)[UIApplication sharedApplication].delegate setUserDict:nil];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else if ([@"M044" isEqualToString:method] && [@"00" isEqualToString:responseCode])
    { //获取构思列表
        
        //NSMutableArray * dataSource = [[NSMutableArray alloc]initWithArray:[responseDict valueForKey:@"units"]];
        NSArray* dataSource = [responseDict valueForKey:@"units"];
        NSMutableArray * dataSourceArr = [[NSMutableArray alloc]init];
        if ([dataSource count] > 0) {
            if (Gousi044_Type == 1) {
                
                for (NSDictionary * item in dataSource) {
                    NSDictionary * _item = [[NSDictionary alloc]initWithObjectsAndKeys:
                                            [item valueForKey:@"designTitle"],@"unitTitle",
                                            [item valueForKey:@"designBrief"],@"unitBrief",
                                            [item valueForKey:@"articleType"],@"articleType",
                                            [item valueForKey:@"designId"],@"unitId",
                                            @"04",@"unitType",
                                            nil];
                    [dataSourceArr addObject:_item];
                }
                
                ZMGousiSwipeViewController * vc = [[ZMGousiSwipeViewController alloc] init];
                [vc setDelegate:self];
                [vc setUnitArray:dataSourceArr];
                [self presentViewController:vc animated:YES completion:NULL];
                [vc release];
            }
        }else{
            
            NSMutableDictionary * userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
            //NSString * courseID = @"";
            /*if (isGetForumByCourse) {
             courseID = [Course_Arr[selectCourseIndex] valueForKey:@"courseId"];
             }
             else
             {*/
            NSString * courseID = [userDict valueForKey:@"currentCourseId"];
            
            // }
            
            NSMutableDictionary * requestDict = [[NSMutableDictionary alloc]init];
            [requestDict setValue:@"M051" forKey:@"method"];
            [requestDict setValue:courseID forKey:@"courseId"];
            
            [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
            [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
            ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
            [httpEngine setDelegate:self];
            [httpEngine requestWithDict:requestDict];
            [httpEngine release];
            [requestDict release];
            
        }
        
    }
    else if ([@"M061" isEqualToString:method] && [@"00" isEqualToString:responseCode])
    { //获取试题列表

        
        //NSArray* dataSource = [responseDict valueForKey:@"units"];
        NSMutableArray * dataSource = [[NSMutableArray alloc]initWithArray:[responseDict valueForKey:@"units"]];
        if ([dataSource count] > 0) {
            
            if (Shiti_Type == 0) {
                ZMShitiSwipeViewController * vc = [[ZMShitiSwipeViewController alloc] init];
                [vc setDelegate:self];
                [vc setUnitArray:dataSource];
                [self presentViewController:vc animated:YES completion:NULL];
                [vc release];
            }else {
                ZMShitiBrowseViewController* shitiBrowseView = [[ZMShitiBrowseViewController alloc] init];
                [shitiBrowseView setUnitArray:dataSource];
                 [self.navigationController pushViewController:shitiBrowseView animated:YES];
                 [shitiBrowseView release];
            }
            
        }else{
            
            NSString * str = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate isjinru];
            
            if (![str isEqualToString:@"1"]) {
                NSMutableDictionary * userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
                NSMutableDictionary * requestDict = [[NSMutableDictionary alloc]init];
                
                [requestDict setValue:@"M069" forKey:@"method"];
                
                [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
                [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
                
                ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
                [httpEngine setDelegate:self];
                [httpEngine requestWithDict:requestDict];
                [httpEngine release];
                [requestDict release];
            }
            [self showTip:@"没有内容！"];
        }
    }
    else if ([@"M066" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        /*if (M066) {
            NSString * dicStatusStr = [responseDict valueForKey:@"dictionary"];
            
            NSString * libStatusStr = [responseDict valueForKey:@"library"];
            if([@"01" isEqualToString:dicStatusStr]){
                ZMMdlZcdVCtrl * zcdViewCtrl = [[ZMMdlZcdVCtrl alloc] init];
                [zcdViewCtrl setZcdDelegate:self];
                UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:zcdViewCtrl];
                navigationController.navigationBarHidden = YES;
                [self presentViewController:navigationController animated:YES completion:NULL];
                [zcdViewCtrl release];
            }else if([@"01" isEqualToString:libStatusStr]){
                ZMMdlZykVCtrl * zykViewCtrl = [[ZMMdlZykVCtrl alloc] init];
                [zykViewCtrl setDelegate:self];
                UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:zykViewCtrl];
                navigationController.navigationBarHidden = YES;
                [self presentViewController:navigationController animated:YES completion:NULL];
                [zykViewCtrl release];
            }else{
                [self showTip:@"暂无内容！"];
            }

        }*/
        if (self.timuhidden == NO && CT == shitiyincang) {
            NSString * exaStatusStr = [responseDict valueForKey:@"examQuestions"];
            if ([exaStatusStr isEqualToString:@"01"]) {
                
                NSMutableDictionary * userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
                NSMutableDictionary * requestDict = [[NSMutableDictionary alloc]init];
                
                [requestDict setValue:@"M061" forKey:@"method"];
                
                [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
                [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
                
                ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
                [httpEngine setDelegate:self];
                [httpEngine requestWithDict:requestDict];
                [httpEngine release];
                [requestDict release];
            }else {
                [self showTip:@"暂无内容！"];
                
            }
            return;
        }
        
        if (CT == dictionary) {
            NSString * dicStatusStr = [responseDict valueForKey:@"dictionary"];
            NSString * libStatusStr = [responseDict valueForKey:@"library"];
            if([@"01" isEqualToString:dicStatusStr]){
                ZMMdlZcdVCtrl * zcdViewCtrl = [[ZMMdlZcdVCtrl alloc] init];
                [zcdViewCtrl setZcdDelegate:self];
                UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:zcdViewCtrl];
                navigationController.navigationBarHidden = YES;
                [self presentViewController:navigationController animated:YES completion:NULL];
                [zcdViewCtrl release];
            }else if([@"01" isEqualToString:libStatusStr]){
                ZMMdlZykVCtrl * zykViewCtrl = [[ZMMdlZykVCtrl alloc] init];
                [zykViewCtrl setDelegate:self];
                UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:zykViewCtrl];
                navigationController.navigationBarHidden = YES;
                [self presentViewController:navigationController animated:YES completion:NULL];
                [zykViewCtrl release];
            }else {
                [self showTip:@"暂无内容！"];
            }
        }else if (CT == examination){
            
            NSString * exaStatusStr = [responseDict valueForKey:@"examination"];
            if([@"01" isEqualToString:exaStatusStr]){
                [zmvc dismissViewControllerAnimated:YES completion:^{
                    NSString * controller = @"ZMShitiBrowseViewController";
                    if (![NSStringFromClass([self class]) isEqualToString:controller] ) {
                        NSInteger currentIndex = -1;
                        NSArray* arr = [[NSArray alloc] initWithArray:[self.navigationController viewControllers]];
                        for(int i=0 ; i<[arr count] ; i++){
                            if([[arr objectAtIndex:i] isKindOfClass:NSClassFromString(controller)]){
                                currentIndex = i;
                                break;
                            }
                        }
                        
                        if (currentIndex == -1) {
                            Shiti_Type = 1;
                            
                            NSMutableDictionary * userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
                            NSMutableDictionary * requestDict = [[NSMutableDictionary alloc]init];
                            
                            [requestDict setValue:@"M061" forKey:@"method"];
                            
                            [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
                            [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
                            
                            ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
                            [httpEngine setDelegate:self];
                            [httpEngine requestWithDict:requestDict];
                            [httpEngine release];
                            [requestDict release];
                        }else{
                            [self.navigationController popToViewController:[arr objectAtIndex:currentIndex] animated:YES];
                        }
                        
                        [arr release];
                    }
                }];
            }
            else{
                [zmvc showTip:@"暂无内容！"];
            }
        }
    }else if ([@"M051" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        
        NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:[responseDict valueForKey:@"forumTitles"]];
        if ([arr count] > 0) {
            ZMMdlBbsVCtrl * bbsViewCtrl = [[ZMMdlBbsVCtrl alloc]init];
            [self presentViewController:bbsViewCtrl animated:YES completion:NULL];
        }else{
            
            NSMutableDictionary * userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
            NSMutableDictionary * requestDict = [[NSMutableDictionary alloc]init];
            
            [requestDict setValue:@"M061" forKey:@"method"];
            
            [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
            [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
            
            ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
            [httpEngine setDelegate:self];
            [httpEngine requestWithDict:requestDict];
            [httpEngine release];
            [requestDict release];

            
        }
        
    }else if ([@"M069" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
    
        NSMutableArray * dataSource = [[NSMutableArray alloc]initWithArray:[responseDict valueForKey:@"units"]];
        if ([dataSource count] > 0) {
            
            ZMZuoYeViewController * vc = [[ZMZuoYeViewController alloc] init];
            //                [vc setDelegate:self];
            vc.unitArray = dataSource;
            [self presentViewController:vc animated:YES completion:NULL];
            
        }else{
            
            [self showTip:@"没有内容！"];
            
        }

    }


}

@end
