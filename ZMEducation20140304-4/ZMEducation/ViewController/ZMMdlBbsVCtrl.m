#import "ZMMdlBbsVCtrl.h"
//#import "RegexKitLite.h"

/*#define kTagCourseSelectBtn 1100
#define kTagCourseTableView 1200*/

#define kTagForumSelectBtn2 1130
#define kTagForumTableView2 1230

#define kTagForumSelectBtn 1110
#define kTagForumTableView 1210

#define kTagBbsTableView 1300
#define kTagCloseGousiBtn 20131123

#import "ZMShitiSwipeViewController.h"
#import "ZMGousiSwipeViewController.h"
#import "ZMZuoYeViewController.h"

@implementation ZMMdlBbsVCtrl

-(void)loadView
{
    [super loadView];
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768) ];
    view.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
    self.view = view;
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
   //Course_Arr = [[NSMutableArray alloc]init];
    Forum_Arr_User = [[NSMutableArray alloc]init];
    Forum_Arr_Course = [[NSMutableArray alloc]init];
    Bbs_Arr = [[NSMutableArray alloc]init];
    //isGetForumByCourse = NO;
    
    {
        UIImageView * IV_Bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
         IV_Bg.image = [UIImage imageNamed:@"bg_bbs.png"];
         [self.view addSubview:IV_Bg];
    }
    
    {
        UIImage* article_Category_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Category_bg" ofType:@"png"]];
        UIImageView* article_Category_View = [[UIImageView alloc] initWithFrame:CGRectMake(291, 15, 421, 43)];
        [article_Category_View setImage:article_Category_Image];
        [self.view addSubview:article_Category_View];
        [article_Category_View release];
        
        [self addLabel:@"班级论坛"
                 frame:CGRectMake(291, 20, 421, 30)
                  size:18
              intoView:self.view];
    }
    
    
   
    //提交论坛主题选择
    {
        UIButton* forumSelectBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [forumSelectBut setTag:kTagForumSelectBtn];
        [forumSelectBut setFrame:CGRectMake(12, 117, 263, 38)];
        [forumSelectBut setTitleEdgeInsets:UIEdgeInsetsMake(0, 0.0, 0.0, 20.0)];
        [forumSelectBut setTitle:@"请选择主题" forState:UIControlStateNormal];
        [forumSelectBut setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [forumSelectBut addTarget:self
                            action:@selector(forumSelectClick:)
                  forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:forumSelectBut];
        //[forumSelectBut release];
    }
    
    {
        TV_Draft_Content = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(25, 190, 245.0f, 415)];
        
        TV_Draft_Content.text = @"";
        
        TV_Draft_Content.backgroundColor = [UIColor clearColor];
        TV_Draft_Content.font = [UIFont systemFontOfSize:18];
        
        [self.view addSubview:TV_Draft_Content];
        

        
    }
    
    //删除课程选择 update 20131201
    /*{
        UIButton* courseSelectBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [courseSelectBut setTag:kTagCourseSelectBtn];
        [courseSelectBut setFrame:CGRectMake(440, 105, 150, 38)];
        [courseSelectBut setTitleEdgeInsets:UIEdgeInsetsMake(0, 0.0, 0.0, 20.0)];
        [courseSelectBut setTitle:@"请选择课程" forState:UIControlStateNormal];
        [courseSelectBut setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [courseSelectBut addTarget:self
                            action:@selector(courseSelectClick:)
                  forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:courseSelectBut];
        
    }*/
    //查询论坛主题选择
    {
        UIButton* forumSelectBut2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [forumSelectBut2 setTag:kTagForumSelectBtn2];
        [forumSelectBut2 setFrame:CGRectMake(450, 105, 308, 38)];
        [forumSelectBut2 setTitleEdgeInsets:UIEdgeInsetsMake(0, 0.0, 0.0, 20.0)];
        [forumSelectBut2 setTitle:@"请选择主题" forState:UIControlStateNormal];
        [forumSelectBut2 setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [forumSelectBut2 addTarget:self
                           action:@selector(forumSelectClick2:)
                 forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:forumSelectBut2];
    }
    
    
    
    {
        
        UIButton* backBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBut setFrame:CGRectMake(950, 10, 47, 47)];
        [backBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Close_Btn" ofType:@"png"]] forState:UIControlStateNormal];
        [backBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Close_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
        [backBut addTarget:self
                    action:@selector(backClick:)
          forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:backBut];
    }
    {
        UIButton* submitBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [submitBut setFrame:CGRectMake(180, 650, 105, 89)];
        [submitBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Submit_Btn" ofType:@"png"]] forState:UIControlStateNormal];
        [submitBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Submit_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
        [submitBut addTarget:self
                      action:@selector(submitClick:)
            forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:submitBut];
    }
    {
        UIButton* query_But = [UIButton buttonWithType:UIButtonTypeCustom];
        [query_But setFrame:CGRectMake(905, 93, 71, 61)];
        [query_But setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Query_Btn" ofType:@"png"]] forState:UIControlStateNormal];
        [query_But setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Query_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
        [query_But addTarget:self
                      action:@selector(queryClick:)
            forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:query_But];
    }
    
    
    [self getForumTitle];
    //[self getCourses];

    self.panBtn = [[UIButton alloc]initWithFrame:CGRectMake(948, 500, 50, 50)];
    self.panBtn.backgroundColor = [UIColor grayColor];
    self.panBtn.layer.cornerRadius = 8;
    self.panBtn.layer.masksToBounds = YES;
    self.panBtn.alpha = 0.9;
    [self.panBtn addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.panBtn];
    
    self.gousiBtn = [[UIButton alloc]init];
    self.gousiBtn.backgroundColor = [UIColor grayColor];
    [self.gousiBtn setTitle:@"构思图表" forState:UIControlStateNormal];
    [self.gousiBtn addTarget:self action:@selector(gousi) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.gousiBtn];
    self.gousiBtn.hidden = YES;
    
    self.zuoyeBtn = [[UIButton alloc]init];
    self.zuoyeBtn.backgroundColor = [UIColor grayColor];
    [self.zuoyeBtn setTitle:@"我的文稿" forState:UIControlStateNormal];
    [self.zuoyeBtn addTarget:self action:@selector(zuoye) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.zuoyeBtn];
    self.zuoyeBtn.hidden = YES;
    
    self.luntanBtn = [[UIButton alloc]init];
    self.luntanBtn.backgroundColor = [UIColor grayColor];
    [self.luntanBtn setTitle:@"论坛" forState:UIControlStateNormal];
    [self.luntanBtn addTarget:self action:@selector(luntan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.luntanBtn];
    self.luntanBtn.hidden = YES;
    
    self.shijuanBtn = [[UIButton alloc]init];
    self.shijuanBtn.backgroundColor = [UIColor grayColor];
    [self.shijuanBtn setTitle:@"习题" forState:UIControlStateNormal];
    [self.shijuanBtn addTarget:self action:@selector(shijuan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.shijuanBtn];
    self.shijuanBtn.hidden = YES;
    
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestures:)];
    self.panGestureRecognizer.minimumNumberOfTouches = 1;
    self.panGestureRecognizer.maximumNumberOfTouches = 1;
    [self.panBtn addGestureRecognizer:self.panGestureRecognizer];
    
    UITapGestureRecognizer *TAP = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:TAP];

  
}

-(void)tap
{
    self.gousiBtn.hidden = NO;
    self.zuoyeBtn.hidden = NO;
    self.luntanBtn.hidden = NO;
    self.shijuanBtn.hidden = NO;
    
    self.gousiBtn.frame = CGRectMake(self.panBtn.frame.origin.x, self.panBtn.frame.origin.y - 100, self.panBtn.frame.size.width + 50, self.panBtn.frame.size.height);
    self.zuoyeBtn.frame = CGRectMake(self.panBtn.frame.origin.x, self.panBtn.frame.origin.y + 100, self.panBtn.frame.size.width + 50, self.panBtn.frame.size.height);
    self.luntanBtn.frame = CGRectMake(self.panBtn.frame.origin.x - 100, self.panBtn.frame.origin.y, self.panBtn.frame.size.width + 50, self.panBtn.frame.size.height);
    self.shijuanBtn.frame = CGRectMake(self.panBtn.frame.origin.x + 100, self.panBtn.frame.origin.y, self.panBtn.frame.size.width + 50, self.panBtn.frame.size.height);
    
    self.panBtn.hidden = YES;
    
}

-(void)gousi
{
    self.gousiBtn.hidden = YES;
    self.zuoyeBtn.hidden = YES;
    self.luntanBtn.hidden = YES;
    self.shijuanBtn.hidden = YES;
    
    self.panBtn.hidden = NO;
    
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

-(void)zuoye
{
    self.gousiBtn.hidden = YES;
    self.zuoyeBtn.hidden = YES;
    self.luntanBtn.hidden = YES;
    self.shijuanBtn.hidden = YES;
    
    self.panBtn.hidden = NO;
    
    NSMutableDictionary * userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary * requestDict = [[NSMutableDictionary alloc]init];
    
    [requestDict setValue:@"M069" forKey:@"method"];
    
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"authorId"];

    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}

-(void)luntan
{
    self.gousiBtn.hidden = YES;
    self.zuoyeBtn.hidden = YES;
    self.luntanBtn.hidden = YES;
    self.shijuanBtn.hidden = YES;
    
    self.panBtn.hidden = NO;
}

-(void)shijuan
{
    self.gousiBtn.hidden = YES;
    self.zuoyeBtn.hidden = YES;
    self.luntanBtn.hidden = YES;
    self.shijuanBtn.hidden = YES;
    
    self.panBtn.hidden = NO;
    
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

-(void)tap:(UITapGestureRecognizer *)sender
{
    self.gousiBtn.hidden = YES;
    self.zuoyeBtn.hidden = YES;
    self.luntanBtn.hidden = YES;
    self.shijuanBtn.hidden = YES;
    
    self.panBtn.hidden = NO;
    
}

-(void)handlePanGestures:(UIPanGestureRecognizer *)paramSender{
    if (paramSender.state != UIGestureRecognizerStateEnded && paramSender.state != UIGestureRecognizerStateFailed) {
        CGPoint location = [paramSender locationInView:paramSender.view.superview];
        paramSender.view.center = location;
    }
}


//获取课程
/*-(void)getCourses{
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
}*/

//根据自身信息获取论坛主题
-(void)getForumTitle{

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

-(void)queryClick:(UIButton *)sender
{
    
    if ([Forum_Arr_Course count] > 0 ) {
        UITableView * exitTB = (UITableView *)[self.view viewWithTag : kTagBbsTableView];
        [exitTB removeFromSuperview];
        NSMutableDictionary * userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
        NSMutableDictionary * requestDict = [[NSMutableDictionary alloc]init];
        
        [requestDict setValue:@"M053" forKey:@"method"];
        
        NSString *  forumID =[[Forum_Arr_Course objectAtIndex:selectForumIndex2] valueForKey:@"forumTitleId"];
        [requestDict setValue:forumID forKey:@"forumTitleId"];//主题
        //[requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"]; comment 20131030
        [requestDict setValue:@"" forKey:@"userId"];
        [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
        [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
        [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
        ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
        [httpEngine setDelegate:self];
        [httpEngine requestWithDict:requestDict];
        [httpEngine release];
        [requestDict release];
    }else
    {
        [self showTip:@"请选择论坛主题"];
    }
    
}

-(void)submitClick:(UIButton *)sender
{
    NSString * answer = TV_Draft_Content.text;
    answer = [answer  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //stringByTrimmingCharactersInSet:whitespace
    if ([answer length] != 0) {
        NSMutableDictionary * userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
        NSMutableDictionary * requestDict = [[NSMutableDictionary alloc]init];
        
        [requestDict setValue:@"M052" forKey:@"method"];
        NSString *  forumID =[[Forum_Arr_User objectAtIndex:selectForumIndex] valueForKey:@"forumTitleId"];
        [requestDict setValue:forumID forKey:@"forumTitleId"];//主题
        [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
        [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
        [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
        [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
        //forumContent
        [requestDict setValue:TV_Draft_Content.text forKey:@"forumContent"];
        ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
        [httpEngine setDelegate:self];
        [httpEngine requestWithDict:requestDict];
        [httpEngine release];
        [requestDict release];
    }else{
    
        [self showTip:@"请输入内容后提交！"];
    }
    
    
}

#pragma mark ZMHttpEngineDelegate
-(void)httpEngine:(ZMHttpEngine *)httpEngine didSuccess:(NSDictionary *)responseDict{
    [super httpEngine:httpEngine didSuccess:responseDict];
    NSString* method = [responseDict valueForKey:@"method"];
    NSString* responseCode = [responseDict valueForKey:@"responseCode"];
    
    if ([@"M051" isEqualToString:method] && [@"00" isEqualToString:responseCode]) //获取主题列表
    {
        /*if (isGetForumByCourse) {
            Forum_Arr_Course = [[NSMutableArray alloc]initWithArray:[responseDict valueForKey:@"forumTitles"]];
                            UIButton* forumBtn = (UIButton*)[self.view viewWithTag:kTagForumSelectBtn2];
                [forumBtn setTitle:@"请选择主题" forState:UIControlStateNormal];
                
        }else{*/
            Forum_Arr_User =[[NSMutableArray alloc]initWithArray:[responseDict valueForKey:@"forumTitles"]];
        Forum_Arr_Course = [[NSMutableArray alloc]initWithArray:[responseDict valueForKey:@"forumTitles"]];
        //}
        
        //[bbsListView reloadData];
        
    }
    else if ([@"M053" isEqualToString:method] && [@"00" isEqualToString:responseCode]) //获取帖子列表
    {
        Bbs_Arr = [[NSMutableArray alloc]initWithArray:[responseDict valueForKey:@"forums"]];
         CGRect frame = CGRectMake(305, 240, 688, 490);
        UITableView * bbsTableView = [[UITableView alloc] initWithFrame:frame];
        [bbsTableView setTag:kTagBbsTableView];
        bbsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        bbsTableView.delegate = self;
        bbsTableView.dataSource = self;
        [bbsTableView setBackgroundColor:[UIColor clearColor]];
        
        //[tableViewController setTableView:moduleTableView];
        
        [self.view addSubview:bbsTableView];
        [bbsTableView release];
        
    }
    else if ([@"M004" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
       //Course_Arr = [responseDict valueForKey:@"courses"];
        //Course_Arr = [[NSMutableArray alloc]initWithArray:[responseDict valueForKey:@"courses"]];
        
        /*
        
        UIButton* courseBtn = (UIButton*)[self.view viewWithTag:kTagCourseSelectBtn];
        selectCourseIndex = 0;
        NSDictionary* courseDict = [courseArray objectAtIndex:selectCourseIndex];
        [courseBtn setTitle:[courseDict valueForKey:@"course"] forState:UIControlStateNormal];
        
        [self getModules];
         */
    }
    else if ([@"M052" isEqualToString:method] && [@"00" isEqualToString:responseCode]) //提交论坛内容
    {
        [self showTip:@"论坛提交成功"];
        TV_Draft_Content.text = @"";
        
        
    }else if ([@"M061" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        //NSArray* dataSource = [responseDict valueForKey:@"units"];
        NSMutableArray * dataSource = [[NSMutableArray alloc]initWithArray:[responseDict valueForKey:@"units"]];
        if ([dataSource count] > 0) {
            
            ZMShitiSwipeViewController * vc = [[ZMShitiSwipeViewController alloc] init];
            //                [vc setDelegate:self];
            [vc setUnitArray:dataSource];
            [self presentViewController:vc animated:YES completion:NULL];
            
        }else{
            
            [self showTip:@"没有内容！"];
            
        }
        
    }else if ([@"M044" isEqualToString:method] && [@"00" isEqualToString:responseCode])
    { //获取构思列表
        
        //NSMutableArray * dataSource = [[NSMutableArray alloc]initWithArray:[responseDict valueForKey:@"units"]];
        NSArray* dataSource = [responseDict valueForKey:@"units"];
        NSMutableArray * dataSourceArr = [[NSMutableArray alloc]init];
        if ([dataSource count] > 0) {
            
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
            //                [vc setDelegate:self];
            [vc setUnitArray:dataSourceArr];
            [self presentViewController:vc animated:YES completion:NULL];
            [vc release];
        }else{
            
            [self showTip:@"没有内容！"];
            
        }
        
    }else if([@"M069" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        
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


    else if(![@"00" isEqualToString:responseCode]){
        [self showTip:@"服务器异常"];
    }
}




/*-(IBAction)courseSelectClick:(id)sender{
    UITableViewController *tableViewController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    CGRect frame = CGRectMake(0, 0, 263, 240);
    UITableView* courseTableView = [[UITableView alloc] initWithFrame:frame];
    //[courseTableView setTag:kTagForumTableView];
    [courseTableView setTag:kTagCourseTableView];
    courseTableView.delegate = self;
    courseTableView.dataSource = self;
    [tableViewController setTableView:courseTableView];
    [courseTableView release];
    
    popoverViewController = [[JHPopoverViewController alloc] initWithViewController:tableViewController andContentSize:frame.size];
    [popoverViewController presentPopoverFromRect:[(UIButton*)sender frame] inView:self.view animated:YES];
    [tableViewController release];
    
}*/

-(IBAction)forumSelectClick:(UIButton * )sender{
    UITableViewController *tableViewController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    CGRect frame = CGRectMake(0, 0, 320, 240);
    UITableView * moduleTableView = [[UITableView alloc] initWithFrame:frame];
    [moduleTableView setTag:kTagForumTableView];
    moduleTableView.delegate = self;
    moduleTableView.dataSource = self;
    [tableViewController setTableView:moduleTableView];
    [moduleTableView release];
    
    popoverViewController = [[UIPopoverController alloc] initWithContentViewController:tableViewController];
    
    
     [popoverViewController setPopoverContentSize:CGSizeMake(330,330)];
     [popoverViewController presentPopoverFromRect:((UIView *)sender).frame
                              inView:self.view
                     permittedArrowDirections:UIPopoverArrowDirectionAny
                                     animated:YES];
    
    [tableViewController release];
    
    
}

-(IBAction)forumSelectClick2:(UIButton * )sender{
    UITableViewController *tableViewController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    CGRect frame = CGRectMake(0, 30, 320, 240);
    UITableView * moduleTableView = [[UITableView alloc] initWithFrame:frame];
    [moduleTableView setTag:kTagForumTableView2];
    moduleTableView.delegate = self;
    moduleTableView.dataSource = self;
    [tableViewController setTableView:moduleTableView];
    [moduleTableView release];
    
    popoverViewController = [[UIPopoverController alloc] initWithContentViewController:tableViewController];
    
    
    [popoverViewController setPopoverContentSize:CGSizeMake(330,330)];
    [popoverViewController presentPopoverFromRect:((UIView *)sender).frame
                                           inView:self.view
                         permittedArrowDirections:UIPopoverArrowDirectionAny
                                         animated:YES];
    
    
    [tableViewController release];
}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        
    }else if(buttonIndex == 1){
        int tag = alertView.tag;
        if (tag == kTagCloseGousiBtn) {
            //            [self.delegate ZMGousiSwipeViewDidClose:self];
            
            [self.navigationController popViewControllerAnimated:YES];
            [self dismissModalViewControllerAnimated:YES];
            
        }
    }
}

-(IBAction)backClick:(id)sender
{
  /*  [self screenLocked];
 
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSString* screenControl = [userDict valueForKey:@"screenControl"];
    NSString* role = [userDict valueForKey:@"role"];
    if ([@"02" isEqualToString:role] ||
        (([@"03" isEqualToString:role] || [@"04" isEqualToString:role])&& [@"01" isEqualToString:screenControl])) {
        if ([@"00" isEqualToString:screenControl]) {
            NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
            [requestDict setValue:@"M013" forKey:@"method"];
            [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
            [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
            [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
            [requestDict setValue:[userDict valueForKey:@"currentModuleId"] forKey:@"moduleId"];
            [requestDict setValue:[_unitDict valueForKey:@"unitId"] forKey:@"unitId"];
            
            [requestDict setValue:@"02" forKey:@"control"];
            
            ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
            [httpEngine setDelegate:self];
            [httpEngine requestWithDict:requestDict];
            [httpEngine release];
            [requestDict release];
        }else{*/
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定关闭？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alert setTag:kTagCloseGousiBtn];
    [alert show];
    [alert release];

    
        //}
    //}
}



#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSLog(@"[tableDataSourceArray count]:%d",[_dataSource count]);
    int tag = tableView.tag;
    
    /*if (tag == kTagCourseTableView) {
        return [Course_Arr count];
    }else */if(tag == kTagForumTableView){
        return [Forum_Arr_User count];
    }
    else if(tag == kTagForumTableView2){
        return [Forum_Arr_Course count];
    }else if(tag == kTagBbsTableView){
        return [Bbs_Arr count];
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
    /*if (tag == kTagCourseTableView) {
        NSDictionary* courseDict = [Course_Arr objectAtIndex:indexPath.row];
        [cell.textLabel setText:[courseDict valueForKey:@"course"]];
    }else */if(tag == kTagForumTableView){
        NSDictionary* forumDict = [Forum_Arr_User objectAtIndex:indexPath.row];
        [cell.textLabel setText:[forumDict valueForKey:@"forumTitle"]];
    }else if(tag == kTagForumTableView2){
        NSDictionary* forumDict = [Forum_Arr_Course objectAtIndex:indexPath.row];
        [cell.textLabel setText:[forumDict valueForKey:@"forumTitle"]];
    }else if(tag == kTagBbsTableView){
        
        NSDictionary * bbsDict = [Bbs_Arr objectAtIndex:indexPath.row];
        UILabel * LB_Creator = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 120, 59)];
        LB_Creator.text = [bbsDict valueForKey:@"author"];
        LB_Creator.backgroundColor = [UIColor clearColor];
        UILabel * LB_Content = [[UILabel alloc]initWithFrame:CGRectMake(135, 0, 360, 75)];
        LB_Content.text = [bbsDict valueForKey:@"forumContent"];
        LB_Content.numberOfLines = 3;
        LB_Content.backgroundColor = [UIColor clearColor];
        
        NSString* commitTime = [bbsDict valueForKey:@"commitTime"];
        
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        NSDate *dateFromString = [formatter dateFromString:commitTime];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString* stringFromDate = [formatter stringFromDate:dateFromString];
        [formatter release];
        
        UILabel * LB_Time = [[UILabel alloc]initWithFrame:CGRectMake(535, 0, 160, 75)];
        LB_Time.text = stringFromDate;
        LB_Time.backgroundColor = [UIColor clearColor];
        
        UIImage* separater_lineImage1 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Button_separater_line" ofType:@"png"]];
        UIImageView* separater_lineView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 73, 970, 2)];
        [separater_lineView1 setImage:separater_lineImage1];
        cell.contentView.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:separater_lineView1];
        [cell.contentView addSubview:LB_Creator];
        [cell.contentView addSubview:LB_Content];
        [cell.contentView addSubview:LB_Time];

        [LB_Creator release];
        [LB_Content release];
        [LB_Time release];
        
    }
    return cell;
}

#pragma mark - Table view delegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    int tag = tableView.tag;
    if (tag == kTagBbsTableView) {
        return 75.0f;
    }else{
    
        return 39.0f;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int tag = tableView.tag;
    /*if (tag == kTagCourseTableView) {
        UIButton* courseBtn = (UIButton*)[self.view viewWithTag:kTagCourseSelectBtn];
        
        NSDictionary* courseDict = [Course_Arr objectAtIndex:indexPath.row];
        [courseBtn setTitle:[courseDict valueForKey:@"course"] forState:UIControlStateNormal];
        
        selectCourseIndex = indexPath.row;
        isGetForumByCourse = YES;
        [self getForumTitle];
        //[self getForumTitle];
    }else */if(tag == kTagForumTableView){
        UIButton* moduleBtn = (UIButton*)[self.view viewWithTag:kTagForumSelectBtn];
        
        NSDictionary* moduleDict = [Forum_Arr_User objectAtIndex:indexPath.row];
        [moduleBtn setTitle:[moduleDict valueForKey:@"forumTitle"] forState:UIControlStateNormal];
        
        selectForumIndex = indexPath.row;
    }
    else if(tag == kTagForumTableView2){
        UIButton* moduleBtn = (UIButton*)[self.view viewWithTag:kTagForumSelectBtn2];
        
        NSDictionary* moduleDict = [Forum_Arr_Course objectAtIndex:indexPath.row];
        [moduleBtn setTitle:[moduleDict valueForKey:@"forumTitle"] forState:UIControlStateNormal];
        
        selectForumIndex2 = indexPath.row;
    }
    
    [popoverViewController dismissPopoverAnimated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)tableView:(UITableView*)tableView  willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}


@end
