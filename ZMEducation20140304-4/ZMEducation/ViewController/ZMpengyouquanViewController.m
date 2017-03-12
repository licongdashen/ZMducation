//
//  ZMpengyouquanViewController.m
//  ZMEducation
//
//  Created by Queen on 2017/3/7.
//  Copyright © 2017年 99Bill. All rights reserved.
//

#import "ZMpengyouquanViewController.h"
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
#import "ZMMdlCommentVCtrl.h"
#import "ZMZuoYeViewController.h"
#import "ZMdianyingzuoyeViewController.h"

#import "ZMWorkBrowseViewController.h"
#import "ZMpengyouquanDetailViewController.h"

#define kTagCourseSelectBtn 1100
#define kTagModuleSelectBtn 1110
#define kTagStudentSelectBtn 1111

#define kTagCourseTableView 1200
#define kTagModuleTableView 1210
#define kTagStudentTableView 1211
#define kTagWorkTableView 1213

@interface ZMpengyouquanViewController ()
{
    UITableView* workTableView;
}

@property (nonatomic, strong) NSMutableArray * m136Arr;

@end

@implementation ZMpengyouquanViewController


-(void)studentSelectClick:(id)sender{
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

-(void)courseSelectClick:(id)sender{
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

-(void)moduleSelectClick:(id)sender{
    UITableViewController *tableViewController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    CGRect frame = CGRectMake(0, 0, 200, 240);
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

-(void)queryClick:(id)sender{
//    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
//    
//    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
//    [requestDict setValue:@"M016" forKey:@"method"];
//    [requestDict setValue:[[courseArray objectAtIndex:selectCourseIndex] valueForKey:@"courseId"] forKey:@"courseId"];
//    if (selectModuleIndex == 0) {
//        [requestDict setValue:@"01"forKey:@"moduleId"];
//        
//    }else{
//        [requestDict setValue:@"02"forKey:@"moduleId"];
//    }
//    
//    //    NSString* role = [userDict valueForKey:@"role"];
//    //    if ([@"03" isEqualToString:role] || [@"04" isEqualToString:role]) {
//    //        [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
//    //    }else if([@"02" isEqualToString:role]){
//    //        [requestDict setValue:[[studentArray objectAtIndex:selectStudentIndex] valueForKey:@"userId"] forKey:@"userId"];
//    //    }
//    [requestDict setValue:[[studentArray objectAtIndex:selectStudentIndex] valueForKey:@"userId"] forKey:@"userId"];
//    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
//    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
//    
//    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
//    [httpEngine setDelegate:self];
//    [httpEngine requestWithDict:requestDict];
//    [httpEngine release];
//    [requestDict release];
    
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M136" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    
    [self showIndicator];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];

}

-(void)detailClick:(id)sender{
    UIButton* detailButton = (UIButton*)sender;
    int index = detailButton.tag;
    
    NSDictionary* workDict = [self.m136Arr objectAtIndex:index];
    NSLog(@"workDict:%@",workDict);
    
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* unitDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [unitDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [unitDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [unitDict setValue:[workDict valueForKey:@"courseId"] forKey:@"courseId"];
    [unitDict setValue:[workDict valueForKey:@"moduleId"] forKey:@"moduleId"];
    
    //    NSString* role = [userDict valueForKey:@"role"];
    //    if ([@"03" isEqualToString:role] || [@"04" isEqualToString:role]) {
    //        [unitDict setValue:[userDict valueForKey:@"userId"] forKey:@"authorId"];
    //    }else if([@"02" isEqualToString:role]){
    //        [unitDict setValue:[[studentArray objectAtIndex:selectStudentIndex] valueForKey:@"userId"] forKey:@"authorId"];
    //    }
    //    [unitDict setValue:[[studentArray objectAtIndex:selectStudentIndex] valueForKey:@"userId"] forKey:@"authorId"];
    
    [unitDict setValue:[workDict valueForKey:@"authorId"] forKey:@"authorId"];
    [unitDict setValue:[workDict valueForKey:@"unitId"] forKey:@"unitId"];
    [unitDict setValue:[workDict valueForKey:@"recordId"] forKey:@"recordId"];
    
    NSString* unitType = [NSString stringWithFormat:@"%@",[workDict valueForKey:@"sourceId"]];
    if ([@"03" isEqualToString:unitType]) {
//        ZMFeedbackDetailViewController* viewController = [[ZMFeedbackDetailViewController alloc] init];
//        [viewController setType:3];
//        [viewController setUnitDict:unitDict];
//        [self.navigationController pushViewController:viewController animated:YES];
//        [viewController release];
    }else if([@"4" isEqualToString:unitType]){

        NSString* articleType = [workDict valueForKey:@"articleType"];
        if ([@"01" isEqualToString:articleType]) {
            ZMArticleViewController* viewController = [[ZMArticleViewController alloc] init];
            [viewController setType:3];
            [viewController setUnitDict:unitDict];
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }else if([@"02" isEqualToString:articleType]){
            ZMArticleView01Controller* viewController = [[ZMArticleView01Controller alloc] init];
            [viewController setType:3];
            [viewController setUnitDict:unitDict];
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }else if([@"03" isEqualToString:articleType]){
            ZMArticleView02Controller* viewController = [[ZMArticleView02Controller alloc] init];
            [viewController setType:3];
            [viewController setUnitDict:unitDict];
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }else if([@"04" isEqualToString:articleType]){
            ZMArticleView03Controller* viewController = [[ZMArticleView03Controller alloc] init];
            [viewController setType:3];
            [viewController setUnitDict:unitDict];
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }else if([@"05" isEqualToString:articleType]){
            ZMArticleView04Controller* viewController = [[ZMArticleView04Controller alloc] init];
            [viewController setType:3];
            [viewController setUnitDict:unitDict];
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }else if([@"06" isEqualToString:articleType]){
            ZMArticleView05Controller* viewController = [[ZMArticleView05Controller alloc] init];
            [viewController setType:3];
            [viewController setUnitDict:unitDict];
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }else if([@"07" isEqualToString:articleType]){
            ZMArticleView06Controller* viewController = [[ZMArticleView06Controller alloc] init];
            [viewController setType:3];
            [viewController setUnitDict:unitDict];
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }else if([@"08" isEqualToString:articleType]){
            ZMArticleView07Controller* viewController = [[ZMArticleView07Controller alloc] init];
            [viewController setType:3];
            [viewController setUnitDict:unitDict];
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }else if([@"09" isEqualToString:articleType]){
            ZMWriteGuideViewController* viewController = [[ZMWriteGuideViewController alloc] init];
            [viewController setType:3];
            [viewController setUnitDict:unitDict];
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }else if([@"00" isEqualToString:articleType]){
            ZMCheckItemViewController* viewController = [[ZMCheckItemViewController alloc] init];
            [viewController setType:3];
            [viewController setUnitDict:unitDict];
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }else if([articleType intValue] == 11){//7个模板 11－17分别对应7个模板
            [unitDict setValue:articleType forKey:@"articleType"];
            ZMMdlCmpVCtrl * viewController = [[ZMMdlCmpVCtrl alloc] init];
            [viewController setType:3];
            viewController.unitDict = unitDict;
            [self.navigationController pushViewController:viewController animated:YES];
            [ZMMdlCmpVCtrl release];
        }
        else if([articleType intValue] == 12){
            [unitDict setValue:articleType forKey:@"articleType"];
            ZMMdlExplainVCtrl * viewController = [[ZMMdlExplainVCtrl alloc] init];
            [viewController setType:3];
            viewController.unitDict = unitDict;
            [self.navigationController pushViewController:viewController animated:YES];
            [ZMMdlCmpVCtrl release];
        }
        else if([articleType intValue]== 13){
            [unitDict setValue:articleType forKey:@"articleType"];
            ZMMdlTopicVCtrl * viewController = [[ZMMdlTopicVCtrl alloc] init];
            [viewController setType:3];
            viewController.unitDict = unitDict;
            [self.navigationController pushViewController:viewController animated:YES];
            [ZMMdlCmpVCtrl release];
        }
        else if([articleType intValue] == 14){
            [unitDict setValue:articleType forKey:@"articleType"];
            ZMMdlSliderVCtrl * viewController = [[ZMMdlSliderVCtrl alloc] init];
            
            [viewController setType:3];
            viewController.unitDict = unitDict;
            [self.navigationController pushViewController:viewController animated:YES];
            [ZMMdlCmpVCtrl release];
        }
        else if([articleType intValue] == 15){
            [unitDict setValue:articleType forKey:@"articleType"];
            ZMMdlStoryVCtrl * viewController = [[ZMMdlStoryVCtrl alloc] init];
            [viewController setType:3];
            viewController.unitDict = unitDict;
            [self.navigationController pushViewController:viewController animated:YES];
            [ZMMdlCmpVCtrl release];
        }
        else if([articleType intValue] == 16){
            [unitDict setValue:articleType forKey:@"articleType"];
            ZMMdlTravelVCtrl * viewController = [[ZMMdlTravelVCtrl alloc] init];
            [viewController setType:3];
            viewController.unitDict = unitDict;
            [self.navigationController pushViewController:viewController animated:YES];
            [ZMMdlCmpVCtrl release];
        }
        else if([articleType intValue] == 17){
            [unitDict setValue:articleType forKey:@"articleType"];
            ZMMdlConceptionVCtrl * viewController = [[ZMMdlConceptionVCtrl alloc] init];
            [viewController setType:3];
            viewController.unitDict = unitDict;
            [self.navigationController pushViewController:viewController animated:YES];
            [ZMMdlCmpVCtrl release];
        }else if([articleType intValue] == 18){
            [unitDict setValue:articleType forKey:@"articleType"];
            ZMMdlCommentVCtrl * viewController = [[ZMMdlCommentVCtrl alloc] init];
            [viewController setType:3];
            viewController.unitDict = unitDict;
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }else if ([articleType intValue] == 98){
            [unitDict setValue:articleType forKey:@"articleType"];
            ZMdianyingzuoyeViewController * viewController = [[ZMdianyingzuoyeViewController alloc] init];
            [viewController setType:3];
            viewController.unitDict = unitDict;
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }
        
    }else {
    
        ZMpengyouquanDetailViewController *vc = [[ZMpengyouquanDetailViewController alloc]init];
        vc.dic = workDict;
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
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
    
    [self addLabel:@"朋发布浏览"
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
//
//    [self addLabel:@"请选择类型:"
//             frame:CGRectMake(510, 100, 140, 30)
//              size:16
//          intoView:self.view];
//    UIButton* moduleSelectBut = [UIButton buttonWithType:UIButtonTypeCustom];
//    [moduleSelectBut setTag:kTagModuleSelectBtn];
//    [moduleSelectBut setFrame:CGRectMake(655, 96, 200, 38)];
//    [moduleSelectBut setTitleEdgeInsets:UIEdgeInsetsMake(0, 0.0, 0.0, 20.0)];
//    [moduleSelectBut setTitle:@"构思图表" forState:UIControlStateNormal];
//    [moduleSelectBut setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
//    [moduleSelectBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Button_02" ofType:@"png"]] forState:UIControlStateNormal];
//    [moduleSelectBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Button_02" ofType:@"png"]] forState:UIControlStateHighlighted];
//    [moduleSelectBut addTarget:self
//                        action:@selector(moduleSelectClick:)
//              forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:moduleSelectBut];
//    
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
    [requestDict setValue:[userDict valueForKey:@"role"] forKey:@"role"];
    
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
    
    
    moduleArray1 = [[NSMutableArray alloc] initWithObjects:@"构思图表",@"我的文稿" ,nil];
    
    
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
    //
    //    studentArray = [[NSMutableArray alloc] initWithCapacity:0];
    //    [self getUserList];
    
    
    //    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    //    NSString* role = [userDict valueForKey:@"role"];
    //    if ([@"03" isEqualToString:role] || [@"04" isEqualToString:role]) {
    //
    //    }else if([@"02" isEqualToString:role]){
    //        [self addLabel:@"请选择学生:"
    //                 frame:CGRectMake(620, 100, 100, 30)
    //                  size:16
    //              intoView:self.view];
    //        UIButton* studentSelectBut = [UIButton buttonWithType:UIButtonTypeCustom];
    //        [studentSelectBut setTag:kTagStudentSelectBtn];
    //        [studentSelectBut setFrame:CGRectMake(740, 96, 104, 38)];
    //        [studentSelectBut setTitleEdgeInsets:UIEdgeInsetsMake(0, 0.0, 0.0, 20.0)];
    //        //[studentSelectBut setTitle:@"李明" forState:UIControlStateNormal];
    //        [studentSelectBut setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    //        [studentSelectBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Button_02" ofType:@"png"]] forState:UIControlStateNormal];
    //        [studentSelectBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Button_02" ofType:@"png"]] forState:UIControlStateHighlighted];
    //        [studentSelectBut addTarget:self
    //                             action:@selector(studentSelectClick:)
    //                   forControlEvents:UIControlEventTouchUpInside];
    //        [self.view addSubview:studentSelectBut];
    //
    //        studentArray = [[NSMutableArray alloc] initWithCapacity:0];
    //        [self getUserList];
    //
    //    }
    
    workArray = [[NSMutableArray alloc] initWithCapacity:0];
    CGRect frame = CGRectMake(27, 155, 970, 600);
    workTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [workTableView setTag:kTagWorkTableView];
    workTableView.delegate = self;
    workTableView.dataSource = self;
    [workTableView setBackgroundColor:[UIColor clearColor]];
    [workTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    UIView* headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 970, 50)];
    
    [self addLabel:@"发布时间"
             frame:CGRectMake(10, 10, 150, 30)
              size:16
          intoView:headView];
    [self addLabel:@"发布来源"
             frame:CGRectMake(160, 10, 140, 30)
              size:16
          intoView:headView];
    [self addLabel:@"作者"
             frame:CGRectMake(320, 10, 90, 30)
              size:16
          intoView:headView];
    [self addLabel:@"课程名称"
             frame:CGRectMake(430, 10, 100, 30)
              size:16
          intoView:headView];
//    [self addLabel:@"类型"
//             frame:CGRectMake(580, 10, 80, 30)
//              size:16
//          intoView:headView];
//    [self addLabel:@"点评数量"
//             frame:CGRectMake(730, 10, 80, 30)
//              size:16
//          intoView:headView];
//    [self addLabel:@"点评"
//             frame:CGRectMake(840, 10, 105, 30)
//              size:16
//          intoView:headView];
    UIImage* separater_lineImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Button_separater_line" ofType:@"png"]];
    UIImageView* separater_lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 48, 970, 2)];
    [separater_lineView setImage:separater_lineImage];
    [headView addSubview:separater_lineView];
    [separater_lineView release];
    [workTableView setTableHeaderView:headView];
    [headView release];
    
    [self.view addSubview:workTableView];
    [workTableView release];
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
    
    UITableView* workTableView = (UITableView*)[self.view viewWithTag:kTagWorkTableView];
    [workTableView setDataSource:nil];
    [workTableView setDelegate:nil];
    [workArray release];
    
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
        return [moduleArray1 count];
    }else if(tag == kTagStudentTableView){
        return [studentArray count];
    }else if(tag == kTagWorkTableView){
        return [self.m136Arr count];
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
        NSString* moduleDict = [moduleArray1 objectAtIndex:indexPath.row];
        [cell.textLabel setText:moduleDict];
    }else if(tag == kTagStudentTableView){
        NSDictionary* studentDict = [studentArray objectAtIndex:indexPath.row];
        [cell.textLabel setText:[studentDict valueForKey:@"userName"]];
    }else if(tag == kTagWorkTableView){
        NSDictionary* workDict = [self.m136Arr objectAtIndex:indexPath.row];
        
        NSString* commitTime = [workDict valueForKey:@"commitTime"];
        
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
        
        [self addLabel:[workDict valueForKey:@"sourceName"]
                 frame:CGRectMake(160, 10, 140, 30)
                  size:14
              intoView:cell.contentView];
        
        [self addLabel:[workDict valueForKey:@"author"]
                 frame:CGRectMake(320, 10, 90, 30)
                  size:14
              intoView:cell.contentView];
        
        [self addLabel:[workDict valueForKey:@"course"]
                 frame:CGRectMake(430, 10, 100, 30)
                  size:14
              intoView:cell.contentView];
        
//        [self addLabel:[workDict valueForKey:@"module"]
//                 frame:CGRectMake(580, 10, 80, 30)
//                  size:14
//              intoView:cell.contentView];
//        
//        int feedbackNo = [[workDict valueForKey:@"feedbackNo"] intValue];
//        [self addLabel:[NSString stringWithFormat:@"%d",feedbackNo]
//                 frame:CGRectMake(730, 10, 80, 30)
//                  size:14
//              intoView:cell.contentView];
        
        UIButton* detailBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [detailBut setFrame:CGRectMake(840, 10, 105, 30)];
        [detailBut setTag:indexPath.row];
        [detailBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Button_Detail" ofType:@"png"]] forState:UIControlStateNormal];
        [detailBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Button_Detail" ofType:@"png"]] forState:UIControlStateHighlighted];
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
    if (tag == kTagWorkTableView) {
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
        
        NSString* moduleDict = [moduleArray1 objectAtIndex:indexPath.row];
        [moduleBtn setTitle:moduleDict forState:UIControlStateNormal];
        
        selectModuleIndex = indexPath.row;
    }else if(tag == kTagStudentTableView){
        UIButton* studentBtn = (UIButton*)[self.view viewWithTag:kTagStudentSelectBtn];
        
        NSDictionary* studentDict = [studentArray objectAtIndex:indexPath.row];
        [studentBtn setTitle:[studentDict valueForKey:@"userName"] forState:UIControlStateNormal];
        
        selectStudentIndex = indexPath.row;
    }else if(tag == kTagWorkTableView){
        
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
        //        NSDictionary* moduleDict = [moduleArray objectAtIndex:selectModuleIndex];
        //        [moduleBtn setTitle:[moduleDict valueForKey:@"module"] forState:UIControlStateNormal];
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
    }else if([@"M016" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        [workArray removeAllObjects];
        
        NSArray* _articleArray = [responseDict valueForKey:@"articles"];
        for (int i=0; i<[_articleArray count]; i++) {
            NSLog(@"article:%@",[_articleArray objectAtIndex:i]);
            [workArray addObject:[_articleArray objectAtIndex:i]];
        }
        
        UITableView* workTableView = (UITableView*)[self.view viewWithTag:kTagWorkTableView];
        [workTableView reloadData];
    }else if([@"M069" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        
        NSMutableArray * dataSource = [[NSMutableArray alloc]initWithArray:[responseDict valueForKey:@"units"]];
        if ([dataSource count] > 0) {
            
            ZMZuoYeViewController * vc = [[ZMZuoYeViewController alloc] init];
            //                [vc setDelegate:self];
            vc.unitArray = dataSource;
            vc.ishidden = YES;
            [self presentViewController:vc animated:YES completion:NULL];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"vn" object:nil];
            
        }else{
            
            [self showTip:@"没有内容！"];
            
        }
    }else if([@"M136" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        self.m136Arr = responseDict[@"releases"];
        NSLog(@"self.m136Arr===%@",self.m136Arr);
        [self hideIndicator];
        [workTableView reloadData];
    }else if(![@"00" isEqualToString:responseCode]){
        [self showTip:@"服务器异常"];
    }
}

@end
