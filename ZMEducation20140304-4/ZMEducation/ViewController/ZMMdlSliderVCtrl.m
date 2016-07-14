#define IOS7 [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0

#import "ZMMdlSliderVCtrl.h"

@implementation ZMMdlSliderVCtrl

-(void)addCommentView
{
    //NSArray* _articleCommentArray = [articleDict valueForKey:@"articleComment"];
    NSArray * topLabelTitles = [gousiDict valueForKey:@"field1"];
    
    //if ([topLabelTitles count] > 0) {
        for (int i = 0; i < [topLabelTitles count]; i++) {
            UILabel * itemLabel = [top_label_Arr objectAtIndex:i];
            itemLabel.text = topLabelTitles[i] ;
        }
    //}
    
    NSArray * articleComments = [gousiDict valueForKey:@"articleComments"];
    
    //if ([articleComments count] > 0) {
        for (int i = 0; i < [articleComments count]; i++) {
            UIExpandingTextView * commentTextView = [textView_Arr objectAtIndex:i];
            commentTextView.text = [articleComments[i] valueForKey:@"articleComment"];
            if (self.type == 2 || self.type == 3) {
                [commentTextView setEditable:NO];
            }
        }
    //}
    
    
}

-(void)addDraftView
{
    
        UIImageView * IV_Bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
        IV_Bg.image = [UIImage imageNamed:@"bg_slider.png"];
        [articleView addSubview:IV_Bg];
    
}


