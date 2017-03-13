#import "shitiBrowseVCtrl.h"
#import "shitiView.h"
#import "RegexKitLite.h"


#define kTagUITableViewShiti 999999


@implementation shitiBrowseVCtrl

@synthesize unitDict = _unitDict;


-(void)loadView{
    [super loadView];
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768) ];
    view.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1.0];
    
    self.view = view;
 }

-(void)dealloc
{
    [super dealloc];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"popopo" object:nil];
    
}

-(void)action:(UIButton *)sender
{
    self.shoucangview.hidden = YES;
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M131" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:shitiArr[0][@"questionContent"] forKey:@"collectTitile"];
    [requestDict setValue:contentStr forKey:@"collectContent"];
    [requestDict setValue:[NSString stringWithFormat:@"%ld",(long)sender.tag + 1] forKey:@"typeId"];
    [requestDict setValue:@"2" forKey:@"sourceId"];
    [requestDict setValue:shitiArr[0][@"userAnswers"][sender.tag][@"authorId"] forKey:@"authorId"];
    [requestDict setValue:shitiArr[0][@"userAnswers"][sender.tag][@"recordId"] forKey:@"recordId"];
    
    [self showIndicator];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}

-(void)shoucang:(NSNotification *)sender
{
    NSMutableDictionary *dic = (NSMutableDictionary *)[sender userInfo];
    if (shoucangHidden == YES) {
        self.shoucangview.hidden = NO;
        shoucangHidden = NO;
    }else{
        self.shoucangview.hidden = YES;
        shoucangHidden = YES;
    }
    nameStr = dic[@"userName"];
    contentStr = dic[@"answer"][0];
}

-(void)viewDidLoad{
    shitiObjArr = [[NSMutableArray alloc]init];
    [self getShitiInfo];
    [super viewDidLoad];
    shoucangHidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shoucang:) name:@"popopo" object:nil];
    
    self.shoucangview = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 210)];
    self.shoucangview.center = self.view.center;
    self.shoucangview.hidden = YES;
    self.shoucangview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.shoucangview];
    
    NSArray *arr = @[@"好词语",@"好句子",@"好段落",@"好开头",@"好结尾",@"好题目",@"好文章",];
    int y = 0;
    for (int i = 0; i < 7; i ++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, y, 60, 30)];
        btn.tag = i;
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.layer.borderColor = [UIColor blackColor].CGColor;
        btn.layer.borderWidth = 1;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        [self.shoucangview addSubview:btn];
        y += 30;
    }

}

