#import "ZcdQueryCharacter.h"
#define kTagBushou 9887
#define kTagBushouTB 9886
#define kTagTableCharacter 9990

@implementation ZcdQueryCharacter

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        datasourceBushou = [[NSMutableArray alloc]init];
        dataSourceArr = [[NSMutableArray alloc]init];
        httpId = 0;
        bishouSelectIndex = -1;
        characterSelectIndex = -1;
        
        type_dict = [[NSDictionary alloc]initWithObjectsAndKeys:@"字典",@"10",
                     @"词典",@"20",
                     @"成语",@"30",
                     @"诗词",@"40",
                     @"名言",@"50",@"俗语",@"60",@"资源库",@"70",nil];
        txfieldArr = [[NSMutableArray alloc]init];
      
        {
            UILabel * field1 = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, 120, 47)];
            field1.text = @"直输汉字：";
            field1.backgroundColor = [UIColor clearColor];
            
            [self addSubview:field1];
            UIImageView * bg = [[UIImageView alloc]initWithFrame:CGRectMake(126, 0, 127, 47)];
            bg.image = [UIImage imageNamed:@"bg_textField.png"];
            [self addSubview:bg];
            UITextField * txField1 = [[UITextField alloc]initWithFrame:CGRectMake(135, 10, 125, 47)];
            txField1.tag = 1;
            txField1.text = @"";
            [self addSubview:txField1];
            [txfieldArr addObject:txField1];
        }
        
        {
            UILabel * field2 = [[UILabel alloc]initWithFrame:CGRectMake(30, 60, 120, 47)];
            field2.text = @"直输拼音：";
            field2.backgroundColor = [UIColor clearColor];
            
            [self addSubview:field2];
            
            UIImageView * bg = [[UIImageView alloc]initWithFrame:CGRectMake(126, 60, 127, 47)];
            bg.image = [UIImage imageNamed:@"bg_textField.png"];
            [self addSubview:bg];
            UITextField * txField2 = [[UITextField alloc]initWithFrame:CGRectMake(135, 70, 125, 47)];
            txField2.tag = 2;
            txField2.text = @"";
            [self addSubview:txField2];
            [txfieldArr addObject:txField2];
        }
        
        {
            //UILabel * field3 = [[UILabel alloc]initWithFrame:CGRectMake(30, 120, 120, 47)];
            UILabel * field3 = [[UILabel alloc]initWithFrame:CGRectMake(30, 180, 120, 47)];

            field3.text = @"部首笔画：";
            field3.backgroundColor = [UIColor clearColor];
            
            [self addSubview:field3];
            
            UIImageView * bg = [[UIImageView alloc]initWithFrame:CGRectMake(126, 180, 127, 47)];
            bg.image = [UIImage imageNamed:@"bg_textField.png"];
            [self addSubview:bg];
            bushouTF = [[UITextField alloc]initWithFrame:CGRectMake(135, 190, 125, 47)];
            //bushouTF.background = [UIImage imageNamed:@"bg_textField.png"];
            bushouTF.tag = 3;
            bushouTF.text = @"";
            [self addSubview:bushouTF];
            [txfieldArr addObject:bushouTF];
        }
        
        //类型选择
        {
            //UILabel * field4 = [[UILabel alloc]initWithFrame:CGRectMake(30, 180, 120, 47)];
            UILabel * field4 = [[UILabel alloc]initWithFrame:CGRectMake(30, 240, 120, 47)];

            field4.text = @"选择部首：";
            field4.backgroundColor = [UIColor clearColor];
            [self addSubview:field4];

            UIButton* bushouSelectBut = [UIButton buttonWithType:UIButtonTypeCustom];
            [bushouSelectBut setTag:kTagBushou];
            [bushouSelectBut setFrame:CGRectMake(126, 240, 125, 47)];
            [bushouSelectBut setTitleEdgeInsets:UIEdgeInsetsMake(0, 0.0, 0.0, 20.0)];
            [bushouSelectBut setTitle:@"选择部首" forState:UIControlStateNormal];
            [bushouSelectBut setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
            [bushouSelectBut setBackgroundImage:[UIImage imageNamed:@"bg_textfield_120.png"] forState:UIControlStateNormal];
            [bushouSelectBut addTarget:self
                                  action:@selector(bushouSelectClick:)
                        forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:bushouSelectBut];
            //[forumSelectBut release];
        }
        
        {
            //UILabel * field5 = [[UILabel alloc]initWithFrame:CGRectMake(30, 240, 120, 47)];
            UILabel * field5 = [[UILabel alloc]initWithFrame:CGRectMake(30, 120, 120, 47)];

            field5.text = @"总笔画数：";
            field5.backgroundColor = [UIColor clearColor];
            [self addSubview:field5];
            
            UIImageView * bg = [[UIImageView alloc]initWithFrame:CGRectMake(126, 120, 127, 47)];
            bg.image = [UIImage imageNamed:@"bg_textField.png"];
            [self addSubview:bg];
            //UITextField * txField5 = [[UITextField alloc]initWithFrame:CGRectMake(135, 250, 125, 47)];
            UITextField * txField5 = [[UITextField alloc]initWithFrame:CGRectMake(135, 130, 125, 47)];

            //txField5.background = [UIImage imageNamed:@"bg_textField.png"];
            txField5.tag = 5;
            txField5.text = @"";
            [self addSubview:txField5];
            [txfieldArr addObject:txField5];
        }
        
        {
            UILabel * field6 = [[UILabel alloc]initWithFrame:CGRectMake(30, 300, 120, 47)];
            field6.text = @"选择汉字：";
            field6.backgroundColor = [UIColor clearColor];
            [self addSubview:field6];
            
            /*UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(123, 300, 127, 162)];
            
            tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_zcdlist.png"]];
            [self addSubview:tableView];*/
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


        
        
    }
    return self;

}



