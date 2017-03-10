//
//  ZMArticleBaseViewController.m
//  ZMEducation
//
//  Created by Hunter Li on 13-5-25.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import "ZMArticleBaseViewController.h"

#define kTagFeedbackTableView 2100
#define kTagFeedbackTitleView 2200
#define kTagFeedbackAppreciate01View 2300
#define kTagFeedbackAppreciate02View 2301
#define kTagFeedbackAppreciate03View 2302
#define kTagFeedbackAdvice01View 2401
#define kTagFeedbackAdvice02View 2402
#define kTagFeedbackAdvice03View 2403

#define kTagCollectAddButton 5202

@implementation ZMArticleBaseViewController
@synthesize type = _type;
@synthesize unitDict = _unitDict;

-(void)submitWork{}



-(IBAction)backClick:(id)sender{
    [self screenLocked];
    
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSString* screenControl = [userDict valueForKey:@"screenControl"];
    NSString* role = [userDict valueForKey:@"role"];
    if ([@"02" isEqualToString:role] ||
        (([@"03" isEqualToString:role] || [@"04" isEqualToString:role])&& [@"01" isEqualToString:screenControl])) {
        if ([@"00" isEqualToString:screenControl]) {
            NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
            [requestDict setValue:@"M013" forKey:@"method"];
            [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
            [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
            [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
            [requestDict setValue:[userDict valueForKey:@"currentModuleId"] forKey:@"moduleId"];
            [requestDict setValue:[_unitDict valueForKey:@"unitId"] forKey:@"unitId"];
            [requestDict setValue:@"02" forKey:@"control"];
            
            ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
            [httpEngine setDelegate:self];
            [httpEngine requestWithDict:requestDict];
            [httpEngine release];
            [requestDict release];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

-(void)dealloc{
    [_unitDict release];
    
    [articleView release];
    
    UITableView* feedbackView = (UITableView*)[self.view viewWithTag:kTagFeedbackTableView];
    [feedbackView setDataSource:nil];
    [feedbackView setDelegate:nil];
    [_feedbackArray release];
    
    [theScrollView release];

    [super dealloc];
}

-(IBAction)submitFeedbackClick:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定提交？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alert setTag:kTagFeedbackCommitButton];
    [alert show];
    [alert release];
}

-(void)submitFeedback{
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M022" forKey:@"method"];
    [requestDict setValue:[_unitDict valueForKey:@"courseId"] forKey:@"courseId"];
    [requestDict setValue:[_unitDict valueForKey:@"classId"] forKey:@"classId"];
    [requestDict setValue:[_unitDict valueForKey:@"gradeId"] forKey:@"gradeId"];
    [requestDict setValue:[_unitDict valueForKey:@"moduleId"] forKey:@"moduleId"];
    [requestDict setValue:[_unitDict valueForKey:@"authorId"] forKey:@"authorId"];
    [requestDict setValue:[_unitDict valueForKey:@"unitId"] forKey:@"unitId"];
    [requestDict setValue:[_unitDict valueForKey:@"partnerId"] forKey:@"partnerId"];
    
    UITableView* feedbackTableView = (UITableView*)[self.view viewWithTag:kTagFeedbackTableView];
    UITableViewCell* tableViewCell = [feedbackTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (reviewType == 1) {
        //自评
        NSMutableArray* feedbackAdviceArray = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 0; i < [gousiFeedBack_AdvicesTextView count]; i++) {
            
            UIExpandingTextView * adviceView = gousiFeedBack_AdvicesTextView[i];
            NSDictionary* advice01Dict = [NSDictionary dictionaryWithObjectsAndKeys:adviceView.text,@"advice", nil];
            [feedbackAdviceArray addObject:advice01Dict];        
        }
        
        [requestDict setValue:[feedbackAdviceArray JSONString] forKey:@"advices"];
        [feedbackAdviceArray release];
        
        [requestDict setValue:@"" forKey:@"title"];
        [requestDict setValue:@"" forKey:@"appreciates"];
        
    }else if (reviewType == 2)
    {
        //互评
        
        NSMutableArray* feedbackAdviceArray = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 0; i < [gousiFeedBack_AdvicesTextView count]; i++) {
            
            UIExpandingTextView * adviceView = gousiFeedBack_AdvicesTextView[i];
            NSDictionary* advice01Dict = [NSDictionary dictionaryWithObjectsAndKeys:adviceView.text,@"advice", nil];
            [feedbackAdviceArray addObject:advice01Dict];
        }
        
        NSMutableArray* feedbackAppreciateArray = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 0; i < [gousiFeedBack_AppreciateTextView count]; i++) {
            
            UIExpandingTextView * appreciateView = gousiFeedBack_AppreciateTextView[i];
            NSDictionary* appreciateDict = [NSDictionary dictionaryWithObjectsAndKeys:appreciateView.text,@"appreciate", nil];
            [feedbackAppreciateArray addObject:appreciateDict];
        }
        
        [requestDict setValue:[feedbackAdviceArray JSONString] forKey:@"advices"];
        [requestDict setValue:[feedbackAdviceArray JSONString] forKey:@"selfassessments"];
       
        [feedbackAdviceArray release];
        
        [requestDict setValue:@"" forKey:@"title"];
        [requestDict setValue:[feedbackAppreciateArray JSONString] forKey:@"appreciates"];
    }else {
    
        UITextField* titleView = (UITextField*)[tableViewCell.contentView viewWithTag:kTagFeedbackTitleView];
        [requestDict setValue:[titleView text] forKey:@"title"];
        
        NSMutableArray* feedbackAppreciateArray = [[NSMutableArray alloc] initWithCapacity:0];
        UITextField* appreciate01View = (UITextField*)[tableViewCell.contentView viewWithTag:kTagFeedbackAppreciate01View];
        NSDictionary* appreciate01Dict = [NSDictionary dictionaryWithObjectsAndKeys:[appreciate01View text],@"appreciate", nil];
        [feedbackAppreciateArray addObject:appreciate01Dict];
        
        UITextField* appreciate02View = (UITextField*)[tableViewCell.contentView viewWithTag:kTagFeedbackAppreciate02View];
        NSDictionary* appreciate02Dict = [NSDictionary dictionaryWithObjectsAndKeys:[appreciate02View text],@"appreciate", nil];
        [feedbackAppreciateArray addObject:appreciate02Dict];
        
        UITextField* appreciate03View = (UITextField*)[tableViewCell.contentView viewWithTag:kTagFeedbackAppreciate03View];
        NSDictionary* appreciate03Dict = [NSDictionary dictionaryWithObjectsAndKeys:[appreciate03View text],@"appreciate", nil];
        [feedbackAppreciateArray addObject:appreciate03Dict];
        
        [requestDict setValue:[feedbackAppreciateArray JSONString] forKey:@"appreciates"];
        [feedbackAppreciateArray release];
        
        
        NSMutableArray* feedbackAdviceArray = [[NSMutableArray alloc] initWithCapacity:0];
        UITextField* advice01View = (UITextField*)[tableViewCell.contentView viewWithTag:kTagFeedbackAdvice01View];
        NSDictionary* advice01Dict = [NSDictionary dictionaryWithObjectsAndKeys:[advice01View text],@"advice", nil];
        [feedbackAdviceArray addObject:advice01Dict];
        
        UITextField* advice02View = (UITextField*)[tableViewCell.contentView viewWithTag:kTagFeedbackAdvice02View];
        NSDictionary* advice02Dict = [NSDictionary dictionaryWithObjectsAndKeys:[advice02View text],@"advice", nil];
        [feedbackAdviceArray addObject:advice02Dict];
        
        UITextField* advice03View = (UITextField*)[tableViewCell.contentView viewWithTag:kTagFeedbackAdvice03View];
        NSDictionary* advice03Dict = [NSDictionary dictionaryWithObjectsAndKeys:[advice03View text],@"advice", nil];
        [feedbackAdviceArray addObject:advice03Dict];
        
        [requestDict setValue:[feedbackAdviceArray JSONString] forKey:@"advices"];
        [feedbackAdviceArray release];
    }
    
    
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}

-(IBAction)shareClick:(id)sender{
    UIButton* shareBtn = (UIButton*)sender;
    
    [shareBtn setSelected:!shareBtn.selected];
}

-(void)addToCollect{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M025" forKey:@"method"];
    [requestDict setValue:[_unitDict valueForKey:@"courseId"] forKey:@"courseId"];
    [requestDict setValue:[_unitDict valueForKey:@"classId"] forKey:@"classId"];
    [requestDict setValue:[_unitDict valueForKey:@"gradeId"] forKey:@"gradeId"];
    [requestDict setValue:[_unitDict valueForKey:@"moduleId"] forKey:@"moduleId"];
    [requestDict setValue:[_unitDict valueForKey:@"unitId"] forKey:@"unitId"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}

-(IBAction)collectButClick:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定加入错题集吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alert setTag:kTagCollectAddButton];
    [alert show];
    [alert release];
}

-(void)setBackgroundView{
    [self.view setBackgroundColor:[UIColor colorWithRed:217.0/255.0 green:217.0/255.0 blue:217.0/255.0 alpha:1.0]];
}

-(void)addDraftView{
    UIImage* article_Title_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Title_bg" ofType:@"png"]];
    UIImageView* article_Title_View = [[UIImageView alloc] initWithFrame:CGRectMake(35, 55, 263, 76)];
    [article_Title_View setImage:article_Title_Image];
    [articleView addSubview:article_Title_View];
    [article_Title_View release];
    
    UIExpandingTextView* titleView = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(40, 61, 253, 64)];
    [titleView setTag:kTagArticleTitleView];
    if (_type == 2 || _type == 3) {
        [titleView setEditable:NO];
    }
    [titleView setText:[articleDict valueForKey:@"title"]];
    [titleView setFont:[UIFont boldSystemFontOfSize:16]];
    [articleView addSubview:titleView];
    [titleView release];
    
    UIImage* article_Content_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Content_bg" ofType:@"png"]];
    UIImageView* article_Content_View = [[UIImageView alloc] initWithFrame:CGRectMake(35, 145, 263, 589)];
    [article_Content_View setImage:article_Content_Image];
    [articleView addSubview:article_Content_View];
    [article_Content_View release];
    
    UIExpandingTextView* draftView = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(40, 150, 253, 577)];
    [draftView setFont:[UIFont systemFontOfSize:16]];
    [draftView setTag:kTagArticleDraftView];
    if (_type == 2 || _type == 3) {
        [draftView setEditable:NO];
    }
    [draftView setText:[articleDict valueForKey:@"articleDraft"]];
    [articleView addSubview:draftView];
    [draftView release];
}

