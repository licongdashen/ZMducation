#import "ZMMdlZykVCtrl.h"
#import "ZMMdlZcdVCtrl.h"

#define kTagCategory       8777
#define kTagCategoryTb     8677
#define kTagFirstClass     8778
#define kTagFirstClassTb   8678
#define kTagSubClass       8779
#define kTagSubClassTb     8679
#define kTagRes            8780
#define kTagResTb          8680

#define kTagResShow        8990


@implementation ZMMdlZykVCtrl

@synthesize delegate ;



-(void)loadView
{
    [super loadView];
    UIView * view = [[UIView alloc]initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    view.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
    self.view = view;
    
    
    type_dict = [[NSDictionary alloc]initWithObjectsAndKeys:@"字典",@"10",
                                                            @"词典",@"20",
                                                            @"成语",@"30",
                                                            @"诗词",@"40",
                                                            @"名言",@"50",@"俗语",@"60",@"资源库",@"70",nil];
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    selectCategoryIndex = -1;
    selectFirstClassIndex = -1;
    selectSubClassIndex = -1;
    selectResIndex = -1;
    
   resArr = [[NSMutableArray alloc]initWithObjects:@"好词",@"好句",@"好段", nil];
    
    {
        UIImageView * IV_Bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
        IV_Bg.image = [UIImage imageNamed:@"bg_ziyuanku.png"];
        [self.view addSubview:IV_Bg];
    }
    
    {
        UIImage* article_Category_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Category_bg" ofType:@"png"]];
        UIImageView* article_Category_View = [[UIImageView alloc] initWithFrame:CGRectMake(291, 15, 421, 43)];
        [article_Category_View setImage:article_Category_Image];
        [self.view addSubview:article_Category_View];
        [article_Category_View release];
        
        [self addLabel:@"资源库"
                 frame:CGRectMake(291, 20, 421, 30)
                  size:18
              intoView:self.view];
    }
    

    
    {
        UIButton* closeBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeBut setFrame:CGRectMake(948, 46, 49, 49)];
        [closeBut setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Close_Btn" ofType:@"png"]] forState:UIControlStateNormal];
        [closeBut setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Close_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
        [closeBut addTarget:self
                     action:@selector(closeClick:)
           forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:closeBut];
    }
    {
        UIButton* submitBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [submitBut setFrame:CGRectMake(858, 714, 124, 40)];
        [submitBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon_zicidian" ofType:@"png"]] forState:UIControlStateNormal];
        [submitBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon_zicidian" ofType:@"png"]] forState:UIControlStateHighlighted];
        [submitBut addTarget:self
                      action:@selector(zcdClick:)
            forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:submitBut];
    }
    {
        UIButton* query_But = [UIButton buttonWithType:UIButtonTypeCustom];
        [query_But setFrame:CGRectMake(180, 410, 71, 61)];
        [query_But setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Query_Btn" ofType:@"png"]] forState:UIControlStateNormal];
        [query_But setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Query_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
        [query_But addTarget:self
                      action:@selector(queryClick:)
            forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:query_But];
    }
    
    {
        UIButton * zcd_But = [UIButton buttonWithType:UIButtonTypeCustom];
        [zcd_But setFrame:CGRectMake(873, 719, 315, 40)];
        [zcd_But addTarget:self action:@selector(zcdClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:zcd_But];
    }
    //类型选择
    {
        UIButton* categorySelectBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [categorySelectBut setTag:kTagCategory];
        [categorySelectBut setFrame:CGRectMake(132, 132, 120, 38)];
        [categorySelectBut setTitleEdgeInsets:UIEdgeInsetsMake(0, 0.0, 0.0, 20.0)];
        [categorySelectBut setTitle:@"选择类型" forState:UIControlStateNormal];
        [categorySelectBut setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [categorySelectBut addTarget:self
                           action:@selector(categorySelectClick:)
                 forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:categorySelectBut];
        //[forumSelectBut release];
    }
    
    //选择大类
    {
        UIButton* firstClassSelectBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [firstClassSelectBut setTag:kTagFirstClass];
        [firstClassSelectBut setFrame:CGRectMake(132, 200, 120, 38)];
        [firstClassSelectBut setTitleEdgeInsets:UIEdgeInsetsMake(0, 0.0, 0.0, 20.0)];
        [firstClassSelectBut setTitle:@"选择大类" forState:UIControlStateNormal];
        [firstClassSelectBut setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [firstClassSelectBut addTarget:self
                              action:@selector(firstClassSelectClick:)
                    forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:firstClassSelectBut];
        //[forumSelectBut release];
    }
    
    //选择小类
    {
        UIButton* subClassSelectBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [subClassSelectBut setTag:kTagSubClass];
        [subClassSelectBut setFrame:CGRectMake(132, 265, 120, 38)];
        [subClassSelectBut setTitleEdgeInsets:UIEdgeInsetsMake(0, 0.0, 0.0, 20.0)];
        [subClassSelectBut setTitle:@"选择小类" forState:UIControlStateNormal];
        [subClassSelectBut setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [subClassSelectBut addTarget:self
                              action:@selector(subClassSelectClick:)
                    forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:subClassSelectBut];
        //[forumSelectBut release];
    }
    
    //选择资源
    {
        UIButton* resSelectBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [resSelectBut setTag:kTagRes];
        [resSelectBut setFrame:CGRectMake(132, 340, 120, 38)];
        [resSelectBut setTitleEdgeInsets:UIEdgeInsetsMake(0, 0.0, 0.0, 20.0)];
        [resSelectBut setTitle:@"选择资源" forState:UIControlStateNormal];
        [resSelectBut setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [resSelectBut addTarget:self
                              action:@selector(resSelectClick:)
                    forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:resSelectBut];
        //[forumSelectBut release];
    }
 
    {
        sv_top  =[[UIScrollView alloc] initWithFrame:CGRectMake(365, 145,607, 316)];
        sv_top.directionalLockEnabled = YES;
        sv_top.alwaysBounceVertical = NO;
        [self.view addSubview:sv_top];
    }
    
    {
        sv_bottom  =[[UIScrollView alloc] initWithFrame:CGRectMake(365, 145+420,607, 120)];
        sv_bottom.directionalLockEnabled = YES;
        sv_bottom.alwaysBounceVertical = NO;
        
        [self.view addSubview:sv_bottom];
    }
    [self getCategory];
    [self getHitory];
    
    
}

/*-(IBAction)backClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}*/

-(IBAction)closeClick:(id)sender
{
    //[_zcdDelegate zcdViewDidClose:self];
    [self.delegate zykViewDidClose:self];
    
}

-(void)zcdClick:(id)sender
{

    //[self.navigationController popViewControllerAnimated:YES];
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


-(IBAction)categorySelectClick:(UIButton * )sender{
    UITableViewController *tableViewController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    CGRect frame = CGRectMake(0, 0, 120, 240);
    UITableView * moduleTableView = [[UITableView alloc] initWithFrame:frame];
    [moduleTableView setTag:kTagCategoryTb];
    moduleTableView.delegate = self;
    moduleTableView.dataSource = self;
    [tableViewController setTableView:moduleTableView];
    [moduleTableView release];
    
    popoverViewController = [[JHPopoverViewController alloc] initWithViewController:tableViewController andContentSize:frame.size];
    
    //[popoverViewController presentPopoverFromRect:CGRectMake(120, 115, 20, 44) inView:self.view animated:YES];
    [popoverViewController presentPopoverFromRect:[sender frame] inView:self.view animated:YES];
    
    
    [tableViewController release];
}

-(IBAction)firstClassSelectClick:(UIButton * )sender{
    UITableViewController *tableViewController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    CGRect frame = CGRectMake(0, 0, 120, 240);
    UITableView * moduleTableView = [[UITableView alloc] initWithFrame:frame];
    [moduleTableView setTag:kTagFirstClassTb];
    moduleTableView.delegate = self;
    moduleTableView.dataSource = self;
    [tableViewController setTableView:moduleTableView];
    [moduleTableView release];
    
    popoverViewController = [[JHPopoverViewController alloc] initWithViewController:tableViewController andContentSize:frame.size];
    
    //[popoverViewController presentPopoverFromRect:CGRectMake(120, 115, 20, 44) inView:self.view animated:YES];
    [popoverViewController presentPopoverFromRect:[sender frame] inView:self.view animated:YES];
    
    
    [tableViewController release];
}

-(IBAction)subClassSelectClick:(UIButton * )sender{
    UITableViewController *tableViewController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    CGRect frame = CGRectMake(0, 0, 120, 240);
    UITableView * moduleTableView = [[UITableView alloc] initWithFrame:frame];
    [moduleTableView setTag:kTagSubClassTb];
    moduleTableView.delegate = self;
    moduleTableView.dataSource = self;
    [tableViewController setTableView:moduleTableView];
    [moduleTableView release];
    
    popoverViewController = [[JHPopoverViewController alloc] initWithViewController:tableViewController andContentSize:frame.size];
    
    //[popoverViewController presentPopoverFromRect:CGRectMake(120, 115, 20, 44) inView:self.view animated:YES];
    [popoverViewController presentPopoverFromRect:[sender frame] inView:self.view animated:YES];
    
    
    [tableViewController release];
}

-(IBAction)resSelectClick:(UIButton * )sender{
    UITableViewController *tableViewController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    CGRect frame = CGRectMake(0, 0, 120, 240);
    UITableView * moduleTableView = [[UITableView alloc] initWithFrame:frame];
    [moduleTableView setTag:kTagResTb];
    moduleTableView.delegate = self;
    moduleTableView.dataSource = self;
    [tableViewController setTableView:moduleTableView];
    [moduleTableView release];
    
    popoverViewController = [[JHPopoverViewController alloc] initWithViewController:tableViewController andContentSize:frame.size];
    
    //[popoverViewController presentPopoverFromRect:CGRectMake(120, 115, 20, 44) inView:self.view animated:YES];
    [popoverViewController presentPopoverFromRect:[sender frame] inView:self.view animated:YES];
    
    
    [tableViewController release];
}

//获取类型
-(void)getCategory{
    
    httpId = 1;
    
    NSMutableArray * queryConditions = [[NSMutableArray alloc]init];

    NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:@"01",@"key",@"",@"value",@"0",@"matchMode", nil];
    [queryConditions addObject:dic];
    
    NSMutableDictionary * userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];

    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"71" forKey:@"queryType"];
    [requestDict setValue:@"M054" forKey:@"method"];
    [requestDict setValue:@"1" forKey:@"returnMode"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[queryConditions JSONString] forKey:@"queryConditions"];
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];

}

//获取大类
-(void)getFirstClass{
    httpId = 2;
    NSMutableArray * queryConditions = [[NSMutableArray alloc]init];
    NSString * val = [categoryArr objectAtIndex:selectCategoryIndex];
    NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:@"01",@"key",val,@"value",@"0",@"matchMode", nil];
    [queryConditions addObject:dic];
    NSMutableDictionary * userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"72" forKey:@"queryType"];
    [requestDict setValue:@"M054" forKey:@"method"];
    [requestDict setValue:@"0" forKey:@"returnMode"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[queryConditions JSONString] forKey:@"queryConditions"];
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
    
}

//获取小类
-(void)getSubClass{
    httpId = 3;
    NSMutableArray * queryConditions = [[NSMutableArray alloc]init];
    NSString * val = [firstClassArr objectAtIndex:selectFirstClassIndex];
    NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:@"01",@"key",val,@"value",@"0",@"matchMode", nil];
    [queryConditions addObject:dic];
    NSMutableDictionary * userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"73" forKey:@"queryType"];
    [requestDict setValue:@"M054" forKey:@"method"];
    [requestDict setValue:@"0" forKey:@"returnMode"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[queryConditions JSONString] forKey:@"queryConditions"];
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
    
}

//查询历史
-(void)getHitory{
    NSMutableDictionary * userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M055" forKey:@"method"];
    [requestDict setValue:@"library" forKey:@"type"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
    
}

-(void)queryClick:(UIButton *)sender {

    BOOL flag = NO;
    httpId = 4;
    NSString * val = @"";
    NSMutableArray * queryConditions = [[NSMutableArray alloc]init];
    {
        if (selectCategoryIndex != -1) {
            val = [categoryArr objectAtIndex:selectCategoryIndex];
        }else{
            val = @"";
        }
        
        NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:@"01",@"key",val,@"value",@"0",@"matchMode", nil];
        [queryConditions addObject:dic];
        [dic release];
        if (![val isEqualToString:@""]) {
            flag = YES;
        }
    }
    {
        if (selectFirstClassIndex != -1) {
            val = [firstClassArr objectAtIndex:selectFirstClassIndex];
        }else{
            val = @"";
        }
        /*if ([firstClassArr count]>0) {
            val = [firstClassArr objectAtIndex:selectFirstClassIndex];
        }*/
        NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:@"02",@"key",val,@"value",@"0",@"matchMode", nil];
        [queryConditions addObject:dic];
        [dic release];
        if (![val isEqualToString:@""]) {
            flag = YES;
        }
        
    }
    {
        if (selectSubClassIndex != -1) {
            val = [subClassArr objectAtIndex:selectSubClassIndex];
        }else{
            val = @"";
        }
        /*if ([subClassArr count]>0) {
            val = [subClassArr objectAtIndex:selectSubClassIndex];
        }*/
        NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:@"03",@"key",val,@"value",@"0",@"matchMode", nil];
        [queryConditions addObject:dic];
        [dic release];
        if (![val isEqualToString:@""]) {
            flag = YES;
        }
        
    }
    {
        if (selectResIndex != -1) {
            val = [resArr objectAtIndex:selectResIndex];
        }else{
            val = @"";
        }
        //val = [resArr objectAtIndex:selectResIndex];
        NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:@"04",@"key",val,@"value",@"0",@"matchMode", nil];
        [queryConditions addObject:dic];
        [dic release];
        if (![val isEqualToString:@""]) {
            flag = YES;
        }
    }
    
    if (!flag) {
        [self showTip:@"请输入查询条件"];
        return;
    }
    
    
    NSMutableDictionary * userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"70" forKey:@"queryType"];
    [requestDict setValue:@"M054" forKey:@"method"];
    [requestDict setValue:@"0" forKey:@"returnMode"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[queryConditions JSONString] forKey:@"queryConditions"];
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
    
    

}



