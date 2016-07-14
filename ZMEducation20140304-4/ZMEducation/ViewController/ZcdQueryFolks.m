#import "ZcdQueryFolks.h"
#define kTagBtnCategory 9999
#define kTagTblCategory 9998
#define kTagTblList 9899

@implementation ZcdQueryFolks

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
         txfieldArr = [[NSMutableArray alloc]init];
        type_dict = [[NSDictionary alloc]initWithObjectsAndKeys:@"字典",@"10",
                     @"词典",@"20",
                     @"成语",@"30",
                     @"诗词",@"40",
                     @"名言",@"50",@"俗语",@"60",@"资源库",@"70",nil];

        cagetorySelectIndex = -1;
        {
            UILabel * field1 = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, 120, 47)];
            field1.text = @"选择分类：";
            field1.backgroundColor = [UIColor clearColor];
            [self addSubview:field1];
           
        }
        //类型选择
        {
            categorySelectBut = [UIButton buttonWithType:UIButtonTypeCustom];
            [categorySelectBut setTag:kTagBtnCategory];
            [categorySelectBut setFrame:CGRectMake(123, 0, 127, 47)];
            [categorySelectBut setTitleEdgeInsets:UIEdgeInsetsMake(0, 0.0, 0.0, 20.0)];
            [categorySelectBut setTitle:@"选择类型" forState:UIControlStateNormal];
            [categorySelectBut setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
            [categorySelectBut setBackgroundImage:[UIImage imageNamed:@"bg_textfield_120.png"] forState:UIControlStateNormal];
            [categorySelectBut addTarget:self
                                  action:@selector(categorySelectClick:)
                        forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:categorySelectBut];
            //[forumSelectBut release];
        }
        
        {
            UILabel * field2 = [[UILabel alloc]initWithFrame:CGRectMake(30, 60, 120, 47)];
            field2.text = @"首字拼音：";
            field2.backgroundColor = [UIColor clearColor];
            [self addSubview:field2];
            
            UIImageView * bg = [[UIImageView alloc]initWithFrame:CGRectMake(126, 60, 127, 47)];
            bg.image = [UIImage imageNamed:@"bg_textField.png"];
            [self addSubview:bg];
            UITextField * txField2 = [[UITextField alloc]initWithFrame:CGRectMake(135, 70, 125, 47)];
            txField2.tag = 2;
            txField2.text = @"";
            //txField2.background = [UIImage imageNamed:@"bg_textField.png"];
            [self addSubview:txField2];
            [txfieldArr addObject:txField2];
        }
        
        {
            UILabel * field2 = [[UILabel alloc]initWithFrame:CGRectMake(30, 120, 120, 47)];
            field2.text = @"主要内容：";
            field2.backgroundColor = [UIColor clearColor];
            [self addSubview:field2];
            
            UIImageView * bg = [[UIImageView alloc]initWithFrame:CGRectMake(126, 120, 127, 47)];
            bg.image = [UIImage imageNamed:@"bg_textField.png"];
            [self addSubview:bg];
            UITextField * txField2 = [[UITextField alloc]initWithFrame:CGRectMake(135, 130, 125, 47)];
            txField2.tag = 3;
            txField2.text = @"";
            [self addSubview:txField2];
            [txfieldArr addObject:txField2];
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
        
        [self getCategory];
        
        
        
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
    NSString * queryType = @"60";
    NSString * key = @"";
    NSString * val = @"";
    
    httpId = 2;
   
    NSMutableArray * queryConditions = [[NSMutableArray alloc]init];
    
    if (cagetorySelectIndex >= 0) {
        val = categorySourceArr[cagetorySelectIndex];
        NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:@"01",@"key",val,@"value",@"0",@"matchMode", nil];
        [queryConditions addObject:dic];
        flag = YES;
    }else{
        NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:@"01",@"key",@"",@"value",@"0",@"matchMode", nil];
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
            categorySourceArr = [[NSMutableArray alloc]initWithArray:[responseDict valueForKey:@"results"]];
   
        }else if (httpId == 2){
            for (UIView * vw in [sv_top subviews]) {
                [vw removeFromSuperview];
            }
            NSArray * prefix = [[NSArray alloc]initWithObjects:@"【分类】",@"【首字拼音】",@"【内容】", nil];
            
            showArr = [[NSMutableArray alloc]initWithArray:[responseDict valueForKey:@"results"]];
            NSString * showStr = @"";
            /*for (NSArray * item in showArr) {
             for (NSString * str in item) {
             showStr = [showStr stringByAppendingString:[NSString stringWithFormat:@"%@\n",str]];
             }
             showStr = [showStr stringByAppendingString:@"\n\n"];
             }*/
            for (NSArray * item in showArr) {
                //NSString * str in item
                for (int i = 0 ;i<[item count];i++) {
                    //showStr = [showStr stringByAppendingString:[NSString stringWithFormat:@"%@\n",str]];
                    showStr = [NSString stringWithFormat:@"%@%@%@\n",showStr,prefix[i],item[i]];
                }
                showStr = [showStr stringByAppendingString:@"\n\n"];
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

-(IBAction)categorySelectClick:(UIButton * )sender{
    UITableViewController *tableViewController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    CGRect frame = CGRectMake(0, 0, 120, 240);
    UITableView * moduleTableView = [[UITableView alloc] initWithFrame:frame];
    [moduleTableView setTag:kTagTblCategory];
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
    
    if (tag == kTagTblCategory) {
        return [categorySourceArr count];
    }else if (tag == kTagTblList){
        return [dataSourceArr count];
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
    if (tag == kTagTblCategory) {
         [cell.textLabel setText:[categorySourceArr objectAtIndex:indexPath.row]];
    }else if (tag == kTagTblList){
        [cell.textLabel setText:[dataSourceArr objectAtIndex:indexPath.row][0]];
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
    if (tag == kTagTblCategory) {
        
        //UIButton * courseBtn = (UIButton*)[self viewWithTag:kTagBtnCategory];
        [categorySelectBut setTitle:[categorySourceArr objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        cagetorySelectIndex = indexPath.row;
        
    }else if (tag == kTagTblList){
    
        httpId = 2;
        NSString * queryType = @"60";
        NSString * key = @"01";
        NSString * val = [dataSourceArr objectAtIndex:indexPath.row][0];
        
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

    }
    [popoverViewController dismissPopoverAnimated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)tableView:(UITableView*)tableView  willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}



//获取类型
-(void)getCategory{
    
    
    httpId = 1;
    NSString * queryType = @"61";
    
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
@end