#define IOS7 [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0

#import "ZMMdlTopicVCtrl.h"

@implementation ZMMdlTopicVCtrl

-(void)addDraftView
{
    
    UIImageView * IV_Bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    IV_Bg.image = [UIImage imageNamed:@"bg_topic.png"];
    [articleView addSubview:IV_Bg];

    
}

-(void)addCommentView{}

-(void)addContentView
{
    title_label_arr = [[NSMutableArray alloc]init];
    bake_label_arr = [[NSMutableArray alloc]init];
    comment_btn_arr = [[NSMutableArray alloc]init];
  
    
    {
        
        UILabel * LB_Bake = [[UILabel alloc]initWithFrame:CGRectMake(27, 85, 485, 50)];
        LB_Bake.text = @"注释：如果该童话包含这个主题就打“√”";
        LB_Bake.backgroundColor = [UIColor clearColor];
        [articleView addSubview:LB_Bake];
        [LB_Bake release];
     
    }
    {
        UILabel * tt_lb_01 = [[UILabel alloc]initWithFrame:CGRectMake(25, 190, 178, 44)];
        tt_lb_01.backgroundColor = [UIColor clearColor];
        [articleView addSubview:tt_lb_01];
        [title_label_arr addObject:tt_lb_01];
        
        UILabel * tt_lb_02 = [[UILabel alloc]initWithFrame:CGRectMake(25, 234, 178, 44)];
        tt_lb_02.backgroundColor = [UIColor clearColor];
        [articleView addSubview:tt_lb_02];
        [title_label_arr addObject:tt_lb_02];
        
        UILabel * tt_lb_03 = [[UILabel alloc]initWithFrame:CGRectMake(25, 278, 178, 44)];
        tt_lb_03.backgroundColor = [UIColor clearColor];
        [articleView addSubview:tt_lb_03];
        [title_label_arr addObject:tt_lb_03];
        
        UILabel * tt_lb_04 = [[UILabel alloc]initWithFrame:CGRectMake(25, 322, 178, 44)];
        tt_lb_04.backgroundColor = [UIColor clearColor];
        [articleView addSubview:tt_lb_04];
        [title_label_arr addObject:tt_lb_04];
        
        UILabel * tt_lb_05 = [[UILabel alloc]initWithFrame:CGRectMake(25, 366, 178, 44)];
        tt_lb_05.backgroundColor = [UIColor clearColor];
        [articleView addSubview:tt_lb_05];
        [title_label_arr addObject:tt_lb_05];
        
        UILabel * tt_lb_06 = [[UILabel alloc]initWithFrame:CGRectMake(25, 410, 178, 44)];
        tt_lb_06.backgroundColor = [UIColor clearColor];
        [articleView addSubview:tt_lb_06];
        [title_label_arr addObject:tt_lb_06];
        
        UILabel * tt_lb_07 = [[UILabel alloc]initWithFrame:CGRectMake(25, 454, 178, 44)];
        tt_lb_07.backgroundColor = [UIColor clearColor];
        [articleView addSubview:tt_lb_07];
        [title_label_arr addObject:tt_lb_07];
        
        UILabel * tt_lb_08 = [[UILabel alloc]initWithFrame:CGRectMake(25, 498, 178, 44)];
        tt_lb_08.backgroundColor = [UIColor clearColor];
        [articleView addSubview:tt_lb_08];
        [title_label_arr addObject:tt_lb_08];
    
    }
    
    {
        UILabel * bk_lb_01 = [[UILabel alloc]initWithFrame:CGRectMake(233, 547, 315, 30)];
        bk_lb_01.backgroundColor = [UIColor clearColor];
        [articleView addSubview:bk_lb_01];
        [bake_label_arr addObject:bk_lb_01];
        
        UILabel * bk_lb_02 = [[UILabel alloc]initWithFrame:CGRectMake(560, 547, 315, 30)];
        bk_lb_02.backgroundColor = [UIColor clearColor];
        [articleView addSubview:bk_lb_02];
        [bake_label_arr addObject:bk_lb_02];
        
        UILabel * bk_lb_03 = [[UILabel alloc]initWithFrame:CGRectMake(233, 577, 315, 30)];
        bk_lb_03.backgroundColor = [UIColor clearColor];
        [articleView addSubview:bk_lb_03];
        [bake_label_arr addObject:bk_lb_03];
        
        UILabel * bk_lb_04 = [[UILabel alloc]initWithFrame:CGRectMake(560, 577, 315, 30)];
        bk_lb_04.backgroundColor = [UIColor clearColor];
        [articleView addSubview:bk_lb_04];
        [bake_label_arr addObject:bk_lb_04];
        
        UILabel * bk_lb_05 = [[UILabel alloc]initWithFrame:CGRectMake(233, 607, 315, 30)];
        bk_lb_05.backgroundColor = [UIColor clearColor];
        [articleView addSubview:bk_lb_05];
        [bake_label_arr addObject:bk_lb_05];
        
        UILabel * bk_lb_06 = [[UILabel alloc]initWithFrame:CGRectMake(560, 607, 315, 30)];
        bk_lb_06.backgroundColor = [UIColor clearColor];
        [articleView addSubview:bk_lb_06];
        [bake_label_arr addObject:bk_lb_06];
        
        UILabel * bk_lb_07 = [[UILabel alloc]initWithFrame:CGRectMake(233, 637, 315, 30)];
        bk_lb_07.backgroundColor = [UIColor clearColor];
        [articleView addSubview:bk_lb_07];
        [bake_label_arr addObject:bk_lb_07];
        
        UILabel * bk_lb_08 = [[UILabel alloc]initWithFrame:CGRectMake(560, 637, 315, 30)];
        bk_lb_08.backgroundColor = [UIColor clearColor];
        [articleView addSubview:bk_lb_08];
        [bake_label_arr addObject:bk_lb_08];
    }
    
  
    
    {

        NSMutableArray * row_arr = [[NSMutableArray alloc]init];
        for (int i = 0 , m = 0; i < 8; i++) {
            
            UIButton* shareBut = [UIButton buttonWithType:UIButtonTypeCustom];
            [shareBut setFrame:CGRectMake(250 + i * 95, 200 + m * 44, 25, 25)];
            [shareBut setSelected:NO];
            [shareBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Btn" ofType:@"png"]] forState:UIControlStateNormal];
            [shareBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
            [shareBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Select_Btn" ofType:@"png"]] forState:UIControlStateSelected];
            [shareBut addTarget:self
                         action:@selector(shareClick:)
               forControlEvents:UIControlEventTouchUpInside];
            [articleView addSubview:shareBut];
            [row_arr addObject:shareBut];
            if (self.type == 2 || self.type == 3) {
                [shareBut setEnabled:NO];
            }
            
            
            if (m < 7) {
                if(i == 7)
                {
                    [comment_btn_arr addObject:[NSArray arrayWithArray:row_arr]];
                    [row_arr removeAllObjects];
                    i = -1;
                    m ++ ;
                }
            }
            if (m == 7 && i == 7 ) {
                [comment_btn_arr addObject:[NSArray arrayWithArray:row_arr]];
                [row_arr removeAllObjects];
            }
                    
        }
    }
    
    
    
    NSArray * titleArr = [gousiDict valueForKey:@"field1"];
    NSArray * bakeArr = [gousiDict valueForKey:@"field2"];
    NSArray * commentArr = [gousiDict valueForKey:@"articleComments"];
    
    for (int i = 0; i < [titleArr count]; i++) {
        UILabel * item = (UILabel *)[title_label_arr objectAtIndex:i];
        item.text = titleArr[i];
    }
    
    for (int i = 0; i < [bakeArr count]; i++) {
        UILabel * item = (UILabel *)[bake_label_arr objectAtIndex:i];
        item.text = bakeArr[i];
    }
    
    for (int i = 0; i < [commentArr count]; i++) {
        NSArray * rowArr = [[commentArr[i] valueForKey:@"articleComment"] componentsSeparatedByString:@","];
        NSArray * btnArr = comment_btn_arr[i];
        for (int k = 0; k < [rowArr count]; k++) {
            if ([rowArr[k] intValue] == 1) {
                [btnArr[k] setSelected:YES];
            }
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
    
    NSMutableArray * articleCommentsArray = [[NSMutableArray alloc]init];
    for (NSArray * item in comment_btn_arr) {
        
        NSMutableArray * valueArr = [[NSMutableArray alloc]init];
        for (int i = 0; i < [item count]; i ++) {
            UIButton * btn = (UIButton *) item[i];
            int k = (btn.selected) ? 1 : 0 ;
            [valueArr addObject:[NSString stringWithFormat:@"%d",k]];
        }
        
        NSDictionary * item_dic = [[NSDictionary alloc]initWithObjectsAndKeys:[valueArr componentsJoinedByString:@","], @"articleComment",nil];
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