-(IBAction)bushouSelectClick:(UIButton * )sender{

    
    httpId = 2;
    NSString * queryType = @"12";
    NSString * key = @"";
    NSString * val = @"";
    
    NSMutableArray * queryConditions = [[NSMutableArray alloc]init];
    //bishouSelectIndex = 0;
    
    /*for (UITextField * view in txfieldArr) {
        val = view.text;
        key = [NSString stringWithFormat:@"0%d",view.tag];
        
        NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:key,@"key",val,@"value",@"1",@"matchMode", nil];
        [queryConditions addObject:dic];
        
    }*/
    {

        NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:@"01",@"key",bushouTF.text,@"value",@"1",@"matchMode", nil];
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
    httpId = 1;
    NSString * queryType = @"10";
    NSString * key = @"";
    NSString * val = @"";
    
    NSMutableArray * queryConditions = [[NSMutableArray alloc]init];
  
    if ([txfieldArr count] > 0) {
        NSString * matchMode = @"1";
        
        for (UITextField * view in txfieldArr) {
            val = [view text];
            key = [NSString stringWithFormat:@"0%d",view.tag];
            
            if ([key isEqualToString:@"03" ] || [key isEqualToString:@"05"]) {
                matchMode = @"0";
            }
            NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:key,@"key",val,@"value",matchMode,@"matchMode", nil];
            [queryConditions addObject:dic];
            if (![val isEqualToString:@""]) {
                flag = YES;
            }
            
        }
    }
    
    
    
        if (bishouSelectIndex >= 0) {
            val = datasourceBushou[bishouSelectIndex];
            NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:@"04",@"key",val,@"value",@"0",@"matchMode", nil];
            [queryConditions addObject:dic];
            flag = YES;
        }else{
            
            //NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:@"04",@"key",@"",@"value",@"1",@"matchMode", nil];
            NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:@"04",@"key",@"",@"value",@"0",@"matchMode", nil];
            [queryConditions addObject:dic];
        }
       
    if (!flag) {
        [self showTip:@"请输入查询条件"];
        return;
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
            dataSourceArr = [[NSMutableArray alloc]initWithArray:[responseDict valueForKey:@"results"]];
            if ([dataSourceArr count] > 0) {
                CGRect frame = CGRectMake(126, 300, 120, 120);
                UITableView * wordTableView = [[UITableView alloc] initWithFrame:frame];
                
                [wordTableView setTag:kTagTableCharacter];
                wordTableView.delegate = self;
                wordTableView.dataSource = self;
                [self addSubview:wordTableView];
                [wordTableView release];
            }
           
        }else if (httpId == 2) {
            
            datasourceBushou = [[NSMutableArray alloc]initWithArray:[responseDict valueForKey:@"results"]];
            UITableViewController *tableViewController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
            
            CGRect frame = CGRectMake(0, 0, 120, 240);
            UITableView * moduleTableView = [[UITableView alloc] initWithFrame:frame];
            [moduleTableView setTag:kTagBushouTB];
            moduleTableView.delegate = self;
            moduleTableView.dataSource = self;
            [tableViewController setTableView:moduleTableView];
            [moduleTableView release];
            
            popoverViewController = [[JHPopoverViewController alloc] initWithViewController:tableViewController andContentSize:frame.size];
            [popoverViewController presentPopoverFromRect:CGRectMake(140, 180, 125, 47) inView:self animated:YES];

            //[popoverViewController presentPopoverFromRect:[sender frame] inView:self animated:YES];
            [tableViewController release];
        }else if (httpId == 3){
            for (UIView * vw in [sv_top subviews]) {
                [vw removeFromSuperview];
            }
            NSArray * prefix = [[NSArray alloc]initWithObjects:@"【本字】",@"【读音】",@"【部首笔画】",@"【部首】",@"【笔画总数】",@"【笔顺】",@"【释义】",@"【组词】",@"【成语】", nil];
            showArr = [[NSMutableArray alloc]initWithArray:[responseDict valueForKey:@"results"]];
            NSString * showStr = @"";
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



#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int tag = tableView.tag;
    
    if (tag == kTagBushouTB) {
        return [datasourceBushou count];
    }else if (tag == kTagTableCharacter){
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
    if (tag == kTagBushouTB) {
        //NSDictionary* courseDict = [categoryArr objectAtIndex:indexPath.row];
        [cell.textLabel setText:[datasourceBushou objectAtIndex:indexPath.row]];
    }else if (tag == kTagTableCharacter){
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
    if (tag == kTagBushouTB) {
        if ([datasourceBushou count]>0) {
            UIButton* courseBtn = (UIButton*)[self viewWithTag:kTagBushou];
            [courseBtn setTitle:[datasourceBushou objectAtIndex:indexPath.row] forState:UIControlStateNormal];
            bishouSelectIndex = indexPath.row;
        }
        
        
    }else if (tag == kTagTableCharacter){
        httpId = 3;
        NSString * queryType = @"10";
        NSString * key = @"";
        NSString * val = @"";
        
        NSMutableArray * queryConditions = [[NSMutableArray alloc]init];
        
        /*for (UITextField * view in txfieldArr) {
            val = view.text;
            key = [NSString stringWithFormat:@"0%d",view.tag];
            
            NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:key,@"key",val,@"value",@"0",@"matchMode", nil];
            [queryConditions addObject:dic];
            
        }*/
        {
            val = [dataSourceArr objectAtIndex:indexPath.row][0];
            NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:@"01",@"key",val,@"value",@"0",@"matchMode", nil];
            [queryConditions addObject:dic];
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
    
    [popoverViewController dismissPopoverAnimated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)tableView:(UITableView*)tableView  willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}



@end