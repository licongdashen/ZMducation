#import "shitiView.h"
#import "RegexKitLite.h"

@implementation shitiView
@synthesize answerArr = _answerArr;
@synthesize questionId;
@synthesize questionType;

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
    [requestDict setValue:nameStr forKey:@"collectTitile"];
    [requestDict setValue:contentStr forKey:@"collectContent"];
    [requestDict setValue:[NSString stringWithFormat:@"%ld",(long)sender.tag + 1] forKey:@"typeId"];
    [requestDict setValue:@"2" forKey:@"sourceId"];
    
    [self showIndicator];

    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}

-(void)shoucang:(UIButton *)sender
{
    
    self.shoucangview.hidden = NO;
    self.shoucangview.center = CGPointMake(self.view.center.x, self.scro.contentOffset.y + self.scro.frame.size.height/2);
    nameStr = self.shiti[@"userAnswers"][sender.tag - 1000][@"userName"];
    contentStr = self.shiti[@"userAnswers"][sender.tag - 1000][@"answer"][0];

}

-(void)fabu:(UIButton *)sender
{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M135" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:self.shiti[@"userAnswers"][sender.tag - 10000][@"userName"] forKey:@"collectTitile"];
    [requestDict setValue:self.shiti[@"userAnswers"][sender.tag - 10000][@"answer"][0] forKey:@"collectContent"];
    [requestDict setValue:@"3" forKey:@"sourceId"];
//    [requestDict setValue:((ZMAppDelegate*)[UIApplication sharedApplication].delegate).authorId forKey:@"authorId"];
//    [requestDict setValue:((ZMAppDelegate*)[UIApplication sharedApplication].delegate).unitId forKey:@"recordId"];
    
    [self showIndicator];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
    

    
}

