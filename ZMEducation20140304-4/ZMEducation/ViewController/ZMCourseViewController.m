//
//  ZMCourseViewController.m
//  ZMEducation
//
//  Created by Hunter Li on 13-5-29.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import "ZMCourseViewController.h"
#import "ZMHomeViewController.h"

@implementation ZMCourseViewController
@synthesize gradeArray = _gradeArray;

-(IBAction)gradeClick:(id)sender{
    UIButton* gradeButton = (UIButton*)sender;
    int index = gradeButton.tag;
    
    NSDictionary* gradeDict = [_gradeArray objectAtIndex:index];
    selectGrade = [[gradeDict valueForKey:@"gradeId"] intValue];
    grade = [gradeDict valueForKey:@"grade"];

    ((ZMAppDelegate *)[UIApplication sharedApplication].delegate).grade = grade;
    
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M004" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:[NSNumber numberWithInt:selectGrade] forKey:@"gradeId"];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}

-(IBAction)classClick:(id)sender{
    UIButton* classButton = (UIButton*)sender;
    int index = classButton.tag;
    
    NSDictionary* classDict = [classArray objectAtIndex:index];
    selectClass = [[classDict valueForKey:@"classId"] intValue];
    
    [courseView reloadData];
}

-(IBAction)courseClick:(id)sender{
    UIButton* lectureButton = (UIButton*)sender;
    int index = lectureButton.tag;
    
    NSDictionary* courseDict = [courseArray objectAtIndex:index];
    selectCourse = [[courseDict valueForKey:@"courseId"] intValue];
    course = [courseDict valueForKey:@"course"];
    sort = [courseDict valueForKey:@"sort"];
    courseSort = [courseDict valueForKey:@"courseSort"];
    
    ((ZMAppDelegate *)[UIApplication sharedApplication].delegate).course = course;
    ((ZMAppDelegate *)[UIApplication sharedApplication].delegate).sort = sort;
    ((ZMAppDelegate *)[UIApplication sharedApplication].delegate).courseSort = courseSort;
    ((ZMAppDelegate *)[UIApplication sharedApplication].delegate).isdownfinsh = NO;
    
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M005" forKey:@"method"];
    [requestDict setValue:[NSNumber numberWithInt:selectCourse] forKey:@"courseId"];
    [requestDict setValue:[NSNumber numberWithInt:selectClass] forKey:@"classId"];
    [requestDict setValue:[NSNumber numberWithInt:selectGrade] forKey:@"gradeId"];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
    
    
}

-(void)dealloc{
    [gradeView setDataSource:nil];
    [gradeView setDelegate:nil];
    [gradeView release];
    [_gradeArray release];
    
    [classView setDataSource:nil];
    [classView setDelegate:nil];
    [classView release];
    [classArray release];
    
    [courseView setDataSource:nil];
    [courseView setDelegate:nil];
    [courseView release];
    [courseArray release];
    
    [moduleArray release];
    
    [self.request cancel];
    [self.request setDelegate:nil];
    [self.netWorkQueue cancelAllOperations];
    self.netWorkQueue.delegate = nil;
    
    [super dealloc];
}

-(void)loadView{
    [super loadView];
    


    CGRect bgFrame = CGRectMake(0, 0, 1024, 768);
    UIImage* bgImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Menu_bg" ofType:@"png"]];
    UIImageView* bgView = [[UIImageView alloc] initWithFrame:bgFrame];
    [bgView setImage:bgImage];
    [self.view insertSubview:bgView atIndex:0];
    [bgView release];
    
    
}

- (void)viewDidLoad{
    [super viewDidLoad];
	
    moduleArray = [[NSMutableArray alloc] initWithCapacity:10];
    
    UIImage* gradeImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Course_Bg" ofType:@"png"]];
    UIImageView* gradeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(70, 226, 214, 416)];
    [gradeImageView setImage:gradeImage];
    [self.view addSubview:gradeImageView];
    [gradeImageView release];

    gradeView = [[JTListView alloc] initWithFrame:CGRectMake(70,226,214,416)
                                           layout:JTListViewLayoutTopToBottom];
    [gradeView setDataSource:self];
    [gradeView setDelegate:self];
    //[gradeView setScrollEnabled:NO];
    [gradeView setGapBetweenItems:10.0f];
    [self.view addSubview:gradeView];
    [gradeView reloadData];
    
    UIImage* course_Arrow_UpImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Course_Arrow_Up" ofType:@"png"]];
    UIImageView* course_Arrow_UpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(300, 480, 81, 45)];
    [course_Arrow_UpImageView setImage:course_Arrow_UpImage];
    [self.view addSubview:course_Arrow_UpImageView];
    [course_Arrow_UpImageView release];

    UIImage* classImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Course_Bg" ofType:@"png"]];
    UIImageView* classImageView = [[UIImageView alloc] initWithFrame:CGRectMake(400, 226, 214, 416)];
    [classImageView setImage:classImage];
    [self.view addSubview:classImageView];
    [classImageView release];

    classArray = [[NSMutableArray alloc] initWithCapacity:10];
    classView = [[JTListView alloc] initWithFrame:CGRectMake(400,226,214,416)
                                           layout:JTListViewLayoutTopToBottom];
    [classView setDataSource:self];
    [classView setDelegate:self];
    //[classView setScrollEnabled:NO];
    [classView setGapBetweenItems:10.0f];
    [self.view addSubview:classView];
    
    UIImage* course_Arrow_DownImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Course_Arrow_Down" ofType:@"png"]];
    UIImageView* course_Arrow_DownImageView = [[UIImageView alloc] initWithFrame:CGRectMake(630, 326, 81, 45)];
    [course_Arrow_DownImageView setImage:course_Arrow_DownImage];
    [self.view addSubview:course_Arrow_DownImageView];
    [course_Arrow_DownImageView release];

    UIImage* courseImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Course_Bg" ofType:@"png"]];
    UIImageView* courseImageView = [[UIImageView alloc] initWithFrame:CGRectMake(730, 226, 214, 416)];
    [courseImageView setImage:courseImage];
    [self.view addSubview:courseImageView];
    [courseImageView release];

    courseArray = [[NSMutableArray alloc] initWithCapacity:10];
    courseView = [[JTListView alloc] initWithFrame:CGRectMake(730,226,214,416)
                                           layout:JTListViewLayoutTopToBottom];
    [courseView setDataSource:self];
    [courseView setDelegate:self];
    //[courseView setScrollEnabled:YES];
    [courseView setGapBetweenItems:10.0f];
    [self.view addSubview:courseView];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - JTListViewDataSource
