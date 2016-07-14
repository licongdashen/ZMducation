//
//  ZMMenuViewController.m
//  ZMEducation
//
//  Created by Hunter Li on 13-5-18.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//  description: 小助手菜单

#import "ZMMenuViewController.h"

@implementation ZMMenuViewController
@synthesize menuDelegate = _menuDelegate;
@synthesize screenControlOn = _screenControlOn;

/*-(IBAction)gousiClick:(id)sender{
    [_menuDelegate menuViewDidGousi:self];
}*/

/*-(IBAction)dictionaryClick:(id)sender{
    [_menuDelegate menuViewDidDictionary:self];
}*/

/*-(IBAction)ziyuankuClick:(id)sender{
    [_menuDelegate menuViewDidZiyuanku:self];
}*/

-(IBAction)bbsClick:(id)sender{
    [_menuDelegate menuViewDidBbs:self];
}

-(IBAction)closeClick:(id)sender{
    [_menuDelegate menuViewDidClose:self];
}

-(IBAction)logoutClick:(id)sender{
    [_menuDelegate menuViewDidLogout:self];
}

-(IBAction)workBrowseClick:(id)sender{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    [userDict setObject:@"1" forKey:@"articleMode"];
    [_menuDelegate menuViewDidBrowseWorks:self];
}

-(IBAction)shitiBrowseClick:(id)sender{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    [userDict setObject:@"1" forKey:@"articleMode"];
    [_menuDelegate menuViewDidBrowseShiti:self];
}


-(IBAction)wrongClick:(id)sender{
    [_menuDelegate menuViewDidBrowseWrong:self];
}

-(IBAction)feedbackClick:(id)sender{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    [userDict setObject:@"1" forKey:@"articleMode"];
    [_menuDelegate menuViewDidBrowseMyFeedback:self];
}

-(IBAction)teacherEvaluateClick:(id)sender{
    [_menuDelegate menuViewDidTeacherEvaluate:self];
}

-(IBAction)studyAccumulationClick:(id)sender{
    [_menuDelegate menuViewDidStudyAccumulation:self];
}

-(IBAction)screenControlClick:(id)sender{
    [_menuDelegate menuViewDidScreenControl:self];
}

