#import "ZMMdlShitiVCtrl.h"
#import "ZMMdlQuestion.h"
#import "RegexKitLite.h"


#define kTagUITableViewShiti 999999


@implementation ZMMdlShitiVCtrl

@synthesize unitDict = _unitDict;

-(void)loadView{
    [super loadView];
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    view.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
    self.view = view;
    
    
    UIImage* article_Category_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Category_bg" ofType:@"png"]];
    UIImageView* article_Category_View = [[UIImageView alloc] initWithFrame:CGRectMake(291, 15, 421, 43)];
    [article_Category_View setImage:article_Category_Image];
    [view addSubview:article_Category_View];
    [article_Category_View release];
    
    
    UIButton* submitBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBut setFrame:CGRectMake(894, 670, 105, 89)];
    [submitBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Submit_Btn" ofType:@"png"]] forState:UIControlStateNormal];
    [submitBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Submit_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
    
    [submitBut addTarget:self action:@selector(submitWorkClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBut];

    


}

-(void)viewDidLoad{
    shitiObjArr = [[NSMutableArray alloc]init];
    [self getShitiInfo];
    [super viewDidLoad];
    
}

-(void)getShitiInfo{
    
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M062" forKey:@"method"];
    [requestDict setValue:[_unitDict valueForKey:@"courseId"] forKey:@"courseId"];
    [requestDict setValue:[_unitDict valueForKey:@"classId"] forKey:@"classId"];
    [requestDict setValue:[_unitDict valueForKey:@"gradeId"] forKey:@"gradeId"];
    [requestDict setValue:[_unitDict valueForKey:@"moduleId"] forKey:@"moduleId"];
    [requestDict setValue:[_unitDict valueForKey:@"authorId"] forKey:@"userId"];
    [requestDict setValue:[_unitDict valueForKey:@"unitId"] forKey:@"unitId"];
    [requestDict setValue:[_unitDict valueForKey:@"recordId"] forKey:@"recordId"];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}

-(void)submitWorkClick:(UIButton *)sender
{
    NSMutableArray * answersArr = [[NSMutableArray alloc]init];
    
    
    for (ZMMdlQuestion * question in shitiObjArr) {
        NSMutableDictionary * answerItem = [[NSMutableDictionary alloc] init];
        [answerItem removeAllObjects];
        [answerItem setValue:[NSString stringWithFormat:@"%d",question.questionId] forKey:@"questionId"];
        [answerItem setValue:[NSString stringWithFormat:@"%d",question.questionType] forKey:@"questionType"];
        [answerItem setValue:[question.answerArr JSONString] forKey:@"answer"];
        [answersArr addObject:answerItem];
    }
    
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M063" forKey:@"method"];
    [requestDict setValue:[_unitDict valueForKey:@"courseId"] forKey:@"courseId"];
    [requestDict setValue:[_unitDict valueForKey:@"classId"] forKey:@"classId"];
    [requestDict setValue:[_unitDict valueForKey:@"gradeId"] forKey:@"gradeId"];
    [requestDict setValue:@"" forKey:@"moduleId"];
    [requestDict setValue:[_unitDict valueForKey:@"authorId"] forKey:@"userId"];
    [requestDict setValue:[_unitDict valueForKey:@"unitId"] forKey:@"unitId"];
    //[requestDict setValue:[_unitDict valueForKey:@"recordId"] forKey:@"recordId"];
    [requestDict setValue:[answersArr JSONString] forKey:@"answers"];
    
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
    if(([@"M062" isEqualToString:method] && [@"00" isEqualToString:responseCode])){
        
        [self addLabel:[responseDict valueForKey:@"unitTitle"]
                 frame:CGRectMake(291, 22, 421, 30)
                  size:18
              intoView:self.view];
        
        
        shitiArr = [[NSArray alloc]initWithArray:[responseDict valueForKey:@"questions"]];
        
        UITableView * shitiTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, 1024, 610)];
        shitiTableView.tag = kTagUITableViewShiti;
        shitiTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        shitiTableView.delegate = self;
        shitiTableView.dataSource = self;
        [shitiTableView setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:shitiTableView];
        [shitiTableView release];
        
    }if(([@"M063" isEqualToString:method] && [@"00" isEqualToString:responseCode])){
        
        [self showTip:@"提交答案成功"];

        
    }else if(![@"00" isEqualToString:responseCode]){
        [self showTip:@"服务器异常"];
    }
}


