//
//  ZMTeacherEvaluateViewController.m
//  ZMEducation
//
//  Created by Hunter Li on 13-6-4.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import "ZMTeacherEvaluateViewController.h"
#define kTagCourseSelectBtn 1100
#define kTagStudentSelectBtn 1111

#define kTagCourseTableView 1200
#define kTagStudentTableView 1211
#define kTagEvaluateTableView 1213

#define kTagSumStarLabel 2301
#define kTagTotalStarLabel 2302

@implementation ZMTeacherEvaluateViewController

-(IBAction)submitEvaluateClick:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定提交？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alert setTag:kTagEvaluateCommitButton];
    [alert show];
    [alert release];
}

-(void)submitEvaluate{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M023" forKey:@"method"];
    
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[[courseArray objectAtIndex:selectCourseIndex] valueForKey:@"courseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"teacherId"];
    [requestDict setValue:[[studentArray objectAtIndex:selectStudentIndex] valueForKey:@"userId"] forKey:@"studentId"];
    
    [requestDict setValue:[NSNumber numberWithInt:prepareSegmentedControl.selectedSegmentIndex+1] forKey:@"prepare"];
    [requestDict setValue:[NSNumber numberWithInt:activitySegmentedControl.selectedSegmentIndex+1] forKey:@"activity"];
    [requestDict setValue:[NSNumber numberWithInt:processSegmentedControl.selectedSegmentIndex+1] forKey:@"process"];
    [requestDict setValue:[NSNumber numberWithInt:importanceSegmentedControl.selectedSegmentIndex+1] forKey:@"importance"];
    [requestDict setValue:[NSNumber numberWithInt:commonSegmentedControl.selectedSegmentIndex+1] forKey:@"common"];
        
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
    
    NSString* role = [userDict valueForKey:@"role"];
    if ([@"02" isEqualToString:role]) {
        [requestDict setValue:@"M024" forKey:@"method"];
        [requestDict setValue:[[courseArray objectAtIndex:selectCourseIndex] valueForKey:@"courseId"] forKey:@"courseId"];
        [requestDict setValue:[[studentArray objectAtIndex:selectStudentIndex] valueForKey:@"userId"] forKey:@"studentId"];
        [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"teacherId"];
        [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
        [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    }else if([@"03" isEqualToString:role] || [@"04" isEqualToString:role]){
        [requestDict setValue:@"M037" forKey:@"method"];
        [requestDict setValue:[[courseArray objectAtIndex:selectCourseIndex] valueForKey:@"courseId"] forKey:@"courseId"];
        [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
        [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
        [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    }

    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}

-(void)setBackgroundView{
    [self.view setBackgroundColor:[UIColor colorWithRed:217.0/255.0 green:217.0/255.0 blue:217.0/255.0 alpha:1.0]];
}

-(IBAction)segmentAction:(id)sender{
    UISegmentedControl* segmentControl = (UISegmentedControl*)sender;
    int index = segmentControl.tag;

    int sum = prepareSegmentedControl.selectedSegmentIndex+1;
    sum+=activitySegmentedControl.selectedSegmentIndex+1;
    sum+=processSegmentedControl.selectedSegmentIndex+1;
    sum+=importanceSegmentedControl.selectedSegmentIndex+1;
    sum+=commonSegmentedControl.selectedSegmentIndex+1;
    
    
    UITableView* evaluateTableView = (UITableView*)[self.view viewWithTag:kTagEvaluateTableView];
    UITableViewCell* tableViewCell = [evaluateTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    UILabel* totalStarLabel = (UILabel*)[tableViewCell.contentView viewWithTag:kTagTotalStarLabel];
    [totalStarLabel setText:[NSString stringWithFormat:@"%d",sum]];
    
    NSDictionary* evaluateDict = [evaluateArray objectAtIndex:index];
    int totalStars = [[evaluateDict valueForKey:@"totalStars"] intValue];
    UILabel* sumStarLabel = (UILabel*)[tableViewCell.contentView viewWithTag:kTagSumStarLabel];
    [sumStarLabel setText:[NSString stringWithFormat:@"%d",sum+totalStars]];
}
-(void)loadView{
    [super loadView];
    
    UIImage* article_Category_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Category_bg" ofType:@"png"]];
    UIImageView* article_Category_View = [[UIImageView alloc] initWithFrame:CGRectMake(291, 15, 421, 43)];
    [article_Category_View setImage:article_Category_Image];
    [self.view addSubview:article_Category_View];
    [article_Category_View release];
    
    [self addLabel:@"教师评价"
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

-(void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
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
    
    evaluateArray = [[NSMutableArray alloc] initWithCapacity:0];
    CGRect frame = CGRectMake(27, 155, 970, 600);
    UITableView* evaluateTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [evaluateTableView setTag:kTagEvaluateTableView];
    evaluateTableView.delegate = self;
    evaluateTableView.dataSource = self;
    [evaluateTableView setBackgroundColor:[UIColor clearColor]];
    [evaluateTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    UIView* headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 970, 100)];
    UIImage* separater_line_upImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Button_separater_line" ofType:@"png"]];
    UIImageView* separater_line_upView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 970, 2)];
    [separater_line_upView setImage:separater_line_upImage];
    [headView addSubview:separater_line_upView];
    [separater_line_upView release];
    
    [self addLabel:@"姓名"
             frame:CGRectMake(0, 30, 100, 30)
              size:16
          intoView:headView];

    [self addLabel:@"课前准备"
             frame:CGRectMake(110, 10, 120, 30)
              size:16
          intoView:headView];
    [self addLabel:@"课堂活动"
             frame:CGRectMake(250, 10, 120, 30)
              size:16
          intoView:headView];
    [self addLabel:@"写作过程"
             frame:CGRectMake(390, 10, 120, 30)
              size:16
          intoView:headView];
    [self addLabel:@"学习重点"
             frame:CGRectMake(530, 10, 120, 30)
              size:16
          intoView:headView];
    [self addLabel:@"写作常规"
             frame:CGRectMake(670, 10, 120, 30)
              size:16
          intoView:headView];
    
    UIImage* separater_line_midImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Button_separater_line" ofType:@"png"]];
    UIImageView* separater_line_midView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 50, 720, 2)];
    [separater_line_midView setImage:separater_line_midImage];
    [headView addSubview:separater_line_midView];
    [separater_line_midView release];

    for (int i=0; i<5; i++) {
        for (int j=0; j<3; j++) {
            UIImageView* smileImageView = [[UIImageView alloc] init];
            [smileImageView setFrame:CGRectMake(115+142*i+38*j, 60, 31, 31)];
            [smileImageView setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"smile" ofType:@"png"]]];
            [headView addSubview:smileImageView];
            [smileImageView release];
        }
    }

    UIImageView* smileImageView1 = [[UIImageView alloc] init];
    [smileImageView1 setFrame:CGRectMake(845, 15, 31, 31)];
    [smileImageView1 setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"smile" ofType:@"png"]]];
    [headView addSubview:smileImageView1];
    [smileImageView1 release];
    
    UIImageView* smileImageView2 = [[UIImageView alloc] init];
    [smileImageView2 setFrame:CGRectMake(915, 15, 31, 31)];
    [smileImageView2 setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"smile" ofType:@"png"]]];
    [headView addSubview:smileImageView2];
    [smileImageView2 release];
    
    [self addLabel:@"数"
             frame:CGRectMake(830, 60, 60, 30)
              size:16
          intoView:headView];
    [self addLabel:@"累计数"
             frame:CGRectMake(900, 60, 60, 30)
              size:16
          intoView:headView];
    UIImage* separater_line_downImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Button_separater_line" ofType:@"png"]];
    UIImageView* separater_line_downView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 98, 970, 2)];
    [separater_line_downView setImage:separater_line_downImage];
    [headView addSubview:separater_line_downView];
    [separater_line_downView release];
    [evaluateTableView setTableHeaderView:headView];
    [headView release];

    [self.view addSubview:evaluateTableView];
    [evaluateTableView release];
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
    
    UITableView* evaluateTableView = (UITableView*)[self.view viewWithTag:kTagEvaluateTableView];
    [evaluateTableView setDataSource:nil];
    [evaluateTableView setDelegate:nil];
    [evaluateArray release];
    
    [prepareSegmentedControl release];
    [activitySegmentedControl release];
    [processSegmentedControl release];
    [importanceSegmentedControl release];
    [commonSegmentedControl release];
    
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
    }else if(tag == kTagStudentTableView){
        return [studentArray count];
    }else if(tag == kTagEvaluateTableView){
        return [evaluateArray count];
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
    }else if(tag == kTagEvaluateTableView){
        NSDictionary* evaluateDict = [evaluateArray objectAtIndex:indexPath.row];
        [self addLabel:[evaluateDict valueForKey:@"studentName"]
                 frame:CGRectMake(0, 10, 100, 50)
                  size:14
              intoView:cell.contentView];
        
        NSArray *segmentedArray = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",nil];
        prepareSegmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
        prepareSegmentedControl.frame = CGRectMake(112, 15, 120.0, 40);
        
        [prepareSegmentedControl setTag:indexPath.row];
        int prepare = [[evaluateDict valueForKey:@"prepare"] intValue];
        if (prepare != 0 && prepare < 4) {
            prepareSegmentedControl.selectedSegmentIndex = prepare-1;
        }
        [prepareSegmentedControl addTarget:self
                                    action:@selector(segmentAction:)
                          forControlEvents:UIControlEventValueChanged];
        prepareSegmentedControl.tintColor = [UIColor redColor];
        prepareSegmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
        [cell.contentView addSubview:prepareSegmentedControl];
         
        activitySegmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
        activitySegmentedControl.frame = CGRectMake(254, 15, 120.0, 40);
        
        [activitySegmentedControl setTag:indexPath.row];
        int activity = [[evaluateDict valueForKey:@"activity"] intValue];
        if (activity != 0 && activity < 4) {
            activitySegmentedControl.selectedSegmentIndex = activity-1;
        }
        [activitySegmentedControl addTarget:self
                                    action:@selector(segmentAction:)
                          forControlEvents:UIControlEventValueChanged];
        activitySegmentedControl.tintColor = [UIColor redColor];
        activitySegmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
        [cell.contentView addSubview:activitySegmentedControl];

        processSegmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
        processSegmentedControl.frame = CGRectMake(396, 15, 120.0, 40);

        [processSegmentedControl setTag:indexPath.row];
        int process = [[evaluateDict valueForKey:@"process"] intValue];
        if (process != 0 && process < 4) {
            processSegmentedControl.selectedSegmentIndex = process-1;
        }
        [processSegmentedControl addTarget:self
                                    action:@selector(segmentAction:)
                          forControlEvents:UIControlEventValueChanged];
        processSegmentedControl.tintColor = [UIColor redColor];
        processSegmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
        [cell.contentView addSubview:processSegmentedControl];

        importanceSegmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
        importanceSegmentedControl.frame = CGRectMake(538, 15, 120.0, 40);
        
        [importanceSegmentedControl setTag:indexPath.row];
        int importance = [[evaluateDict valueForKey:@"importance"] intValue];
        if (importance != 0 && importance < 4) {
            importanceSegmentedControl.selectedSegmentIndex = importance-1;
        }
        [importanceSegmentedControl addTarget:self
                                    action:@selector(segmentAction:)
                          forControlEvents:UIControlEventValueChanged];
        importanceSegmentedControl.tintColor = [UIColor redColor];
        importanceSegmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
        [cell.contentView addSubview:importanceSegmentedControl];

        commonSegmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
        commonSegmentedControl.frame = CGRectMake(680, 15, 120.0, 40);

        [commonSegmentedControl setTag:indexPath.row];
        int common = [[evaluateDict valueForKey:@"common"] intValue];
        if (common != 0 && common < 4) {
            commonSegmentedControl.selectedSegmentIndex = common-1;
        }
        [commonSegmentedControl addTarget:self
                                    action:@selector(segmentAction:)
                          forControlEvents:UIControlEventValueChanged];
        commonSegmentedControl.tintColor = [UIColor redColor];
        commonSegmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
        [cell.contentView addSubview:commonSegmentedControl];

        [segmentedArray release];
        NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
        NSString* role = [userDict valueForKey:@"role"];
        if ([@"03" isEqualToString:role] || [@"04" isEqualToString:role]) {
            [prepareSegmentedControl setEnabled:NO];
            [activitySegmentedControl setEnabled:NO];
            [processSegmentedControl setEnabled:NO];
            [importanceSegmentedControl setEnabled:NO];
            [commonSegmentedControl setEnabled:NO];
        }
        
        [self addLabel:[NSString stringWithFormat:@"%d",prepare+activity+process+importance+common]
                 frame:CGRectMake(830, 15, 60, 30)
         textAlignment:NSTextAlignmentCenter
                   tag:kTagTotalStarLabel
                  size:14 textColor:[UIColor darkTextColor]
              intoView:cell.contentView];

        int totalStars = [[evaluateDict valueForKey:@"totalStars"] intValue];
        [self addLabel:[NSString stringWithFormat:@"%d",totalStars+prepare+activity+process+importance+common]
                 frame:CGRectMake(900, 15, 60, 30)
         textAlignment:NSTextAlignmentCenter
                   tag:kTagSumStarLabel
                  size:14 textColor:[UIColor darkTextColor]
              intoView:cell.contentView];

        UIImage* separater_lineImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Button_separater_line" ofType:@"png"]];
        UIImageView* separater_lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 68, 970, 2)];
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
    if (tag == kTagEvaluateTableView) {
        return 70;
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
    }else if(tag == kTagEvaluateTableView){
        
    }
    
    [popoverViewController dismissPopoverAnimated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        
    }else if(buttonIndex == 1){
        int tag = alertView.tag;
        if(tag == kTagEvaluateCommitButton){
            [self submitEvaluate];
        }
    }
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
    }else if([@"M024" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        [evaluateArray removeAllObjects];
        
        NSArray* _evaluateArray = [responseDict valueForKey:@"evaluations"];
        for (int i=0; i<[_evaluateArray count]; i++) {
            NSLog(@"evaluate:%@",[_evaluateArray objectAtIndex:i]);
            [evaluateArray addObject:[_evaluateArray objectAtIndex:i]];
        }
        
        UITableView* evaluateTableView = (UITableView*)[self.view viewWithTag:kTagEvaluateTableView];
        
        UIView* footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 970, 110)];
        UIButton* submitBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [submitBut setFrame:CGRectMake(794, 10, 105, 89)];
        [submitBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Submit_Btn" ofType:@"png"]] forState:UIControlStateNormal];
        [submitBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Submit_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
        [submitBut addTarget:self
                      action:@selector(submitEvaluateClick:)
            forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:submitBut];
        
        [evaluateTableView setTableFooterView:footView];
        [footView release];
        
        [evaluateTableView reloadData];
    }else if([@"M037" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        [evaluateArray removeAllObjects];
        
        NSArray* _evaluateArray = [responseDict valueForKey:@"evaluations"];
        for (int i=0; i<[_evaluateArray count]; i++) {
            NSLog(@"evaluate:%@",[_evaluateArray objectAtIndex:i]);
            [evaluateArray addObject:[_evaluateArray objectAtIndex:i]];
        }
        
        UITableView* evaluateTableView = (UITableView*)[self.view viewWithTag:kTagEvaluateTableView];
        [evaluateTableView reloadData];
    }else if([@"M023" isEqualToString:method] && [@"00" isEqualToString:responseCode]){

    }else if(![@"00" isEqualToString:responseCode]){
        [self showTip:@"服务器异常"];
    }
}

@end