-(void)getUserList{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M009" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"role"] forKey:@"role"];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}



-(void)loadView{
    [super loadView];
    
    CGRect bgFrame = CGRectMake(0, 0, 1024, 768);
    UIImage* bgImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Menu_bg" ofType:@"png"]];
    UIImageView* bgView = [[UIImageView alloc] initWithFrame:bgFrame];
    [bgView setImage:bgImage];
    [self.view addSubview:bgView];
    [bgView release];
    
    UIImage* assistantImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Assistant_Bg" ofType:@"png"]];
    UIImageView* assistantImageView = [[UIImageView alloc] initWithFrame:CGRectMake(17, 29, 990, 710)];
    [assistantImageView setImage:assistantImage];
    [self.view addSubview:assistantImageView];
    [assistantImageView release];
    
    UIButton* closeBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBut setFrame:CGRectMake(948, 46, 49, 49)];
    [closeBut setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Close_Btn" ofType:@"png"]] forState:UIControlStateNormal];
    [closeBut setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Close_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
    [closeBut addTarget:self
                 action:@selector(closeClick:)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBut];
    
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
     NSString* role = [userDict valueForKey:@"role"];
    if ([@"03" isEqualToString:role] || [@"04" isEqualToString:role]){
        [self addLabel:[userDict valueForKey:@"fullName"]
                 frame:CGRectMake(420, 87, 150, 30)
         textAlignment:NSTextAlignmentRight
                   tag:0
                  size:25
             textColor:[UIColor whiteColor]
              intoView:self.view];
        
        [self addLabel:[NSString stringWithFormat:@"同学的小助手(%@)",[userDict valueForKey:@"userName"]]
                 frame:CGRectMake(588, 89, 370, 30)
         textAlignment:NSTextAlignmentLeft
                   tag:0
                  size:16
             textColor:[UIColor whiteColor]
              intoView:self.view];
    }else if ([@"02" isEqualToString:role]){
        [self addLabel:[userDict valueForKey:@"fullName"]
                 frame:CGRectMake(420, 87, 150, 30)
         textAlignment:NSTextAlignmentRight
                   tag:0
                  size:25
             textColor:[UIColor whiteColor]
              intoView:self.view];
        
        [self addLabel:[NSString stringWithFormat:@"老师的小助手(%@)",[userDict valueForKey:@"userName"]]
                 frame:CGRectMake(588, 89, 370, 30)
         textAlignment:NSTextAlignmentLeft
                   tag:0
                  size:16
             textColor:[UIColor whiteColor]
              intoView:self.view];
    }
    
    UIImage* separater_lineImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Assistant_Title_line" ofType:@"png"]];
    UIImageView* separater_lineView = [[UIImageView alloc] initWithFrame:CGRectMake(36, 121, 954, 2)];
    [separater_lineView setImage:separater_lineImage];
    [self.view addSubview:separater_lineView];
    [separater_lineView release];
    
    UIImage* left_blockImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Assistant_Block_bg" ofType:@"png"]];
    UIImageView* left_blockView = [[UIImageView alloc] initWithFrame:CGRectMake(413, 183, 282, 539)];
    [left_blockView setImage:left_blockImage];
    [self.view addSubview:left_blockView];
    [left_blockView release];
    
    //  班级论坛 我的点评 作业浏览 错题集 学习积累 教师评价 屏幕控制 退出系统
    
    //班级论坛
    UIButton* bbs_But = [UIButton buttonWithType:UIButtonTypeCustom];
    [bbs_But setFrame:CGRectMake(450, 210, 190, 44)];
    [bbs_But setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Assist_Btn_Bbs" ofType:@"png"]] forState:UIControlStateNormal];
    [bbs_But setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Assist_Btn_Bbs" ofType:@"png"]] forState:UIControlStateHighlighted];
    [bbs_But addTarget:self
                  action:@selector(bbsClick:)
        forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:bbs_But];
    
 
    //我的点评
    UIButton* feedback_But = [UIButton buttonWithType:UIButtonTypeCustom];
    [feedback_But setFrame:CGRectMake(450, 265, 190, 44)];
    [feedback_But setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Feedback_Btn" ofType:@"png"]] forState:UIControlStateNormal];
    [feedback_But setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Feedback_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
    [feedback_But addTarget:self
                   action:@selector(feedbackClick:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:feedback_But];
    
    //作业浏览
    UIButton* browse_But = [UIButton buttonWithType:UIButtonTypeCustom];
    [browse_But setFrame:CGRectMake(450, 320, 190, 44)];
    [browse_But setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Browse_Btn" ofType:@"png"]] forState:UIControlStateNormal];
    [browse_But setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Browse_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
    [browse_But addTarget:self
                   action:@selector(workBrowseClick:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:browse_But];
    
    //试题浏览
    UIButton* shitiBrowse_But = [UIButton buttonWithType:UIButtonTypeCustom];
    [shitiBrowse_But setFrame:CGRectMake(450, 375, 190, 44)];
    [shitiBrowse_But setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ShitiBrowser_Btn" ofType:@"png"]] forState:UIControlStateNormal];
    [shitiBrowse_But setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ShitiBrowser_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
    [shitiBrowse_But addTarget:self
                   action:@selector(shitiBrowseClick:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shitiBrowse_But];

    //错题集
    UIButton* wrongs_But = [UIButton buttonWithType:UIButtonTypeCustom];
    [wrongs_But setFrame:CGRectMake(450, 430, 190, 44)];
    [wrongs_But setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Wrongs_Btn" ofType:@"png"]] forState:UIControlStateNormal];
    [wrongs_But setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Wrongs_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
    [wrongs_But addTarget:self
                   action:@selector(wrongClick:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wrongs_But];
    
    //学习积累
    UIButton* student_Accumulation_But = [UIButton buttonWithType:UIButtonTypeCustom];
    [student_Accumulation_But setFrame:CGRectMake(450, 485, 190, 44)];
    [student_Accumulation_But setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Study_Accumulation_Btn" ofType:@"png"]] forState:UIControlStateNormal];
    [student_Accumulation_But setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Study_Accumulation_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
    [student_Accumulation_But addTarget:self
                              action:@selector(studyAccumulationClick:)
                    forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:student_Accumulation_But];
    
    //教师评价
    UIButton* student_Evaluate__But = [UIButton buttonWithType:UIButtonTypeCustom];
    [student_Evaluate__But setFrame:CGRectMake(450, 540, 190, 44)];
    [student_Evaluate__But setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Student_Evaluate_Btn" ofType:@"png"]] forState:UIControlStateNormal];
    [student_Evaluate__But setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Student_Evaluate_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
    [student_Evaluate__But addTarget:self
                       action:@selector(teacherEvaluateClick:)
             forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:student_Evaluate__But];
    
    //退出系统
    UIButton* logout_But = [UIButton buttonWithType:UIButtonTypeCustom];
    [logout_But setFrame:CGRectMake(450, 650, 194, 44)];
    [logout_But setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Logoff_Btn" ofType:@"png"]] forState:UIControlStateNormal];
    [logout_But setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Logoff_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
    [logout_But addTarget:self
                   action:@selector(logoutClick:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logout_But];
    
    if ([@"02" isEqualToString:role]){
        //屏幕控制
        UIButton* screen_But = [UIButton buttonWithType:UIButtonTypeCustom];
        [screen_But setFrame:CGRectMake(450, 595, 194, 44)];
        [screen_But setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ScreenControl_Button" ofType:@"png"]] forState:UIControlStateNormal];
        [screen_But setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ScreenControl_Button" ofType:@"png"]] forState:UIControlStateHighlighted];
        [screen_But addTarget:self
                       action:@selector(screenControlClick:)
             forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:screen_But];
        
        userArray = [[NSMutableArray alloc] initWithCapacity:10];
        userTableView = [[UITableView alloc] initWithFrame:CGRectMake(723.0f, 183, 243, 539) style:UITableViewStylePlain];
        [userTableView setDelegate:self];
        [userTableView setDataSource:self];
        [userTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [userTableView setBackgroundColor:[UIColor clearColor]];
        
        UIImage* right_blockImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Assistant_right_Block_bg" ofType:@"png"]];
        UIImageView* right_blockView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 243, 539)];
        [right_blockView setImage:right_blockImage];
        
        [userTableView setBackgroundView:right_blockView];
        [right_blockView release];
        [self.view addSubview:userTableView];
        
        [self getUserList];
    }
}

#pragma mark applicationDidEnterBackground methods
-(void)applicationDidEnterBackground:(NSNotification *)notification{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter]  addObserver:self
                                              selector:@selector(applicationDidEnterBackground:)
                                                  name:@"applicationDidEnterBackground"
                                                object:nil];

}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [userTableView setDelegate:nil];
    [userTableView setDataSource:nil];
    [userTableView release];
    [userArray release];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"applicationDidEnterBackground"
                                                  object:nil];

    [super dealloc];
}
#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [userArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"AISRegularEntityCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }else{
        for (UIView *subView in [cell.contentView subviews]){
			[subView removeFromSuperview];
		}
    }
        
    NSDictionary* userDict = [userArray objectAtIndex:indexPath.row];
    
    UIImage* photoImage = nil;
    NSString* status = [userDict valueForKey:@"status"];
    if ([@"01" isEqualToString:status]) {
        photoImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Student_Status_Online" ofType:@"png"]];
    }else if([@"02" isEqualToString:status]){
        photoImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Student_Status_Offline" ofType:@"png"]];
    }
    UIImageView* photoView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 9, 30, 26)];
    [photoView setImage:photoImage];
    [cell.contentView addSubview:photoView];
    [photoView release];

    [self addLabel:[userDict valueForKey:@"userName"]
             frame:CGRectMake(60, 7, 200, 30)
     textAlignment:NSTextAlignmentLeft
               tag:0
              size:14
         textColor:[UIColor darkTextColor]
          intoView:cell.contentView];
    
    UIImage* separater_lineImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Student_Separate_line" ofType:@"png"]];
    UIImageView* separater_lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, cell.contentView.frame.size.height - 1.0, cell.contentView.frame.size.width, 1)];
    [separater_lineView setImage:separater_lineImage];
    [cell.contentView addSubview:separater_lineView];
    [separater_lineView release];

    return cell;
}

#pragma mark - Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark ZMHttpEngineDelegate
-(void)httpEngine:(ZMHttpEngine *)httpEngine didSuccess:(NSDictionary *)responseDict{
    [super httpEngine:httpEngine didSuccess:responseDict];
    
    NSString* method = [responseDict valueForKey:@"method"];
    NSString* responseCode = [responseDict valueForKey:@"responseCode"];
    if ([@"M009" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        NSArray* _studentArray = [responseDict valueForKey:@"students"];
        for (int i=0; i<[_studentArray count]; i++) {
            NSLog(@"student:%@",[_studentArray objectAtIndex:i]);
            [userArray addObject:[_studentArray objectAtIndex:i]];
        }
        
        [userTableView reloadData];
    }else if(![@"00" isEqualToString:responseCode]){
        [self showTip:@"服务器异常"];
    }
}

@end