#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [shitiArr count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //static NSString *CellIdentifier = @"Cell";
    NSString * CellIdentifier = [NSString stringWithFormat:@"Cell_%d",indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSLog(@"CellIdentifier : %@",CellIdentifier);
    if (cell == nil){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    
    
    NSDictionary * shiti = [shitiArr objectAtIndex:indexPath.row];
    NSString * questionType = [shiti objectForKey:@"questionType"];
    float height = 300.0f;
    if ([questionType intValue] == 0){ //简答题
        //先计算文本高度
        NSString *cellText = [shiti objectForKey:@"questionContent"];
        height = [self getTextHeight:cellText] + 20 + 120 ;//文本高度+输入框高度
        
    }else if ([questionType intValue] == 1) { // 填空题
        //先计算文本高度
        NSString *cellText = [shiti objectForKey:@"questionContent"];
        
        
        //再计算几行输入框
        NSString *searchString = [shiti objectForKey:@"questionContent"];
        NSString *regexString = @"(_+)";
        NSArray  *matchArray   = NULL;
        matchArray = [searchString componentsMatchedByRegex:regexString];
        int numberOfTxField = [matchArray count] / 4 ;
        if ([matchArray count] % 4 > 0) {
            numberOfTxField ++ ;
        }
        height =  [self getTextHeight:cellText] + 20 + numberOfTxField*75;
    }else{
        NSString *cellText = [shiti objectForKey:@"questionContent"];
        //再计算几个选项
        NSArray * options = [shiti objectForKey:@"options"];
        
        height = [self getTextHeight:cellText] + 20 + [options count]*50;
    
    }
    ZMMdlQuestion * question = [[ZMMdlQuestion alloc]initWithQuestion:shiti frame:CGRectMake(120, 0, 800, height)];
    [cell.contentView addSubview:question];
    
    [shitiObjArr addObject:question];
    //[question release];
   
    }/*else{
        for (UIView *subView in [cell.contentView subviews]){
			[subView removeFromSuperview];
		}
    }*/
   
    
    return cell;
}

#pragma mark - Table view delegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSDictionary * shiti = shitiArr[indexPath];
    NSDictionary * shiti = [shitiArr objectAtIndex:indexPath.row];
    NSString * questionType = [shiti objectForKey:@"questionType"];
    
    if ([questionType intValue] == 0){
        NSString *cellText = [shiti objectForKey:@"questionContent"];
        return  [self getTextHeight:cellText] + 20 + 120 ;
        
    }else if ([questionType intValue] == 1){
        NSString *cellText = [shiti objectForKey:@"questionContent"];
        //再计算几行输入框
        NSString *searchString = [shiti objectForKey:@"questionContent"];
        NSString *regexString = @"(_+)";
        NSArray  *matchArray   = NULL;
        matchArray = [searchString componentsMatchedByRegex:regexString];
        int numberOfTxField = [matchArray count] / 4 ;
        if ([matchArray count] % 4 > 0) {
            numberOfTxField ++ ;
        }
        return [self getTextHeight:cellText] + 20 + numberOfTxField*75;
    }else{
        NSString *cellText = [shiti objectForKey:@"questionContent"];
        //再计算几个选项
        NSArray * options = [shiti objectForKey:@"options"];
        
        return [self getTextHeight:cellText] + 20 + [options count]*50;
    }
    
    return 300.0f;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)tableView:(UITableView*)tableView  willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}


-(float)getTextHeight:(NSString *) textStr{
    
    
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:17.0];
    CGSize constraintSize = CGSizeMake(800.0f, MAXFLOAT);
    CGSize labelSize = [textStr sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    float height = labelSize.height+20 ;
    return height;
}

@end