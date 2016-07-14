#define IOS7 [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0

#import "ZMMdlConceptionVCtrl.h"

@implementation ZMMdlConceptionVCtrl

//-(void)viewDidLoad{
//    [super viewDidLoad];
//    [[NSNotificationCenter defaultCenter]  addObserver:self
//                                              selector:@selector(submitWork)
//                                                  name:@"ZMArticleViewClose"
//                                                object:nil];
//}

-(void)addCommentView
{
    article_Comments_Arr = [[NSMutableArray alloc]init];
    
    {
        UIImage* article_Comment_01_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bg_comment_01" ofType:@"png"]];
        UIImageView* article_Comment_01_View = [[UIImageView alloc] initWithFrame:CGRectMake(845, 72, 166, 99)];
        [article_Comment_01_View setImage:article_Comment_01_Image];
        [articleView addSubview:article_Comment_01_View];
        [article_Comment_01_View release];
        
        UIImage* article_Comment_02_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bg_comment_02" ofType:@"png"]];
        UIImageView* article_Comment_02_View = [[UIImageView alloc] initWithFrame:CGRectMake(845, 565, 167, 100)];
        [article_Comment_02_View setImage:article_Comment_02_Image];
        [articleView addSubview:article_Comment_02_View];
        [article_Comment_02_View release];
    }
    
    UIExpandingTextView * TV_Bk1 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(885, 80, 125, 82)];
    TV_Bk1.font = [UIFont systemFontOfSize:18];
    TV_Bk1.backgroundColor = [UIColor clearColor];
    [articleView addSubview:TV_Bk1];
    [article_Comments_Arr addObject:TV_Bk1];
    if (self.type == 2 || self.type == 3) {
        [TV_Bk1 setEditable:NO];
    }

    [TV_Bk1 release];
    
    UIExpandingTextView * TV_Bk2 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(885, 572, 125, 82)];
    TV_Bk2.font = [UIFont systemFontOfSize:18];
    TV_Bk2.backgroundColor = [UIColor clearColor];
    [articleView addSubview:TV_Bk2];
    [article_Comments_Arr addObject:TV_Bk2];
    if (self.type == 2 || self.type == 3) {
        [TV_Bk2 setEditable:NO];
    }

    [TV_Bk2 release];
    
    NSArray * articleComments = [gousiDict valueForKey:@"articleComments"];
    for (int i = 0; i < [articleComments count]; i++) {
        UIExpandingTextView * commentTextView = [article_Comments_Arr objectAtIndex:i];
        commentTextView.text = [articleComments[i] valueForKey:@"articleComment"];
    }
    

}

-(void)addDraftView
{
   
    UIImageView * IV_Bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    IV_Bg.image = [UIImage imageNamed:@"bg_conceptMap.png"];
    [articleView addSubview:IV_Bg];
    
    TF_Draft_Title   = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(25, 85, 180, 55)];
    [articleView addSubview:TF_Draft_Title];
    TV_Draft_Content = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(25, 165, 180, 565)];
    TV_Draft_Content.font = [UIFont systemFontOfSize:18];
    [articleView addSubview:TV_Draft_Content];

    
    TF_Draft_Title.text = [gousiDict valueForKey:@"title"];
    TV_Draft_Content.text = [gousiDict valueForKey:@"articleDraft"];
 
}