-(void)fabu
{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M135" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:gousiDict[@"title"] forKey:@"collectTitile"];
    [requestDict setValue:gousiDict[@"articleDraft"] forKey:@"collectContent"];
    [requestDict setValue:@"4" forKey:@"sourceId"];
    [requestDict setValue:[_unitDict valueForKey:@"authorId"] forKey:@"authorId"];
    [requestDict setValue:[_unitDict valueForKey:@"unitId"] forKey:@"recordId"];

    [self showIndicator];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];

}

-(void)addContentView{
    
    if ([((ZMAppDelegate*)[UIApplication sharedApplication].delegate).str isEqualToString:@"2"]) {
    UIButton * fabuBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 15, 50, 40)];
    [fabuBtn setTitle:@"发布" forState:UIControlStateNormal];
    [fabuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    fabuBtn.layer.borderColor = [UIColor blackColor].CGColor;
    [fabuBtn addTarget:self action:@selector(fabu) forControlEvents:UIControlEventTouchUpInside];
    fabuBtn.layer.borderWidth = 1;
    [articleView addSubview:fabuBtn];
       
    }
}

-(void)addCommentView{

    UIImage* article_Comment_01_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Comment_bg_01" ofType:@"png"]];
    UIImageView* article_Comment_01_View = [[UIImageView alloc] initWithFrame:CGRectMake(725, 80, 274, 164)];
    [article_Comment_01_View setImage:article_Comment_01_Image];
    [articleView addSubview:article_Comment_01_View];
    [article_Comment_01_View release];
    
    UIImage* article_Comment_02_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Comment_bg_02" ofType:@"png"]];
    UIImageView* article_Comment_02_View = [[UIImageView alloc] initWithFrame:CGRectMake(725, 285, 275, 166)];
    [article_Comment_02_View setImage:article_Comment_02_Image];
    [articleView addSubview:article_Comment_02_View];
    [article_Comment_02_View release];
    
    UIImage* article_Comment_03_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Comment_bg_03" ofType:@"png"]];
    UIImageView* article_Comment_03_View = [[UIImageView alloc] initWithFrame:CGRectMake(725, 490, 273, 170)];
    [article_Comment_03_View setImage:article_Comment_03_Image];
    [articleView addSubview:article_Comment_03_View];
    [article_Comment_03_View release];

    NSArray* _articleCommentArray = [articleDict valueForKey:@"articleComment"];    
    UIExpandingTextView* comment_01View = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(786, 90, 198, 138)];
    [comment_01View setFont:[UIFont systemFontOfSize:16]];
    [comment_01View setTag:kTagArticleComment01View];
    if (_type == 2 || _type == 3) {
        [comment_01View setEditable:NO];
    }
    if ([_articleCommentArray count]>0) {
        NSDictionary* comment01Dict = [_articleCommentArray objectAtIndex:0];
        [comment_01View setText:[comment01Dict valueForKey:@"articleComment"]];
    }
    [articleView addSubview:comment_01View];
    [comment_01View release];
    
    UIExpandingTextView* comment_02View = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(786, 295, 198, 138)];
    [comment_02View setFont:[UIFont systemFontOfSize:16]];
    [comment_02View setTag:kTagArticleComment02View];
    if (_type == 2 || _type == 3) {
        [comment_02View setEditable:NO];
    }
    if ([_articleCommentArray count]>1) {
        NSDictionary* comment02Dict = [_articleCommentArray objectAtIndex:1];
        [comment_02View setText:[comment02Dict valueForKey:@"articleComment"]];
    }
    [articleView addSubview:comment_02View];
    [comment_02View release];
    
    UIExpandingTextView* comment_03View = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(786, 500, 198, 138)];
    [comment_03View setFont:[UIFont systemFontOfSize:16]];
    [comment_03View setTag:kTagArticleComment03View];
    if (_type == 2 || _type == 3) {
        [comment_03View setEditable:NO];
    }
    if ([_articleCommentArray count]>2) {
        NSDictionary* comment03Dict = [_articleCommentArray objectAtIndex:2];
        [comment_03View setText:[comment03Dict valueForKey:@"articleComment"]];
    }
    [articleView addSubview:comment_03View];
    [comment_03View release];
    


}

-(void)getArticleInfo{
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M030" forKey:@"method"];
    [requestDict setValue:[_unitDict valueForKey:@"courseId"] forKey:@"courseId"];
    [requestDict setValue:[_unitDict valueForKey:@"classId"] forKey:@"classId"];
    [requestDict setValue:[_unitDict valueForKey:@"gradeId"] forKey:@"gradeId"];
    [requestDict setValue:[_unitDict valueForKey:@"moduleId"] forKey:@"moduleId"];
    [requestDict setValue:[_unitDict valueForKey:@"authorId"] forKey:@"authorId"];
    [requestDict setValue:[_unitDict valueForKey:@"unitId"] forKey:@"unitId"];
    [requestDict setValue:[_unitDict valueForKey:@"recordId"] forKey:@"recordId"];

    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}