-(void)httpEngine:(ZMHttpEngine *)httpEngine didSuccess:(NSDictionary *)responseDict{
    [super httpEngine:httpEngine didSuccess:responseDict];
    
    NSString* method = [responseDict valueForKey:@"method"];
    NSString* responseCode = [responseDict valueForKey:@"responseCode"];
    if ([@"M131" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        [self hideIndicator];
        [self showTip:@"收藏成功"];
    }
    if ([@"M131" isEqualToString:method] && [@"96" isEqualToString:responseCode]) {
        [self hideIndicator];
        [self showTip:@"收藏失败"];
    }
    
    if ([@"M135" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        [self hideIndicator];
        [self showTip:@"发布成功"];
    }
    if ([@"M135" isEqualToString:method] && [@"96" isEqualToString:responseCode]) {
        [self hideIndicator];
        [self showTip:@"发布失败"];
    }
}

-(id)initWithQuestion:(NSDictionary *)question frame:(CGRect)frame{
    
    if (self = [super init]) {
        
        self.shiti = question;
        
        self.scro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 200)];
        self.scro.contentSize = CGSizeMake(frame.size.width, frame.size.height);
        [self.view addSubview:self.scro];
        
        self.shoucangview = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 210)];
        self.shoucangview.center = self.view.center;
        self.shoucangview.hidden = YES;
        [self.scro addSubview:self.shoucangview];
        
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

        questionId = [[question objectForKey:@"questionId"]intValue];
        questionType = [[question objectForKey:@"questionType"]intValue];
        
        _answerInput = [[NSMutableArray alloc]init];
        _checkBox = [[NSMutableArray alloc]init];
        
        if ([[question objectForKey:@"questionType"] intValue] == 0) {//简答题
             float totalHeight = 0.0f;
             NSString * questionText = [question objectForKey:@"questionContent"]; // 题目
             NSString * answerText = @"";
            int y = 0;
            int i= 0;
             for (NSDictionary * item in [question objectForKey:@"userAnswers"]) {
             NSString * tempStr = [NSString stringWithFormat:@"%@：\n%@\n\n",[item objectForKey:@"userName"],[item objectForKey:@"answer"][0]];
             answerText = [answerText stringByAppendingString:tempStr];

                 
                 totalHeight = [self getTextHeight1:tempStr];

                 UITextView * lb_title = [[UITextView alloc]initWithFrame:CGRectMake(0, y + 20, 800, totalHeight)];
                 lb_title.text = tempStr;
                 lb_title.backgroundColor = [UIColor clearColor];
                 lb_title.font = [UIFont systemFontOfSize:16];
                 lb_title.editable = NO;
                 lb_title.userInteractionEnabled = NO;
                 [self.scro addSubview:lb_title];
                 
                 self.shoucangBtn = [[UIButton alloc]initWithFrame:CGRectMake(150, y + 20, 50, 30)];
                 [self.shoucangBtn setTitle:@"收藏" forState:UIControlStateNormal];
                 [self.shoucangBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                 self.shoucangBtn.layer.borderColor = [UIColor blackColor].CGColor;
                 self.shoucangBtn.layer.borderWidth = 1;
                 self.shoucangBtn.tag = 1000 + i;
                 [self.shoucangBtn addTarget:self action:@selector(shoucang:) forControlEvents:UIControlEventTouchUpInside];
                 [self.scro addSubview:self.shoucangBtn];
                 
                UIButton *fabuBtn = [[UIButton alloc]initWithFrame:CGRectMake(220, y + 20, 50, 30)];
                 [fabuBtn setTitle:@"发布" forState:UIControlStateNormal];
                 [fabuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                 fabuBtn.layer.borderColor = [UIColor blackColor].CGColor;
                 fabuBtn.layer.borderWidth = 1;
                 fabuBtn.tag = 10000 + i;
                 [fabuBtn addTarget:self action:@selector(fabu:) forControlEvents:UIControlEventTouchUpInside];
                 [self.scro addSubview:fabuBtn];
                 y += totalHeight;
                 i++;
                 NSLog(@"hhhhhh%@",tempStr);
             }

            
        }else if ([[question objectForKey:@"questionType"] intValue] == 1) {//填空题
            
            
            NSString * questionText = [question objectForKey:@"questionContent"];
            NSString * answerText = @"";
            for (NSDictionary * userAnswer in [question objectForKey:@"userAnswers"]) {
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
            
            NSString * label_text = [NSString stringWithFormat:@"%@\n%@",questionText,answerText];
            float totalHeight = [self getTextHeight:label_text];
            UITextView * lb_title = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, 800, totalHeight)];
            lb_title.text = label_text;
            lb_title.backgroundColor = [UIColor clearColor];
            lb_title.font = [UIFont systemFontOfSize:16];
            lb_title.editable = NO;
            [self.view addSubview:lb_title];
            
           
        }else if ([[question objectForKey:@"questionType"] intValue] == 2 ) // 是非题
        {
            NSString * questionText = [question objectForKey:@"questionContent"];
            questionText = [questionText stringByAppendingString:@"\n"];
            NSString * label_text = @"";
            label_text = [label_text stringByAppendingString:questionText];
            for (NSDictionary * item in [question objectForKey:@"options"]) {
                NSString * optionContent =[NSString stringWithFormat:@"%@\n",[item objectForKey:@"optionContent"]] ;
                //NSLog(@"...%@",[item objectForKey:@"isCorrect"]);
                if ([[item objectForKey:@"isCorrect"] intValue] == 1) {
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
            float totalHeight = [self getTextHeight:label_text];
            UITextView * lb_title = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, 800, totalHeight)];
            lb_title.text = label_text;
            lb_title.backgroundColor = [UIColor clearColor];
            lb_title.font = [UIFont systemFontOfSize:16];
            lb_title.editable = NO;
            [self.view addSubview:lb_title];

        }
        else if ([[question objectForKey:@"questionType"] intValue] == 3 )
        {
            float totalHeight = 0.0f;
            NSString *questionText = [question objectForKey:@"questionContent"];
            NSString * answerText = @"正确答案：\n";
            for (NSString * answerStr in [question objectForKey:@"correctOptions"]) {
                //answerText = [answerText stringByAppendingString:answerStr];
                 answerText = [NSString stringWithFormat:@"%@%@、",answerText,answerStr];
            }
            answerText = [answerText substringToIndex:(answerText.length - 1)];

            answerText = [answerText stringByAppendingString:@"\n"];
            
            NSString * wrongText = @"答错的学生：\n";
            for (NSDictionary * item in [question objectForKey:@"options"]) {
                wrongText = [wrongText stringByAppendingString:[item objectForKey:@"optionContent"]];
                 wrongText = [wrongText stringByAppendingString:@"：\n"];
                for (NSString * userNameStr in [item objectForKey:@"errorUsers"]) {
                    wrongText = [wrongText stringByAppendingString:[NSString stringWithFormat:@"%@、",userNameStr]];

                }
                wrongText = [wrongText substringToIndex:(wrongText.length - 1)];

                wrongText = [wrongText stringByAppendingString:@"\n"];
            }
            
            NSString * label_text = [NSString stringWithFormat:@"%@\n%@%@",questionText,answerText,wrongText];

            totalHeight = [self getTextHeight:label_text];
            
            UITextView * lb_title = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, 800, totalHeight)];
            lb_title.text = label_text;
            lb_title.backgroundColor = [UIColor clearColor];
            lb_title.font = [UIFont systemFontOfSize:16];
            lb_title.editable = NO;
            [self.view addSubview:lb_title];
            
            
        }
        else if ([[question objectForKey:@"questionType"] intValue] == 4)
        {
            float totalHeight = 0.0f;
            NSString *questionText = [question objectForKey:@"questionContent"];
            NSString * answerText = @"正确答案：\n";
            for (NSString * answerStr in [question objectForKey:@"correctOptions"]) {
                 answerText = [NSString stringWithFormat:@"%@%@、",answerText,answerStr];
            }
            answerText = [answerText substringToIndex:(answerText.length - 1)];

            answerText = [answerText stringByAppendingString:@"\n"];
            
            NSString * wrongText = @"答错的学生：\n";
            for (NSDictionary * item in [question objectForKey:@"options"]) {
                wrongText = [wrongText stringByAppendingString:[item objectForKey:@"optionContent"]];
                 wrongText = [wrongText stringByAppendingString:@"：\n"];
                
                for (NSString * userNameStr in [item objectForKey:@"errorUsers"]) {
                    wrongText = [wrongText stringByAppendingString:[NSString stringWithFormat:@"%@、",userNameStr]];
                    
                }
                wrongText = [wrongText substringToIndex:(wrongText.length - 1)];
                wrongText = [wrongText stringByAppendingString:@"\n"];

            }
            
            NSString * label_text = [NSString stringWithFormat:@"%@\n%@%@",questionText,answerText,wrongText];
            
            totalHeight = [self getTextHeight:label_text];
            
            UITextView * lb_title = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, 800, totalHeight)];
            lb_title.text = label_text;
            lb_title.backgroundColor = [UIColor clearColor];
            lb_title.font = [UIFont systemFontOfSize:16];
            lb_title.editable = NO;
            [self.view addSubview:lb_title];
        }
        
        
    }
    
    return self;
}