#pragma mark ZMHttpEngineDelegate
-(void)httpEngine:(ZMHttpEngine *)httpEngine didSuccess:(NSDictionary *)responseDict{
    [super httpEngine:httpEngine didSuccess:responseDict];
    NSString* method = [responseDict valueForKey:@"method"];
    NSString* responseCode = [responseDict valueForKey:@"responseCode"];
    
    if ([@"M054" isEqualToString:method] && [@"00" isEqualToString:responseCode]) //获取主题列表
    {
        if (httpId == 1) {
            categoryArr = [[NSMutableArray alloc]initWithArray:[responseDict valueForKey:@"results"]];
        } else if (httpId == 2){
            firstClassArr = [[NSMutableArray alloc]initWithArray:[responseDict valueForKey:@"results"]];
        } else if (httpId == 3){
            subClassArr = [[NSMutableArray alloc]initWithArray:[responseDict valueForKey:@"results"]];
        } else if (httpId == 4){
            
            for (UIView * vw in [sv_top subviews]) {
                [vw removeFromSuperview];
            }
            NSArray * prefix = [[NSArray alloc]initWithObjects:@"【类型】",@"【大类】",@"【小类】",@"【资源】",@"【内容】", nil];
            
            NSArray * showArr = [[NSArray alloc]initWithArray:[responseDict valueForKey:@"results"]];
            
            NSString * showStr = @"";
            
            /*for (NSArray * item in showArr) {
                showStr = [showStr stringByAppendingString:[NSString stringWithFormat:@"%@\n\n",item[4]]];
            }*/
            
            for (NSArray * item in showArr) {
                //NSString * str in item
                for (int i = 0 ;i<[item count];i++) {
                    //showStr = [showStr stringByAppendingString:[NSString stringWithFormat:@"%@\n",str]];
                    showStr = [NSString stringWithFormat:@"%@%@%@\n",showStr,prefix[i],item[i]];
                }
                showStr = [showStr stringByAppendingString:@"\n\n"];
            }

            
            UILabel * lb_show = [[UILabel alloc]initWithFrame:CGRectMake(0,0, 600, 316)];
            lb_show.backgroundColor = [UIColor clearColor];
            lb_show.numberOfLines = 0;
            lb_show.lineBreakMode = UILineBreakModeWordWrap;
            lb_show.text = showStr;
            lb_show.font = [UIFont systemFontOfSize:20];
            [lb_show sizeToFit];
            
            CGSize titleSize = [showStr sizeWithFont:[UIFont systemFontOfSize:20] constrainedToSize:CGSizeMake(lb_show.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
            
            
             CGSize sz = CGSizeMake(titleSize.width, titleSize.height);
            [sv_top setContentSize:sz];
            [sv_top addSubview:lb_show];
            [self getHitory];
            
            
            
            
        }
        
    }else if ([@"M055" isEqualToString:method] && [@"00" isEqualToString:responseCode])//查询历史
    {
        for (UIView * vw in [sv_bottom subviews]) {
            [vw removeFromSuperview];
        }
        NSArray * queryArr = [responseDict valueForKey:@"myQuerys"];
        UILabel * queryLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 600, 0)];
        queryLb.backgroundColor = [UIColor clearColor];
        queryLb.numberOfLines = 0;
        queryLb.lineBreakMode = UILineBreakModeWordWrap;
        NSString * showStr = @"";
        
        for (NSDictionary * item in queryArr) {
            /*showStr = [showStr stringByAppendingString:[NSString stringWithFormat:@"%@->%@\n\n",[item valueForKey:@"queryType"], [item valueForKey:@"myQueryContent"]]];*/
            NSString * queryName = [type_dict valueForKey:[item valueForKey:@"queryType"]];
            NSArray * queryContentArr = [item objectForKey:@"myQueryContent"];
            NSString * contentStr = @"";
        
                NSArray * prefix = [[NSArray alloc]initWithObjects:@"(类型)",@"(大类)",@"(小类)", @"(资源)",nil];
                for (int i = 0; i<[queryContentArr count]; i++ ) {
                    if (![[queryContentArr[i] valueForKey:@"value"] isEqualToString:@""]) {
                        contentStr = [NSString stringWithFormat:@"%@%@%@->",contentStr,[queryContentArr[i] valueForKey:@"value"],prefix[i]];
                    }
                }
            
            if ([contentStr length] > 0) {
                int k = [contentStr length];
                contentStr = [contentStr substringToIndex:k-2];
            }
            
            showStr = [showStr stringByAppendingString:[NSString stringWithFormat:@"%@：%@\n\n",queryName,contentStr]];
            
        }
        
        queryLb.text = showStr;
        [queryLb sizeToFit];
        CGSize titleSize = [showStr sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(queryLb.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];

        CGSize sz = CGSizeMake(titleSize.width, titleSize.height);
        [sv_bottom setContentSize:sz];
        [sv_bottom addSubview:queryLb];

        
        
    }else if ([@"M066" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        
        NSString * statusStr = [responseDict valueForKey:@"dictionary"];
        if([@"01" isEqualToString:statusStr]){
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self showTip:@"暂无内容！"];
        }
        
        
    }
    else if(![@"00" isEqualToString:responseCode]){
        [self showTip:@"服务器异常"];
    }
}




#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSLog(@"[tableDataSourceArray count]:%d",[_dataSource count]);
    int tag = tableView.tag;
    
    if (tag == kTagCategoryTb) {
        return [categoryArr count];
    }else if(tag == kTagFirstClassTb){
        return [firstClassArr count];
    }
    else if(tag == kTagSubClassTb){
        return [subClassArr count];
    }else if(tag == kTagResTb){
        return [resArr count];
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
    if (tag == kTagCategoryTb) {
        //NSDictionary* courseDict = [categoryArr objectAtIndex:indexPath.row];
        [cell.textLabel setText:[categoryArr objectAtIndex:indexPath.row]];
    }else if(tag == kTagFirstClassTb){
        [cell.textLabel setText:[firstClassArr objectAtIndex:indexPath.row]];
    }else if(tag == kTagSubClassTb){
        //NSDictionary* forumDict = [subClassArr objectAtIndex:indexPath.row];
        [cell.textLabel setText:[subClassArr objectAtIndex:indexPath.row]];
    }else if(tag == kTagResTb){
         [cell.textLabel setText:[resArr objectAtIndex:indexPath.row]];
    }
    return cell;
}

#pragma mark - Table view delegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        return 39.0f;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int tag = tableView.tag;
    if (tag == kTagCategoryTb) {
        UIButton* courseBtn = (UIButton*)[self.view viewWithTag:kTagCategory];
       [courseBtn setTitle:[categoryArr objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        selectCategoryIndex = indexPath.row;
        
        [self getFirstClass];
        
    }else if(tag == kTagFirstClassTb){
        UIButton* moduleBtn = (UIButton*)[self.view viewWithTag:kTagFirstClass];
        [moduleBtn setTitle:[firstClassArr objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        
        selectFirstClassIndex = indexPath.row;
        [self getSubClass];
    }
    else if(tag == kTagSubClassTb){
        UIButton* moduleBtn = (UIButton*)[self.view viewWithTag:kTagSubClass];
       [moduleBtn setTitle:[subClassArr objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        
        selectSubClassIndex = indexPath.row;
    }
    else if(tag == kTagResTb){
        UIButton* moduleBtn = (UIButton*)[self.view viewWithTag:kTagRes];
        [moduleBtn setTitle:[resArr objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        
        selectResIndex = indexPath.row;
    }
    
    [popoverViewController dismissPopoverAnimated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)tableView:(UITableView*)tableView  willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}


@end