-(void)loadView{
    [super loadView];
    editMode = -1;
   
    self.issuccess = NO;
    theScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)]; // All
	theScrollView.showsHorizontalScrollIndicator = YES;
	theScrollView.backgroundColor = [UIColor clearColor];
    theScrollView.scrollEnabled = YES;
	[self.view addSubview:theScrollView];
    
    articleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    [articleView setBackgroundColor:[UIColor clearColor]];
    [theScrollView addSubview:articleView];
    
    UIImage* article_Category_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Category_bg" ofType:@"png"]];
    UIImageView* article_Category_View = [[UIImageView alloc] initWithFrame:CGRectMake(291, 15, 421, 43)];
    [article_Category_View setImage:article_Category_Image];
    [articleView addSubview:article_Category_View];
    [article_Category_View release];
    
    if (_type == 1) {
        NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
        NSString* role = [userDict valueForKey:@"role"];
        if([@"03" isEqualToString:role] || [@"04" isEqualToString:role]){
            
            
            UIButton* shareBut = [UIButton buttonWithType:UIButtonTypeCustom];
            [shareBut setTag:kTagShareButton];
            [shareBut setFrame:CGRectMake(801, 707, 25, 25)];
            [shareBut setSelected:NO];
            [shareBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Btn" ofType:@"png"]] forState:UIControlStateNormal];
            [shareBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
            [shareBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Select_Btn" ofType:@"png"]] forState:UIControlStateSelected];
            [shareBut addTarget:self
                         action:@selector(shareClick:)
               forControlEvents:UIControlEventTouchUpInside];
            [articleView addSubview:shareBut];
            
            UILabel* shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(830, 710, 80, 20)];
            [shareLabel setText:@"是否共享"];
            [shareLabel setBackgroundColor:[UIColor clearColor]];
            [shareLabel setTextColor:[UIColor colorWithRed:0 green:110.0/255.0 blue:167.0/255.0 alpha:1.0]];
            [articleView addSubview:shareLabel];
            
            
            //20140121 00或18不要复选框
            NSString * articleType = [NSString stringWithFormat:@"%@",[_unitDict objectForKey:@"articleType"]];
            if ([articleType isEqualToString:@"00"] || [articleType isEqualToString:@"18"]) {
                [shareBut removeFromSuperview];
                [shareLabel removeFromSuperview];
            }
            
            [shareLabel release];
        }
        
        UIButton* submitBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [submitBut setFrame:CGRectMake(894, 670, 105, 89)];
        [submitBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Submit_Btn" ofType:@"png"]] forState:UIControlStateNormal];
        [submitBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Submit_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
        [submitBut addTarget:self
                      action:@selector(submitWorkClick:)
            forControlEvents:UIControlEventTouchUpInside];
        [articleView addSubview:submitBut];
        
        
    }
    
    if (_type == 2 || _type == 3) { //点评、浏览
        _feedbackArray = [[NSMutableArray alloc] initWithCapacity:0];
        
        UITableView* feedbackView = [[UITableView alloc] initWithFrame:CGRectMake(27, 768, 970, 0) style:UITableViewStylePlain];
        [feedbackView setTag:kTagFeedbackTableView];
        [feedbackView setDelegate:self];
        [feedbackView setDataSource:self];
        [feedbackView setScrollEnabled:NO];
        [feedbackView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [feedbackView setBackgroundColor:[UIColor clearColor]];
        [theScrollView addSubview:feedbackView];
        [feedbackView release];
    }
}

- (void)viewDidLoad{
    
    [self getArticleInfo];

    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSString * articleMode = [userDict valueForKey:@"articleMode"];
    if ([@"1" isEqualToString:articleMode]) {
        [super viewDidLoad];
    }
    NSString* role = [userDict valueForKey:@"role"];
    if(([@"03" isEqualToString:role] || [@"04" isEqualToString:role])
       && (_type == 1)){
        UIButton* collectBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [collectBut setFrame:CGRectMake(35, 2, 51, 46)];
        [collectBut setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Collect_Button" ofType:@"png"]] forState:UIControlStateNormal];
        [collectBut setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Collect_Button" ofType:@"png"]] forState:UIControlStateHighlighted];
        [collectBut addTarget:self
                       action:@selector(collectButClick:)
             forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:collectBut];
    }
    if (_type == 2) {
        NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
        [requestDict setValue:@"M029" forKey:@"method"];
        [requestDict setValue:[_unitDict valueForKey:@"courseId"] forKey:@"courseId"];
        [requestDict setValue:[_unitDict valueForKey:@"classId"] forKey:@"classId"];
        [requestDict setValue:[_unitDict valueForKey:@"gradeId"] forKey:@"gradeId"];
        [requestDict setValue:[_unitDict valueForKey:@"moduleId"] forKey:@"moduleId"];
        [requestDict setValue:[_unitDict valueForKey:@"authorId"] forKey:@"authorId"];
        [requestDict setValue:[_unitDict valueForKey:@"unitId"] forKey:@"unitId"];
        [requestDict setValue:[_unitDict valueForKey:@"partnerId"] forKey:@"partnerId"];
        
        ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
        [httpEngine setDelegate:self];
        [httpEngine requestWithDict:requestDict];
        [httpEngine release];
        [requestDict release];
    }else if(_type == 3){
        NSMutableDictionary* myRequestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
        [myRequestDict setValue:@"M036" forKey:@"method"];
        [myRequestDict setValue:[_unitDict valueForKey:@"courseId"] forKey:@"courseId"];
        [myRequestDict setValue:[_unitDict valueForKey:@"classId"] forKey:@"classId"];
        [myRequestDict setValue:[_unitDict valueForKey:@"gradeId"] forKey:@"gradeId"];
        [myRequestDict setValue:[_unitDict valueForKey:@"moduleId"] forKey:@"moduleId"];
        [myRequestDict setValue:[_unitDict valueForKey:@"authorId"] forKey:@"authorId"];
        [myRequestDict setValue:[_unitDict valueForKey:@"unitId"] forKey:@"unitId"];
        
        ((ZMAppDelegate*)[UIApplication sharedApplication].delegate).authorId = [_unitDict valueForKey:@"authorId"];
        ((ZMAppDelegate*)[UIApplication sharedApplication].delegate).unitId = [_unitDict valueForKey:@"unitId"];

        ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
        [httpEngine setDelegate:self];
        [httpEngine requestWithDict:myRequestDict];
        [httpEngine release];
        [myRequestDict release];
    }
    
    
}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int tag = tableView.tag;
    if(tag == kTagFeedbackTableView){
        //if (_type == 1) {
         //   return 1;
        //}else{
            return [_feedbackArray count];
        //}
        
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"AISRegularEntityCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //
    if (cell == nil){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }else{
        for (UIView *subView in [cell.contentView subviews]){
			[subView removeFromSuperview];
		}
    }
    
    int tag = tableView.tag;
    if(tag == kTagFeedbackTableView){
        
        NSDictionary* feedbackDict = [_feedbackArray objectAtIndex:indexPath.row];
        feedbackDict_Gousi = [[NSDictionary alloc]init];
        feedbackDict_Gousi = [_feedbackArray objectAtIndex:indexPath.row];
        
        
        // 所有点评都添加作者和点评者  20140121
        [self addLabel:[NSString stringWithFormat:@"作者：%@",[feedbackDict valueForKey:@"author"]]
                 frame:CGRectMake(30, 10, 180, 30)
                  size:16
              intoView:cell.contentView];
        [self addLabel:[NSString stringWithFormat:@"点评者：%@",[feedbackDict valueForKey:@"partner"]]
                 frame:CGRectMake(730, 10, 180, 30)
                  size:16
              intoView:cell.contentView];
        
        
        
        if (reviewType == 1 )//自评
        {

            //评分规则
            UIImage * bg_selfComment = [UIImage imageNamed:@"bg_selfComment.png"];
            UIImageView * bg_selfCommentView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 37, 970, 587)];
            bg_selfCommentView.image = bg_selfComment;
            [cell.contentView addSubview:bg_selfCommentView];
            
            
            NSMutableArray * label_arr = [[NSMutableArray alloc]init];
            
            NSMutableArray * label_0_arr = [[NSMutableArray alloc]init];
            //row 0
            UILabel * row_00 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0+37, 250, 87)];
            row_00.font = [UIFont systemFontOfSize:18];
            row_00.textAlignment = UITextAlignmentCenter;
            row_00.backgroundColor = [UIColor clearColor];
            
            [cell.contentView addSubview:row_00];
            [label_0_arr addObject:row_00];
            
            UILabel * row_01 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0+37, 0, 0)];
            [label_0_arr addObject:row_01];
            
            UILabel * row_02 = [[UILabel alloc]initWithFrame:CGRectMake(250, 0+37, 206, 87)];
            row_02.font = [UIFont systemFontOfSize:18];
            row_02.textAlignment = UITextAlignmentCenter;
            row_02.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:row_02];
            [label_0_arr addObject:row_02];
            
            UILabel * row_03 = [[UILabel alloc]initWithFrame:CGRectMake(250+215, 0+37, 206, 87)];
            row_03.font = [UIFont systemFontOfSize:18];
            row_03.textAlignment = UITextAlignmentCenter;
            row_03.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:row_03];
            [label_0_arr addObject:row_03];
            
            UILabel * row_04 = [[UILabel alloc]initWithFrame:CGRectMake(250+215+210, 0+37, 206, 87)];
            row_04.font = [UIFont systemFontOfSize:18];
            row_04.textAlignment = UITextAlignmentCenter;
            row_04.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:row_04];
            [label_0_arr addObject:row_04];
            [label_arr addObject:label_0_arr];
            
            
            
            NSMutableArray * label_1_arr = [[NSMutableArray alloc]init];
            //row 1
            UILabel * row_10 = [[UILabel alloc]initWithFrame:CGRectMake(0, 87+37, 150, 84)];
            row_10.font = [UIFont systemFontOfSize:18];
            row_10.textAlignment = UITextAlignmentCenter;
            row_10.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:row_10];
            [label_1_arr addObject:row_10];
            
            UILabel * row_11 = [[UILabel alloc]initWithFrame:CGRectMake(153, 87+37, 96, 84)];
            row_11.font = [UIFont systemFontOfSize:16];
            row_11.textAlignment = UITextAlignmentCenter;
            row_11.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:row_11];
            [label_1_arr addObject:row_11];
            
            UILabel * row_12 = [[UILabel alloc]initWithFrame:CGRectMake(260, 87+37, 195, 84)];
            row_12.font = [UIFont systemFontOfSize:16];
            row_12.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:row_12];
            [label_1_arr addObject:row_12];
            
            UILabel * row_13 = [[UILabel alloc]initWithFrame:CGRectMake(153+100+212, 87+37, 205, 84)];
            row_13.font = [UIFont systemFontOfSize:16];
            row_13.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:row_13];
            [label_1_arr addObject:row_13];
            
            UILabel * row_14 = [[UILabel alloc]initWithFrame:CGRectMake(153+96+212+218, 87+37, 193, 84)];
            row_14.font = [UIFont systemFontOfSize:16];
            row_14.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:row_14];
            [label_1_arr addObject:row_14];
            [label_arr addObject:label_1_arr];
            
            NSMutableArray * label_2_arr = [[NSMutableArray alloc]init];
            //row 2
            UILabel * row_20 = [[UILabel alloc]initWithFrame:CGRectMake(0, 170+37, 150, 167)];
            row_20.font = [UIFont systemFontOfSize:18];
            row_20.textAlignment = UITextAlignmentCenter;
            
            row_20.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:row_20];
            [label_2_arr addObject:row_20];
            
            UILabel * row_21 = [[UILabel alloc]initWithFrame:CGRectMake(153, 170+37, 96, 84)];
            row_21.font = [UIFont systemFontOfSize:16];
            row_21.textAlignment = UITextAlignmentCenter;
            row_21.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:row_21];
            [label_2_arr addObject:row_21];
            
            UILabel * row_22 = [[UILabel alloc]initWithFrame:CGRectMake(260, 170+37, 195, 84)];
            row_22.font = [UIFont systemFontOfSize:16];
            row_22.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:row_22];
            [label_2_arr addObject:row_22];
            
            UILabel * row_23 = [[UILabel alloc]initWithFrame:CGRectMake(153+100+212, 170+37, 205, 84)];
            row_23.font = [UIFont systemFontOfSize:16];
            row_23.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:row_23];
            [label_2_arr addObject:row_23];
            
            UILabel * row_24 = [[UILabel alloc]initWithFrame:CGRectMake(153+96+212+218, 170+37, 193, 84)];
            row_24.font = [UIFont systemFontOfSize:16];
            row_24.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:row_24];
            [label_2_arr addObject:row_24];
            [label_arr addObject:label_2_arr];
            
            
            NSMutableArray * label_3_arr = [[NSMutableArray alloc]init];
            //row 3
            UILabel * row_30 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0+37, 0)];
            [label_3_arr addObject:row_30];
            
            UILabel * row_31 = [[UILabel alloc]initWithFrame:CGRectMake(153, 253+37, 96, 84)];
            row_31.font = [UIFont systemFontOfSize:18];
            row_31.textAlignment = UITextAlignmentCenter;
            row_31.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:row_31];
            [label_3_arr addObject:row_31];
            
            UILabel * row_32 = [[UILabel alloc]initWithFrame:CGRectMake(260, 253+37, 195, 84)];
            row_32.font = [UIFont systemFontOfSize:16];
            row_32.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:row_32];
            [label_3_arr addObject:row_32];
            
            UILabel * row_33 = [[UILabel alloc]initWithFrame:CGRectMake(153+100+212, 253+37, 205, 84)];
            row_33.font = [UIFont systemFontOfSize:16];
            row_33.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:row_33];
            [label_3_arr addObject:row_33];
            
            UILabel * row_34 = [[UILabel alloc]initWithFrame:CGRectMake(153+96+212+218, 253+37, 193, 84)];
            row_34.font = [UIFont systemFontOfSize:16];
            row_34.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:row_34];
            [label_3_arr addObject:row_34];
            [label_arr addObject:label_3_arr];
            
            NSMutableArray * label_4_arr = [[NSMutableArray alloc]init];
            //row 4
            UILabel * row_40 = [[UILabel alloc]initWithFrame:CGRectMake(0, 336+37, 150, 167)];
            row_40.font = [UIFont systemFontOfSize:18];
            row_40.textAlignment = UITextAlignmentCenter;
            row_40.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:row_40];
            [label_4_arr addObject:row_40];
            
            UILabel * row_41 = [[UILabel alloc]initWithFrame:CGRectMake(153, 336+37, 96, 84)];
            row_41.font = [UIFont systemFontOfSize:16];
            row_41.textAlignment = UITextAlignmentCenter;
            row_41.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:row_41];
            [label_4_arr addObject:row_41];
            
            UILabel * row_42 = [[UILabel alloc]initWithFrame:CGRectMake(260, 336+37, 195, 84)];
            row_42.font = [UIFont systemFontOfSize:16];
            row_42.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:row_42];
            [label_4_arr addObject:row_42];
            
            UILabel * row_43 = [[UILabel alloc]initWithFrame:CGRectMake(153+100+212, 336+37, 205, 84)];
            row_43.font = [UIFont systemFontOfSize:16];
            row_43.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:row_43];
            [label_4_arr addObject:row_43];
            
            UILabel * row_44 = [[UILabel alloc]initWithFrame:CGRectMake(153+96+212+218, 336+37, 193, 84)];
            row_44.font = [UIFont systemFontOfSize:16];
            row_44.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:row_44];
            [label_4_arr addObject:row_44];
            [label_arr addObject:label_4_arr];
            
            
            
            NSMutableArray * label_5_arr = [[NSMutableArray alloc]init];
            //row 5
            UILabel * row_50 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0+37, 0, 0)];
            [label_5_arr addObject:row_50];
            
            UILabel * row_51 = [[UILabel alloc]initWithFrame:CGRectMake(153, 419+37, 96, 84)];
            row_51.font = [UIFont systemFontOfSize:16];
            row_51.textAlignment = UITextAlignmentCenter;
            row_51.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:row_51];
            [label_5_arr addObject:row_51];
            
            UILabel * row_52 = [[UILabel alloc]initWithFrame:CGRectMake(260, 419+37, 196, 84)];
            row_52.font = [UIFont systemFontOfSize:16];
            row_52.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:row_52];
            [label_5_arr addObject:row_52];
            
            UILabel * row_53 = [[UILabel alloc]initWithFrame:CGRectMake(153+100+212, 419+37, 205, 84)];
            row_53.font = [UIFont systemFontOfSize:16];
            row_53.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:row_53];
            [label_5_arr addObject:row_53];
            
            UILabel * row_54 = [[UILabel alloc]initWithFrame:CGRectMake(153+96+212+218, 419+37, 193, 84)];
            row_54.font = [UIFont systemFontOfSize:16];
            row_54.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:row_54];
            [label_5_arr addObject:row_54];
            [label_arr addObject:label_5_arr];
            
            NSMutableArray * label_6_arr = [[NSMutableArray alloc]init];
            //row 6
            UILabel * row_60 = [[UILabel alloc]initWithFrame:CGRectMake(0, 503+37, 153, 84)];
            row_60.font = [UIFont systemFontOfSize:18];
            row_60.textAlignment = UITextAlignmentCenter;
            row_60.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:row_60];
            [label_6_arr addObject:row_60];
            
            UILabel * row_61 = [[UILabel alloc]initWithFrame:CGRectMake(153, 503+37, 96, 84)];
            row_61.font = [UIFont systemFontOfSize:16];
            row_61.textAlignment =UITextAlignmentCenter;
            row_61.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:row_61];
            [label_6_arr addObject:row_61];
            
            UILabel * row_62 = [[UILabel alloc]initWithFrame:CGRectMake(260, 503+37, 196, 84)];
            row_62.font = [UIFont systemFontOfSize:16];
            row_62.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:row_62];
            [label_6_arr addObject:row_62];
            
            UILabel * row_63 = [[UILabel alloc]initWithFrame:CGRectMake(153+100+212, 503+37, 205, 84)];
            row_63.font = [UIFont systemFontOfSize:16];
            row_63.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:row_63];
            [label_6_arr addObject:row_63];
            
            UILabel * row_64 = [[UILabel alloc]initWithFrame:CGRectMake(153+96+212+218, 503+37, 193, 84)];
            row_64.font = [UIFont systemFontOfSize:16];
            row_64.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:row_64];
            [label_6_arr addObject:row_64];
            [label_arr addObject:label_6_arr];
            
            
            //加载数据
            NSArray * row_arr = [feedbackDict_Gousi valueForKey:@"feedstr"];
            //NSLog(@"%d",[row_arr count]);
            for (int i = 0; i < [row_arr count]; i++) {
                NSArray * row_item_arr = [row_arr objectAtIndex:i];
                
                //NSLog(@"%@",row_item_arr);
                for (int k = 0; k < [row_item_arr count]; k++) {
                    UILabel * labelItem = label_arr[i][k];
                    labelItem.numberOfLines = 3;
                    //labelItem.textAlignment = UITextAlignmentCenter;
                    labelItem.text = row_item_arr[k];
                }
            }
            
            
            
            //评分
            gousiFeedBack_AdvicesTextView = [[NSMutableArray alloc]init];
            
            UILabel * row_scoreTitle = [[UILabel alloc]initWithFrame:CGRectMake(900, 0+37, 107, 87)];
            row_scoreTitle.font = [UIFont systemFontOfSize:18];
            row_scoreTitle.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:row_scoreTitle];
            row_scoreTitle.text = @"评分";
            
            
            
            for (int i = 0 ; i < 6; i++) {
                UITextField * ET_00 = [[UITextField alloc]initWithFrame:CGRectMake(910, 84 * i + 95+27, 107, 84)];
                ET_00.backgroundColor = [UIColor clearColor];
                ET_00.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                ET_00.font = [UIFont systemFontOfSize:18];
                ET_00.delegate = self;
                [cell.contentView addSubview:ET_00];
                [gousiFeedBack_AdvicesTextView addObject:ET_00];
            }
            
            /*selfTotal = [[UILabel alloc]initWithFrame:CGRectMake(900, 460+70, 50, 96)];
            selfTotal.backgroundColor = [UIColor clearColor];
            selfTotal.font = [UIFont systemFontOfSize:18];
            [cell.contentView addSubview:selfTotal];*/
            
            //加载数据
            NSArray * advice_arr = [feedbackDict_Gousi valueForKey:@"advices"];
            if ([advice_arr count]>0) {
                //int totalScore = 0;
                for (int i = 0; i < [advice_arr count]; i++) {
                    
                    UITextField * labelItem = gousiFeedBack_AdvicesTextView[i];
                    labelItem.delegate = self;
                    labelItem.text = [advice_arr[i] valueForKey:@"advice"];
                    //totalScore = totalScore + [[advice_arr[i] valueForKey:@"advice"] intValue];
                    
                }
                //selfTotal.text = [NSString stringWithFormat:@"%d",totalScore];

            }
            
            if (_type == 3) {
                for (UITextField * txItem in gousiFeedBack_AdvicesTextView) {
                    txItem.enabled = NO;
                }
                
            }
            
            
            
            
            
        }
        else if (reviewType == 2)//互评
        {
            gousiFeedBack_AdvicesTextView = [[NSMutableArray alloc]init];
            gousiFeedBack_AppreciateTextView = [[NSMutableArray alloc]init];

            //同伴互评
            UIImage * bg_interComment = [UIImage imageNamed:@"bg_interComment.png"];
            UIImageView * bg_interCommentView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0+37, 970, 587)];
            bg_interCommentView.image = bg_interComment;
            [cell.contentView addSubview:bg_interCommentView];
            
            NSMutableArray * label_arr = [[NSMutableArray alloc]init];
            
            NSMutableArray * label_1_arr = [[NSMutableArray alloc]init];
            UILabel * label_00 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0+37, 120, 98)];
            label_00.font = [UIFont systemFontOfSize:18];
            label_00.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:label_00];
            [label_1_arr addObject:label_00];
            
            UILabel * label_01 = [[UILabel alloc]initWithFrame:CGRectMake(135, 0+37, 500, 98)];
            label_01.font = [UIFont systemFontOfSize:18];
            label_01.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:label_01];
            [label_1_arr addObject:label_01];
            
            UILabel * label_02 = [[UILabel alloc]initWithFrame:CGRectMake(645, 0+37, 100, 98)];
            label_02.font = [UIFont systemFontOfSize:18];
            label_02.textAlignment = UITextAlignmentCenter;
            label_02.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:label_02];
            [label_1_arr addObject:label_02];
            [label_arr addObject:label_1_arr];
            
            NSMutableArray * label_2_arr = [[NSMutableArray alloc]init];
            UILabel * label_10 = [[UILabel alloc]initWithFrame:CGRectMake(0, 98+37, 120, 98)];
            label_10.font = [UIFont systemFontOfSize:18];
            label_10.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:label_10];
            [label_2_arr addObject:label_10];
            
            UILabel * label_11 = [[UILabel alloc]initWithFrame:CGRectMake(135, 98+37, 500, 98)];
            label_11.font = [UIFont systemFontOfSize:18];
            label_11.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:label_11];
            [label_2_arr addObject:label_11];
            
            UILabel * label_12 = [[UILabel alloc]initWithFrame:CGRectMake(645, 98+37, 100, 98)];
            label_12.font = [UIFont systemFontOfSize:18];
            label_12.textAlignment = UITextAlignmentCenter;
            label_12.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:label_12];
            [label_2_arr addObject:label_12];
            [label_arr addObject:label_2_arr];
            
            NSMutableArray * label_3_arr = [[NSMutableArray alloc]init];
            UILabel * label_20 = [[UILabel alloc]initWithFrame:CGRectMake(0, 196+37, 120, 98)];
            label_20.font = [UIFont systemFontOfSize:18];
            label_20.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:label_20];
            [label_3_arr addObject:label_20];
            
            UILabel * label_21 = [[UILabel alloc]initWithFrame:CGRectMake(135, 196+37, 500, 98)];
            label_21.font = [UIFont systemFontOfSize:18];
            label_21.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:label_21];
            [label_3_arr addObject:label_21];
            
            UILabel * label_22 = [[UILabel alloc]initWithFrame:CGRectMake(645, 196+37, 100, 98)];
            label_22.font = [UIFont systemFontOfSize:18];
            label_22.textAlignment = UITextAlignmentCenter;
            label_22.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:label_22];
            [label_3_arr addObject:label_22];
            [label_arr addObject:label_3_arr];
            
            NSMutableArray * label_4_arr = [[NSMutableArray alloc]init];
            UILabel * label_30 = [[UILabel alloc]initWithFrame:CGRectMake(0, 294+37, 120, 155)];
            label_30.font = [UIFont systemFontOfSize:18];
            label_30.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:label_30];
            [label_4_arr addObject:label_30];
            
            UILabel * label_31 = [[UILabel alloc]initWithFrame:CGRectMake(135, 294+37, 500, 155)];
            label_31.font = [UIFont systemFontOfSize:18];
            label_31.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:label_31];
            [label_4_arr addObject:label_31];
            
            UILabel * label_32 = [[UILabel alloc]initWithFrame:CGRectMake(645, 294+37, 100, 155)];
            label_32.font = [UIFont systemFontOfSize:18];
            label_32.textAlignment = UITextAlignmentCenter;
            label_32.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:label_32];
            [label_4_arr addObject:label_32];
            [label_arr addObject:label_4_arr];
            
            NSMutableArray * label_5_arr = [[NSMutableArray alloc]init];
            UILabel * label_40 = [[UILabel alloc]initWithFrame:CGRectMake(0, 448+37, 120, 98)];
            label_40.font = [UIFont systemFontOfSize:18];
            label_40.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:label_40];
            [label_5_arr addObject:label_40];
            
            UILabel * label_41 = [[UILabel alloc]initWithFrame:CGRectMake(135, 448+37, 500, 98)];
            label_41.font = [UIFont systemFontOfSize:18];
            label_41.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:label_41];
            [label_5_arr addObject:label_41];
            
            UILabel * label_42 = [[UILabel alloc]initWithFrame:CGRectMake(645, 448+37, 100, 98)];
            label_42.font = [UIFont systemFontOfSize:18];
            label_42.textAlignment = UITextAlignmentCenter;
            label_42.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:label_42];
            [label_5_arr addObject:label_42];
            [label_arr addObject:label_5_arr];
            
            //总分
            UILabel * label_50 = [[UILabel alloc]initWithFrame:CGRectMake(0, 534+37, 696, 54)];
            label_50.font = [UIFont systemFontOfSize:18];
            label_50.backgroundColor = [UIColor clearColor];
            label_50.text = @"总分";
            [cell.contentView addSubview:label_50];
            //[label_arr addObject:label_50];
            
            UILabel * label_51 = [[UILabel alloc]initWithFrame:CGRectMake(645, 534+37, 100, 54)];
            label_51.font = [UIFont systemFontOfSize:18];
            label_51.textAlignment = UITextAlignmentCenter;
            label_51.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:label_51];
            //[label_arr addObject:label_51];
            
            //得分、评分
            UILabel * label_score_title = [[UILabel alloc]initWithFrame:CGRectMake(753, 0+37, 215, 50)];
             label_score_title.font = [UIFont systemFontOfSize:18];
            label_score_title.textAlignment = UITextAlignmentCenter;
             label_score_title.backgroundColor = [UIColor clearColor];
             label_score_title.text = @"得分";
             [cell.contentView addSubview:label_score_title];
             
             UILabel * label_score_self = [[UILabel alloc]initWithFrame:CGRectMake(753, 52+37, 108, 48)];
             label_score_self.font = [UIFont systemFontOfSize:18];
            label_score_self.textAlignment = UITextAlignmentCenter;
             label_score_self.backgroundColor = [UIColor clearColor];
             label_score_self.text = @"自评";
             [cell.contentView addSubview:label_score_self];
             
             UILabel * label_score_other = [[UILabel alloc]initWithFrame:CGRectMake(861, 52+37, 108, 48)];
             label_score_other.font = [UIFont systemFontOfSize:18];
            label_score_other.textAlignment = UITextAlignmentCenter;
             label_score_other.backgroundColor = [UIColor clearColor];
             label_score_other.text = @"同学评";
             [cell.contentView addSubview:label_score_other];
            
            //if (_type != 1) {
                //加载数据
                NSArray * row_arr = [feedbackDict_Gousi valueForKey:@"feedstr"];
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
                UITextField * ET_00 = [[UITextField alloc]initWithFrame:CGRectMake(790, 98 * (i+1) + 37, 100, 98)];
                ET_00.backgroundColor = [UIColor clearColor];
                ET_00.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                ET_00.font = [UIFont systemFontOfSize:18];
                ET_00.delegate = self;
                [cell.contentView addSubview:ET_00];
                [gousiFeedBack_AdvicesTextView addObject:ET_00];
            }
            
            UITextField * ET_03 = [[UITextField alloc]initWithFrame:CGRectMake(790, 294+37, 100, 155)];
            ET_03.backgroundColor = [UIColor clearColor];
            ET_03.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            ET_03.font = [UIFont systemFontOfSize:18];
            ET_03.delegate = self;
            [cell.contentView addSubview:ET_03];
            [gousiFeedBack_AdvicesTextView addObject:ET_03];
            
            UITextField * ET_04 = [[UITextField alloc]initWithFrame:CGRectMake(790, 448+37, 100, 98)];
            ET_04.backgroundColor = [UIColor clearColor];
            ET_04.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            ET_04.font = [UIFont systemFontOfSize:18];
            ET_04.delegate = self;
            [cell.contentView addSubview:ET_04];
            [gousiFeedBack_AdvicesTextView addObject:ET_04];
            
            selfTotal = [[UILabel alloc]initWithFrame:CGRectMake(790, 480+70, 50, 96)];
            selfTotal.backgroundColor = [UIColor clearColor];
            selfTotal.font = [UIFont systemFontOfSize:18];
            [cell.contentView addSubview:selfTotal];
            
            
            
            for (int i = 0 ; i < 2; i++) {
                UITextField * ET_00 = [[UITextField alloc]initWithFrame:CGRectMake(900, 98 * (i+1) + 37, 100, 98)];
                ET_00.backgroundColor = [UIColor clearColor];
                ET_00.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                ET_00.font = [UIFont systemFontOfSize:18];
                ET_00.delegate = self;
                [cell.contentView addSubview:ET_00];
                [gousiFeedBack_AppreciateTextView addObject:ET_00];
            }
            
            UITextField * ET_13 = [[UITextField alloc]initWithFrame:CGRectMake(900, 294+37, 100, 155)];
            ET_13.backgroundColor = [UIColor clearColor];
            ET_13.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            ET_13.font = [UIFont systemFontOfSize:18];
            ET_13.delegate = self;
            [cell.contentView addSubview:ET_13];
            [gousiFeedBack_AppreciateTextView addObject:ET_13];
            
            UITextField * ET_14 = [[UITextField alloc]initWithFrame:CGRectMake(900,448+37, 100, 98)];
            ET_14.backgroundColor = [UIColor clearColor];
            ET_14.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            ET_14.font = [UIFont systemFontOfSize:18];
            ET_14.delegate = self;
            [cell.contentView addSubview:ET_14];
            [gousiFeedBack_AppreciateTextView addObject:ET_14];
            
            otherTotal = [[UILabel alloc]initWithFrame:CGRectMake(900, 480+70, 50, 96)];
            otherTotal.backgroundColor = [UIColor clearColor];
            otherTotal.font = [UIFont systemFontOfSize:18];
            [cell.contentView addSubview:otherTotal];
            //加载数据
            NSArray * advice_arr = Nil; // 由advices 改为 selfassessments update 20140119
            //NSArray * advice_arr = [feedbackDict_Gousi valueForKey:@"advices"];
            if ([feedbackDict_Gousi objectForKey:@"selfassessments"]) {
                advice_arr = [feedbackDict_Gousi objectForKey:@"selfassessments"];
            }
            
            
            //自评列
            if (advice_arr && [advice_arr count] > 0) {
                int selfTotalScore = 0;
                for (int i = 0; i < [advice_arr count]; i++) {
                    UITextField * labelItem = gousiFeedBack_AdvicesTextView[i];
                    labelItem.delegate = self;
                    labelItem.text = [advice_arr[i] valueForKey:@"advice"];
                    selfTotalScore = selfTotalScore + [[advice_arr[i] valueForKey:@"advice"] intValue];
                }
                selfTotal.text = [NSString stringWithFormat:@"%d",selfTotalScore];

            }
            
            //同学评列
            NSArray * appreciate_arr = [feedbackDict_Gousi valueForKey:@"appreciates"];
            if ([appreciate_arr count]>0) {
                int otherTotalScore = 0;
                for (int i = 0; i < [appreciate_arr count]; i++) {
                    UITextField * labelItem = gousiFeedBack_AppreciateTextView[i];
                    labelItem.delegate = self;
                    labelItem.text = [appreciate_arr[i] valueForKey:@"appreciate"];
                    otherTotalScore = otherTotalScore + [[appreciate_arr[i] valueForKey:@"appreciate"] intValue];
                }
                otherTotal.text = [NSString stringWithFormat:@"%d",otherTotalScore];

            }
            
            // add 20140119
            if (editMode == 0) {
                for (UITextField * txItem in gousiFeedBack_AdvicesTextView) {
                    txItem.enabled = NO;
                }
            }
            if (editMode == 1) {
                for (UITextField * txItem in gousiFeedBack_AppreciateTextView) {
                    txItem.enabled = NO;
                }
            }
            
            if (_type == 3) {
                for (UITextField * txItem in gousiFeedBack_AdvicesTextView) {
                    txItem.enabled = NO;
                }
                for (UITextField * txItem in gousiFeedBack_AppreciateTextView) {
                    txItem.enabled = NO;
                }
            }
            
            
            
            
        }
        else
        {
            //默认
            
           // NSLog(@"feedbackDict:%@",feedbackDict);
            /*[self addLabel:[NSString stringWithFormat:@"作者：%@",[feedbackDict valueForKey:@"author"]]
                     frame:CGRectMake(30, 10, 180, 30)
                      size:16
                  intoView:cell.contentView];
            [self addLabel:[NSString stringWithFormat:@"点评者：%@",[feedbackDict valueForKey:@"partner"]]
                     frame:CGRectMake(730, 10, 180, 30)
                      size:16
                  intoView:cell.contentView];*/
            
            UIImage* separater_lineImage1 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Button_separater_line" ofType:@"png"]];
            UIImageView* separater_lineView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 48, 970, 2)];
            [separater_lineView1 setImage:separater_lineImage1];
            [cell.contentView addSubview:separater_lineView1];
            [separater_lineView1 release];
            
            /*[self addLabel:@"主题"
                     frame:CGRectMake(30, 60, 180, 30)
                      size:16
                  intoView:cell.contentView];
            
            UITextField* titleView = [[UITextField alloc] initWithFrame:CGRectMake(230, 65, 730, 40)];
            [titleView setFont:[UIFont systemFontOfSize:16]];
            [titleView setTag:kTagFeedbackTitleView];
            if (_type == 1 || _type == 3) {
                [titleView setEnabled:NO];
            }
            [titleView setText:[feedbackDict valueForKey:@"title"]];
            [cell.contentView addSubview:titleView];
            [titleView release];
            
            UIImage* separater_lineImage2 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Button_separater_line" ofType:@"png"]];
            UIImageView* separater_lineView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 98, 970, 2)];
            [separater_lineView2 setImage:separater_lineImage2];
            [cell.contentView addSubview:separater_lineView2];
            [separater_lineView2 release];*/
            
            [self addLabel:@"我欣赏的是"
                     frame:CGRectMake(30, 160-98+50, 180, 30)
                      size:16
                  intoView:cell.contentView];
            
            /*UIImage* separater_lineImage3 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Button_separater_line" ofType:@"png"]];
            UIImageView* separater_lineView3 = [[UIImageView alloc] initWithFrame:CGRectMake(220, 148-98, 750, 2)];
            [separater_lineView3 setImage:separater_lineImage3];
            [cell.contentView addSubview:separater_lineView3];
            [separater_lineView3 release];*/
            
            UIImage* separater_lineImage4 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Button_separater_line" ofType:@"png"]];
            UIImageView* separater_lineView4 = [[UIImageView alloc] initWithFrame:CGRectMake(220, 198-98, 750, 2)];
            [separater_lineView4 setImage:separater_lineImage4];
            [cell.contentView addSubview:separater_lineView4];
            [separater_lineView4 release];
            
            UIImage* separater_lineImage5 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Button_separater_line" ofType:@"png"]];
            UIImageView* separater_lineView5 = [[UIImageView alloc] initWithFrame:CGRectMake(220, 248-98, 750, 2)];
            [separater_lineView5 setImage:separater_lineImage5];
            [cell.contentView addSubview:separater_lineView5];
            [separater_lineView5 release];
            
            UIImage* separater_lineImage5_01 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Button_separater_line" ofType:@"png"]];
            UIImageView* separater_lineView5_01 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 248-98+50, 970, 2)];
            [separater_lineView5_01 setImage:separater_lineImage5_01];
            [cell.contentView addSubview:separater_lineView5_01];
            [separater_lineView5_01 release];
            
            NSArray* _appreciateArray = [feedbackDict valueForKey:@"appreciates"];
            for (int i=0; i<3; i++) {
                
            }
            NSDictionary* appreciate01Dict = [_appreciateArray objectAtIndex:0];
            UITextField* appreciate01View = [[UITextField alloc] initWithFrame:CGRectMake(230, 115-98+50, 730, 40)];
            [appreciate01View setFont:[UIFont systemFontOfSize:16]];
            [appreciate01View setTag:kTagFeedbackAppreciate01View];
            if (_type == 1 || _type == 3) {
                [appreciate01View setEnabled:NO];
            }
            [appreciate01View setText:[appreciate01Dict valueForKey:@"appreciate"]];
            [cell.contentView addSubview:appreciate01View];
            [appreciate01View release];
            
            NSDictionary* appreciate02Dict = [_appreciateArray objectAtIndex:1];
            UITextField* appreciate02View = [[UITextField alloc] initWithFrame:CGRectMake(230, 165-98+50, 730, 40)];
            [appreciate02View setFont:[UIFont systemFontOfSize:16]];
            [appreciate02View setTag:kTagFeedbackAppreciate02View];
            if (_type == 1 || _type == 3) {
                [appreciate02View setEnabled:NO];
            }
            [appreciate02View setText:[appreciate02Dict valueForKey:@"appreciate"]];
            [cell.contentView addSubview:appreciate02View];
            [appreciate02View release];
            
            NSDictionary* appreciate03Dict = [_appreciateArray objectAtIndex:2];
            UITextField* appreciate03View = [[UITextField alloc] initWithFrame:CGRectMake(230, 215-98+50, 730, 40)];
            [appreciate03View setFont:[UIFont systemFontOfSize:16]];
            [appreciate03View setTag:kTagFeedbackAppreciate03View];
            if (_type == 1 || _type == 3) {
                [appreciate03View setEnabled:NO];
            }
            [appreciate03View setText:[appreciate03Dict valueForKey:@"appreciate"]];
            [cell.contentView addSubview:appreciate03View];
            [appreciate03View release];
            
            
            [self addLabel:@"我建议你改变的是"
                     frame:CGRectMake(30, 310-98+50, 180, 30)
                      size:16
                  intoView:cell.contentView];
            
            UIImage* separater_lineImage6 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Button_separater_line" ofType:@"png"]];
            UIImageView* separater_lineView6 = [[UIImageView alloc] initWithFrame:CGRectMake(220, 298-98+50, 750, 2)];
            [separater_lineView6 setImage:separater_lineImage6];
            [cell.contentView addSubview:separater_lineView6];
            [separater_lineView6 release];
            
            UIImage* separater_lineImage7 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Button_separater_line" ofType:@"png"]];
            UIImageView* separater_lineView7 = [[UIImageView alloc] initWithFrame:CGRectMake(220, 348-98+50, 750, 2)];
            [separater_lineView7 setImage:separater_lineImage7];
            [cell.contentView addSubview:separater_lineView7];
            [separater_lineView7 release];
            
            UIImage* separater_lineImage8  = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Button_separater_line" ofType:@"png"]];
            UIImageView* separater_lineView8 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 398-98+50, 970, 2)];
            [separater_lineView8 setImage:separater_lineImage8];
            [cell.contentView addSubview:separater_lineView8];
            [separater_lineView8 release];
            
            NSArray* _adviceArray = [feedbackDict valueForKey:@"advices"];
            NSDictionary* advice01Dict = [_adviceArray objectAtIndex:0];
            UITextField* advice01View = [[UITextField alloc] initWithFrame:CGRectMake(230, 265-98+50, 730, 40)];
            [advice01View setFont:[UIFont systemFontOfSize:16]];
            [advice01View setTag:kTagFeedbackAdvice01View];
            if (_type == 1 || _type == 3) {
                [advice01View setEnabled:NO];
            }
            [advice01View setText:[advice01Dict valueForKey:@"advice"]];
            [cell.contentView addSubview:advice01View];
            [advice01View release];
            
            NSDictionary* advice02Dict = [_adviceArray objectAtIndex:1];
            UITextField* advice02View = [[UITextField alloc] initWithFrame:CGRectMake(230, 315-98+50, 730, 40)];
            [advice02View setFont:[UIFont systemFontOfSize:16]];
            [advice02View setTag:kTagFeedbackAdvice02View];
            if (_type == 1 || _type == 3) {
                [advice02View setEnabled:NO];
            }
            [advice02View setText:[advice02Dict valueForKey:@"advice"]];
            [cell.contentView addSubview:advice02View];
            [advice02View release];
            
            NSDictionary* advice03Dict = [_adviceArray objectAtIndex:2];
            UITextField* advice03View = [[UITextField alloc] initWithFrame:CGRectMake(230, 365-98+50, 730, 40)];
            [advice03View setFont:[UIFont systemFontOfSize:16]];
            [advice03View setTag:kTagFeedbackAdvice03View];
            if (_type == 1 || _type == 3) {
                [advice03View setEnabled:NO];
            }
            [advice03View setText:[advice03Dict valueForKey:@"advice"]];
            [cell.contentView addSubview:advice03View];
            [advice03View release];
        }
        
    }
    
    return cell;
}

