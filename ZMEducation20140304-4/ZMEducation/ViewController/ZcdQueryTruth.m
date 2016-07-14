#import "ZcdQueryTruth.h"
#define kTagCategory       1111
#define kTagCategoryTb     1112
#define kTagParentClass     1113
#define kTagFirstClassTb   1114
#define kTagSubClass       1115
#define kTagSubClassTb     1116
#define kTagRes            1117
#define kTagResTb          1118


@implementation ZcdQueryTruth

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        selectFirstClassIndex = -1;
        selectSubClassIndex = -1;
        txfieldArr = [[NSMutableArray alloc]init];
        type_dict = [[NSDictionary alloc]initWithObjectsAndKeys:@"字典",@"10",
                     @"词典",@"20",
                     @"成语",@"30",
                     @"诗词",@"40",
                     @"名言",@"50",@"俗语",@"60",@"资源库",@"70",nil];

        btnArr = [[NSMutableArray alloc]init];
        {
            UILabel * field1 = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, 120, 47)];
            field1.text = @"选择大类：";
            field1.backgroundColor = [UIColor clearColor];
            [self addSubview:field1];
        }
        
        //选择大类
        {
            firstClassSelectBut = [UIButton buttonWithType:UIButtonTypeCustom];
            [firstClassSelectBut setTag:kTagParentClass];
            [firstClassSelectBut setFrame:CGRectMake(123, 0, 127, 47)];
            [firstClassSelectBut setTitleEdgeInsets:UIEdgeInsetsMake(0, 0.0, 0.0, 20.0)];
            [firstClassSelectBut setTitle:@"选择大类" forState:UIControlStateNormal];
            [firstClassSelectBut setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
            [firstClassSelectBut setBackgroundImage:[UIImage imageNamed:@"bg_textfield_120.png"] forState:UIControlStateNormal];
            [firstClassSelectBut addTarget:self
                                    action:@selector(firstClassSelectClick:)
                          forControlEvents:UIControlEventTouchUpInside];
            firstClassSelectBut.tag = 1;
            
            [btnArr addObject:firstClassSelectBut];
            [self addSubview:firstClassSelectBut];
            //[forumSelectBut release];
        }
        
        
        
        {
            UILabel * field2 = [[UILabel alloc]initWithFrame:CGRectMake(30, 60, 120, 47)];
            field2.text = @"选择小类：";
            field2.backgroundColor = [UIColor clearColor];
            [self addSubview:field2];
     
        }
        
        //选择小类
        {
            subClassSelectBut = [UIButton buttonWithType:UIButtonTypeCustom];
            [subClassSelectBut setTag:kTagSubClass];
            [subClassSelectBut setFrame:CGRectMake(123, 60, 127, 47)];
            [subClassSelectBut setTitleEdgeInsets:UIEdgeInsetsMake(0, 0.0, 0.0, 20.0)];
            [subClassSelectBut setTitle:@"选择小类" forState:UIControlStateNormal];
            [subClassSelectBut setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
            [subClassSelectBut addTarget:self
                                  action:@selector(subClassSelectClick:)
                        forControlEvents:UIControlEventTouchUpInside];
            [subClassSelectBut setBackgroundImage:[UIImage imageNamed:@"bg_textfield_120.png"] forState:UIControlStateNormal];
            subClassSelectBut.tag = 2;
            [btnArr addObject:subClassSelectBut];
            [self addSubview:subClassSelectBut];
            //[forumSelectBut release];
        }
        
        {
            UILabel * field2 = [[UILabel alloc]initWithFrame:CGRectMake(30, 120, 120, 47)];
            field2.text = @"输入作者：";
            field2.backgroundColor = [UIColor clearColor];
            [self addSubview:field2];
            
            
            UIImageView * bg = [[UIImageView alloc]initWithFrame:CGRectMake(126, 120, 127, 47)];
            bg.image = [UIImage imageNamed:@"bg_textField.png"];
            [self addSubview:bg];
            UITextField * txField2 = [[UITextField alloc]initWithFrame:CGRectMake(135, 130, 125, 47)];
            txField2.tag = 3;
            txField2.text = @"";
            [txfieldArr addObject:txField2];
            [self addSubview:txField2];
        }
        
        {
            UILabel * field2 = [[UILabel alloc]initWithFrame:CGRectMake(30, 180, 120, 47)];
            field2.text = @"输入内容：";
            field2.backgroundColor = [UIColor clearColor];
            [self addSubview:field2];
            
            UIImageView * bg = [[UIImageView alloc]initWithFrame:CGRectMake(126, 180, 127, 47)];
            bg.image = [UIImage imageNamed:@"bg_textField.png"];
            [self addSubview:bg];
            UITextField * txField3 = [[UITextField alloc]initWithFrame:CGRectMake(135, 190, 125, 47)];
            txField3.tag = 4;
            txField3.text = @"";
            [txfieldArr addObject:txField3];
            [self addSubview:txField3];
        }
        
        {
            UIButton* query_But = [UIButton buttonWithType:UIButtonTypeCustom];
            [query_But setFrame:CGRectMake(180, 650-195, 71, 61)];
            [query_But setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Query_Btn" ofType:@"png"]] forState:UIControlStateNormal];
            [query_But setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Query_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
            [query_But addTarget:self
                          action:@selector(queryClickHandle:)
                forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:query_But];
        }
        
        {
            sv_top  =[[UIScrollView alloc] initWithFrame:CGRectMake(360, -40,607, 316)];
            sv_top.directionalLockEnabled = YES;
            sv_top.alwaysBounceVertical = NO;
            sv_top.userInteractionEnabled = YES;
            [self addSubview:sv_top];
            
        }
        
        
        {
            sv_bottom  =[[UIScrollView alloc] initWithFrame:CGRectMake(360, 370,607, 120)];
            sv_bottom.directionalLockEnabled = YES;
            sv_bottom.alwaysBounceVertical = NO;
            [self addSubview:sv_bottom];
        }
        [self getHitory];

        [self getFirstClass];
        
    }
    return self;
    
}

/*----------------------*/
-(void)showTip:(NSString *)tip{
    UIImageView* flashTipView = [[UIImageView alloc] init];
    [flashTipView setFrame:CGRectMake(456.0f, 107.0f, 113.0f, 113.0f)];
    [flashTipView setImage:[UIImage imageWithContentsOfFile:
                            [[NSBundle mainBundle] pathForResource:@"network_connect_bg" ofType:@"png"]]];
    [self addSubview:flashTipView];
    
    UILabel* tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 93, 83)];
    [tipLabel setText:tip];
    [tipLabel setNumberOfLines:3];
    [tipLabel setFont:[UIFont systemFontOfSize:17.0f]];
    [tipLabel setTextAlignment:NSTextAlignmentCenter];
    [tipLabel setBackgroundColor:[UIColor clearColor]];
    [tipLabel setTextColor:[UIColor whiteColor]];
    [flashTipView addSubview:tipLabel];
    [tipLabel release];
    
    flashTipView.alpha = 0;
    [UIView animateWithDuration:0.5f
                     animations:^{ flashTipView.alpha = 1; }
                     completion:^(BOOL finished){
                         [NSTimer scheduledTimerWithTimeInterval:1.8f
                                                          target:self
                                                        selector:@selector(hideTip:)
                                                        userInfo:flashTipView
                                                         repeats:NO];
                     }];
    [flashTipView release];
}

