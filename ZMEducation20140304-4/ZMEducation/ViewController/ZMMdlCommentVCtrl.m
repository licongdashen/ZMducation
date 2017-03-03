#define IOS7 [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0

#import "ZMMdlCommentVCtrl.h"

@implementation ZMMdlCommentVCtrl

-(void)getArticleInfo{
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M067" forKey:@"method"];
    [requestDict setValue:[self.unitDict valueForKey:@"courseId"] forKey:@"courseId"];
    [requestDict setValue:[self.unitDict valueForKey:@"classId"] forKey:@"classId"];
    [requestDict setValue:[self.unitDict valueForKey:@"gradeId"] forKey:@"gradeId"];
    [requestDict setValue:[self.unitDict valueForKey:@"moduleId"] forKey:@"moduleId"];
    [requestDict setValue:[self.unitDict valueForKey:@"authorId"] forKey:@"userId"];
    [requestDict setValue:[self.unitDict valueForKey:@"unitId"] forKey:@"unitId"];
    //[requestDict setValue:[self.unitDict valueForKey:@"recordId"] forKey:@"recordId"];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}
-(void)addCommentView
{

}

-(void)addDraftView
{
    
   
}


-(void)addContentView
{
    [super addContentView];

    feedbackDict_Gousi = [[NSDictionary alloc]init];
    feedbackDict_Gousi = [_feedbackArray objectAtIndex:0];
    NSMutableArray * label_arr = [[NSMutableArray alloc]init];
    
    NSMutableArray * label_1_arr = [[NSMutableArray alloc]init];
    UILabel * label_00 = [[UILabel alloc]initWithFrame:CGRectMake(27, 70, 120, 98)];
    label_00.font = [UIFont systemFontOfSize:18];
    label_00.backgroundColor = [UIColor clearColor];
    [articleView addSubview:label_00];
    [label_1_arr addObject:label_00];
    
    UILabel * label_01 = [[UILabel alloc]initWithFrame:CGRectMake(135+27, 70, 500, 98)];
    label_01.font = [UIFont systemFontOfSize:18];
    label_01.backgroundColor = [UIColor clearColor];
    [articleView addSubview:label_01];
    [label_1_arr addObject:label_01];
    
    UILabel * label_02 = [[UILabel alloc]initWithFrame:CGRectMake(645+27, 70, 100, 98)];
    label_02.font = [UIFont systemFontOfSize:18];
    label_02.textAlignment = UITextAlignmentCenter;
    label_02.backgroundColor = [UIColor clearColor];
    [articleView addSubview:label_02];
    [label_1_arr addObject:label_02];
    [label_arr addObject:label_1_arr];
    
    NSMutableArray * label_2_arr = [[NSMutableArray alloc]init];
    UILabel * label_10 = [[UILabel alloc]initWithFrame:CGRectMake(27, 98+70, 120, 98)];
    label_10.font = [UIFont systemFontOfSize:18];
    label_10.backgroundColor = [UIColor clearColor];
    [articleView addSubview:label_10];
    [label_2_arr addObject:label_10];
    
    UILabel * label_11 = [[UILabel alloc]initWithFrame:CGRectMake(135+27, 98+70, 500, 98)];
    label_11.font = [UIFont systemFontOfSize:18];
    label_11.backgroundColor = [UIColor clearColor];
    [articleView addSubview:label_11];
    [label_2_arr addObject:label_11];
    
    UILabel * label_12 = [[UILabel alloc]initWithFrame:CGRectMake(645+27, 98+70, 100, 98)];
    label_12.font = [UIFont systemFontOfSize:18];
    label_12.textAlignment = UITextAlignmentCenter;
    label_12.backgroundColor = [UIColor clearColor];
    [articleView addSubview:label_12];
    [label_2_arr addObject:label_12];
    [label_arr addObject:label_2_arr];
    
    NSMutableArray * label_3_arr = [[NSMutableArray alloc]init];
    UILabel * label_20 = [[UILabel alloc]initWithFrame:CGRectMake(27, 196+70, 120, 98)];
    label_20.font = [UIFont systemFontOfSize:18];
    label_20.backgroundColor = [UIColor clearColor];
    [articleView addSubview:label_20];
    [label_3_arr addObject:label_20];
    
    UILabel * label_21 = [[UILabel alloc]initWithFrame:CGRectMake(135+27, 196+70, 500, 98)];
    label_21.font = [UIFont systemFontOfSize:18];
    label_21.backgroundColor = [UIColor clearColor];
    [articleView addSubview:label_21];
    [label_3_arr addObject:label_21];
    
    UILabel * label_22 = [[UILabel alloc]initWithFrame:CGRectMake(645+27, 196+70, 100, 98)];
    label_22.font = [UIFont systemFontOfSize:18];
    label_22.textAlignment = UITextAlignmentCenter;
    label_22.backgroundColor = [UIColor clearColor];
    [articleView addSubview:label_22];
    [label_3_arr addObject:label_22];
    [label_arr addObject:label_3_arr];
    
    NSMutableArray * label_4_arr = [[NSMutableArray alloc]init];
    UILabel * label_30 = [[UILabel alloc]initWithFrame:CGRectMake(27, 294+70, 120, 155)];
    label_30.font = [UIFont systemFontOfSize:18];
    label_30.backgroundColor = [UIColor clearColor];
    [articleView addSubview:label_30];
    [label_4_arr addObject:label_30];
    
    UILabel * label_31 = [[UILabel alloc]initWithFrame:CGRectMake(135+27, 294+70, 500, 155)];
    label_31.font = [UIFont systemFontOfSize:18];
    label_31.backgroundColor = [UIColor clearColor];
    [articleView addSubview:label_31];
    [label_4_arr addObject:label_31];
    
    UILabel * label_32 = [[UILabel alloc]initWithFrame:CGRectMake(645+27, 294+70, 100, 155)];
    label_32.font = [UIFont systemFontOfSize:18];
    label_32.textAlignment = UITextAlignmentCenter;
    label_32.backgroundColor = [UIColor clearColor];
    [articleView addSubview:label_32];
    [label_4_arr addObject:label_32];
    [label_arr addObject:label_4_arr];
    
    NSMutableArray * label_5_arr = [[NSMutableArray alloc]init];
    UILabel * label_40 = [[UILabel alloc]initWithFrame:CGRectMake(27, 448+70, 120, 98)];
    label_40.font = [UIFont systemFontOfSize:18];
    label_40.backgroundColor = [UIColor clearColor];
    [articleView addSubview:label_40];
    [label_5_arr addObject:label_40];
    
    UILabel * label_41 = [[UILabel alloc]initWithFrame:CGRectMake(135+27, 448+70, 500, 98)];
    label_41.font = [UIFont systemFontOfSize:18];
    label_41.backgroundColor = [UIColor clearColor];
    [articleView addSubview:label_41];
    [label_5_arr addObject:label_41];
    
    UILabel * label_42 = [[UILabel alloc]initWithFrame:CGRectMake(645+27, 448+70, 100, 98)];
    label_42.font = [UIFont systemFontOfSize:18];
    label_42.textAlignment = UITextAlignmentCenter;
    label_42.backgroundColor = [UIColor clearColor];
    [articleView addSubview:label_42];
    [label_5_arr addObject:label_42];
    [label_arr addObject:label_5_arr];
    
    //总分
    UILabel * label_50 = [[UILabel alloc]initWithFrame:CGRectMake(27, 534+70, 696, 54)];
    label_50.font = [UIFont systemFontOfSize:18];
    label_50.backgroundColor = [UIColor clearColor];
    label_50.text = @"总分";
    [articleView addSubview:label_50];
    //[label_arr addObject:label_50];
    
    UILabel * label_51 = [[UILabel alloc]initWithFrame:CGRectMake(645+27, 534+70, 100, 54)];
    label_51.font = [UIFont systemFontOfSize:18];
    label_51.textAlignment = UITextAlignmentCenter;
    label_51.backgroundColor = [UIColor clearColor];
    [articleView addSubview:label_51];
    //[label_arr addObject:label_51];
    
    //得分、评分
    UILabel * label_score_title = [[UILabel alloc]initWithFrame:CGRectMake(753+27, 0+70, 215, 50)];
    label_score_title.font = [UIFont systemFontOfSize:18];
    label_score_title.textAlignment = UITextAlignmentCenter;
    label_score_title.backgroundColor = [UIColor clearColor];
    label_score_title.text = @"得分";
    [articleView addSubview:label_score_title];
    
    UILabel * label_score_self = [[UILabel alloc]initWithFrame:CGRectMake(753+27+54, 52+70, 108, 48)];
    label_score_self.font = [UIFont systemFontOfSize:18];
    label_score_self.textAlignment = UITextAlignmentCenter;
    label_score_self.backgroundColor = [UIColor clearColor];
    label_score_self.text = @"自评";
    [articleView addSubview:label_score_self];
    
    
    
    //if (_type != 1) {
    //加载数据
    NSArray * row_arr = [feedbackDict_Gousi valueForKey:@"checkitems"];
    if ([row_arr count] > 0) {
        for (int i = 0; i < [row_arr count]; i++) {
            NSArray * row_item_arr = [row_arr objectAtIndex:i];
            for (int k = 0; k < [row_item_arr count]; k++) {
                UILabel * labelItem = label_arr[i][k];
                labelItem.numberOfLines = 5;
                labelItem.text = row_item_arr[k];
            }
        }
    }
    
    
    //}
    
    int totalScore = 0;
    
    totalScore = [label_12.text intValue] + [label_22.text intValue] + [label_32.text intValue] + [label_42.text intValue];
    label_51.text = [NSString stringWithFormat:@"%d",totalScore];
    
    for (int i = 0 ; i < 2; i++) {
        UITextField * ET_00 = [[UITextField alloc]initWithFrame:CGRectMake(790+27+54, 96 * i + 130+40, 50, 94)];
        ET_00.backgroundColor = [UIColor clearColor];
        ET_00.font = [UIFont systemFontOfSize:18];
        ET_00.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        ET_00.delegate = self;
        [articleView addSubview:ET_00];
        [gousiFeedBack_AdvicesTextView addObject:ET_00];
    }
    
    UITextField * ET_03 = [[UITextField alloc]initWithFrame:CGRectMake(790+27+54, 350+10, 50, 96+70)];
    ET_03.backgroundColor = [UIColor clearColor];
    ET_03.font = [UIFont systemFontOfSize:18];
    ET_03.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    ET_03.delegate = self;
    [articleView addSubview:ET_03];
    [gousiFeedBack_AdvicesTextView addObject:ET_03];
    
    UITextField * ET_04 = [[UITextField alloc]initWithFrame:CGRectMake(790+27+54, 470+55, 50, 82)];
    ET_04.backgroundColor = [UIColor clearColor];
    ET_04.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    ET_04.delegate = self;
    ET_04.font = [UIFont systemFontOfSize:18];
    [articleView addSubview:ET_04];
    [gousiFeedBack_AdvicesTextView addObject:ET_04];
    
    selfTotal = [[UILabel alloc]initWithFrame:CGRectMake(790+27+54, 514+70, 50, 96)];
    selfTotal.backgroundColor = [UIColor clearColor];
    selfTotal.font = [UIFont systemFontOfSize:18];
    [articleView addSubview:selfTotal];
    
    
    
    //加载数据
    NSArray * advice_arr = [feedbackDict_Gousi valueForKey:@"answers"];
    
    //自评列
    if ([advice_arr count] > 0) {
        
        int selfTotalScore = 0;
        for (int i = 0; i < [advice_arr count]; i++) {
            
            UITextField * labelItem = gousiFeedBack_AdvicesTextView[i];
            labelItem.text = [advice_arr[i] valueForKey:@"advice"];
            selfTotalScore = selfTotalScore + [[advice_arr[i] valueForKey:@"advice"] intValue];
            
        }
        selfTotal.text = [NSString stringWithFormat:@"%d",selfTotalScore];
    }
    
    
    
    
    
    
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    UIImageView * IV_Bg = [[UIImageView alloc]initWithFrame:CGRectMake(27, 70, 970, 587)];
    IV_Bg.image = [UIImage imageNamed:@"bg_interComment_20140119.png"];
    [articleView addSubview:IV_Bg];
    
    //评分
    gousiFeedBack_AdvicesTextView = [[NSMutableArray alloc]init];
    
    
    
}

#pragma mark - UIExpandingTextViewDelegate

/*- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string   // return NO to not change text
{
    NSString *textString = textField.text ;
    NSUInteger length = [textString length];
    
    BOOL bChange =YES;
    if (length >= 3)
        bChange = NO;
    
    if (range.length == 1) {
        bChange = YES;
    }
    return bChange;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    //自评列
    
    int selfTotalScore = 0;
    for (UITextField * item in gousiFeedBack_AdvicesTextView) {
        
        selfTotalScore = selfTotalScore + [item.text intValue] ;
    }
    selfTotal.text = [NSString stringWithFormat:@"%d",selfTotalScore];
    
    
    
    //同学评列
    
    int otherTotalScore = 0;
    for (UITextField * item in gousiFeedBack_AppreciateTextView) {
        
        otherTotalScore = otherTotalScore + [item.text intValue];
    }
    otherTotal.text = [NSString stringWithFormat:@"%d",otherTotalScore];
    
    
    
}*/

-(IBAction)submitWorkClick:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定提交？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alert setTag:kTagWorkCommitButton];
    [alert show];
    [alert release];
}