- (NSUInteger)numberOfItemsInListView:(JTListView *)listView{
    if (listView == gradeView) {
        return [_gradeArray count];
    }else if(listView == classView){
        return  [classArray count];
    }else if(listView == courseView){
        return [courseArray count];
    }

    return 0;
}

- (UIView *)listView:(JTListView *)listView viewForItemAtIndex:(NSUInteger)index{
    UIView *view = [listView dequeueReusableView];
    for(UIView* subView in [view subviews]){
        [subView removeFromSuperview];
    }
    
    if (!view) {
        view = [[[UIView alloc] init] autorelease];
    }
    
    if (listView == gradeView) {
        UIButton* gradeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [gradeButton setTag:index];
        [gradeButton setFrame:CGRectMake(50, 16.0f, 111, 120)];
        [gradeButton setImage:[UIImage imageWithContentsOfFile:
                               [[NSBundle mainBundle] pathForResource:@"Grade_Icon" ofType:@"png"]]
                     forState:UIControlStateNormal];
        [gradeButton setImage:[UIImage imageWithContentsOfFile:
                               [[NSBundle mainBundle] pathForResource:@"Grade_Icon" ofType:@"png"]]
                     forState:UIControlStateHighlighted];
        [gradeButton addTarget:self action:@selector(gradeClick:)
              forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:gradeButton];
        
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(125, 20.0f, 30.0f, 30.0f)];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        NSDictionary* gradeDict = [_gradeArray objectAtIndex:index];
        [titleLabel setText:[gradeDict valueForKey:@"grade"]];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setMinimumScaleFactor:1.0];
        [titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:20]];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [view addSubview:titleLabel];
        [titleLabel release];
    }else if(listView == classView){
        UIButton* classButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [classButton setTag:index];
        [classButton setFrame:CGRectMake(54, 16.0f, 105, 110)];
        [classButton setImage:[UIImage imageWithContentsOfFile:
                               [[NSBundle mainBundle] pathForResource:@"Class_Icon" ofType:@"png"]]
                     forState:UIControlStateNormal];
        [classButton setImage:[UIImage imageWithContentsOfFile:
                               [[NSBundle mainBundle] pathForResource:@"Class_Icon" ofType:@"png"]]
                     forState:UIControlStateHighlighted];
        [classButton addTarget:self action:@selector(classClick:)
              forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:classButton];
        
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(125, 20.0f, 30.0f, 30.0f)];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        NSDictionary* classDict = [classArray objectAtIndex:index];
        [titleLabel setText:[classDict valueForKey:@"class"]];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setMinimumScaleFactor:1.0];
        [titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:20]];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [view addSubview:titleLabel];
        [titleLabel release];
    }else if(listView == courseView){
        UIButton* courseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [courseButton setTag:index];
        [courseButton setFrame:CGRectMake(53, 16.0f, 108, 107)];
        [courseButton setImage:[UIImage imageWithContentsOfFile:
                               [[NSBundle mainBundle] pathForResource:@"Course_Icon" ofType:@"png"]]
                     forState:UIControlStateNormal];
        [courseButton setImage:[UIImage imageWithContentsOfFile:
                               [[NSBundle mainBundle] pathForResource:@"Course_Icon" ofType:@"png"]]
                     forState:UIControlStateHighlighted];
        [courseButton addTarget:self action:@selector(courseClick:)
              forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:courseButton];
        
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(128, 20.0f, 30.0f, 30.0f)];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        NSDictionary* courseDict = [courseArray objectAtIndex:index];
        int courseId = [[courseDict valueForKey:@"sort"] intValue];
        [titleLabel setText:[NSString stringWithFormat:@"%d",courseId]];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setMinimumScaleFactor:1.0];
        [titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:20]];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [view addSubview:titleLabel];
        [titleLabel release];
    }

    
    return view;
}