-(void)addContentView
{

    
    article_Contents_Arr = [[NSMutableArray alloc]init];

    {
        
        UIExpandingTextView * TV_Con1 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(387, 72, 105, 35)];
        TV_Con1.backgroundColor = [UIColor clearColor];
        TV_Con1.font = [UIFont systemFontOfSize:14];
        [articleView addSubview:TV_Con1];
        [article_Contents_Arr addObject:TV_Con1];
        
        UIExpandingTextView * TV_Con2 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(296, 134, 105, 35)];
        TV_Con2.backgroundColor = [UIColor clearColor];
        TV_Con2.font = [UIFont systemFontOfSize:14];
        [articleView addSubview:TV_Con2];
        [article_Contents_Arr addObject:TV_Con2];
        
        UIExpandingTextView * TV_Con3 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(261, 199, 105, 35)];
        TV_Con3.backgroundColor = [UIColor clearColor];
        TV_Con3.font = [UIFont systemFontOfSize:14];
        [articleView addSubview:TV_Con3];
        [article_Contents_Arr addObject:TV_Con3];
        
        UIExpandingTextView * TV_Con4 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(238, 274, 105, 35)];
        TV_Con4.backgroundColor = [UIColor clearColor];
        TV_Con4.font = [UIFont systemFontOfSize:14];
        [articleView addSubview:TV_Con4];
        [article_Contents_Arr addObject:TV_Con4];
        
        UIExpandingTextView * TV_Con5 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(223, 342, 105, 35)];
        TV_Con5.backgroundColor = [UIColor clearColor];
        TV_Con5.font = [UIFont systemFontOfSize:14];
        [articleView addSubview:TV_Con5];
        [article_Contents_Arr addObject:TV_Con5];
        
        UIExpandingTextView * TV_Con6 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(223, 413, 105, 35)];
        TV_Con6.backgroundColor = [UIColor clearColor];
        TV_Con6.font = [UIFont systemFontOfSize:14];
        [articleView addSubview:TV_Con6];
        [article_Contents_Arr addObject:TV_Con6];
        
        UIExpandingTextView * TV_Con7 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(238, 477, 105, 35)];
        TV_Con7.backgroundColor = [UIColor clearColor];
        TV_Con7.font = [UIFont systemFontOfSize:14];
        [articleView addSubview:TV_Con7];
        [article_Contents_Arr addObject:TV_Con7];
        
        UIExpandingTextView * TV_Con8 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(261, 548, 105, 35)];
        TV_Con8.backgroundColor = [UIColor clearColor];
        TV_Con8.font = [UIFont systemFontOfSize:14];
        [articleView addSubview:TV_Con8];
        [article_Contents_Arr addObject:TV_Con8];
        
        UIExpandingTextView * TV_Con9 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(296, 613, 105, 35)];
        TV_Con9.backgroundColor = [UIColor clearColor];
        TV_Con9.font = [UIFont systemFontOfSize:14];
        [articleView addSubview:TV_Con9];
        [article_Contents_Arr addObject:TV_Con9];
        
        UIExpandingTextView * TV_Con10 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(387, 674, 105, 35)];
        TV_Con10.backgroundColor = [UIColor clearColor];
        TV_Con10.font = [UIFont systemFontOfSize:14];
        [articleView addSubview:TV_Con10];
        [article_Contents_Arr addObject:TV_Con10];
        
        UIExpandingTextView * TV_Con11 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(604, 72, 105, 35)];
        TV_Con11.backgroundColor = [UIColor clearColor];
        TV_Con11.font = [UIFont systemFontOfSize:14];
        [articleView addSubview:TV_Con11];
        [article_Contents_Arr addObject:TV_Con11];
        
        UIExpandingTextView * TV_Con12 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(695, 134, 105, 35)];
        TV_Con12.backgroundColor = [UIColor clearColor];
        TV_Con12.font = [UIFont systemFontOfSize:14];
        [articleView addSubview:TV_Con12];
        [article_Contents_Arr addObject:TV_Con12];
        
        UIExpandingTextView * TV_Con13 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(753, 199, 105, 35)];
        TV_Con13.backgroundColor = [UIColor clearColor];
        TV_Con13.font = [UIFont systemFontOfSize:14];
        [articleView addSubview:TV_Con13];
        [article_Contents_Arr addObject:TV_Con13];
        
        UIExpandingTextView * TV_Con14 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(795, 271, 105, 35)];
        TV_Con14.backgroundColor = [UIColor clearColor];
        TV_Con14.font = [UIFont systemFontOfSize:14];
        [articleView addSubview:TV_Con14];
        [article_Contents_Arr addObject:TV_Con14];
        
        UIExpandingTextView * TV_Con15 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(813, 342, 105, 35)];
        TV_Con15.backgroundColor = [UIColor clearColor];
        TV_Con15.font = [UIFont systemFontOfSize:14];
        [articleView addSubview:TV_Con15];
        [article_Contents_Arr addObject:TV_Con15];
        
        UIExpandingTextView * TV_Con16 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(813, 413, 105, 35)];
        TV_Con16.backgroundColor = [UIColor clearColor];
        TV_Con16.font = [UIFont systemFontOfSize:14];
        [articleView addSubview:TV_Con16];
        [article_Contents_Arr addObject:TV_Con16];
        
        UIExpandingTextView * TV_Con17 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(795, 477, 105, 35)];
        TV_Con17.backgroundColor = [UIColor clearColor];
        TV_Con17.font = [UIFont systemFontOfSize:14];
        [articleView addSubview:TV_Con17];
        [article_Contents_Arr addObject:TV_Con17];
        
        UIExpandingTextView * TV_Con18 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(753, 548, 105, 35)];
        TV_Con18.backgroundColor = [UIColor clearColor];
        TV_Con18.font = [UIFont systemFontOfSize:14];
        [articleView addSubview:TV_Con18];
        [article_Contents_Arr addObject:TV_Con18];
        
        UIExpandingTextView * TV_Con19 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(695, 613, 105, 35)];
        TV_Con19.backgroundColor = [UIColor clearColor];
        TV_Con19.font = [UIFont systemFontOfSize:14];
        [articleView addSubview:TV_Con19];
        [article_Contents_Arr addObject:TV_Con19];
        
        UIExpandingTextView * TV_Con20 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(604, 674, 105, 35)];
        TV_Con20.backgroundColor = [UIColor clearColor];
        TV_Con20.font = [UIFont systemFontOfSize:14];
        [articleView addSubview:TV_Con20];
        [article_Contents_Arr addObject:TV_Con20];
        
        UIExpandingTextView * TV_Con21 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(428, 213, 105, 35)];
        TV_Con21.backgroundColor = [UIColor clearColor];
        TV_Con21.font = [UIFont systemFontOfSize:14];
        [articleView addSubview:TV_Con21];
        [article_Contents_Arr addObject:TV_Con21];
        
        UIExpandingTextView * TV_Con22 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(584, 213, 105, 35)];
        TV_Con22.backgroundColor = [UIColor clearColor];
        TV_Con22.font = [UIFont systemFontOfSize:14];
        [articleView addSubview:TV_Con22];
        [article_Contents_Arr addObject:TV_Con22];
        
        UIExpandingTextView * TV_Con23 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(428, 540, 105, 35)];
        TV_Con23.backgroundColor = [UIColor clearColor];
        TV_Con23.font = [UIFont systemFontOfSize:14];
        [articleView addSubview:TV_Con23];
        [article_Contents_Arr addObject:TV_Con23];
        
        UIExpandingTextView * TV_Con24 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(584, 540, 105, 35)];
        TV_Con24.backgroundColor = [UIColor clearColor];
        TV_Con24.font = [UIFont systemFontOfSize:14];
        [articleView addSubview:TV_Con24];
        [article_Contents_Arr addObject:TV_Con24];
        
        UIExpandingTextView * TV_Con25 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(492, 342, 135, 105)];
        TV_Con25.backgroundColor = [UIColor clearColor];
        TV_Con25.font = [UIFont systemFontOfSize:14];
        [articleView addSubview:TV_Con25];
        [article_Contents_Arr addObject:TV_Con25];
        
    }
    
    NSArray * articleContents = [gousiDict valueForKey:@"articleContents"];
    
    for (int i = 0; i < [articleContents count]; i++) {
        UIExpandingTextView * contentTextView = [article_Contents_Arr objectAtIndex:i];
        contentTextView.text = [articleContents[i] valueForKey:@"articleContent"];
    }
    
    
    
}



