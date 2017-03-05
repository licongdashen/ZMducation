#define IOS7 [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0

#import "ZMMdlCmpVCtrl.h"
@implementation ZMMdlCmpVCtrl

-(void)addCommentView
{
    article_Comments_Arr = [[NSMutableArray alloc]init];

    {
        UIImage* article_Comment_01_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bg_comment_01" ofType:@"png"]];
        UIImageView* article_Comment_01_View = [[UIImageView alloc] initWithFrame:CGRectMake(813, 90, 185, 111)];
        [article_Comment_01_View setImage:article_Comment_01_Image];
        [articleView addSubview:article_Comment_01_View];
        [article_Comment_01_View release];
        
        UIImage* article_Comment_02_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bg_comment_02" ofType:@"png"]];
        UIImageView* article_Comment_02_View = [[UIImageView alloc] initWithFrame:CGRectMake(813, 555, 186, 112)];
        [article_Comment_02_View setImage:article_Comment_02_Image];
        [articleView addSubview:article_Comment_02_View];
        [article_Comment_02_View release];
      
    }
    
    UIExpandingTextView * TV_Bk1 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(860, 102, 125, 82)];
    TV_Bk1.font = [UIFont systemFontOfSize:18];
    TV_Bk1.backgroundColor = [UIColor clearColor];
    [articleView addSubview:TV_Bk1];
    [article_Comments_Arr addObject:TV_Bk1];
    //[TV_Bk1 release];
    
    UIExpandingTextView * TV_Bk2 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(860, 567, 125, 82)];
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
    {
        UIImageView * IV_Bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
        IV_Bg.image = [UIImage imageNamed:@"bg_differ.png"];
        [articleView addSubview:IV_Bg];
        [IV_Bg release];
    }
    TF_Draft_Title   = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(25, 85, 234, 55)];
    TF_Draft_Title.font = [UIFont systemFontOfSize:18];
    TF_Draft_Title.backgroundColor = [UIColor clearColor];

    TF_Draft_Title.text = @"";
    [articleView addSubview:TF_Draft_Title];
    
    TV_Draft_Content = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(25, 170, 234, 565)];
    TV_Draft_Content.backgroundColor = [UIColor clearColor];
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
        UIExpandingTextView * TV_Cmp1 = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(335, 245, 125, 250)];
        TV_Cmp1.backgroundColor = [UIColor clearColor];

        [TV_Cmp1 setFont:[UIFont boldSystemFontOfSize:18]];
        [articleView addSubview:TV_Cmp1];
        [article_Contents_Arr addObject:TV_Cmp1];
        if (self.type == 2 || self.type == 3) {
            [TV_Cmp1 setEditable:NO];
        }
        
        UIExpandingTextView * TV_Cmp2 = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(536, 245, 123, 250)];
        TV_Cmp2.backgroundColor = [UIColor clearColor];

        [TV_Cmp2 setFont:[UIFont boldSystemFontOfSize:18]];
        [articleView addSubview:TV_Cmp2];
        [article_Contents_Arr addObject:TV_Cmp2];
        if (self.type == 2 || self.type == 3) {
            [TV_Cmp2 setEditable:NO];
        }
        
        UIExpandingTextView * TV_Cmp3 = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(730, 245, 110, 250)];
        TV_Cmp3.backgroundColor = [UIColor clearColor];

        [TV_Cmp3 setFont:[UIFont boldSystemFontOfSize:18]];
        [articleView addSubview:TV_Cmp3];
        [article_Contents_Arr addObject:TV_Cmp3];
        if (self.type == 2 || self.type == 3) {
            [TV_Cmp3 setEditable:NO];
        }
    }
    
    NSArray * articleContents = [gousiDict valueForKey:@"articleContents"];
    for (int i = 0; i < [articleContents count]; i++) {
         UIExpandingTextView * contentTextView = [article_Contents_Arr objectAtIndex:i];
        contentTextView.text = [articleContents[i] valueForKey:@"articleContent"];
    }

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

-(IBAction)submitWorkClick:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定提交？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alert setTag:kTagWorkCommitButton];
    [alert show];
    [alert release];
}

@end