-(void)hideTip:(NSTimer *)timer{
    UIImageView* flashTipView = (UIImageView *)[timer userInfo];
    [UIView animateWithDuration:0.5f
                     animations:^{ flashTipView.alpha = 0; }
                     completion:^(BOOL finished){}];
}
/*----------------------*/
-(void)queryClickHandle:(id)sender
{
    
    
    BOOL flag = NO;
    httpId =4;
    NSString * queryType = @"50";
    NSString * key = @"";
    NSString * val = @"";
 
    NSMutableArray * queryConditions = [[NSMutableArray alloc]init];
    
    if (selectFirstClassIndex >= 0) {
        val = [firstClassArr objectAtIndex:selectFirstClassIndex];
        key = @"01";
        
        NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:key,@"key",val,@"value",@"0",@"matchMode", nil];
        [queryConditions addObject:dic];
        flag = YES;
    }else{
        key = @"01";
        NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:key,@"key",@"",@"value",@"0",@"matchMode", nil];
        [queryConditions addObject:dic];
    }
    
    if (selectSubClassIndex >= 0) {
        val = [subClassArr objectAtIndex:selectSubClassIndex];
        key = @"02";
        
        NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:key,@"key",val,@"value",@"0",@"matchMode", nil];
        [queryConditions addObject:dic];
        flag = YES;
    }else{
        key = @"02";
        
        NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:key,@"key",@"",@"value",@"0",@"matchMode", nil];
        [queryConditions addObject:dic];
    }
    
    for (UITextField * view in txfieldArr) {
        //val = view.text;
        val = [view text];
        key = [NSString stringWithFormat:@"0%d",view.tag];
        NSString * matchMode = @"1";
        
        NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:key,@"key",val,@"value",matchMode,@"matchMode", nil];
        [queryConditions addObject:dic];
        if (![val isEqualToString:@""]) {
            flag = YES;
        }
        
    }
    
    if (!flag) {
        [self showTip:@"请输入查询条件"];
        return;
    }
    
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:queryType forKey:@"queryType"];
    [requestDict setValue:@"M054" forKey:@"method"];
    [requestDict setValue:@"0" forKey:@"returnMode"];
    [requestDict setValue:[queryConditions JSONString] forKey:@"queryConditions"];
    NSMutableDictionary * userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];

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
    [requestDict setValue:@"dictionary" forKey:@"type"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
    
}
#pragma mark ZMHttpEngineDelegate
-(void)httpEngineDidBegin:(ZMHttpEngine *)httpEngine{
    //[self showIndicator];
}



