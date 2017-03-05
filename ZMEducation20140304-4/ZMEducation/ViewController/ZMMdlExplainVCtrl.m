#define IOS7 [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0

#import "ZMMdlExplainVCtrl.h"

@implementation ZMMdlExplainVCtrl

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
        UIImageView* article_Comment_02_View = [[UIImageView alloc] initWithFrame:CGRectMake(845, 560, 167, 100)];
        [article_Comment_02_View setImage:article_Comment_02_Image];
        [articleView addSubview:article_Comment_02_View];
        [article_Comment_02_View release];
    }
    
    UIExpandingTextView *TV_Bk1 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(885, 80, 125, 82)];
    TV_Bk1.font = [UIFont systemFontOfSize:18];
    TV_Bk1.backgroundColor = [UIColor clearColor];
    [articleView addSubview:TV_Bk1];
    [article_Comments_Arr addObject:TV_Bk1];
    //[TV_Bk1 release];
    
    UIExpandingTextView * TV_Bk2 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(885, 572, 125, 82)];
    TV_Bk2.font = [UIFont systemFontOfSize:18];
    TV_Bk2.backgroundColor = [UIColor clearColor];
    [articleView addSubview:TV_Bk2];
    [article_Comments_Arr addObject:TV_Bk2];
    //[TV_Bk2 release];
    
   
    NSArray * articleComments = [gousiDict valueForKey:@"articleComments"];
    
    for (int i = 0; i < [articleComments count]; i++) {
        UIExpandingTextView * commentTextView = [article_Comments_Arr objectAtIndex:i];
        commentTextView.text = [articleComments[i] valueForKey:@"articleComment"];
    }
    
  
}

-(void)addDraftView
{
    
    UIImageView * IV_Bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    IV_Bg.image = [UIImage imageNamed:@"bg_chanshiwen.png"];
    [articleView addSubview:IV_Bg];
    
    TF_Draft_Title   = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(25, 85, 180, 55)];
    [articleView addSubview:TF_Draft_Title];
    TV_Draft_Content = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(25, 175, 180, 565)];
    TV_Draft_Content.font = [UIFont systemFontOfSize:18];
    [articleView addSubview:TV_Draft_Content];
    
    TF_Draft_Title.text = [gousiDict valueForKey:@"title"];
    TV_Draft_Content.text = [gousiDict valueForKey:@"articleDraft"];
    
    
}


-(void)addContentView
{
    [super addContentView];

    article_Contents_Arr = [[NSMutableArray alloc]init];
       
    {
        
        
        UIExpandingTextView * TV_Exp1 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(324, 89, 169, 133)];
        TV_Exp1.backgroundColor = [UIColor clearColor];
        TV_Exp1.font = [UIFont systemFontOfSize:18];
        [article_Contents_Arr addObject:TV_Exp1];
        [articleView addSubview:TV_Exp1];
        
        UIExpandingTextView *TV_Exp2 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(626, 89, 169, 133)];
        TV_Exp2.backgroundColor = [UIColor clearColor];
        TV_Exp2.font = [UIFont systemFontOfSize:18];
        [article_Contents_Arr addObject:TV_Exp2];
        [articleView addSubview:TV_Exp2];
        
        UIExpandingTextView *TV_Exp3 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(470, 336, 169, 133)];
        TV_Exp3.backgroundColor = [UIColor clearColor];
        TV_Exp3.font = [UIFont systemFontOfSize:18];
        [article_Contents_Arr addObject:TV_Exp3];
        [articleView addSubview:TV_Exp3];
        
        UIExpandingTextView *TV_Exp4 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(239, 269, 158, 100)];
        TV_Exp4.backgroundColor = [UIColor clearColor];
        TV_Exp4.font = [UIFont systemFontOfSize:18];
        [articleView addSubview:TV_Exp4];
        [article_Contents_Arr addObject:TV_Exp4];
        
        UIExpandingTextView *TV_Exp5 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(734, 269, 158, 100)];
        TV_Exp5.backgroundColor = [UIColor clearColor];
        TV_Exp5.font = [UIFont systemFontOfSize:18];
        [articleView addSubview:TV_Exp5];
        [article_Contents_Arr addObject:TV_Exp5];
        
        UIExpandingTextView *TV_Exp6 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(239, 428, 158, 100)];
        TV_Exp6.backgroundColor = [UIColor clearColor];
        TV_Exp6.font = [UIFont systemFontOfSize:18];
        [articleView addSubview:TV_Exp6];
        [article_Contents_Arr addObject:TV_Exp6];
        
        UIExpandingTextView *TV_Exp7 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(734, 428, 158, 100)];
        TV_Exp7.backgroundColor = [UIColor clearColor];
        TV_Exp7.font = [UIFont systemFontOfSize:18];
        [articleView addSubview:TV_Exp7];
        [article_Contents_Arr addObject:TV_Exp7];
        
        UIExpandingTextView *TV_Exp8 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(324, 581, 169, 133)];
        TV_Exp8.backgroundColor = [UIColor clearColor];
        TV_Exp8.font = [UIFont systemFontOfSize:18];
        [articleView addSubview:TV_Exp8];
        [article_Contents_Arr addObject:TV_Exp8];
        
        UIExpandingTextView *TV_Exp9 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(626, 581, 169, 133)];
        TV_Exp9.backgroundColor = [UIColor clearColor];
        TV_Exp9.font = [UIFont systemFontOfSize:18];
        [articleView addSubview:TV_Exp9];
        [article_Contents_Arr addObject:TV_Exp9];
        
        
        
        
        
    }
    
    NSArray * articleContents = [gousiDict valueForKey:@"articleContents"];
    
    
    for (int i = 0; i < [articleContents count]; i++) {
        UIExpandingTextView * contentTextView = [article_Contents_Arr objectAtIndex:i];
        contentTextView.text = [articleContents[i] valueForKey:@"articleContent"];
        if (self.type == 2 || self.type == 3) {
            [contentTextView setEditable:NO];
        }
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
    
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:20];
    [requestDict setValue:@"M015" forKey:@"method"];
    [requestDict setValue:[self.unitDict valueForKey:@"courseId"] forKey:@"courseId"];
    [requestDict setValue:[self.unitDict valueForKey:@"classId"] forKey:@"classId"];
    [requestDict setValue:[self.unitDict valueForKey:@"gradeId"] forKey:@"gradeId"];
    [requestDict setValue:[self.unitDict valueForKey:@"articleType"] forKey:@"articleType"];
    [requestDict setValue:[self.unitDict valueForKey:@"moduleId"] forKey:@"moduleId"];
    [requestDict setValue:[self.unitDict valueForKey:@"unitId"] forKey:@"unitId"];
    [requestDict setValue:[self.unitDict valueForKey:@"authorId"] forKey:@"userId"];
    [requestDict setValue:[TF_Draft_Title text] forKey:@"articleTitle"];
    [requestDict setValue:TV_Draft_Content.text forKey:@"articleDraft"];
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
    [self.navigationController popViewControllerAnimated:YES];
}

@end
