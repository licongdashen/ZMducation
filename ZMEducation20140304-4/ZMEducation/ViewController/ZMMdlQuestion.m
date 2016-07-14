#import "ZMMdlQuestion.h"
#import "RegexKitLite.h"

@implementation ZMMdlQuestion
@synthesize answerArr = _answerArr;
@synthesize questionId;
@synthesize questionType;


-(id)initWithQuestion:(NSDictionary *)question frame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        questionId = [[question objectForKey:@"questionId"]intValue];
        questionType = [[question objectForKey:@"questionType"]intValue];
        
        _answerInput = [[NSMutableArray alloc]init];
        _checkBox = [[NSMutableArray alloc]init];
        
        if ([[question objectForKey:@"questionType"] intValue] == 0) {
        
            UILabel * lb_title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 800, 50)];
            lb_title.text = [question objectForKey:@"questionContent"];
            lb_title.backgroundColor = [UIColor clearColor];
            lb_title.lineBreakMode = UILineBreakModeWordWrap;
            lb_title.numberOfLines = 0;
            [lb_title sizeToFit];
            [self addSubview:lb_title];
            float height = [self getTextHeight:[question objectForKey:@"questionContent"]];
            //UIExpandingTextView * tf_answer = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(0, height, 800, 120)];
            UITextView * tf_answer = [[UITextView alloc]initWithFrame:CGRectMake(0, height, 800, 120)];
            tf_answer.font = [UIFont systemFontOfSize:18];
            tf_answer.backgroundColor = [UIColor whiteColor];
            
            //tf_answer.placeholder = @"请在此答题";
            //tf_answer.textAlignment = UIControlContentHorizontalAlignmentLeft;
            [self addSubview:tf_answer];
            {
                NSArray *  answerArray = [[NSArray alloc]initWithArray:[question objectForKey:@"answer"]];
                if ([answerArray count] > 0) {
                    tf_answer.text = answerArray[0];
                }
                
            }
            [_answerInput addObject:tf_answer];
            
        }else if ([[question objectForKey:@"questionType"] intValue] == 1) {
            
            UILabel * lb_title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 800, 50)];
            lb_title.text = [question objectForKey:@"questionContent"];
            lb_title.backgroundColor = [UIColor clearColor];
            lb_title.lineBreakMode = UILineBreakModeWordWrap;
            lb_title.numberOfLines = 0;
            [lb_title sizeToFit];
            [self addSubview:lb_title];
            float height = [self getTextHeight:[question objectForKey:@"questionContent"]];
            UILabel * lb_answer = [[UILabel alloc]initWithFrame:CGRectMake(0, height - 20, 120, 50)];
            lb_answer.backgroundColor = [UIColor clearColor];
            lb_answer.textAlignment = UIControlContentVerticalAlignmentTop;
            lb_answer.text = @"请在此答题：";
            [self addSubview:lb_answer];
            {

                NSArray *  answerArray = [[NSArray alloc]initWithArray:[question objectForKey:@"answer"]];
                
                // 搜索字符串
                
                NSString *searchString = [question objectForKey:@"questionContent"];
                NSString *regexString = @"(_+)";
                NSArray  *matchArray   = NULL;
                
                // 根据正则表达式提取对应的内容
                
                matchArray = [searchString componentsMatchedByRegex:regexString];
                
                for (int i = 0 , k = 0 , m = 0; i < [matchArray count]; i++,m++) {
                    
                    
                    if (i % 4 == 0) {
                        k++;
                        m = 0;
                    }
                    
                    CGRect rct = CGRectMake(170*m+140, 75*(k-1)+height, 140, 55);
                    //NSLog(@"frame : %@",NSStringFromCGRect(rct));
                    UITextView * tf_answer = [[UITextView alloc]initWithFrame:rct];
                    tf_answer.font = [UIFont systemFontOfSize:18];
                    //tf_answer.placeholder = [NSString stringWithFormat:@"%d",i+1];
                    //tf_answer.maximumNumberOfLines = 2;
                    tf_answer.backgroundColor = [UIColor colorWithRed:248 green:248 blue:248 alpha:1.0];
                    if ([answerArray count] > 0) {
                        tf_answer.text = answerArray[i];
                    }
                    [self addSubview:tf_answer];
                    [_answerInput addObject:tf_answer];
                    
                    /*添加序号*/
                    CGRect rct_indic = CGRectMake(170*m+123, 75*(k-1)+height, 20, 55);
                    UILabel * lb_indic = [[UILabel alloc]initWithFrame:rct_indic];
                    lb_indic.backgroundColor = [UIColor clearColor];
                    lb_indic.text = [NSString stringWithFormat:@"%d",i+1];
                    lb_indic.textColor = [UIColor grayColor];
                    [self addSubview:lb_indic];
                    
                }
                
                
                
            }
        }else if ([[question objectForKey:@"questionType"] intValue] == 2 )
        {
            NSArray *  answerArray = [[NSArray alloc]initWithArray:[question objectForKey:@"answer"]];
            
        
            UILabel * lb_title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 800, 50)];
            lb_title.text = [question objectForKey:@"questionContent"];
            lb_title.backgroundColor = [UIColor clearColor];
            lb_title.lineBreakMode = UILineBreakModeWordWrap;
            lb_title.numberOfLines = 0;
            [lb_title sizeToFit];
            [self addSubview:lb_title];
            float height = [self getTextHeight:[question objectForKey:@"questionContent"]];
            NSArray * options = [question objectForKey:@"options"];
            for (int i = 0 ; i < [options count]; i++) {
                UILabel * lb_option = [[UILabel alloc]initWithFrame:CGRectMake(40, 50*i + height-5, 800, 50)];
                lb_option.text = [options[i] objectForKey:@"optionContent"];
                lb_option.backgroundColor = [UIColor clearColor];
                [self addSubview:lb_option];
                UIButton * btn_right = [[UIButton alloc]initWithFrame:CGRectMake(0, 8 + 50*i + height, 25, 25)];
                [btn_right setBackgroundImage:[UIImage imageNamed:@"Share_Btn.png"] forState:UIControlStateNormal];
                [btn_right setBackgroundImage:[UIImage imageNamed:@"Share_Select_Btn.png"] forState:UIControlStateSelected];
                [btn_right addTarget:self
                              action:@selector(shareClick:)
                    forControlEvents:UIControlEventTouchUpInside];
                btn_right.tag = [[options[i] objectForKey:@"optionId"] intValue];
                
                if ([answerArray count] > 0) {
                    NSDictionary * optionDict = answerArray[i];
                    NSString * flag = [optionDict valueForKey:@"flag"];
                    if ([flag isEqualToString:@"1"]) {
                        [btn_right setSelected:YES];
                    }
                }
                
                [self addSubview:btn_right];
                [_checkBox addObject:btn_right];
            }
        }
        else if ([[question objectForKey:@"questionType"] intValue] == 3 )
        {
            NSArray *  answerArray = [[NSArray alloc]initWithArray:[question objectForKey:@"answer"]];
            
            UILabel * lb_title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 800, 50)];
            lb_title.text = [question objectForKey:@"questionContent"];
            lb_title.backgroundColor = [UIColor clearColor];
            lb_title.lineBreakMode = UILineBreakModeWordWrap;
            lb_title.numberOfLines = 0;
            [lb_title sizeToFit];
            [self addSubview:lb_title];
            float height = [self getTextHeight:[question objectForKey:@"questionContent"]];
            NSArray * options = [question objectForKey:@"options"];
            for (int i = 0 ; i < [options count]; i++) {
                UILabel * lb_option = [[UILabel alloc]initWithFrame:CGRectMake(40, 50*i + height-5, 800, 50)];
                lb_option.text = [options[i] objectForKey:@"optionContent"];
                lb_option.backgroundColor = [UIColor clearColor];
                [self addSubview:lb_option];
                UIButton * btn_right = [[UIButton alloc]initWithFrame:CGRectMake(0, 8 + 50*i + height, 25, 25)];
                [btn_right setBackgroundImage:[UIImage imageNamed:@"Share_Btn.png"] forState:UIControlStateNormal];
                [btn_right setBackgroundImage:[UIImage imageNamed:@"Share_Select_Btn.png"] forState:UIControlStateSelected];
                [btn_right addTarget:self
                             action:@selector(shareClick:)
                   forControlEvents:UIControlEventTouchUpInside];
                btn_right.tag = [[options[i] objectForKey:@"optionId"] intValue];
                if ([answerArray count] > 0) {
                    NSDictionary * optionDict = answerArray[i];
                    NSString * flag = [optionDict valueForKey:@"flag"];
                    if ([flag isEqualToString:@"1"]) {
                        [btn_right setSelected:YES];
                    }
                }
                [self addSubview:btn_right];
                [_checkBox addObject:btn_right];
            }
            
        }
        else if ([[question objectForKey:@"questionType"] intValue] == 4)
        {
            NSArray *  answerArray = [[NSArray alloc]initWithArray:[question objectForKey:@"answer"]];
            
            UILabel * lb_title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 800, 50)];
            lb_title.text = [question objectForKey:@"questionContent"];
            lb_title.backgroundColor = [UIColor clearColor];
            lb_title.lineBreakMode = UILineBreakModeWordWrap;
            lb_title.numberOfLines = 0;
            [lb_title sizeToFit];
            [self addSubview:lb_title];
            float height = [self getTextHeight:[question objectForKey:@"questionContent"]];
            NSArray * options = [question objectForKey:@"options"];
            for (int i = 0 ; i < [options count]; i++) {
                UILabel * lb_option = [[UILabel alloc]initWithFrame:CGRectMake(40, 50*i + height-5, 800, 50)];
                lb_option.text = [options[i] objectForKey:@"optionContent"];
                lb_option.backgroundColor = [UIColor clearColor];
                [self addSubview:lb_option];
                UIButton * btn_right = [[UIButton alloc]initWithFrame:CGRectMake(0, 8 + 50*i + height, 25, 25)];
                [btn_right setBackgroundImage:[UIImage imageNamed:@"Share_Btn.png"] forState:UIControlStateNormal];
                [btn_right setBackgroundImage:[UIImage imageNamed:@"Share_Select_Btn.png"] forState:UIControlStateSelected];
                [btn_right addTarget:self
                              action:@selector(shareClick:)
                    forControlEvents:UIControlEventTouchUpInside];
                btn_right.tag = [[options[i] objectForKey:@"optionId"] intValue];
                
                /*if ([answerArray count] > 0) {
                    NSDictionary * optionDict = answerArray[i];
                    NSString * flag = [optionDict valueForKey:@"flag"];
                    if ([flag isEqualToString:@"1"]) {
                        [btn_right setSelected:YES];
                    }
                }*/
                
                if ([answerArray count] > 0) {
                    for (NSDictionary * answerDict in answerArray) {
                        int answertIntValue = [[answerDict objectForKey:@"optionId"] intValue];
                        int optionIntValue = [[options[i] objectForKey:@"optionId"] intValue] ;
                        if (answertIntValue == optionIntValue) {
                            NSString * flag = [answerDict valueForKey:@"flag"];
                            if ([flag isEqualToString:@"1"]) {
                                [btn_right setSelected:YES];
                            }
                        }
                    }
                }
                
                
                [self addSubview:btn_right];
                [_checkBox addObject:btn_right];
            }
            
        }

        
    }
    
    return self;
}

-(NSArray *)answerArr{
    
    NSMutableArray * answers = [[NSMutableArray alloc]init];
    if (self.questionType == 0) {
        
        for (UITextView * tv in _answerInput) {
            [answers addObject:tv.text];
        }
    }if (self.questionType == 1) {
        
        for (UITextView * tv in _answerInput) {
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