-(void)httpEngine:(ZMHttpEngine *)httpEngine didFailed:(NSString *)failResult{
    //[self hideIndicator];
    
    //[self showTip:failResult];
}

#pragma mark ZMHttpEngineDelegate
-(void)httpEngine:(ZMHttpEngine *)httpEngine didSuccess:(NSDictionary *)responseDict{
    NSString* method = [responseDict valueForKey:@"method"];
    NSString* responseCode = [responseDict valueForKey:@"responseCode"];
    if([@"M054" isEqualToString:method] && [@"00" isEqualToString:responseCode])
    {
        
        if (httpId == 1) {
            firstClassArr = [[NSMutableArray alloc]initWithArray:[responseDict valueForKey:@"results"]];
        }else if (httpId == 2){
            subClassArr = [[NSMutableArray alloc]initWithArray:[responseDict valueForKey:@"results"]];
        }else if (httpId == 4){
            for (UIView * vw in [sv_top subviews]) {
                [vw removeFromSuperview];
            }
            NSArray * prefix = [[NSArray alloc]initWithObjects:@"【大类】",@"【小类】",@"【作者】",@"【内容】", nil];
            
            showArr = [[NSMutableArray alloc]initWithArray:[responseDict valueForKey:@"results"]];
            NSString * showStr = @"";
            
            /*for (NSArray * item in showArr) {
             for (NSString * str in item) {
             showStr = [showStr stringByAppendingString:[NSString stringWithFormat:@"%@\n",str]];
             }
             showStr = [showStr stringByAppendingString:@"\n\n"];
             }*/
            for (NSArray * item in showArr) {
                if ([item isKindOfClass:[NSArray class]]) {
                    for (int i = 0 ;i<[item count];i++) {
                        //showStr = [showStr stringByAppendingString:[NSString stringWithFormat:@"%@\n",str]];
                        showStr = [NSString stringWithFormat:@"%@%@%@\n",showStr,prefix[i],item[i]];
                    }
                    showStr = [showStr stringByAppendingString:@"\n\n"];
                }
                
            }
            
            UILabel * lb_show = [[UILabel alloc]initWithFrame:CGRectMake(0,0, 600, 0)];
            lb_show.backgroundColor = [UIColor clearColor];
            lb_show.numberOfLines = 0;
            lb_show.lineBreakMode = UILineBreakModeWordWrap;
            lb_show.text = showStr;
            lb_show.font = [UIFont systemFontOfSize:20];
            [lb_show sizeToFit];
            
            CGSize titleSize = [showStr sizeWithFont:[UIFont systemFontOfSize:20] constrainedToSize:CGSizeMake(lb_show.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
            CGSize sz = CGSizeMake(titleSize.width, titleSize.height + 20);
            [sv_top setContentSize:sz];
            [sv_top addSubview:lb_show];
            
            [self getHitory];
        }else if (httpId == 3){
            resArr = [[NSMutableArray alloc]initWithArray:[responseDict valueForKey:@"results"]];
            
            CGRect frame = CGRectMake(126, 240, 120, 220);
            UITableView * wordTableView = [[UITableView alloc] initWithFrame:frame];
            
            [wordTableView setTag:kTagResTb];
            wordTableView.delegate = self;
            wordTableView.dataSource = self;
            [self addSubview:wordTableView];
            [wordTableView release];
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
            
            if ([@"60" isEqualToString:[item valueForKey:@"queryType"]]) {
                NSArray * prefix = [[NSArray alloc]initWithObjects:@"(选择分类)",@"(首字拼音)",@"(主要内容)", nil];
                
                for (NSDictionary * item in queryContentArr) {
                    if (![[item valueForKey:@"value"] isEqualToString:@""]) {
                        int i = ([[item valueForKey:@"key"] integerValue] - 1);
                        contentStr = [NSString stringWithFormat:@"%@%@%@->",contentStr,[item valueForKey:@"value"],prefix[i]];
                        
                    }
                }
            }else if ([@"50" isEqualToString:[item valueForKey:@"queryType"]]) {
                NSArray * prefix = [[NSArray alloc]initWithObjects:@"(大类)",@"(小类)",@"(作者)",@"(内容)", nil];
                
                for (NSDictionary * item in queryContentArr) {
                    if (![[item valueForKey:@"value"] isEqualToString:@""]) {
                        int i = ([[item valueForKey:@"key"] integerValue] - 1);
                        contentStr = [NSString stringWithFormat:@"%@%@%@->",contentStr,[item valueForKey:@"value"],prefix[i]];
                        
                    }
                }
                
                
            }else{
                for (NSDictionary * contentItem in queryContentArr) {
                    
                    contentStr = [contentStr stringByAppendingString:[NSString stringWithFormat:@"%@->",[contentItem valueForKey:@"value"]]];
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
        CGSize titleSize = [showStr sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(queryLb.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
        
        CGSize sz = CGSizeMake(titleSize.width, titleSize.height);
        [sv_bottom setContentSize:sz];
        [sv_bottom addSubview:queryLb];
        
        
        
    }
    else
    {
        
    }
    
    //[super hideIndicator];
}

//获取大类
-(void)getFirstClass{
    httpId = 1;
    NSString * queryType = @"51";
    
    NSMutableArray * queryConditions = [[NSMutableArray alloc]init];
    
    {
        
        
        NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:@"01",@"key",@"",@"value",@"1",@"matchMode", nil];
        [queryConditions addObject:dic];
    }
    
    
    
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:queryType forKey:@"queryType"];
    [requestDict setValue:@"M054" forKey:@"method"];
    [requestDict setValue:@"1" forKey:@"returnMode"];
    [requestDict setValue:[queryConditions JSONString] forKey:@"queryConditions"];
    NSMutableDictionary * userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
    
}

//获取小类
-(void)getSubClass{
    httpId = 2;
    NSMutableArray * queryConditions = [[NSMutableArray alloc]init];
    NSString * val = [firstClassArr objectAtIndex:selectFirstClassIndex];
    NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:@"01",@"key",val,@"value",@"0",@"matchMode", nil];
    [queryConditions addObject:dic];
    NSMutableDictionary * userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"52" forKey:@"queryType"];
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
    [popoverViewController presentPopoverFromRect:[sender frame] inView:self animated:YES];
    
    
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
    [popoverViewController presentPopoverFromRect:[sender frame] inView:self animated:YES];
    
    
    [tableViewController release];
}




#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSLog(@"[tableDataSourceArray count]:%d",[_dataSource count]);
    int tag = tableView.tag;
    
    if(tag == kTagFirstClassTb){
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
    if(tag == kTagFirstClassTb){
        //NSDictionary* forumDict = [firstClassArr objectAtIndex:indexPath.row];
        [cell.textLabel setText:[firstClassArr objectAtIndex:indexPath.row]];
    }else if(tag == kTagSubClassTb){
        //NSDictionary* forumDict = [subClassArr objectAtIndex:indexPath.row];
        [cell.textLabel setText:[subClassArr objectAtIndex:indexPath.row]];
    }else if(tag == kTagResTb){
        [cell.textLabel setText:[resArr objectAtIndex:indexPath.row][0]];
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
    if(tag == kTagFirstClassTb){
        [firstClassSelectBut setTitle:[firstClassArr objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        selectFirstClassIndex = indexPath.row;
        [self getSubClass];
    }
    else if(tag == kTagSubClassTb){
        [subClassSelectBut setTitle:[subClassArr objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        
        selectSubClassIndex = indexPath.row;
    }
    /*else if(tag == kTagResTb){
        httpId = 3;
        NSString * queryType = @"50";
        NSString * key = @"01";
        NSString * val = [resArr objectAtIndex:indexPath.row][0];
    
        NSMutableArray * queryConditions = [[NSMutableArray alloc]init];
        
        NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:key,@"key",val,@"value",@"0",@"matchMode", nil];
        [queryConditions addObject:dic];
        
        NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
        [requestDict setValue:queryType forKey:@"queryType"];
        [requestDict setValue:@"M054" forKey:@"method"];
        [requestDict setValue:@"0" forKey:@"returnMode"];
        [requestDict setValue:[queryConditions JSONString] forKey:@"queryConditions"];
        NSMutableDictionary * userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
        [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
        [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
        
        ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
        [httpEngine setDelegate:self];
        [httpEngine requestWithDict:requestDict];
        [httpEngine release];
        [requestDict release];
    }*/
    
    [popoverViewController dismissPopoverAnimated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)tableView:(UITableView*)tableView  willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}


@end