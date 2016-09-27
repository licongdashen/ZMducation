//
//  ZMMyFeedbackViewController.m
//  ZMEducation
//
//  Created by Hunter Li on 13-6-3.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import "ZMCheckItemViewController.h"
#import "ZMWriteGuideViewController.h"

#import "ZMFeedbackDetailViewController.h"

#import "ZMArticleViewController.h"
#import "ZMArticleView01Controller.h"
#import "ZMArticleView02Controller.h"
#import "ZMArticleView03Controller.h"
#import "ZMArticleView04Controller.h"
#import "ZMArticleView05Controller.h"
#import "ZMArticleView06Controller.h"
#import "ZMArticleView07Controller.h"

//模板 add 20131003
#import "ZMMdlCmpVCtrl.h"
#import "ZMMdlExplainVCtrl.h"
#import "ZMMdlTopicVCtrl.h"
#import "ZMMdlSliderVCtrl.h"
#import "ZMMdlStoryVCtrl.h"
#import "ZMMdlTravelVCtrl.h"
#import "ZMMdlConceptionVCtrl.h"
#import "ZMdianyingzuoyeViewController.h"

#import "ZMMyFeedbackViewController.h"
#define kTagCourseSelectBtn 1100
#define kTagModuleSelectBtn 1110
#define kTagStudentSelectBtn 1111

#define kTagCourseTableView 1200
#define kTagModuleTableView 1210
#define kTagStudentTableView 1211
#define kTagFeedbackTableView 1224

@implementation ZMMyFeedbackViewController

-(IBAction)studentSelectClick:(id)sender{
    UITableViewController *tableViewController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    CGRect frame = CGRectMake(0, 0, 100, 240);
    UITableView* studentTableView = [[UITableView alloc] initWithFrame:frame];
    [studentTableView setTag:kTagStudentTableView];
    studentTableView.delegate = self;
    studentTableView.dataSource = self;
    [tableViewController setTableView:studentTableView];
    [studentTableView release];
    
    popoverViewController = [[JHPopoverViewController alloc] initWithViewController:tableViewController andContentSize:frame.size];
    [popoverViewController presentPopoverFromRect:[(UIButton*)sender frame] inView:self.view animated:YES];
    [tableViewController release];
}

-(IBAction)courseSelectClick:(id)sender{
    UITableViewController *tableViewController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    CGRect frame = CGRectMake(0, 0, 310, 240);
    UITableView* courseTableView = [[UITableView alloc] initWithFrame:frame];
    [courseTableView setTag:kTagCourseTableView];
    courseTableView.delegate = self;
    courseTableView.dataSource = self;
    [tableViewController setTableView:courseTableView];
    [courseTableView release];
    
    popoverViewController = [[JHPopoverViewController alloc] initWithViewController:tableViewController andContentSize:frame.size];
    [popoverViewController presentPopoverFromRect:[(UIButton*)sender frame] inView:self.view animated:YES];
    [tableViewController release];
}

-(IBAction)moduleSelectClick:(id)sender{
    UITableViewController *tableViewController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    CGRect frame = CGRectMake(0, 0, 90, 240);
    UITableView* moduleTableView = [[UITableView alloc] initWithFrame:frame];
    [moduleTableView setTag:kTagModuleTableView];
    moduleTableView.delegate = self;
    moduleTableView.dataSource = self;
    [tableViewController setTableView:moduleTableView];
    [moduleTableView release];
    
    popoverViewController = [[JHPopoverViewController alloc] initWithViewController:tableViewController andContentSize:frame.size];
    [popoverViewController presentPopoverFromRect:[(UIButton*)sender frame] inView:self.view animated:YES];
    [tableViewController release];
}

