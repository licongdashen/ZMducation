//
//  ZMStudyExperienceViewController.m
//  ZMEducation
//
//  Created by Hunter Li on 13-6-4.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import "ZMStudyExperienceViewController.h"

@implementation ZMStudyExperienceViewController
@synthesize courseDict = _courseDict;
@synthesize type = _type;

-(void)dealloc{
    [wordView release];
    
    [words_01View release];
    [words_02View release];
    [words_03View release];
    
    [experience_01View release];
    [experience_02View release];
    [experience_03View release];
    
    [_courseDict release];
    
    [super dealloc];
}

-(void)addLabel:(NSString *)text
          frame:(CGRect)frame{
    [self addLabel:text
             frame:frame
     textAlignment:NSTextAlignmentCenter
               tag:0
              size:18
         textColor:[UIColor darkTextColor]
          intoView:self.view];
}

-(void)getStudyExperience{    
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M035" forKey:@"method"];
    [requestDict setValue:[_courseDict valueForKey:@"courseId"] forKey:@"courseId"];
    [requestDict setValue:[_courseDict valueForKey:@"classId"] forKey:@"classId"];
    [requestDict setValue:[_courseDict valueForKey:@"gradeId"] forKey:@"gradeId"];
    [requestDict setValue:[_courseDict valueForKey:@"authorId"] forKey:@"userId"];
    [requestDict setValue:[_courseDict valueForKey:@"recordId"] forKey:@"recordId"];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}

-(void)loadView{
    [super loadView];
    
    UIImage* article_Title_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_14" ofType:@"png"]];
    UIImageView* article_Title_View = [[UIImageView alloc] initWithFrame:CGRectMake(55, 65, 909, 606)];
    [article_Title_View setImage:article_Title_Image];
    [self.view addSubview:article_Title_View];
    [article_Title_View release];
    
    [self addLabel:@"我学习的好词"
             frame:CGRectMake(180, 135, 150, 30)];
    wordView = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(370, 120, 480, 58)];
    [wordView setFont:[UIFont systemFontOfSize:16]];
    if (_type == 1) {
        [wordView setEditable:NO];
    }
    [self.view addSubview:wordView];
    
    
    [self addLabel:@"我学习的好句"
             frame:CGRectMake(180, 282, 150, 30)];
    words_01View = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(370, 192, 480, 58)];
    [words_01View setFont:[UIFont systemFontOfSize:16]];
    if (_type == 1) {
        [words_01View setEditable:NO];
    }
    [self.view addSubview:words_01View];
    
    words_02View = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(370, 264, 480, 58)];
    [words_02View setFont:[UIFont systemFontOfSize:16]];
    if (_type == 1) {
        [words_02View setEditable:NO];
    }
    [self.view addSubview:words_02View];
    
    words_03View = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(370, 336, 480, 58)];
    [words_03View setFont:[UIFont systemFontOfSize:16]];
    if (_type == 1) {
        [words_03View setEditable:NO];
    }
    [self.view addSubview:words_03View];
    
    [self addLabel:@"我学习的体会"
             frame:CGRectMake(180, 490, 150, 30)];
    experience_01View = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(370, 408, 480, 58)];
    [experience_01View setFont:[UIFont systemFontOfSize:16]];
    if (_type == 1) {
        [experience_01View setEditable:NO];
    }
    [self.view addSubview:experience_01View];
    
    experience_02View = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(370, 480, 480, 58)];
    [experience_02View setFont:[UIFont systemFontOfSize:16]];
    if (_type == 1) {
        [experience_02View setEditable:NO];
    }
    [self.view addSubview:experience_02View];
    
    experience_03View = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(370, 552, 480, 58)];
    [experience_03View setFont:[UIFont systemFontOfSize:16]];
    if (_type == 1) {
        [experience_03View setEditable:NO];
    }
    [self.view addSubview:experience_03View];
    
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSString* role = [userDict valueForKey:@"role"];
    if(([@"03" isEqualToString:role] || [@"04" isEqualToString:role])
       && _type == 2) {
        UIButton* submitBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [submitBut setFrame:CGRectMake(894, 670, 105, 89)];
        [submitBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Submit_Btn" ofType:@"png"]] forState:UIControlStateNormal];
        [submitBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Submit_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
        [submitBut addTarget:self
                      action:@selector(submitClick:)
            forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:submitBut];
    }
}

-(void)viewDidLoad{
    [super viewDidLoad];

    [self getStudyExperience];
}
-(void)setBackgroundView{
    [self.view setBackgroundColor:[UIColor colorWithRed:217.0/255.0 green:217.0/255.0 blue:217.0/255.0 alpha:1.0]];
}

-(IBAction)submitClick:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定提交？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alert setTag:kTagStudyExperienceCommitButton];
    [alert show];
    [alert release];
}

-(void)submit{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    
    NSLog(@"userDict:%@",userDict);
    
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M018" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:[wordView text] forKey:@"word"];
    [requestDict setValue:[_courseDict valueForKey:@"recordId"] forKey:@"recordId"];
    
    [requestDict setValue:[[NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"00",@"wordsId",[words_01View text],@"words", nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"01",@"wordsId",[words_02View text],@"words", nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"02",@"wordsId",[words_03View text],@"words", nil], nil] JSONString] forKey:@"wordsList"];
    [requestDict setValue:[[NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"00",@"experienceId",[experience_01View text],@"experience", nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"01",@"experienceId",[experience_02View text],@"experience", nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"02",@"experienceId",[experience_03View text],@"experience", nil], nil] JSONString] forKey:@"experienceList"];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        
    }else if(buttonIndex == 1){
        int tag = alertView.tag;
        if(tag == kTagStudyExperienceCommitButton){
            [self submit];
        }
    }
}

#pragma mark ZMHttpEngineDelegate
-(void)httpEngine:(ZMHttpEngine *)httpEngine didSuccess:(NSDictionary *)responseDict{
    [super httpEngine:httpEngine didSuccess:responseDict];
    
    NSString* method = [responseDict valueForKey:@"method"];
    NSString* responseCode = [responseDict valueForKey:@"responseCode"];
    if ([@"M018" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        
    }else if([@"M035" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        NSString* word = [responseDict valueForKey:@"word"];
        NSLog(@"word:%@",word);
        [wordView setText:word];
        
        NSArray* wordsArray = [responseDict valueForKey:@"wordsList"];
        for (int i=0; i<[wordsArray count]; i++) {
            NSDictionary* wordsDict = [wordsArray objectAtIndex:i];
            NSLog(@"wordsDict:%@",wordsDict);
            
            NSString* words = [wordsDict valueForKey:@"words"];
            if (i==0) {
                [words_01View setText:words];
            }else if(i==1){
                [words_02View setText:words];
            }else if(i==2){
                [words_03View setText:words];
            }
        }
        
        NSArray* experienceArray = [responseDict valueForKey:@"experienceList"];
        for (int i=0; i<[experienceArray count]; i++) {
            NSDictionary* experienceDict = [experienceArray objectAtIndex:i];
            NSLog(@"experienceDict:%@",experienceDict);
            
            NSString* experience = [experienceDict valueForKey:@"experience"];
            if (i==0) {
                [experience_01View setText:experience];
            }else if(i==1){
                [experience_02View setText:experience];
            }else if(i==2){
                [experience_03View setText:experience];
            }
        }
    }else if(![@"00" isEqualToString:responseCode]){
        [self showTip:@"服务器异常"];
    }
}

@end