#pragma mark - Table view delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    int tag = tableView.tag;

    if(tag == kTagFeedbackTableView){
        
        if (reviewType == 1 || reviewType == 2 ) {
            return 610.0f;
        }
        else
        {
            return 420.0f;
        }
        
    }

    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)tableView:(UITableView*)tableView  willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}


#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        
    }else if(buttonIndex == 1){
        int tag = alertView.tag;
        if (tag == kTagWorkCommitButton) {
            [self submitWork];
        }else if(tag ==kTagFeedbackCommitButton){
            [self submitFeedback];
        }else if(tag == kTagCollectAddButton){
            [self addToCollect];
        }
    }
}

#pragma mark - UIExpandingTextViewDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string   // return NO to not change text
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
        
    

}


#pragma mark ZMHttpEngineDelegate
-(void)httpEngine:(ZMHttpEngine *)httpEngine didSuccess:(NSDictionary *)responseDict{
    [super httpEngine:httpEngine didSuccess:responseDict];
    
    NSString* method = [responseDict valueForKey:@"method"];
    NSString* responseCode = [responseDict valueForKey:@"responseCode"];
    if(([@"M015" isEqualToString:method] && [@"00" isEqualToString:responseCode])){
        
        [self showTip:@"成功提交作业"];
        self.issuccess = YES;
        UIButton* shareBtn = (UIButton*)[self.view viewWithTag:kTagShareButton];
        if (shareBtn.selected) {
            NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
            [requestDict setValue:@"M026" forKey:@"method"];
            [requestDict setValue:[_unitDict valueForKey:@"courseId"] forKey:@"courseId"];
            [requestDict setValue:[_unitDict valueForKey:@"classId"] forKey:@"classId"];
            [requestDict setValue:[_unitDict valueForKey:@"gradeId"] forKey:@"gradeId"];
            [requestDict setValue:[_unitDict valueForKey:@"moduleId"] forKey:@"moduleId"];
            [requestDict setValue:[_unitDict valueForKey:@"authorId"] forKey:@"userId"];
            [requestDict setValue:[_unitDict valueForKey:@"unitId"] forKey:@"unitId"];
            
            ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
            [httpEngine setDelegate:self];
            [httpEngine requestWithDict:requestDict];
            [httpEngine release];
            [requestDict release];
        }
    }else if ([@"M036" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        _feedbackArray = [[NSMutableArray alloc] initWithCapacity:0];
        reviewType = [[responseDict valueForKey:@"reviewType"] intValue] ;
        
        NSArray* feedbacksArray = [responseDict valueForKey:@"feedbacks"];
        for (int i=0; i<[feedbacksArray count]; i++) {
            NSMutableDictionary * item = [[NSMutableDictionary alloc]initWithDictionary:[feedbacksArray objectAtIndex:i]];
            NSArray * selfassessments = Nil;
            if ([responseDict objectForKey:@"advices"]) {
                selfassessments = [responseDict objectForKey:@"advices"];
            }else{
                selfassessments = [responseDict objectForKey:@"selfassessments"];
            }
            if (selfassessments) {
                [item setObject:selfassessments forKey:@"selfassessments"];
            }
            
            [_feedbackArray addObject:item];
        }

        if ([_feedbackArray count] > 0) {
            UITableView* feedbackView = [[UITableView alloc] initWithFrame:CGRectMake(0, 768, 1024, 420*[_feedbackArray count]) style:UITableViewStylePlain];
            [feedbackView setTag:kTagFeedbackTableView];
            [feedbackView setDelegate:self];
            [feedbackView setDataSource:self];
            [feedbackView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
            [feedbackView setBackgroundColor:[UIColor clearColor]];
            
            [theScrollView addSubview:feedbackView];
            [feedbackView release];
            if (reviewType == 1 || reviewType == 2) {
                [feedbackView setFrame:CGRectMake(27, 768, 970, 610*[_feedbackArray count]+110)];
                [theScrollView setContentSize:CGSizeMake(1024, 610*[_feedbackArray count] + 768+110)];
            }else
            {
                [feedbackView setFrame:CGRectMake(27, 768, 970, 420*[_feedbackArray count]+110)];
                [theScrollView setContentSize:CGSizeMake(1024, 420*[_feedbackArray count] + 768+110)];
            }
            
            //[theScrollView setContentSize:CGSizeMake(1024, 420*[_feedbackArray count] + 768)];
        }
    }else if([@"M029" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        [_feedbackArray removeAllObjects];
        [_feedbackArray addObject:responseDict];
        
        reviewType = [[responseDict valueForKey:@"reviewType"] intValue] ;
        if (reviewType == 2) {
            if ([[responseDict valueForKey:@"author"] isEqualToString: [responseDict valueForKey:@"partner"]]) {
                editMode = 1;
            }else{
                editMode = 0;
            }
        }
        UITableView* feedbackView = (UITableView*)[theScrollView viewWithTag:kTagFeedbackTableView];
        if (reviewType == 1 || reviewType == 2) {
            [feedbackView setFrame:CGRectMake(27, 768, 970, 610*[_feedbackArray count]+110)];
        }else
        {
            [feedbackView setFrame:CGRectMake(27, 768, 970, 420*[_feedbackArray count]+110)];
        }
        
         UIView* footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 970, 110)];
        UIButton* submitBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [submitBut setFrame:CGRectMake(794, 10, 105, 89)];
        [submitBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Submit_Btn" ofType:@"png"]] forState:UIControlStateNormal];
        [submitBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Submit_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
        [submitBut addTarget:self
                      action:@selector(submitFeedbackClick:)
            forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:submitBut];
        
        [feedbackView setTableFooterView:footView];
  
        [footView release];
        if (reviewType == 1 || reviewType == 2) {
            [theScrollView setContentSize:CGSizeMake(1024, 610*[_feedbackArray count] + 768+110)];
        }else
        {
        [theScrollView setContentSize:CGSizeMake(1024, 420*[_feedbackArray count] + 768+110)];
        }
        
        [feedbackView setDelegate:self];
        [feedbackView setDataSource:self];
        [feedbackView reloadData];
    }else if([@"M030" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        articleDict = [[NSMutableDictionary alloc] initWithCapacity:0];
        gousiDict = [[NSDictionary alloc]init]; // use for gousi model , add by ybyt 20131022
        gousiDict = responseDict;
        reviewType = [[responseDict valueForKey:@"reviewType"] intValue] ;
        [articleDict setValue:[responseDict valueForKey:@"articleCellNumber"] forKey:@"articleCellNumber"];
        [articleDict setValue:[responseDict valueForKey:@"articleType"] forKey:@"articleType"];
        [articleDict setValue:[responseDict valueForKey:@"title"] forKey:@"title"];
        [articleDict setValue:[responseDict valueForKey:@"articleDraft"] forKey:@"articleDraft"];
        [articleDict setValue:[responseDict valueForKey:@"articleContents"] forKey:@"articleContents"];
        [articleDict setValue:[responseDict valueForKey:@"articleComments"] forKey:@"articleComment"];

        [self addLabel:[responseDict valueForKey:@"unitTitle"]
                 frame:CGRectMake(291, 22, 421, 30)
                  size:18
              intoView:articleView];
        
        [self addDraftView];
        [self addContentView];
        [self addCommentView];
        //add 20140111
        /*{
            if (_type == 1 && reviewType == 2) {
                
                //请求反馈详情表
                NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
                [requestDict setValue:@"M029" forKey:@"method"];
                [requestDict setValue:[_unitDict valueForKey:@"courseId"] forKey:@"courseId"];
                [requestDict setValue:[_unitDict valueForKey:@"classId"] forKey:@"classId"];
                [requestDict setValue:[_unitDict valueForKey:@"gradeId"] forKey:@"gradeId"];
                [requestDict setValue:[_unitDict valueForKey:@"moduleId"] forKey:@"moduleId"];
                [requestDict setValue:[_unitDict valueForKey:@"authorId"] forKey:@"authorId"];
                [requestDict setValue:[_unitDict valueForKey:@"unitId"] forKey:@"unitId"];
                [requestDict setValue:[_unitDict valueForKey:@"authorId"] forKey:@"partnerId"];
                
                ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
                [httpEngine setDelegate:self];
                [httpEngine requestWithDict:requestDict];
                [httpEngine release];
                [requestDict release];
                //把互评表添加进来
                _feedbackArray = [[NSMutableArray alloc] initWithCapacity:0];
                
                UITableView* feedbackView = [[UITableView alloc] initWithFrame:CGRectMake(27, 768, 970, 0) style:UITableViewStylePlain];
                [feedbackView setTag:kTagFeedbackTableView];
                [feedbackView setDelegate:self];
                [feedbackView setDataSource:self];
                [feedbackView setScrollEnabled:NO];
                [feedbackView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
                [feedbackView setBackgroundColor:[UIColor clearColor]];
                [theScrollView addSubview:feedbackView];
                
                [feedbackView setFrame:CGRectMake(27, 768, 970, 610+110)];
                [theScrollView setContentSize:CGSizeMake(1024, 610 + 768+110)];
                
                [feedbackView release];
            }
        
        }*/
    }else if([@"M013" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if([@"M022" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        [self showTip:@"成功提交点评"];
    }else if([@"M026" isEqualToString:method] && ![@"00" isEqualToString:responseCode]) {
        if (self.issuccess == YES) {
            [self showTip:@"保存成功，分享失败"];
        }
    }else if([@"M025" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        

    }else if(![@"00" isEqualToString:responseCode]){
        [self showTip:@"服务器异常"];
    }
    
    if ([@"M135" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        [self hideIndicator];
        [self showTip:@"发布成功"];
    }
    if ([@"M135" isEqualToString:method] && [@"96" isEqualToString:responseCode]) {
        [self hideIndicator];
        [self showTip:responseDict[@"responseMessage"]];
    }
}

@end