-(IBAction)queryClick:(id)sender{
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSString* role = [userDict valueForKey:@"role"];
    if([@"03" isEqualToString:role] || [@"04" isEqualToString:role]){
        [requestDict setValue:@"M028" forKey:@"method"];
        [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"partnerId"];
    }else if([@"02" isEqualToString:role]){
        [requestDict setValue:@"M041" forKey:@"method"];
    }
    [requestDict setValue:[[courseArray objectAtIndex:selectCourseIndex] valueForKey:@"courseId"] forKey:@"courseId"];
    [requestDict setValue:[[moduleArray objectAtIndex:selectModuleIndex] valueForKey:@"moduleId"] forKey:@"moduleId"];
    //[requestDict setValue:[[studentArray objectAtIndex:selectStudentIndex] valueForKey:@"userId"] forKey:@"authorId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}

-(IBAction)detailClick:(id)sender{
    UIButton* detailButton = (UIButton*)sender;
    int index = detailButton.tag;
    
    NSDictionary* feedbackDict = [feedbackArray objectAtIndex:index];
    //NSLog(@"feedbackDict:%@",feedbackDict);
    
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* unitDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [unitDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [unitDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [unitDict setValue:[[courseArray objectAtIndex:selectCourseIndex] valueForKey:@"courseId"] forKey:@"courseId"];
    [unitDict setValue:[[moduleArray objectAtIndex:selectModuleIndex] valueForKey:@"moduleId"] forKey:@"moduleId"];
    //[unitDict setValue:[[studentArray objectAtIndex:selectStudentIndex] valueForKey:@"userId"] forKey:@"authorId"];
    [unitDict setValue:[feedbackDict valueForKey:@"authorId"] forKey:@"authorId"];
    NSString* role = [userDict valueForKey:@"role"];
    if([@"03" isEqualToString:role] || [@"04" isEqualToString:role]){
        [unitDict setValue:[userDict valueForKey:@"userId"] forKey:@"partnerId"];
    }else if([@"02" isEqualToString:role]){
        [unitDict setValue:[feedbackDict valueForKey:@"partnerId"] forKey:@"partnerId"];
    }
    [unitDict setValue:[feedbackDict valueForKey:@"unitId"] forKey:@"unitId"];
    
    NSString* unitType = [feedbackDict valueForKey:@"unitType"];
    if ([@"03" isEqualToString:unitType]) {
        ZMFeedbackDetailViewController* viewController = [[ZMFeedbackDetailViewController alloc] init];
        [viewController setType:2];
        [viewController setUnitDict:unitDict];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    }else if([@"04" isEqualToString:unitType]){        
        NSString* articleType = [feedbackDict valueForKey:@"articleType"];
        NSLog(@"articleType:%@",articleType);
        if ([@"01" isEqualToString:articleType]) {
            ZMArticleViewController* viewController = [[ZMArticleViewController alloc] init];
            [viewController setType:2];
            [viewController setUnitDict:unitDict];
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }else if([@"02" isEqualToString:articleType]){
            ZMArticleView01Controller* viewController = [[ZMArticleView01Controller alloc] init];
            [viewController setType:2];
            [viewController setUnitDict:unitDict];
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }else if([@"03" isEqualToString:articleType]){
            ZMArticleView02Controller* viewController = [[ZMArticleView02Controller alloc] init];
            [viewController setType:2];
            [viewController setUnitDict:unitDict];
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }else if([@"04" isEqualToString:articleType]){
            ZMArticleView03Controller* viewController = [[ZMArticleView03Controller alloc] init];
            [viewController setType:2];
            [viewController setUnitDict:unitDict];
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }else if([@"05" isEqualToString:articleType]){
            ZMArticleView04Controller* viewController = [[ZMArticleView04Controller alloc] init];
            [viewController setType:2];
            [viewController setUnitDict:unitDict];
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }else if([@"06" isEqualToString:articleType]){
            ZMArticleView05Controller* viewController = [[ZMArticleView05Controller alloc] init];
            [viewController setType:2];
            [viewController setUnitDict:unitDict];
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }else if([@"07" isEqualToString:articleType]){
            ZMArticleView06Controller* viewController = [[ZMArticleView06Controller alloc] init];
            [viewController setType:2];
            [viewController setUnitDict:unitDict];
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }else if([@"08" isEqualToString:articleType]){
            ZMArticleView07Controller* viewController = [[ZMArticleView07Controller alloc] init];
            [viewController setType:2];
            [viewController setUnitDict:unitDict];
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }else if([@"09" isEqualToString:articleType]){
            ZMWriteGuideViewController* viewController = [[ZMWriteGuideViewController alloc] init];
            [viewController setType:2];
            [viewController setUnitDict:unitDict];
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }else if([@"00" isEqualToString:articleType]){
            ZMCheckItemViewController* viewController = [[ZMCheckItemViewController alloc] init];
            [viewController setType:2];
            [viewController setUnitDict:unitDict];
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }else if([articleType intValue] == 11){//7个模板 11－17分别对应7个模板
            [unitDict setValue:articleType forKey:@"articleType"];
            ZMMdlCmpVCtrl * viewController = [[ZMMdlCmpVCtrl alloc] init];
            [viewController setType:2];
            viewController.unitDict = unitDict;
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }
        else if([articleType intValue] == 12){
            [unitDict setValue:articleType forKey:@"articleType"];
            ZMMdlExplainVCtrl * viewController = [[ZMMdlExplainVCtrl alloc] init];
            [viewController setType:2];
            viewController.unitDict = unitDict;
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }
        else if([articleType intValue]== 13){
            [unitDict setValue:articleType forKey:@"articleType"];
            ZMMdlTopicVCtrl * viewController = [[ZMMdlTopicVCtrl alloc] init];
            [viewController setType:2];
            viewController.unitDict = unitDict;
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }
        else if([articleType intValue] == 14){
            [unitDict setValue:articleType forKey:@"articleType"];
            ZMMdlSliderVCtrl * viewController = [[ZMMdlSliderVCtrl alloc] init];
            
            [viewController setType:2];
            viewController.unitDict = unitDict;
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }
        else if([articleType intValue] == 15){
            [unitDict setValue:articleType forKey:@"articleType"];
            ZMMdlStoryVCtrl * viewController = [[ZMMdlStoryVCtrl alloc] init];
            [viewController setType:2];
            viewController.unitDict = unitDict;
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }
        else if([articleType intValue] == 16){
            [unitDict setValue:articleType forKey:@"articleType"];
            ZMMdlTravelVCtrl * viewController = [[ZMMdlTravelVCtrl alloc] init];
            [viewController setType:2];
            viewController.unitDict = unitDict;
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }
        else if([articleType intValue] == 17){
            [unitDict setValue:articleType forKey:@"articleType"];
            ZMMdlConceptionVCtrl * viewController = [[ZMMdlConceptionVCtrl alloc] init];
            [viewController setType:2];
            viewController.unitDict = unitDict;
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }else if ([articleType intValue] == 98){
        
            [unitDict setValue:articleType forKey:@"articleType"];
            ZMdianyingzuoyeViewController * viewController = [[ZMdianyingzuoyeViewController alloc] init];
            [viewController setType:2];
            viewController.unitDict = unitDict;
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];

        }
        
    }
    
    [unitDict release];
}

-(void)setBackgroundView{
    [self.view setBackgroundColor:[UIColor colorWithRed:217.0/255.0 green:217.0/255.0 blue:217.0/255.0 alpha:1.0]];
}

-(void)loadView{
    [super loadView];
    
    UIImage* article_Category_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Category_bg" ofType:@"png"]];
    UIImageView* article_Category_View = [[UIImageView alloc] initWithFrame:CGRectMake(291, 15, 421, 43)];
    [article_Category_View setImage:article_Category_Image];
    [self.view addSubview:article_Category_View];
    [article_Category_View release];
    
    [self addLabel:@"我的点评"
             frame:CGRectMake(291, 22, 421, 30)
              size:18
          intoView:self.view];
    
    [self addLabel:@"请选择课程名称:"
             frame:CGRectMake(50, 100, 140, 30)
              size:16
          intoView:self.view];
    UIButton* courseSelectBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [courseSelectBut setTag:kTagCourseSelectBtn];
    [courseSelectBut setFrame:CGRectMake(190, 96, 310, 38)];
    [courseSelectBut setTitleEdgeInsets:UIEdgeInsetsMake(0, 0.0, 0.0, 20.0)];
    //[courseSelectBut setTitle:@"第一课" forState:UIControlStateNormal];
    [courseSelectBut setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [courseSelectBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Button_01" ofType:@"png"]] forState:UIControlStateNormal];
    [courseSelectBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Button_01" ofType:@"png"]] forState:UIControlStateHighlighted];
    [courseSelectBut addTarget:self
                        action:@selector(courseSelectClick:)
              forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:courseSelectBut];
    
//    [self addLabel:@"请选择模块名称:"
//             frame:CGRectMake(510, 100, 140, 30)
//              size:16
//          intoView:self.view];
//    UIButton* moduleSelectBut = [UIButton buttonWithType:UIButtonTypeCustom];
//    [moduleSelectBut setTag:kTagModuleSelectBtn];
//    [moduleSelectBut setFrame:CGRectMake(655, 96, 104, 38)];
//    [moduleSelectBut setTitleEdgeInsets:UIEdgeInsetsMake(0, 0.0, 0.0, 20.0)];
//    //[moduleSelectBut setTitle:@"阅读" forState:UIControlStateNormal];
//    [moduleSelectBut setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
//    [moduleSelectBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Button_02" ofType:@"png"]] forState:UIControlStateNormal];
//    [moduleSelectBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Button_02" ofType:@"png"]] forState:UIControlStateHighlighted];
//    [moduleSelectBut addTarget:self
//                        action:@selector(moduleSelectClick:)
//              forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:moduleSelectBut];
    
//    [self addLabel:@"请选择学生:"
//             frame:CGRectMake(620, 100, 100, 30)
//              size:16
//          intoView:self.view];
//    UIButton* studentSelectBut = [UIButton buttonWithType:UIButtonTypeCustom];
//    [studentSelectBut setTag:kTagStudentSelectBtn];
//    [studentSelectBut setFrame:CGRectMake(740, 96, 104, 38)];
//    [studentSelectBut setTitleEdgeInsets:UIEdgeInsetsMake(0, 0.0, 0.0, 20.0)];
//    //[studentSelectBut setTitle:@"李明" forState:UIControlStateNormal];
//    [studentSelectBut setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
//    [studentSelectBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Button_02" ofType:@"png"]] forState:UIControlStateNormal];
//    [studentSelectBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Button_02" ofType:@"png"]] forState:UIControlStateHighlighted];
//    [studentSelectBut addTarget:self
//                         action:@selector(studentSelectClick:)
//               forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:studentSelectBut];
    
    UIButton* query_But = [UIButton buttonWithType:UIButtonTypeCustom];
    [query_But setFrame:CGRectMake(890, 85, 71, 61)];
    [query_But setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Query_Btn" ofType:@"png"]] forState:UIControlStateNormal];
    [query_But setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Query_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
    [query_But addTarget:self
                  action:@selector(queryClick:)
        forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:query_But];
}

-(void)getCourses{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M004" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}

-(void)getModules{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M005" forKey:@"method"];
    [requestDict setValue:[[courseArray objectAtIndex:selectCourseIndex] valueForKey:@"courseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}

-(void)getUserList{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M009" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    //[requestDict setValue:[userDict valueForKey:@"role"] forKey:@"role"];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}

-(void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    courseArray = [[NSMutableArray alloc] initWithCapacity:0];
    [self getCourses];
    
    moduleArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    //studentArray = [[NSMutableArray alloc] initWithCapacity:0];
    //[self getUserList];
    
    feedbackArray = [[NSMutableArray alloc] initWithCapacity:0];
    CGRect frame = CGRectMake(27, 155, 970, 600);
    UITableView* feedbackTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [feedbackTableView setTag:kTagFeedbackTableView];
    feedbackTableView.delegate = self;
    feedbackTableView.dataSource = self;
    [feedbackTableView setBackgroundColor:[UIColor clearColor]];
    [feedbackTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    UIView* headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 970, 50)];
    
    [self addLabel:@"提交时间"
             frame:CGRectMake(10, 10, 150, 30)
              size:16
          intoView:headView];
    [self addLabel:@"作业名称"
             frame:CGRectMake(160, 10, 140, 30)
              size:16
          intoView:headView];
    [self addLabel:@"提交人"
             frame:CGRectMake(320, 10, 90, 30)
              size:16
          intoView:headView];
    [self addLabel:@"课程名称"
             frame:CGRectMake(430, 10, 100, 30)
              size:16
          intoView:headView];
    [self addLabel:@"模块名称"
             frame:CGRectMake(580, 10, 80, 30)
              size:16
          intoView:headView];
    [self addLabel:@"状态"
             frame:CGRectMake(730, 10, 80, 30)
              size:16
          intoView:headView];
    [self addLabel:@"点评"
             frame:CGRectMake(840, 10, 105, 30)
              size:16
          intoView:headView];
    UIImage* separater_lineImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Button_separater_line" ofType:@"png"]];
    UIImageView* separater_lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 48, 970, 2)];
    [separater_lineView setImage:separater_lineImage];
    [headView addSubview:separater_lineView];
    [separater_lineView release];
    [feedbackTableView setTableHeaderView:headView];
    [headView release];
    
    [self.view addSubview:feedbackTableView];
    [feedbackTableView release];
}

-(void)dealloc{
    UITableView* courseTableView = (UITableView*)[self.view viewWithTag:kTagCourseTableView];
    [courseTableView setDataSource:nil];
    [courseTableView setDelegate:nil];
    [courseArray release];
    
    UITableView* moduleTableView = (UITableView*)[self.view viewWithTag:kTagModuleTableView];
    [moduleTableView setDelegate:nil];
    [moduleTableView setDataSource:nil];
    [moduleArray release];
    
    UITableView* studentTableView = (UITableView*)[self.view viewWithTag:kTagStudentTableView];
    [studentTableView setDataSource:nil];
    [studentTableView setDelegate:nil];
    [studentArray release];
        
    UITableView* feedbackTableView = (UITableView*)[self.view viewWithTag:kTagFeedbackTableView];
    [feedbackTableView setDataSource:nil];
    [feedbackTableView setDelegate:nil];
    [feedbackArray release];

    [super dealloc];
}


#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSLog(@"[tableDataSourceArray count]:%d",[_dataSource count]);
    int tag = tableView.tag;
    if (tag == kTagCourseTableView) {
        return [courseArray count];
    }else if(tag == kTagModuleTableView){
        return [moduleArray count];
    }else if(tag == kTagStudentTableView){
        return [studentArray count];
    }else if(tag == kTagFeedbackTableView){
        return [feedbackArray count];
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }else{
        for (UIView *subView in [cell.contentView subviews]){
			[subView removeFromSuperview];
		}
    }
    
    int tag = tableView.tag;
    if (tag == kTagCourseTableView) {
        NSDictionary* courseDict = [courseArray objectAtIndex:indexPath.row];
        [cell.textLabel setText:[courseDict valueForKey:@"course"]];
    }else if(tag == kTagModuleTableView){
        NSDictionary* moduleDict = [moduleArray objectAtIndex:indexPath.row];
        [cell.textLabel setText:[moduleDict valueForKey:@"module"]];
    }else if(tag == kTagStudentTableView){
        NSDictionary* studentDict = [studentArray objectAtIndex:indexPath.row];
        [cell.textLabel setText:[studentDict valueForKey:@"userName"]];
    }else if(tag == kTagFeedbackTableView){
        NSDictionary* feedbackDict = [feedbackArray objectAtIndex:indexPath.row];
        
        NSString* commitTime = [feedbackDict valueForKey:@"commitTime"];
        
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        NSDate *dateFromString = [formatter dateFromString:commitTime];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString* stringFromDate = [formatter stringFromDate:dateFromString];
        [formatter release];
        
        [self addLabel:stringFromDate
                 frame:CGRectMake(10, 10, 150, 30)
                  size:14
              intoView:cell.contentView];
        
        [self addLabel:[feedbackDict valueForKey:@"unit"]
                 frame:CGRectMake(160, 10, 140, 30)
                  size:14
              intoView:cell.contentView];
        
        [self addLabel:[feedbackDict valueForKey:@"author"]
                 frame:CGRectMake(320, 10, 90, 30)
                  size:14
              intoView:cell.contentView];
        
        [self addLabel:[feedbackDict valueForKey:@"course"]
                 frame:CGRectMake(430, 10, 100, 30)
                  size:14
              intoView:cell.contentView];
        
        [self addLabel:[feedbackDict valueForKey:@"module"]
                 frame:CGRectMake(580, 10, 80, 30)
                  size:14
              intoView:cell.contentView];
        
        NSString* status = [feedbackDict valueForKey:@"status"];
        if ([@"00" isEqualToString:status]) {
            [self addLabel:@"未点评"
                     frame:CGRectMake(730, 10, 80, 30)
                      size:14
                  intoView:cell.contentView];
        }else if([@"01" isEqualToString:status]){
            [self addLabel:@"已点评"
                     frame:CGRectMake(730, 10, 80, 30)
                      size:14
                  intoView:cell.contentView];
        }
        
        UIButton* detailBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [detailBut setFrame:CGRectMake(875, 8, 35, 34)];
        [detailBut setTag:indexPath.row];
        [detailBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Feedback_Browse_Btn_Detail" ofType:@"png"]] forState:UIControlStateNormal];
        [detailBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Feedback_Browse_Btn_Detail" ofType:@"png"]] forState:UIControlStateHighlighted];
        [detailBut addTarget:self
                      action:@selector(detailClick:)
            forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:detailBut];
        
        UIImage* separater_lineImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Button_separater_line" ofType:@"png"]];
        UIImageView* separater_lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 48, 970, 2)];
        [separater_lineView setImage:separater_lineImage];
        [cell.contentView addSubview:separater_lineView];
        [separater_lineView release];
    }
    
    return cell;
}

#pragma mark - Table view delegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    int tag = tableView.tag;
    if (tag == kTagFeedbackTableView) {
        return 50;
    }
    return 39.0f;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int tag = tableView.tag;
    if (tag == kTagCourseTableView) {
        UIButton* courseBtn = (UIButton*)[self.view viewWithTag:kTagCourseSelectBtn];
        
        NSDictionary* courseDict = [courseArray objectAtIndex:indexPath.row];
        [courseBtn setTitle:[courseDict valueForKey:@"course"] forState:UIControlStateNormal];
        
        selectCourseIndex = indexPath.row;
        
        [self getModules];
    }else if(tag == kTagModuleTableView){
        UIButton* moduleBtn = (UIButton*)[self.view viewWithTag:kTagModuleSelectBtn];
        
        NSDictionary* moduleDict = [moduleArray objectAtIndex:indexPath.row];
        [moduleBtn setTitle:[moduleDict valueForKey:@"module"] forState:UIControlStateNormal];
        
        selectModuleIndex = indexPath.row;
    }else if(tag == kTagStudentTableView){
        UIButton* studentBtn = (UIButton*)[self.view viewWithTag:kTagStudentSelectBtn];
        
        NSDictionary* studentDict = [studentArray objectAtIndex:indexPath.row];
        [studentBtn setTitle:[studentDict valueForKey:@"userName"] forState:UIControlStateNormal];
        
        selectStudentIndex = indexPath.row;
    }else if(tag == kTagFeedbackTableView){
        
    }
    
    [popoverViewController dismissPopoverAnimated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)tableView:(UITableView*)tableView  willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}


#pragma mark ZMHttpEngineDelegate
-(void)httpEngine:(ZMHttpEngine *)httpEngine didSuccess:(NSDictionary *)responseDict{
    [super httpEngine:httpEngine didSuccess:responseDict];
    
    NSString* method = [responseDict valueForKey:@"method"];
    NSString* responseCode = [responseDict valueForKey:@"responseCode"];
    if ([@"M004" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        NSArray* _courseArray = [responseDict valueForKey:@"courses"];
        for (int i=0; i<[_courseArray count]; i++) {
            NSLog(@"course:%@",[_courseArray objectAtIndex:i]);
            [courseArray addObject:[_courseArray objectAtIndex:i]];
        }
        
        UIButton* courseBtn = (UIButton*)[self.view viewWithTag:kTagCourseSelectBtn];
        selectCourseIndex = 0;
        NSDictionary* courseDict = [courseArray objectAtIndex:selectCourseIndex];
        [courseBtn setTitle:[courseDict valueForKey:@"course"] forState:UIControlStateNormal];
        
        [self getModules];
    }else if([@"M005" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        [moduleArray removeAllObjects];
        
        NSArray* _moduleArray = [responseDict valueForKey:@"modules"];
        for (int i=0; i<[_moduleArray count]; i++) {
            NSLog(@"module:%@",[_moduleArray objectAtIndex:i]);
            [moduleArray addObject:[_moduleArray objectAtIndex:i]];
        }
        
        UIButton* moduleBtn = (UIButton*)[self.view viewWithTag:kTagModuleSelectBtn];
        selectModuleIndex = 0;
        NSDictionary* moduleDict = [moduleArray objectAtIndex:selectModuleIndex];
        [moduleBtn setTitle:[moduleDict valueForKey:@"module"] forState:UIControlStateNormal];
    }else if([@"M009" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        NSArray* _studentArray = [responseDict valueForKey:@"students"];
        for (int i=0; i<[_studentArray count]; i++) {
            NSLog(@"student:%@",[_studentArray objectAtIndex:i]);
            [studentArray addObject:[_studentArray objectAtIndex:i]];
        }
        
        UIButton* studentBtn = (UIButton*)[self.view viewWithTag:kTagStudentSelectBtn];
        selectStudentIndex = 0;
        NSDictionary* studentDict = [studentArray objectAtIndex:selectStudentIndex];
        [studentBtn setTitle:[studentDict valueForKey:@"userName"] forState:UIControlStateNormal];
    }else if([@"M028" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        [feedbackArray removeAllObjects];
        
        NSArray* _feedbackArray = [responseDict valueForKey:@"myFeedbacks"];
        for (int i=0; i<[_feedbackArray count]; i++) {
            NSLog(@"feedback:%@",[_feedbackArray objectAtIndex:i]);
            [feedbackArray addObject:[_feedbackArray objectAtIndex:i]];
        }
        
        UITableView* feedbackTableView = (UITableView*)[self.view viewWithTag:kTagFeedbackTableView];
        [feedbackTableView reloadData];
    }else if([@"M041" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        [feedbackArray removeAllObjects];
        
        NSArray* _feedbackArray = [responseDict valueForKey:@"feedbacks"];
        for (int i=0; i<[_feedbackArray count]; i++) {
            NSLog(@"feedback:%@",[_feedbackArray objectAtIndex:i]);
            [feedbackArray addObject:[_feedbackArray objectAtIndex:i]];
        }
        
        UITableView* feedbackTableView = (UITableView*)[self.view viewWithTag:kTagFeedbackTableView];
        [feedbackTableView reloadData];
    }else if(![@"00" isEqualToString:responseCode]){
        [self showTip:@"服务器异常"];
    }
}

@end