-(void)getShitiInfo{
    
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M065" forKey:@"method"];
    [requestDict setValue:[_unitDict valueForKey:@"courseId"] forKey:@"courseId"];
    [requestDict setValue:[_unitDict valueForKey:@"classId"] forKey:@"classId"];
    [requestDict setValue:[_unitDict valueForKey:@"gradeId"] forKey:@"gradeId"];
    //[requestDict setValue:[_unitDict valueForKey:@"moduleId"] forKey:@"moduleId"];
    //[requestDict setValue:[_unitDict valueForKey:@"authorId"] forKey:@"userId"];
    [requestDict setValue:[_unitDict valueForKey:@"unitId"] forKey:@"unitId"];
    [requestDict setValue:[_unitDict valueForKey:@"recordId"] forKey:@"recordId"];
    
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
    if(([@"M065" isEqualToString:method] && [@"00" isEqualToString:responseCode])){
        
        NSDictionary * papaer = [responseDict valueForKey:@"paper"];
        
        [self addLabel:[papaer valueForKey:@"title"]
                 frame:CGRectMake(291, 22, 421, 30)
                  size:18
              intoView:self.view];
        
        
        shitiArr = [[NSArray alloc]initWithArray:[papaer valueForKey:@"questions"]];
        
        UITableView * shitiTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, 1024, 610)];
        shitiTableView.tag = kTagUITableViewShiti;
        shitiTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        shitiTableView.delegate = self;
        shitiTableView.dataSource = self;
        [shitiTableView setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:shitiTableView];
        [shitiTableView release];
        [self.view bringSubviewToFront:self.shoucangview];
        
    }else if(![@"00" isEqualToString:responseCode]){
        [self showTip:@"服务器异常"];
    }
    
    if ([@"M131" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        [self hideIndicator];
        [self showTip:@"收藏成功"];
    }
    if ([@"M131" isEqualToString:method] && [@"96" isEqualToString:responseCode]) {
        [self hideIndicator];
        [self showTip:responseDict[@"responseMessage"]];
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
   
    NSDictionary * shiti = [shitiArr objectAtIndex:indexPath.row];
    NSString * questionType = [shiti objectForKey:@"questionType"];
    float totalHeight = 0.0f;
    
    if ([questionType intValue] == 0){//简答
        //float totalHeight = 0.0f;
        NSString * questionText = [shiti objectForKey:@"questionContent"]; // 题目
        NSString * answerText = @"";
        
        for (NSDictionary * item in [shiti objectForKey:@"userAnswers"]) {
            NSString * _userAnswer = @"";
            if ([[item objectForKey:@"answer"] isKindOfClass:[NSArray class]] && [[item objectForKey:@"answer"] count]>0) {
                _userAnswer = [item objectForKey:@"answer"][0];
            }
            NSString * tempStr = [NSString stringWithFormat:@"%@：\n%@\n\n",[item objectForKey:@"userName"],_userAnswer];
            answerText = [answerText stringByAppendingString:tempStr];
        }
        totalHeight = [self getTextHeight:[NSString stringWithFormat:@"%@\n%@",questionText,answerText]];

    }else if ([questionType intValue] == 1){//填空
        //float totalHeight = 0.0f;
        NSString * questionText = [shiti objectForKey:@"questionContent"];
        NSString * answerText = @"";
        for (NSDictionary * userAnswer in [shiti objectForKey:@"userAnswers"]) {
            answerText = [answerText stringByAppendingString:[userAnswer objectForKey:@"userName"]];
            answerText = [answerText stringByAppendingString:@":\n"];
            if ([[userAnswer objectForKey:@"answer"] isKindOfClass:[NSArray class]]) {
                for (NSString * answerItem in [userAnswer objectForKey:@"answer"]) {
                    answerText = [answerText stringByAppendingString:[NSString stringWithFormat:@"%@、",answerItem]];
                }
                answerText = [answerText substringToIndex:(answerText.length - 1)];
                answerText = [answerText stringByAppendingString:@"\n\n"];
            }
        }
        totalHeight = [self getTextHeight:[NSString stringWithFormat:@"%@\n%@",questionText,answerText]];
        
        


        
    }
    else if ([questionType intValue] == 2){//是非
        NSString * questionText = [shiti objectForKey:@"questionContent"];
        questionText = [questionText stringByAppendingString:@"\n"];
        NSString * label_text = @"";
        label_text = [label_text stringByAppendingString:questionText];
        for (NSDictionary * item in [shiti objectForKey:@"options"]) {
            NSString * optionContent =[NSString stringWithFormat:@"%@\n",[item objectForKey:@"optionContent"]] ;
            if ([item objectForKey:@"isCorrect"]) {
                optionContent = [optionContent stringByAppendingString:@"正确答案：对"];
            }else{
                optionContent = [optionContent stringByAppendingString:@"正确答案：错"];
            }
            NSString * answerText = @"答错的学生：";
            
            for (NSString * userNameStr in [item objectForKey:@"errorUsers"]) {
                //answerText = [answerText stringByAppendingString:userNameStr];
                answerText = [answerText stringByAppendingString:[NSString stringWithFormat:@"%@、",userNameStr]];
            }
            answerText = [answerText substringToIndex:(answerText.length - 1)];
            answerText = [answerText stringByAppendingString:@"\n"];
            label_text = [label_text stringByAppendingString:[NSString stringWithFormat:@"%@\n%@\n",optionContent,answerText]];
        }
         totalHeight = [self getTextHeight:label_text];
       
        
    }else{
        //float totalHeight = 0.0f;
        NSString *questionText = [shiti objectForKey:@"questionContent"];
        NSString * answerText = @"正确答案：\n";
        for (NSString * answerStr in [shiti objectForKey:@"correctOption"]) {
             answerText = [NSString stringWithFormat:@"%@%@、",answerText,answerStr];
        }
        answerText = [answerText substringToIndex:(answerText.length - 1)];
        answerText = [answerText stringByAppendingString:@"\n"];
        
        NSString * wrongText = @"答错的学生：\n";
        for (NSDictionary * item in [shiti objectForKey:@"options"]) {
            wrongText = [wrongText stringByAppendingString:[item objectForKey:@"optionContent"]];
            wrongText = [wrongText stringByAppendingString:@"：\n"];

            for (NSString * userNameStr in [item objectForKey:@"errorUsers"]) {
                wrongText = [wrongText stringByAppendingString:[NSString stringWithFormat:@"%@、",userNameStr]];
                
            }
            wrongText = [wrongText substringToIndex:(wrongText.length - 1)];
            wrongText = [wrongText stringByAppendingString:@"\n\n"];
        }
        totalHeight = [self getTextHeight:[NSString stringWithFormat:@"%@\n%@%@",questionText,answerText,wrongText]];
        
    }
    
    
    shitiView * question = [[shitiView alloc]initWithQuestion:shiti frame:CGRectMake(120, 0, 800, totalHeight)];
    [cell.contentView addSubview:question.view];
    
    [shitiObjArr addObject:question];
    
    return cell;
}

#pragma mark - Table view delegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary * shiti = [shitiArr objectAtIndex:indexPath.row];
    NSString * questionType = [shiti objectForKey:@"questionType"];
    
    if ([questionType intValue] == 0){//简答
        float totalHeight = 0.0f;
      
        NSString * questionText = [shiti objectForKey:@"questionContent"]; // 题目
        NSString * answerText = @"";
        for (NSDictionary * item in [shiti objectForKey:@"userAnswers"]) {
            NSString * _userAnswer = @"";
            if ([[item valueForKey:@"answer"] isKindOfClass:[NSArray class]]) {
                _userAnswer = [item valueForKey:@"answer"][0];
            }
            NSString * tempStr = [NSString stringWithFormat:@"%@：\n%@\n\n",[item objectForKey:@"userName"],_userAnswer];
            answerText = [answerText stringByAppendingString:tempStr];
        }
        totalHeight = [self getTextHeight:[NSString stringWithFormat:@"%@\n%@",questionText,answerText]];
        
       return  totalHeight;
        
        
    }else if ([questionType intValue] == 1){//填空
        float totalHeight = 0.0f;
   
        NSString * questionText = [shiti objectForKey:@"questionContent"];
        NSString * answerText = @"";
        for (NSDictionary * userAnswer in [shiti objectForKey:@"userAnswers"]) {
            answerText = [answerText stringByAppendingString:[userAnswer objectForKey:@"userName"]];
            answerText = [answerText stringByAppendingString:@":\n"];
            if ([[userAnswer objectForKey:@"answer"] isKindOfClass:[NSArray class]]) {
                for (NSString * answerItem in [userAnswer objectForKey:@"answer"]) {
                    answerText = [answerText stringByAppendingString:[NSString stringWithFormat:@"%@、",answerItem]];
                }
                answerText = [answerText substringToIndex:(answerText.length - 1)];

                answerText = [answerText stringByAppendingString:@"\n\n"];
            }
        }
        totalHeight = [self getTextHeight:[NSString stringWithFormat:@"%@\n%@",questionText,answerText]];
        
        return totalHeight;
        
    }
    else if ([questionType intValue] == 2){//是非
        float totalHeight = 0.0f;
        NSString * questionText = [shiti objectForKey:@"questionContent"];
        questionText = [questionText stringByAppendingString:@"\n"];
        NSString * label_text = @"";
        label_text = [label_text stringByAppendingString:questionText];
        for (NSDictionary * item in [shiti objectForKey:@"options"]) {
            NSString * optionContent =[NSString stringWithFormat:@"%@\n",[item objectForKey:@"optionContent"]] ;
            if ([item objectForKey:@"isCorrect"]) {
                optionContent = [optionContent stringByAppendingString:@"正确答案：对"];
            }else{
                optionContent = [optionContent stringByAppendingString:@"正确答案：错"];
            }
            NSString * answerText = @"答错的学生：";
            
            for (NSString * userNameStr in [item objectForKey:@"errorUsers"]) {
                //answerText = [answerText stringByAppendingString:userNameStr];
                answerText = [answerText stringByAppendingString:[NSString stringWithFormat:@"%@、",userNameStr]];
            }
            answerText = [answerText substringToIndex:(answerText.length - 1)];
            answerText = [answerText stringByAppendingString:@"\n"];
            label_text = [label_text stringByAppendingString:[NSString stringWithFormat:@"%@\n%@\n",optionContent,answerText]];
        }
        totalHeight = [self getTextHeight:label_text];
        return totalHeight;
        
        
    }else{
        float totalHeight = 0.0f;
       
        NSString *questionText = [shiti objectForKey:@"questionContent"];
        NSString * answerText = @"正确答案：\n";
        for (NSString * answerStr in [shiti objectForKey:@"correctOption"]) {
            answerText = [NSString stringWithFormat:@"%@%@、",answerText,answerStr];
        }
        answerText = [answerText substringToIndex:(answerText.length - 1)];
        answerText = [answerText stringByAppendingString:@"\n"];
        
        NSString * wrongText = @"答错的学生：\n";
        for (NSDictionary * item in [shiti objectForKey:@"options"]) {
            wrongText = [wrongText stringByAppendingString:[item objectForKey:@"optionContent"]];
            wrongText = [wrongText stringByAppendingString:@"：\n"];
            
            for (NSString * userNameStr in [item objectForKey:@"errorUsers"]) {
                wrongText = [wrongText stringByAppendingString:[NSString stringWithFormat:@"%@、",userNameStr]];
                
            }
            wrongText = [wrongText substringToIndex:(wrongText.length - 1)];
            wrongText = [wrongText stringByAppendingString:@"\n\n"];
        }
        totalHeight = [self getTextHeight:[NSString stringWithFormat:@"%@\n%@%@",questionText,answerText,wrongText]];
        return totalHeight;
        
           
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
    
    
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:18];
    CGSize constraintSize = CGSizeMake(800.0f, MAXFLOAT);
    CGSize labelSize = [textStr sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    float height = labelSize.height+20 ;
    return height;
}

@end