-(IBAction)submitWorkClick:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定提交？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alert setTag:kTagWorkCommitButton];
    [alert show];
    [alert release];
}

-(void)submitWork {
    
    NSMutableArray * articleContentsArray = [[NSMutableArray alloc]init];
    for (UIExpandingTextView * item in article_Contents_Arr) {
        NSDictionary * item_dic = [[NSDictionary alloc]initWithObjectsAndKeys:item.text, @"articleContent",nil];
        [articleContentsArray addObject:item_dic];
        
    }
    
    NSMutableArray * articleCommentsArray = [[NSMutableArray alloc]init];
    for (UIExpandingTextView * item in article_Comments_Arr) {
        NSDictionary * item_dic = [[NSDictionary alloc]initWithObjectsAndKeys:item.text, @"articleComment",nil];
        [articleCommentsArray addObject:item_dic];
    }
    
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M015" forKey:@"method"];
    [requestDict setValue:[self.unitDict valueForKey:@"courseId"] forKey:@"courseId"];
    [requestDict setValue:[self.unitDict valueForKey:@"classId"] forKey:@"classId"];
    [requestDict setValue:[self.unitDict valueForKey:@"gradeId"] forKey:@"gradeId"];
    [requestDict setValue:[self.unitDict valueForKey:@"articleType"] forKey:@"articleType"];
    [requestDict setValue:[self.unitDict valueForKey:@"moduleId"] forKey:@"moduleId"];
    [requestDict setValue:[self.unitDict valueForKey:@"unitId"] forKey:@"unitId"];
    [requestDict setValue:[self.unitDict valueForKey:@"authorId"] forKey:@"userId"];
    [requestDict setValue:[TF_Draft_Title text] forKey:@"articleTitle"];
    [requestDict setValue:[TV_Draft_Content text] forKey:@"articleDraft"];
    [requestDict setValue:[articleContentsArray JSONString] forKey:@"articleContents"];
    [requestDict setValue:[articleCommentsArray JSONString] forKey:@"articleComments"];
    
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}




-(IBAction)backClick:(id)sender
{
    //[self submitWork];
    [self.navigationController popViewControllerAnimated:YES];
}


@end