-(void)submitWork {
    
    
    NSMutableArray* feedbackAdviceArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < [gousiFeedBack_AdvicesTextView count]; i++) {
        
        UIExpandingTextView * adviceView = gousiFeedBack_AdvicesTextView[i];
        NSDictionary* advice01Dict = [NSDictionary dictionaryWithObjectsAndKeys:adviceView.text,@"advice", nil];
        [feedbackAdviceArray addObject:advice01Dict];
    }
   
    
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:20];
    [requestDict setValue:@"M068" forKey:@"method"];
    [requestDict setValue:[self.unitDict valueForKey:@"courseId"] forKey:@"courseId"];
    [requestDict setValue:[self.unitDict valueForKey:@"authorId"] forKey:@"userId"];
    [requestDict setValue:[self.unitDict valueForKey:@"unitId"] forKey:@"unitId"];
    [requestDict setValue:[feedbackAdviceArray JSONString] forKey:@"answers"];
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
    
}

-(IBAction)backClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark ZMHttpEngineDelegate
-(void)httpEngine:(ZMHttpEngine *)httpEngine didSuccess:(NSDictionary *)responseDict{
    [super httpEngine:httpEngine didSuccess:responseDict];
    
    NSString* method = [responseDict valueForKey:@"method"];
    NSString* responseCode = [responseDict valueForKey:@"responseCode"];
    if ([@"M067" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        
        [self addLabel:[responseDict valueForKey:@"unitTitle"]
                 frame:CGRectMake(291, 22, 421, 30)
                  size:18
              intoView:articleView];
        _feedbackArray = [[NSMutableArray alloc] initWithCapacity:0];
        [_feedbackArray addObject:responseDict];
        [self addContentView];
    }else if([@"M068" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        [self showTip:@"成功提交"];
    }else{
        [super httpEngine:httpEngine didSuccess:responseDict];
    }
}


@end