#pragma mark - JTListViewDelegate
- (void)listView:(JTListView *)listView willDisplayView:(UIView *)view forItemAtIndex:(NSUInteger)index{
}

- (CGFloat)listView:(JTListView *)listView widthForItemAtIndex:(NSUInteger)index{
    return 214;
}

- (CGFloat)listView:(JTListView *)listView heightForItemAtIndex:(NSUInteger)index{
    return 126;
}

#pragma mark ZMHttpEngineDelegate
-(void)httpEngine:(ZMHttpEngine *)httpEngine didSuccess:(NSDictionary *)responseDict{
    [super httpEngine:httpEngine didSuccess:responseDict];
    
    NSString* method = [responseDict valueForKey:@"method"];
    NSString* responseCode = [responseDict valueForKey:@"responseCode"];
    if ([@"M004" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        [classArray removeAllObjects];
        NSArray* _classArray = [responseDict valueForKey:@"classes"];
        for (int i=0; i<[_classArray count]; i++) {
            NSLog(@"class:%@",[_classArray objectAtIndex:i]);
            [classArray addObject:[_classArray objectAtIndex:i]];
        }
        [classView reloadData];
        
        [courseArray removeAllObjects];
        NSArray* _courseArray = [responseDict valueForKey:@"courses"];
        for (int i=0; i<[_courseArray count]; i++) {
            NSLog(@"course:%@",[_courseArray objectAtIndex:i]);
            [courseArray addObject:[_courseArray objectAtIndex:i]];
        }
    }else if([@"M005" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        [moduleArray removeAllObjects];
        
        NSArray* _moduleArray = [responseDict valueForKey:@"modules"];
        for (int i=0; i<[_moduleArray count]; i++) {
            NSLog(@"module:%@",[_moduleArray objectAtIndex:i]);
            [moduleArray addObject:[_moduleArray objectAtIndex:i]];
        }
        
        NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
        [requestDict setValue:@"M010" forKey:@"method"];
        [requestDict setValue:[NSNumber numberWithInt:selectGrade] forKey:@"currentGradeId"];
        [requestDict setValue:[NSNumber numberWithInt:selectClass] forKey:@"currentClassId"];
        [requestDict setValue:[NSNumber numberWithInt:selectCourse] forKey:@"currentCourseId"];
        NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
        [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];

        ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
        [httpEngine setDelegate:self];
        [httpEngine requestWithDict:requestDict];
        [httpEngine release];
        [requestDict release];
    }else if([@"M010" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
        [userDict setValue:[NSNumber numberWithInt:selectGrade] forKey:@"currentGradeId"];
        [userDict setValue:[NSNumber numberWithInt:selectClass] forKey:@"currentClassId"];
        [userDict setValue:[NSNumber numberWithInt:selectCourse] forKey:@"currentCourseId"];
        
        ZMHomeViewController* homeView = [[ZMHomeViewController alloc] init];
        [homeView setModuleArray:moduleArray];
        [self.navigationController pushViewController:homeView animated:YES];
        [homeView release];
        
        NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
        [requestDict setValue:@"M102" forKey:@"method"];
        [requestDict setValue:[NSNumber numberWithInt:selectGrade] forKey:@"gradeId"];
        [requestDict setValue:[NSNumber numberWithInt:selectCourse] forKey:@"courseId"];
        
        ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
        [httpEngine setDelegate:self];
        [httpEngine requestWithDict:requestDict];
        [httpEngine release];
        [requestDict release];

        
    }else if([@"M102" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
    
        NSMutableArray* fileArray = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate fileArray];
        [fileArray removeAllObjects];
        NSArray * _units = [responseDict valueForKey:@"units"];
        for (int i=0; i<[_units count]; i++) {
            NSLog(@"course:%@",[_units objectAtIndex:i]);
            [fileArray addObject:[_units objectAtIndex:i]];
        }

        NSString *str = ((ZMAppDelegate*)[UIApplication sharedApplication].delegate).fileCache;
        
        if ([str isEqualToString:@"01"]) {
            [(ZMAppDelegate*)[UIApplication sharedApplication].delegate request1];
        }
        
    }else if(![@"00" isEqualToString:responseCode]){
        [self showTip:@"服务器异常"];
    }
}

//#pragma mark ASIHTTPRequestDelegate method
////ASIHTTPRequestDelegate,下载之前获取信息的方法,主要获取下载内容的大小，可以显示下载进度多少字节
//-(void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders{
//    
//    NSLog(@"didReceiveResponseHeaders-%@",[responseHeaders valueForKey:@"Content-Length"]);
//    
//    
//    NSLog(@"contentlength=%f",request.contentLength/1024.0/1024.0);
//    NSString * pdfID = [request.userInfo objectForKey:@"pdfID"] ;
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    float tempConLen = [[userDefaults objectForKey:[NSString stringWithFormat:@"pdf_%@_contentLength",pdfID]] floatValue];
//    NSLog(@"tempConLen=%f",tempConLen);
//    //如果没有保存,则持久化他的内容大小
//    if (tempConLen == 0 ) {//如果没有保存,则持久化他的内容大小
//        [userDefaults setObject:[NSNumber numberWithFloat:request.contentLength/1024.0/1024.0] forKey:[NSString stringWithFormat:@"pdf_%@_contentLength",pdfID]];
//    }
//}
//
//-(void) requestFinished:(ASIHTTPRequest *)request{
//    NSString * pdfID = [request.userInfo objectForKey:@"pdfID"] ;
//    
//    currentDownloadLength--;
//    
//    NSLog(@"%@.pdf has been downloaded!",pdfID);
//    NSLog(@"还有%d文件没有下载完成",currentDownloadLength);
//    
//    if (currentDownloadLength == 0) {
//        //将当前选择的年级和课程加入userDefault中
//        
//        //currentDownloadLength = [fileArray count];
//        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//        
//        hasDownloadedDictArray = [[NSMutableArray alloc]initWithArray:[userDefaults objectForKey:@"hasDownloadedDictArray"]];
//        
//        NSDictionary * currentGradeAndCourse = [[NSDictionary alloc]initWithObjectsAndKeys:grade,@"grade",
//                                                course,@"course",currentDownloadArray,@"files",[(ZMAppDelegate*)[UIApplication sharedApplication].delegate fileArray],@"filesinfo",sort,@"sort",courseSort,@"courseSort",nil];
//        for (NSDictionary *dic in hasDownloadedDictArray) {
//            if ([dic[@"course"] isEqualToString:currentGradeAndCourse[@"course"]]) {
//                [hasDownloadedDictArray removeObject:dic];
//                break;
//            }
//        }
//        
//        [hasDownloadedDictArray addObject:currentGradeAndCourse];
//        [userDefaults setValue:hasDownloadedDictArray forKey:@"hasDownloadedDictArray"];
//        
//        NSLog(@"%@",[userDefaults objectForKey:@"hasDownloadedDictArray"]);
//        
//        
//    }
//
//}
@end
