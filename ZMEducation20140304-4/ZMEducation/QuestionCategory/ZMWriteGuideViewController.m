//
//  ZMWriteGuideViewController.m
//  ZMEducation
//
//  Created by Hunter Li on 13-6-4.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import "ZMWriteGuideViewController.h"
#define kTagShareButton 3102 

@implementation ZMWriteGuideViewController
//@synthesize unitDict = _unitDict;

-(void)dealloc{
    [topicView release];
    [formView release];
    [targetView release];
    [readerView release];
    [wordView release];
    
    //[_unitDict release];
    
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
          intoView:articleView];
}

-(void)getArticleInfo{
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M038" forKey:@"method"];
    [requestDict setValue:[self.unitDict valueForKey:@"courseId"] forKey:@"courseId"];
    [requestDict setValue:[self.unitDict valueForKey:@"classId"] forKey:@"classId"];
    [requestDict setValue:[self.unitDict valueForKey:@"gradeId"] forKey:@"gradeId"];
    [requestDict setValue:[self.unitDict valueForKey:@"moduleId"] forKey:@"moduleId"];
    [requestDict setValue:[self.unitDict valueForKey:@"authorId"] forKey:@"userId"];
    [requestDict setValue:[self.unitDict valueForKey:@"unitId"] forKey:@"unitId"];
    [requestDict setValue:[self.unitDict valueForKey:@"recordId"] forKey:@"recordId"];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}

-(void)submitWork{
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M017" forKey:@"method"];
    [requestDict setValue:[self.unitDict valueForKey:@"courseId"] forKey:@"courseId"];
    [requestDict setValue:[self.unitDict valueForKey:@"classId"] forKey:@"classId"];
    [requestDict setValue:[self.unitDict valueForKey:@"gradeId"] forKey:@"gradeId"];
    [requestDict setValue:[self.unitDict valueForKey:@"moduleId"] forKey:@"moduleId"];
    [requestDict setValue:[self.unitDict valueForKey:@"authorId"] forKey:@"userId"];
    [requestDict setValue:[self.unitDict valueForKey:@"unitId"] forKey:@"unitId"];
    [requestDict setValue:[topicView text] forKey:@"topic"];
    [requestDict setValue:[formView text] forKey:@"form"];
    [requestDict setValue:[targetView text] forKey:@"target"];
    [requestDict setValue:[readerView text] forKey:@"reader"];
    [requestDict setValue:[wordView text] forKey:@"wordCount"];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}

-(IBAction)submitWorkClick:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定提交？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alert setTag:kTagWorkCommitButton];
    [alert show];
    [alert release];
}

-(void)addContentView{
    [super addContentView];

    UIImage* article_Title_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_13" ofType:@"png"]];
    UIImageView* article_Title_View = [[UIImageView alloc] initWithFrame:CGRectMake(55, 65, 909, 606)];
    [article_Title_View setImage:article_Title_Image];
    [articleView addSubview:article_Title_View];
    [article_Title_View release];
    
    [self addLabel:@"主 题"
             frame:CGRectMake(180, 170, 150, 30)];
    topicView = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(370, 140, 480, 82)];
    [topicView setFont:[UIFont boldSystemFontOfSize:22]];
    [articleView addSubview:topicView];
    
    [self addLabel:@"形 式"
             frame:CGRectMake(180, 262, 150, 30)];
    formView = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(370, 232, 480, 82)];
    [formView setFont:[UIFont boldSystemFontOfSize:22]];
    [articleView addSubview:formView];
    
    [self addLabel:@"目 的"
             frame:CGRectMake(180, 354, 150, 30)];
    targetView = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(370, 324, 480, 82)];
    [targetView setFont:[UIFont boldSystemFontOfSize:22]];
    [articleView addSubview:targetView];
    
    [self addLabel:@"读 者"
             frame:CGRectMake(180, 446, 150, 30)];
    readerView = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(370, 416, 480, 82)];
    [readerView setFont:[UIFont boldSystemFontOfSize:22]];
    [articleView addSubview:readerView];
    
    [self addLabel:@"字 数"
             frame:CGRectMake(180, 538, 150, 30)];
    wordView = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(370, 508, 480, 82)];
    [wordView setFont:[UIFont boldSystemFontOfSize:22]];
    [articleView addSubview:wordView];
    
    if (self.type == 2 || self.type == 3) {
        [topicView setEditable:NO];
        [formView setEditable:NO];
        [targetView setEditable:NO];
        [readerView setEditable:NO];
        [wordView setEditable:NO];
    }
}

-(void)loadView{
    [super loadView];
    
    [self addContentView];
}

#pragma mark ZMHttpEngineDelegate
-(void)httpEngine:(ZMHttpEngine *)httpEngine didSuccess:(NSDictionary *)responseDict{
    NSString* method = [responseDict valueForKey:@"method"];
    NSString* responseCode = [responseDict valueForKey:@"responseCode"];
    if ([@"M017" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        
        [self showTip:@"成功提交作业"];
        UIButton* shareBtn = (UIButton*)[self.view viewWithTag:kTagShareButton];
        if (shareBtn.selected) {
            NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
            [requestDict setValue:@"M026" forKey:@"method"];
            [requestDict setValue:[self.unitDict valueForKey:@"courseId"] forKey:@"courseId"];
            [requestDict setValue:[self.unitDict valueForKey:@"classId"] forKey:@"classId"];
            [requestDict setValue:[self.unitDict valueForKey:@"gradeId"] forKey:@"gradeId"];
            [requestDict setValue:[self.unitDict valueForKey:@"moduleId"] forKey:@"moduleId"];
            [requestDict setValue:[self.unitDict valueForKey:@"authorId"] forKey:@"userId"];
            [requestDict setValue:[self.unitDict valueForKey:@"unitId"] forKey:@"unitId"];
            
            ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
            [httpEngine setDelegate:self];
            [httpEngine requestWithDict:requestDict];
            [httpEngine release];
            [requestDict release];
        }
        
        [self hideIndicator];
    }else if([@"M038" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        [self addLabel:[responseDict valueForKey:@"unitTitle"]
                 frame:CGRectMake(291, 22, 421, 30)
                  size:18
              intoView:articleView];
        
        NSString* topic = [responseDict valueForKey:@"topic"];
        NSString* form = [responseDict valueForKey:@"form"];
        NSString* target = [responseDict valueForKey:@"target"];
        NSString* reader = [responseDict valueForKey:@"reader"];
        int wordCount = [[responseDict valueForKey:@"wordCount"] intValue];
        
        NSLog(@"topic:%@;form:%@;target:%@;reader:%@;wordCount:%d",topic,form,target,reader,wordCount);
        
        [topicView setText:topic];
        [formView setText:form];
        [targetView setText:target];
        [readerView setText:reader];
        [wordView setText:[NSString stringWithFormat:@"%d",wordCount]];
        
        [self hideIndicator];
    }else{
        [super httpEngine:httpEngine didSuccess:responseDict];
    }
}

@end