-(NSArray *)answerArr{
    
    NSMutableArray * answers = [[NSMutableArray alloc]init];
    if (self.questionType == 1) {
        
        for (UIExpandingTextView * tv in _answerInput) {
            [answers addObject:tv.text];
        }
    }else
    {
        
        for (UIButton * btn in _checkBox) {
            NSString * selectVal = @"0";
            if (btn.selected) {
                selectVal = @"1";
            }
            NSDictionary * dict = [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",btn.tag],@"optionId",selectVal,@"flag", nil];
            [answers addObject:dict];
        }
    }
    
    
    _answerArr = [[NSArray alloc]initWithArray:answers];
    return _answerArr;
    
}

-(float)getTextHeight:(NSString *) textStr{
    
    
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:17.0];
    CGSize constraintSize = CGSizeMake(800.0f, MAXFLOAT);
    CGSize labelSize = [textStr sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    float height = labelSize.height+20 ;
    return height;
}

-(float)getTextHeight1:(NSString *) textStr{
    
    
    UIFont *cellFont = [UIFont systemFontOfSize:16];
    CGSize constraintSize = CGSizeMake(800.0f, MAXFLOAT);
    CGSize labelSize = [textStr sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    float height = labelSize.height;
    return height;
}
-(IBAction)shareClick:(id)sender{
    UIButton* shareBtn = (UIButton*)sender;
    
    [shareBtn setSelected:!shareBtn.selected];
}
/*
 - (void)expandingTextViewDidEndEditing:(UIExpandingTextView *)expandingTextView;
 {
 
 self.answerStr = expandingTextView.text;
 
 }
 */

/*-(id)initWithFrame:(CGRect)frame{
 
 if (self = [super initWithFrame:frame]) {
 
 UILabel * lb_title = [[UILabel alloc]initWithFrame:CGRectMake(120, 0, 800, 50)];
 lb_title.text = [shiti objectForKey:@"questionContent"];
 [self addSubview:lb_title];
 UILabel * lb_answer = [[UILabel alloc]initWithFrame:CGRectMake(120, 60, 120, 50)];
 lb_answer.text = @"请在此答题：";
 UITextField * tf_answer = [[UITextField alloc]initWithFrame:CGRectMake(240, 60, 200, 50)];
 tf_answer.backgroundColor = [UIColor grayColor];
 [self addSubview:lb_answer];
 [self addSubview:tf_answer];
 
 }
 
 return self;
 
 }*/

@end
