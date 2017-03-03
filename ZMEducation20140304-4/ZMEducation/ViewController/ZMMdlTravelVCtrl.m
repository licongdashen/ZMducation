#define IOS7 [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0

#import "ZMMdlTravelVCtrl.h"


@implementation ZMMdlTravelVCtrl


-(void)addCommentView
{
}

-(void)addDraftView
{
    
    UIImageView * IV_Bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    IV_Bg.image = [UIImage imageNamed:@"bg_travel.png"];
    [articleView addSubview:IV_Bg];
    
}


-(void)addContentView
{
    [super addContentView];

    title_column_Arr = [[NSMutableArray alloc]init];
    title_row_Arr = [[NSMutableArray alloc]init];
    textView_Arr = [[NSMutableArray alloc]init];
    
     
    
    
    //行&列
    {
        //00
        UILabel * lb_title_01 = [[UILabel alloc]initWithFrame:CGRectMake(28, 110, 155, 60)];
        lb_title_01.backgroundColor = [UIColor clearColor];
        [articleView addSubview:lb_title_01];
        [title_column_Arr addObject:lb_title_01];
         //01
        UILabel * lb_title_02 = [[UILabel alloc]initWithFrame:CGRectMake(28, 173, 155, 60)];
        lb_title_02.backgroundColor = [UIColor clearColor];
        [articleView addSubview:lb_title_02];
        [title_column_Arr addObject:lb_title_02];
        //02
        UILabel * lb_title_03 = [[UILabel alloc]initWithFrame:CGRectMake(28, 236, 155, 60)];
        lb_title_03.backgroundColor = [UIColor clearColor];
        [articleView addSubview:lb_title_03];
        [title_column_Arr addObject:lb_title_03];
        //03
        UILabel * lb_title_04 = [[UILabel alloc]initWithFrame:CGRectMake(28, 299, 155, 60)];
        lb_title_04.backgroundColor = [UIColor clearColor];
        [articleView addSubview:lb_title_04];
        [title_column_Arr addObject:lb_title_04];
        //04
        UILabel * lb_title_05 = [[UILabel alloc]initWithFrame:CGRectMake(28, 362, 155, 60)];
        lb_title_05.backgroundColor = [UIColor clearColor];
        [articleView addSubview:lb_title_05];
        [title_column_Arr addObject:lb_title_05];
        //05
        UILabel * lb_title_06 = [[UILabel alloc]initWithFrame:CGRectMake(28, 425, 155, 60)];
        lb_title_06.backgroundColor = [UIColor clearColor];
        [articleView addSubview:lb_title_06];
        [title_column_Arr addObject:lb_title_06];
        //06
        UILabel * lb_title_07 = [[UILabel alloc]initWithFrame:CGRectMake(28, 488, 155, 60)];
        lb_title_07.backgroundColor = [UIColor clearColor];
        [articleView addSubview:lb_title_07];
        [title_column_Arr addObject:lb_title_07];
        //07
        UILabel * lb_title_08 = [[UILabel alloc]initWithFrame:CGRectMake(28, 551, 155, 60)];
        lb_title_08.backgroundColor = [UIColor clearColor];
        [articleView addSubview:lb_title_08];
        [title_column_Arr addObject:lb_title_08];
        
        
        //10
        UILabel * lb_title_09 = [[UILabel alloc]initWithFrame:CGRectMake(190, 110, 215, 60)];
        lb_title_09.backgroundColor = [UIColor clearColor];
        [articleView addSubview:lb_title_09];
        [title_row_Arr addObject:lb_title_09];
        //20
        UILabel * lb_title_10 = [[UILabel alloc]initWithFrame:CGRectMake(410, 110, 185, 60)];
        lb_title_10.backgroundColor = [UIColor clearColor];
        [articleView addSubview:lb_title_10];
        [title_row_Arr addObject:lb_title_10];
        //30
        UILabel * lb_title_11 = [[UILabel alloc]initWithFrame:CGRectMake(600, 110, 205, 60)];
        lb_title_11.backgroundColor = [UIColor clearColor];
        [articleView addSubview:lb_title_11];
        [title_row_Arr addObject:lb_title_11];
        //40
        UILabel * lb_title_12 = [[UILabel alloc]initWithFrame:CGRectMake(810, 110, 180, 60)];
        lb_title_12.backgroundColor = [UIColor clearColor];
        [articleView addSubview:lb_title_12];
        [title_row_Arr addObject:lb_title_12];
 
    }
    //textview
    {
        //第2行
        UIExpandingTextView * tv_01 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(190, 180, 215, 60)];
        tv_01.backgroundColor = [UIColor clearColor];
        tv_01.font = [UIFont systemFontOfSize:18];
        [articleView addSubview:tv_01];
        [textView_Arr addObject:tv_01];
        
        UIExpandingTextView * tv_02 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(410, 180, 185, 60)];
        tv_02.backgroundColor = [UIColor clearColor];
        tv_02.font = [UIFont systemFontOfSize:18];
        [articleView addSubview:tv_02];
        [textView_Arr addObject:tv_02];
        
        UIExpandingTextView * tv_03 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(600, 180, 205, 60)];
        tv_03.backgroundColor = [UIColor clearColor];
        tv_03.font = [UIFont systemFontOfSize:18];
        [articleView addSubview:tv_03];
        [textView_Arr addObject:tv_03];
        
        UIExpandingTextView * tv_04 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(810, 180, 180, 60)];
        tv_04.backgroundColor = [UIColor clearColor];
        tv_04.font = [UIFont systemFontOfSize:18];
        [articleView addSubview:tv_04];
        [textView_Arr addObject:tv_04];
        
        //第3行
        UIExpandingTextView * tv_05 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(190, 244, 215, 60)];
        tv_05.backgroundColor = [UIColor clearColor];
        tv_05.font = [UIFont systemFontOfSize:18];
        [articleView addSubview:tv_05];
        [textView_Arr addObject:tv_05];
        
        UIExpandingTextView * tv_06 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(410, 244, 185, 60)];
        tv_06.backgroundColor = [UIColor clearColor];
        tv_06.font = [UIFont systemFontOfSize:18];
        [articleView addSubview:tv_06];
        [textView_Arr addObject:tv_06];
        
        UIExpandingTextView * tv_07 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(600, 244, 205, 60)];
        tv_07.backgroundColor = [UIColor clearColor];
        tv_07.font = [UIFont systemFontOfSize:18];
        [articleView addSubview:tv_07];
        [textView_Arr addObject:tv_07];
        
        UIExpandingTextView * tv_08 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(810, 244, 180, 60)];
        tv_08.backgroundColor = [UIColor clearColor];
        tv_08.font = [UIFont systemFontOfSize:18];
        [articleView addSubview:tv_08];
        [textView_Arr addObject:tv_08];
        
        //第4行
        UIExpandingTextView * tv_09 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(190, 309, 215, 60)];
        tv_09.backgroundColor = [UIColor clearColor];
        tv_09.font = [UIFont systemFontOfSize:18];
        [articleView addSubview:tv_09];
        [textView_Arr addObject:tv_09];
        
        UIExpandingTextView * tv_10 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(410, 309, 185, 60)];
        tv_10.backgroundColor = [UIColor clearColor];
        tv_10.font = [UIFont systemFontOfSize:18];
        [articleView addSubview:tv_10];
        [textView_Arr addObject:tv_10];
        
        UIExpandingTextView * tv_11 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(600, 309, 205, 60)];
        tv_11.backgroundColor = [UIColor clearColor];
        tv_11.font = [UIFont systemFontOfSize:18];
        [articleView addSubview:tv_11];
        [textView_Arr addObject:tv_11];
        
        UIExpandingTextView * tv_12 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(810, 309, 180, 60)];
        tv_12.backgroundColor = [UIColor clearColor];
        tv_12.font = [UIFont systemFontOfSize:18];
        [articleView addSubview:tv_12];
        [textView_Arr addObject:tv_12];
        
        //第5行
        UIExpandingTextView * tv_13 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(190, 377, 215, 60)];
        tv_13.backgroundColor = [UIColor clearColor];
        tv_13.font = [UIFont systemFontOfSize:18];
        [articleView addSubview:tv_13];
        [textView_Arr addObject:tv_13];
        
        UIExpandingTextView * tv_14 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(410, 377, 185, 60)];
        tv_14.backgroundColor = [UIColor clearColor];
        tv_14.font = [UIFont systemFontOfSize:18];
        [articleView addSubview:tv_14];
        [textView_Arr addObject:tv_14];
        
        UIExpandingTextView * tv_15 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(600, 377, 205, 60)];
        tv_15.backgroundColor = [UIColor clearColor];
        tv_15.font = [UIFont systemFontOfSize:18];
        [articleView addSubview:tv_15];
        [textView_Arr addObject:tv_15];
        
        UIExpandingTextView * tv_16 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(810, 377, 180, 60)];
        tv_16.backgroundColor = [UIColor clearColor];
        tv_16.font = [UIFont systemFontOfSize:18];
        [articleView addSubview:tv_16];
        [textView_Arr addObject:tv_16];
        
        //第6行
        UIExpandingTextView * tv_17 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(190, 444, 215, 60)];
        tv_17.backgroundColor = [UIColor clearColor];
        tv_17.font = [UIFont systemFontOfSize:18];
        [articleView addSubview:tv_17];
        [textView_Arr addObject:tv_17];
        
        UIExpandingTextView * tv_18 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(410, 444, 185, 60)];
        tv_18.backgroundColor = [UIColor clearColor];
        tv_18.font = [UIFont systemFontOfSize:18];
        [articleView addSubview:tv_18];
        [textView_Arr addObject:tv_18];
        
        UIExpandingTextView * tv_19 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(600, 444, 205, 60)];
        tv_19.backgroundColor = [UIColor clearColor];
        tv_19.font = [UIFont systemFontOfSize:18];
        [articleView addSubview:tv_19];
        [textView_Arr addObject:tv_19];
        
        UIExpandingTextView * tv_20 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(810, 444, 180, 60)];
        tv_20.backgroundColor = [UIColor clearColor];
        tv_20.font = [UIFont systemFontOfSize:18];
        [articleView addSubview:tv_20];
        [textView_Arr addObject:tv_20];
        
        //第7行
        UIExpandingTextView * tv_21 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(190, 508, 215, 60)];
        tv_21.backgroundColor = [UIColor clearColor];
        tv_21.font = [UIFont systemFontOfSize:18];
        [articleView addSubview:tv_21];
        [textView_Arr addObject:tv_21];
        
        UIExpandingTextView * tv_22 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(410, 508, 185, 60)];
        tv_22.backgroundColor = [UIColor clearColor];
        tv_22.font = [UIFont systemFontOfSize:18];
        [articleView addSubview:tv_22];
        [textView_Arr addObject:tv_22];
        
        UIExpandingTextView * tv_23 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(600, 508, 205, 60)];
        tv_23.backgroundColor = [UIColor clearColor];
        tv_23.font = [UIFont systemFontOfSize:18];
        [articleView addSubview:tv_23];
        [textView_Arr addObject:tv_23];
        
        UIExpandingTextView * tv_24 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(810, 508, 180, 60)];
        tv_24.backgroundColor = [UIColor clearColor];
        tv_24.font = [UIFont systemFontOfSize:18];
        [articleView addSubview:tv_24];
        [textView_Arr addObject:tv_24];
        
        //第8行
        UIExpandingTextView * tv_25 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(190, 573, 800, 60)];
        tv_25.backgroundColor = [UIColor clearColor];
        tv_25.font = [UIFont systemFontOfSize:18];
        [articleView addSubview:tv_25];
        [textView_Arr addObject:tv_25];

    }
    
    NSArray * topLabels = [gousiDict valueForKey:@"field2"];
    for (int i = 0; i < [topLabels count]; i++) {
        UILabel * itemLabel = [title_row_Arr objectAtIndex:i];
        itemLabel.text = topLabels[i];
    }
    
    NSArray * leftLabels  = [gousiDict valueForKey:@"field1"];
    for (int i = 0; i < [leftLabels count]; i++) {
        UILabel * itemLabel = [title_column_Arr objectAtIndex:i];
        itemLabel.text = leftLabels[i];
    }
    
    NSArray * articleComments = [gousiDict valueForKey:@"articleComments"];
    for (int i = 0; i < [articleComments count]; i++) {
        UIExpandingTextView * itemLabel = [textView_Arr objectAtIndex:i];
        itemLabel.text = [articleComments[i] valueForKey:@"articleComment"];
        if (self.type == 2 || self.type == 3) {
            [itemLabel setEditable:NO];
        }
    }
    
    
    
}

-(IBAction)backClick:(id)sender
{
    //[self submitWork];
    [self.navigationController popViewControllerAnimated:YES];
}


-(IBAction)submitWorkClick:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定提交？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alert setTag:kTagWorkCommitButton];
    [alert show];
    [alert release];
}


-(void)submitWork {
    
    
    NSMutableArray * articleCommentsArray = [[NSMutableArray alloc]init];
    for (UIExpandingTextView * item in textView_Arr) {
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
    [requestDict setValue:@"" forKey:@"articleContents"];
    [requestDict setValue:[articleCommentsArray JSONString] forKey:@"articleComments"];
    
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
    
}






@end
