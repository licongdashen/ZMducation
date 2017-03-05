#define IOS7 [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0

#import "ZMMdlStoryVCtrl.h"


@implementation ZMMdlStoryVCtrl


-(void)addDraftView
{
    
    UIImageView * IV_Bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    IV_Bg.image = [UIImage imageNamed:@"bg_story.png"];
    [articleView addSubview:IV_Bg];
    
}

-(void)addCommentView{}

-(void)addContentView
{
    [super addContentView];

    
    left_column_Arr = [[NSMutableArray alloc]init];
    right_column_Arr = [[NSMutableArray alloc]init];
    
 
    {
        
        UILabel * LB_left_column_01 = [[UILabel alloc] initWithFrame:CGRectMake(35, 115, 300, 65)];
        LB_left_column_01.backgroundColor = [UIColor clearColor];
        LB_left_column_01.text = @"";
        [left_column_Arr addObject:LB_left_column_01];
        [articleView addSubview:LB_left_column_01];
        
        UILabel * LB_left_column_02 = [[UILabel alloc] initWithFrame:CGRectMake(35, 177, 300, 65)];
        LB_left_column_02.backgroundColor = [UIColor clearColor];
        LB_left_column_02.text = @"";
        [left_column_Arr addObject:LB_left_column_02];
        [articleView addSubview:LB_left_column_02];
        
        UILabel * LB_left_column_03 = [[UILabel alloc] initWithFrame:CGRectMake(35, 242, 300, 65)];
        LB_left_column_03.backgroundColor = [UIColor clearColor];
        LB_left_column_03.text = @"";
        [left_column_Arr addObject:LB_left_column_03];
        [articleView addSubview:LB_left_column_03];
        
        UILabel * LB_left_column_04 = [[UILabel alloc] initWithFrame:CGRectMake(35, 307, 300, 65)];
        LB_left_column_04.backgroundColor = [UIColor clearColor];
        LB_left_column_04.text = @"";
        [left_column_Arr addObject:LB_left_column_04];
        [articleView addSubview:LB_left_column_04];
        
        UILabel * LB_left_column_05 = [[UILabel alloc] initWithFrame:CGRectMake(35, 372, 300, 65)];
        LB_left_column_05.backgroundColor = [UIColor clearColor];
        LB_left_column_05.text = @"";
        [left_column_Arr addObject:LB_left_column_05];
        [articleView addSubview:LB_left_column_05];
        
        UILabel * LB_left_column_06 = [[UILabel alloc] initWithFrame:CGRectMake(35, 437, 300, 65)];
        LB_left_column_06.backgroundColor = [UIColor clearColor];
        LB_left_column_06.text = @"";
        [left_column_Arr addObject:LB_left_column_06];
        [articleView addSubview:LB_left_column_06];
        
        UILabel * LB_left_column_07 = [[UILabel alloc] initWithFrame:CGRectMake(35, 502, 300, 65)];
        LB_left_column_07.backgroundColor = [UIColor clearColor];
        LB_left_column_07.text = @"";
        [left_column_Arr addObject:LB_left_column_07];
        [articleView addSubview:LB_left_column_07];
        
        UILabel * LB_left_column_08 = [[UILabel alloc] initWithFrame:CGRectMake(35, 569, 300, 65)];
        LB_left_column_08.backgroundColor = [UIColor clearColor];
        LB_left_column_08.text = @"";
        [left_column_Arr addObject:LB_left_column_08];
        [articleView addSubview:LB_left_column_08];
    }
    { 
        UIExpandingTextView *TV_right1 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(335, 115, 635, 65)];
        TV_right1.font = [UIFont systemFontOfSize:18];
        TV_right1.backgroundColor = [UIColor clearColor];
        
        [articleView addSubview:TV_right1];
        [right_column_Arr addObject:TV_right1];
        
        UIExpandingTextView *TV_right2 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(335, 177, 635, 65)];
        TV_right2.font = [UIFont systemFontOfSize:18];
        TV_right2.backgroundColor = [UIColor clearColor];
        [articleView addSubview:TV_right2];
        [right_column_Arr addObject:TV_right2];
        
        UIExpandingTextView *TV_right3 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(335, 242, 635, 65)];
        TV_right3.font = [UIFont systemFontOfSize:18];
        TV_right3.backgroundColor = [UIColor clearColor];
        [articleView addSubview:TV_right3];
        [right_column_Arr addObject:TV_right3];
        
        UIExpandingTextView *TV_right4 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(335, 307, 635, 65)];
        TV_right4.font = [UIFont systemFontOfSize:18];
        TV_right4.backgroundColor = [UIColor clearColor];
        [articleView addSubview:TV_right4];
        [right_column_Arr addObject:TV_right4];
        
        UIExpandingTextView *TV_right5 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(335, 372, 635, 65)];
        TV_right5.font = [UIFont systemFontOfSize:18];
        TV_right5.backgroundColor = [UIColor clearColor];
        [articleView addSubview:TV_right5];
        [right_column_Arr addObject:TV_right5];
        
        UIExpandingTextView *TV_right6 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(335, 437, 635, 65)];
        TV_right6.font = [UIFont systemFontOfSize:18];
        TV_right6.backgroundColor = [UIColor clearColor];
        [articleView addSubview:TV_right6];
        [right_column_Arr addObject:TV_right6];
        
        UIExpandingTextView *TV_right7 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(335, 502, 635, 65)];
        TV_right7.font = [UIFont systemFontOfSize:18];
        TV_right7.backgroundColor = [UIColor clearColor];
        [articleView addSubview:TV_right7];
        [right_column_Arr addObject:TV_right7];
        
        UIExpandingTextView *TV_right8 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(335, 569, 635, 65)];
        TV_right8.font = [UIFont systemFontOfSize:18];
        TV_right5.backgroundColor = [UIColor clearColor];
        [articleView addSubview:TV_right8];
        [right_column_Arr addObject:TV_right8];
    
    }
   
    
    NSArray * leftColumnTitles = [gousiDict valueForKey:@"field1"];
    
    for (int i = 0; i < [leftColumnTitles count]; i++) {
        UILabel * contentlabel = [left_column_Arr objectAtIndex:i];
        contentlabel.text = leftColumnTitles[i] ;
    }
    NSArray * articleComments = [gousiDict valueForKey:@"articleComments"];
    
    
    for (int i = 0; i < [articleComments count]; i++) {
        UIExpandingTextView * commentTextView = [right_column_Arr objectAtIndex:i];
        commentTextView.text = [articleComments[i] valueForKey:@"articleComment"];
        if (self.type == 2 || self.type == 3) {
            [commentTextView setEditable:NO];
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
    for (UILabel * item in left_column_Arr) {
        NSDictionary * item_dic = [[NSDictionary alloc]initWithObjectsAndKeys:item.text, @"articleContent",nil];
        [articleContentsArray addObject:item_dic];
        
    }
    
    NSMutableArray * articleCommentsArray = [[NSMutableArray alloc]init];
    for (UIExpandingTextView * item in right_column_Arr) {
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
    [requestDict setValue:@"" forKey:@"articleTitle"];
    [requestDict setValue:@"" forKey:@"articleDraft"];
    [requestDict setValue:[articleContentsArray JSONString] forKey:@"articleContents"];
    [requestDict setValue:[articleCommentsArray JSONString] forKey:@"articleComments"];
    
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
    
}






@end