-(void)addContentView
    {
        top_label_Arr = [[NSMutableArray alloc]init];
        textView_Arr = [[NSMutableArray alloc]init];
        
        
        
        
        {
            
            UILabel * top_title_01 = [[UILabel alloc]initWithFrame:CGRectMake(30, 115, 125, 66)];
            top_title_01.backgroundColor = [UIColor clearColor];
            [articleView addSubview:top_title_01];
            [top_label_Arr addObject:top_title_01];
            
            UILabel * top_title_02 = [[UILabel alloc]initWithFrame:CGRectMake(165, 115, 125, 66)];
            top_title_02.backgroundColor = [UIColor clearColor];
            [articleView addSubview:top_title_02];
            [top_label_Arr addObject:top_title_02];
            
            UILabel * top_title_03 = [[UILabel alloc]initWithFrame:CGRectMake(305, 115, 125, 66)];
            top_title_03.backgroundColor = [UIColor clearColor];
            [articleView addSubview:top_title_03];
            [top_label_Arr addObject:top_title_03];
            
            UILabel * top_title_04 = [[UILabel alloc]initWithFrame:CGRectMake(432, 115, 200, 66)];
            top_title_04.backgroundColor = [UIColor clearColor];
            [articleView addSubview:top_title_04];
            [top_label_Arr addObject:top_title_04];
            
            UILabel * top_title_05 = [[UILabel alloc]initWithFrame:CGRectMake(635, 115, 200, 66)];
            top_title_05.backgroundColor = [UIColor clearColor];
            [articleView addSubview:top_title_05];
            [top_label_Arr addObject:top_title_05];
            
            UILabel * top_title_06 = [[UILabel alloc]initWithFrame:CGRectMake(834, 115, 155, 66)];
            top_title_06.backgroundColor = [UIColor clearColor];
            [articleView addSubview:top_title_06];
            [top_label_Arr addObject:top_title_06];
            
            //textview list
            
            //row 2
            UIExpandingTextView *TV_01 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(30, 190, 125, 66)];
            TV_01.font = [UIFont systemFontOfSize:18];
            TV_01.backgroundColor = [UIColor clearColor];
            [articleView addSubview:TV_01];
            [textView_Arr addObject:TV_01];
            
            
            UIExpandingTextView * TV_02 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(165, 190, 125, 66)];
            TV_02.font = [UIFont systemFontOfSize:18];
            TV_02.backgroundColor = [UIColor clearColor];
            [articleView addSubview:TV_02];
            [textView_Arr addObject:TV_02];
            
            UIExpandingTextView * TV_03 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(305, 190, 125, 66)];
            TV_03.font = [UIFont systemFontOfSize:18];
            TV_03.backgroundColor = [UIColor clearColor];
            [articleView addSubview:TV_03];
            [textView_Arr addObject:TV_03];
            
            UIExpandingTextView * TV_04 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(432, 190, 200, 66)];
            TV_04.font = [UIFont systemFontOfSize:18];
            TV_04.backgroundColor = [UIColor clearColor];
            [articleView addSubview:TV_04];
            [textView_Arr addObject:TV_04];
            
            UIExpandingTextView * TV_05 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(635, 190, 200, 66)];
            TV_05.font = [UIFont systemFontOfSize:18];
            TV_05.backgroundColor = [UIColor clearColor];
            [articleView addSubview:TV_05];
            [textView_Arr addObject:TV_05];
            
            UIExpandingTextView * TV_06 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(834, 190, 155, 66)];
            TV_06.font = [UIFont systemFontOfSize:18];
            TV_06.backgroundColor = [UIColor clearColor];
            [articleView addSubview:TV_06];
            [textView_Arr addObject:TV_06];
            
            //row 3
            UIExpandingTextView * TV_07 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(30, 265, 125, 66)];
            TV_07.font = [UIFont systemFontOfSize:18];
            TV_07.backgroundColor = [UIColor clearColor];
            [articleView addSubview:TV_07];
            [textView_Arr addObject:TV_07];
            
            UIExpandingTextView * TV_08 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(165, 265, 125, 66)];
            TV_08.font = [UIFont systemFontOfSize:18];
            TV_08.backgroundColor = [UIColor clearColor];
            [articleView addSubview:TV_08];
            [textView_Arr addObject:TV_08];
            
            UIExpandingTextView * TV_09 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(305, 265, 125, 66)];
            TV_09.font = [UIFont systemFontOfSize:18];
            TV_09.backgroundColor = [UIColor clearColor];
            [articleView addSubview:TV_09];
            [textView_Arr addObject:TV_09];
            
            UIExpandingTextView * TV_10 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(432, 265, 200, 66)];
            TV_10.font = [UIFont systemFontOfSize:18];
            TV_10.backgroundColor = [UIColor clearColor];
            [articleView addSubview:TV_10];
            [textView_Arr addObject:TV_10];
            
            UIExpandingTextView * TV_11 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(635, 265, 200, 66)];
            TV_11.font = [UIFont systemFontOfSize:18];
            TV_11.backgroundColor = [UIColor clearColor];
            [articleView addSubview:TV_11];
            [textView_Arr addObject:TV_11];
            
            UIExpandingTextView * TV_12 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(834, 265, 155, 66)];
            TV_12.font = [UIFont systemFontOfSize:18];
            TV_12.backgroundColor = [UIColor clearColor];
            [articleView addSubview:TV_12];
            [textView_Arr addObject:TV_12];
            
            //row 4
            UIExpandingTextView * TV_13 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(30, 340, 125, 66)];
            TV_13.font = [UIFont systemFontOfSize:18];
            TV_13.font = [UIFont systemFontOfSize:18];
            TV_13.backgroundColor = [UIColor clearColor];
            [articleView addSubview:TV_13];
            [textView_Arr addObject:TV_13];
            
            UIExpandingTextView * TV_14 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(165, 340, 125, 66)];
            TV_14.font = [UIFont systemFontOfSize:18];
            TV_14.backgroundColor = [UIColor clearColor];
            [articleView addSubview:TV_14];
            [textView_Arr addObject:TV_14];
            
            UIExpandingTextView * TV_15 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(305, 340, 125, 66)];
            TV_15.font = [UIFont systemFontOfSize:18];
            TV_15.backgroundColor = [UIColor clearColor];
            [articleView addSubview:TV_15];
            [textView_Arr addObject:TV_15];
            
            UIExpandingTextView * TV_16 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(432, 340, 200, 66)];
            TV_16.font = [UIFont systemFontOfSize:18];
            TV_16.backgroundColor = [UIColor clearColor];
            [articleView addSubview:TV_16];
            [textView_Arr addObject:TV_16];
            
            UIExpandingTextView * TV_17 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(635, 340, 200, 66)];
            TV_17.font = [UIFont systemFontOfSize:18];
            TV_17.backgroundColor = [UIColor clearColor];
            [articleView addSubview:TV_17];
            [textView_Arr addObject:TV_17];
            
            UIExpandingTextView * TV_18 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(834, 340, 155, 66)];
            TV_18.font = [UIFont systemFontOfSize:18];
            TV_18.backgroundColor = [UIColor clearColor];
            [articleView addSubview:TV_18];
            [textView_Arr addObject:TV_18];
            
            //row 5
            UIExpandingTextView * TV_19 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(30, 415, 125, 66)];
            TV_19.font = [UIFont systemFontOfSize:18];
            TV_19.backgroundColor = [UIColor clearColor];
            [articleView addSubview:TV_19];
            [textView_Arr addObject:TV_19];
            
            UIExpandingTextView * TV_20 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(165, 415, 125, 66)];
            TV_20.font = [UIFont systemFontOfSize:18];
            TV_20.backgroundColor = [UIColor clearColor];
            [articleView addSubview:TV_20];
            [textView_Arr addObject:TV_20];
            
            UIExpandingTextView * TV_21 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(305, 415, 125, 66)];
            TV_21.font = [UIFont systemFontOfSize:18];
            TV_21.backgroundColor = [UIColor clearColor];
            [articleView addSubview:TV_21];
            [textView_Arr addObject:TV_21];
            
            UIExpandingTextView * TV_22 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(432, 415, 200, 66)];
            TV_22.font = [UIFont systemFontOfSize:18];
            TV_22.backgroundColor = [UIColor clearColor];
            [articleView addSubview:TV_22];
            [textView_Arr addObject:TV_22];
            
            UIExpandingTextView * TV_23 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(635, 415, 200, 66)];
            TV_23.font = [UIFont systemFontOfSize:18];
            TV_23.backgroundColor = [UIColor clearColor];
            [articleView addSubview:TV_23];
            [textView_Arr addObject:TV_23];
            
            UIExpandingTextView * TV_24 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(834, 415, 155, 66)];
            TV_24.font = [UIFont systemFontOfSize:18];
            TV_24.backgroundColor = [UIColor clearColor];
            [articleView addSubview:TV_24];
            [textView_Arr addObject:TV_24];
            
            
            //row 6
            UIExpandingTextView * TV_25 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(30, 490, 125, 66)];
            TV_25.font = [UIFont systemFontOfSize:18];
            TV_25.backgroundColor = [UIColor clearColor];
            [articleView addSubview:TV_25];
            [textView_Arr addObject:TV_25];
            
            UIExpandingTextView * TV_26 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(165, 490, 125, 66)];
            TV_26.font = [UIFont systemFontOfSize:18];
            TV_26.backgroundColor = [UIColor clearColor];
            [articleView addSubview:TV_26];
            [textView_Arr addObject:TV_26];
            
            UIExpandingTextView * TV_27 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(305, 490, 125, 66)];
            TV_27.font = [UIFont systemFontOfSize:18];
            TV_27.backgroundColor = [UIColor clearColor];
            [articleView addSubview:TV_27];
            [textView_Arr addObject:TV_27];
            
            UIExpandingTextView * TV_28 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(432, 490, 200, 66)];
            TV_28.font = [UIFont systemFontOfSize:18];
            TV_28.backgroundColor = [UIColor clearColor];
            [articleView addSubview:TV_28];
            [textView_Arr addObject:TV_28];
            
            UIExpandingTextView * TV_29 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(635, 490, 200, 66)];
            TV_29.font = [UIFont systemFontOfSize:18];
            TV_29.backgroundColor = [UIColor clearColor];
            [articleView addSubview:TV_29];
            [textView_Arr addObject:TV_29];
            
            UIExpandingTextView * TV_30 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(834, 490, 155, 66)];
            TV_30.font = [UIFont systemFontOfSize:18];
            TV_30.backgroundColor = [UIColor clearColor];
            [articleView addSubview:TV_30];
            [textView_Arr addObject:TV_30];
            
            
            //row 7
            UIExpandingTextView * TV_31 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(30, 565, 125, 66)];
            TV_31.font = [UIFont systemFontOfSize:18];
            TV_31.backgroundColor = [UIColor clearColor];
            [articleView addSubview:TV_31];
            [textView_Arr addObject:TV_31];
            
            UIExpandingTextView * TV_32 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(165, 565, 125, 66)];
            TV_32.font = [UIFont systemFontOfSize:18];
            TV_32.backgroundColor = [UIColor clearColor];
            [articleView addSubview:TV_32];
            [textView_Arr addObject:TV_32];
            
            UIExpandingTextView * TV_33 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(305, 565, 125, 66)];
            TV_33.font = [UIFont systemFontOfSize:18];
            TV_33.backgroundColor = [UIColor clearColor];
            [articleView addSubview:TV_33];
            [textView_Arr addObject:TV_33];
            
            
            UIExpandingTextView * TV_34 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(432, 565, 200, 66)];
            TV_34.font = [UIFont systemFontOfSize:18];
            TV_34.backgroundColor = [UIColor clearColor];
            [articleView addSubview:TV_34];
            [textView_Arr addObject:TV_34];
            
            UIExpandingTextView * TV_35 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(635, 565, 200, 66)];
            TV_35.font = [UIFont systemFontOfSize:18];
            TV_35.backgroundColor = [UIColor clearColor];
            [articleView addSubview:TV_35];
            [textView_Arr addObject:TV_35];
            
            UIExpandingTextView * TV_36 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(834, 565, 155, 66)];
            TV_36.font = [UIFont systemFontOfSize:18];
            TV_36.backgroundColor = [UIColor clearColor];
            [articleView addSubview:TV_36];
            [textView_Arr addObject:TV_36];
            
            for (UIExpandingTextView * textview in textView_Arr) {
                if (self.type == 2 || self.type == 3) {
                    [textview setEditable:NO];
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

    -(void)submitWork{
        
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