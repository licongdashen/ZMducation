//
//  ZMWrongViewController.m
//  ZMEducation
//
//  Created by Hunter Li on 13-6-1.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import "ZMWrongViewController.h"

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

#define kTagCourseSelectBtn 1100
#define kTagStudentSelectBtn 1111

#define kTagCourseTableView 1200
#define kTagStudentTableView 1211
#define kTagWrongTableView 1213

@implementation ZMWrongViewController

-(IBAction)removeClick:(id)sender{
    UIButton* detailButton = (UIButton*)sender;
    int index = detailButton.tag;

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定移除错题集？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alert setTag:index];
    [alert show];
    [alert release];
}

-(void)removeWrongAtIndex:(int)index{    
    NSDictionary* wrongDict = [wrongArray objectAtIndex:index];
    NSLog(@"wrongDict:%@",wrongDict);
    
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M042" forKey:@"method"];
    [requestDict setValue:[wrongDict valueForKey:@"courseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[wrongDict valueForKey:@"moduleId"] forKey:@"moduleId"];
    [requestDict setValue:[wrongDict valueForKey:@"unitId"] forKey:@"unitId"];
    
    NSString* role = [userDict valueForKey:@"role"];
    if ([@"03" isEqualToString:role] || [@"04" isEqualToString:role]) {
        [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    }else if([@"02" isEqualToString:role]){
        [requestDict setValue:[[studentArray objectAtIndex:selectStudentIndex] valueForKey:@"userId"] forKey:@"userId"];
    }
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}

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

-(IBAction)queryClick:(id)sender{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M027" forKey:@"method"];
    [requestDict setValue:[[courseArray objectAtIndex:selectCourseIndex] valueForKey:@"courseId"] forKey:@"courseId"];
    
    NSString* role = [userDict valueForKey:@"role"];
    if ([@"03" isEqualToString:role] || [@"04" isEqualToString:role]) {
        [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    }else if([@"02" isEqualToString:role]){
        [requestDict setValue:[[studentArray objectAtIndex:selectStudentIndex] valueForKey:@"userId"] forKey:@"userId"];
    }
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
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
    
    [self addLabel:@"错题集"
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

-(void)dealloc{
    UITableView* courseTableView = (UITableView*)[self.view viewWithTag:kTagCourseTableView];
    [courseTableView setDataSource:nil];
    [courseTableView setDelegate:nil];
    [courseArray release];
        
    UITableView* studentTableView = (UITableView*)[self.view viewWithTag:kTagStudentTableView];
    [studentTableView setDataSource:nil];
    [studentTableView setDelegate:nil];
    [studentArray release];
    
    UITableView* wrongTableView = (UITableView*)[self.view viewWithTag:kTagWrongTableView];
    [wrongTableView setDataSource:nil];
    [wrongTableView setDelegate:nil];
    [wrongArray release];

    [super dealloc];
}

- (void)viewDidLoad{
    [super viewDidLoad];
	
    courseArray = [[NSMutableArray alloc] initWithCapacity:0];
    [self getCourses];
    
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSString* role = [userDict valueForKey:@"role"];
    if ([@"03" isEqualToString:role] || [@"04" isEqualToString:role]) {
        
    }else if([@"02" isEqualToString:role]){
        [self addLabel:@"请选择学生:"
                 frame:CGRectMake(580, 100, 100, 30)
                  size:16
              intoView:self.view];
        UIButton* studentSelectBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [studentSelectBut setTag:kTagStudentSelectBtn];
        [studentSelectBut setFrame:CGRectMake(700, 96, 104, 38)];
        [studentSelectBut setTitleEdgeInsets:UIEdgeInsetsMake(0, 0.0, 0.0, 20.0)];
        //[studentSelectBut setTitle:@"李明" forState:UIControlStateNormal];
        [studentSelectBut setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [studentSelectBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Button_02" ofType:@"png"]] forState:UIControlStateNormal];
        [studentSelectBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Button_02" ofType:@"png"]] forState:UIControlStateHighlighted];
        [studentSelectBut addTarget:self
                             action:@selector(studentSelectClick:)
                   forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:studentSelectBut];
        
        studentArray = [[NSMutableArray alloc] initWithCapacity:0];
        [self getUserList];
    }

    wrongArray = [[NSMutableArray alloc] initWithCapacity:0];
    CGRect frame = CGRectMake(27, 155, 970, 600);
    UITableView* wrongTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [wrongTableView setTag:kTagWrongTableView];
    wrongTableView.delegate = self;
    wrongTableView.dataSource = self;
    [wrongTableView setBackgroundColor:[UIColor clearColor]];
    [wrongTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    UIView* headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 970, 50)];

    if ([@"03" isEqualToString:role] || [@"04" isEqualToString:role]) {
        [self addLabel:@"课程名称"
                 frame:CGRectMake(30, 10, 150, 30)
                  size:16
              intoView:headView];
        
        [self addLabel:@"模块名称"
                 frame:CGRectMake(280, 10, 90, 30)
                  size:16
              intoView:headView];
        
        [self addLabel:@"试题名称"
                 frame:CGRectMake(420, 10, 140, 30)
                  size:16
              intoView:headView];
        
        [self addLabel:@"提交日期"
                 frame:CGRectMake(580, 10, 180, 30)
                  size:16
              intoView:headView];
        
        [self addLabel:@"操作"
                 frame:CGRectMake(800, 10, 100, 30)
                  size:16
              intoView:headView];
    }else if([@"02" isEqualToString:role] ){
        [self addLabel:@"课程名称"
                 frame:CGRectMake(50, 10, 150, 30)
                  size:16
              intoView:headView];
        
        [self addLabel:@"模块名称"
                 frame:CGRectMake(280, 10, 90, 30)
                  size:16
              intoView:headView];
        
        [self addLabel:@"试题名称"
                 frame:CGRectMake(480, 10, 140, 30)
                  size:16
              intoView:headView];
        
        [self addLabel:@"提交日期"
                 frame:CGRectMake(700, 10, 150, 30)
                  size:16
              intoView:headView];
    }

    UIImage* separater_lineImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Button_separater_line" ofType:@"png"]];
    UIImageView* separater_lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 48, 970, 2)];
    [separater_lineView setImage:separater_lineImage];
    [headView addSubview:separater_lineView];
    [separater_lineView release];
    [wrongTableView setTableHeaderView:headView];
    [headView release];
    
    [self.view addSubview:wrongTableView];
    [wrongTableView release];
}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int tag = tableView.tag;
    if (tag == kTagCourseTableView) {
        return [courseArray count];
    }else if(tag == kTagStudentTableView){
        return [studentArray count];
    }else if(tag == kTagWrongTableView){
        return [wrongArray count];
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
    }else if(tag == kTagStudentTableView){
        NSDictionary* studentDict = [studentArray objectAtIndex:indexPath.row];
        [cell.textLabel setText:[studentDict valueForKey:@"userName"]];
    }else if(tag == kTagWrongTableView){
        NSDictionary* wrongDict = [wrongArray objectAtIndex:indexPath.row];
  
        NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
        NSString* role = [userDict valueForKey:@"role"];
        if ([@"03" isEqualToString:role] || [@"04" isEqualToString:role]) {
            [self addLabel:[wrongDict valueForKey:@"course"]
                     frame:CGRectMake(30, 10, 150, 30)
                      size:14
                  intoView:cell.contentView];
            
            [self addLabel:[wrongDict valueForKey:@"module"]
                     frame:CGRectMake(280, 10, 90, 30)
                      size:14
                  intoView:cell.contentView];
            
            [self addLabel:[wrongDict valueForKey:@"unit"]
                     frame:CGRectMake(420, 10, 140, 30)
                      size:14
                  intoView:cell.contentView];
            
            NSString* commitTime = [wrongDict valueForKey:@"commitTime"];
            
            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSDate *dateFromString = [formatter dateFromString:commitTime];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSString* stringFromDate = [formatter stringFromDate:dateFromString];
            [formatter release];
            
            [self addLabel:stringFromDate
                     frame:CGRectMake(580, 10, 180, 30)
                      size:14
                  intoView:cell.contentView];
            
            UIButton* removeBut = [UIButton buttonWithType:UIButtonTypeCustom];
            [removeBut setFrame:CGRectMake(830, 8, 35, 35)];
            [removeBut setTag:indexPath.row];
            [removeBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Wrong_Remove_Button" ofType:@"png"]] forState:UIControlStateNormal];
            [removeBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Wrong_Remove_Button" ofType:@"png"]] forState:UIControlStateHighlighted];
            [removeBut addTarget:self
                          action:@selector(removeClick:)
                forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:removeBut];
        }else if([@"02" isEqualToString:role] ){
            [self addLabel:[wrongDict valueForKey:@"course"]
                     frame:CGRectMake(50, 10, 150, 30)
                      size:14
                  intoView:cell.contentView];
            
            [self addLabel:[wrongDict valueForKey:@"module"]
                     frame:CGRectMake(280, 10, 90, 30)
                      size:14
                  intoView:cell.contentView];
            
            [self addLabel:[wrongDict valueForKey:@"unit"]
                     frame:CGRectMake(480, 10, 140, 30)
                      size:14
                  intoView:cell.contentView];
            
            NSString* commitTime = [wrongDict valueForKey:@"commitTime"];
            
            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSDate *dateFromString = [formatter dateFromString:commitTime];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSString* stringFromDate = [formatter stringFromDate:dateFromString];
            [formatter release];
            
            [self addLabel:stringFromDate
                     frame:CGRectMake(700, 10, 150, 30)
                      size:14
                  intoView:cell.contentView];
        }
        
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
    if (tag == kTagWrongTableView) {
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
    }else if(tag == kTagStudentTableView){
        UIButton* studentBtn = (UIButton*)[self.view viewWithTag:kTagStudentSelectBtn];
        
        NSDictionary* studentDict = [studentArray objectAtIndex:indexPath.row];
        [studentBtn setTitle:[studentDict valueForKey:@"userName"] forState:UIControlStateNormal];
        
        selectStudentIndex = indexPath.row;
    }else if(tag == kTagWrongTableView){
        NSDictionary* wrongDict = [wrongArray objectAtIndex:indexPath.row];
        NSLog(@"wrongDict:%@",wrongDict);
        
        NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
        NSMutableDictionary* unitDict = [[NSMutableDictionary alloc] initWithCapacity:10];
        [unitDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
        [unitDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
        [unitDict setValue:[wrongDict valueForKey:@"courseId"] forKey:@"courseId"];
        [unitDict setValue:[wrongDict valueForKey:@"moduleId"] forKey:@"moduleId"];
        [unitDict setValue:[wrongDict valueForKey:@"unitId"] forKey:@"unitId"];
        NSString* role = [userDict valueForKey:@"role"];
        if ([@"03" isEqualToString:role] || [@"04" isEqualToString:role]) {
            [unitDict setValue:[userDict valueForKey:@"userId"] forKey:@"authorId"];
        }else if([@"02" isEqualToString:role]){
            [unitDict setValue:[[studentArray objectAtIndex:selectStudentIndex] valueForKey:@"userId"] forKey:@"authorId"];
        }
        
        
        NSString* unitType = [wrongDict valueForKey:@"unitType"];
        if ([@"03" isEqualToString:unitType]) {            
            ZMFeedbackDetailViewController* viewController = [[ZMFeedbackDetailViewController alloc] init];
            [viewController setType:3];
            [viewController setUnitDict:unitDict];
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }else if([@"04" isEqualToString:unitType]){
            NSString* articleType = [wrongDict valueForKey:@"articleType"];
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
            }
        }
        
        [unitDict release];
    }
    
    [popoverViewController dismissPopoverAnimated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        
    }else if(buttonIndex == 1){
        int tag = alertView.tag;
        
        [self removeWrongAtIndex:tag];
    }
}

#pragma mark ZMHttpEngineDelegate
-(void)httpEngine:(ZMHttpEngine *)httpEngine didSuccess:(NSDictionary *)responseDict{
    [super httpEngine:httpEngine didSuccess:responseDict];
    
    NSString* method = [responseDict valueForKey:@"method"];
    NSString* responseCode = [responseDict valueForKey:@"responseCode"];
    if ([@"M027" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        [wrongArray removeAllObjects];
        NSArray* _wrongArray = [responseDict valueForKey:@"wrongExams"];
        for (int i=0; i<[_wrongArray count]; i++) {
            NSLog(@"wrongExam:%@",[_wrongArray objectAtIndex:i]);
            [wrongArray addObject:[_wrongArray objectAtIndex:i]];
        }
        
        UITableView* wrongTableView = (UITableView*)[self.view viewWithTag:kTagWrongTableView];
        [wrongTableView reloadData];
    }else if ([@"M004" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        NSArray* _courseArray = [responseDict valueForKey:@"courses"];
        for (int i=0; i<[_courseArray count]; i++) {
            NSLog(@"course:%@",[_courseArray objectAtIndex:i]);
            [courseArray addObject:[_courseArray objectAtIndex:i]];
        }
        
        UIButton* courseBtn = (UIButton*)[self.view viewWithTag:kTagCourseSelectBtn];
        selectCourseIndex = 0;
        NSDictionary* courseDict = [courseArray objectAtIndex:selectCourseIndex];
        [courseBtn setTitle:[courseDict valueForKey:@"course"] forState:UIControlStateNormal];
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
    }else if([@"M042" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
        
        NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
        [requestDict setValue:@"M027" forKey:@"method"];
        [requestDict setValue:[[courseArray objectAtIndex:selectCourseIndex] valueForKey:@"courseId"] forKey:@"courseId"];
        
        NSString* role = [userDict valueForKey:@"role"];
        if ([@"03" isEqualToString:role] || [@"04" isEqualToString:role]) {
            [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
        }else if([@"02" isEqualToString:role]){
            [requestDict setValue:[[studentArray objectAtIndex:selectStudentIndex] valueForKey:@"userId"] forKey:@"userId"];
        }
        [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
        [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
        
        ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
        [httpEngine setDelegate:self];
        [httpEngine requestWithDict:requestDict];
        [httpEngine release];
        [requestDict release];
    }else if(![@"00" isEqualToString:responseCode]){
        [self showTip:@"服务器异常"];
    }
}

@end
