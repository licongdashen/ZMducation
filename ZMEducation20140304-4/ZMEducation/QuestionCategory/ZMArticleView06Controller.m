//
//  ZMArticleView06Controller.m
//  ZMEducation
//
//  Created by Hunter Li on 13-5-25.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import "ZMArticleView06Controller.h"

@implementation ZMArticleView06Controller

-(void)submitWork{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSLog(@"userDict:%@",userDict);
    
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M015" forKey:@"method"];
    
    [requestDict setValue:[self.unitDict valueForKey:@"courseId"] forKey:@"courseId"];
    [requestDict setValue:[self.unitDict valueForKey:@"classId"] forKey:@"classId"];
    [requestDict setValue:[self.unitDict valueForKey:@"gradeId"] forKey:@"gradeId"];
    [requestDict setValue:[self.unitDict valueForKey:@"moduleId"] forKey:@"moduleId"];
    [requestDict setValue:[self.unitDict valueForKey:@"authorId"] forKey:@"userId"];
    [requestDict setValue:[self.unitDict valueForKey:@"unitId"] forKey:@"unitId"];
    
    UIExpandingTextView* titleView = (UIExpandingTextView*)[articleView viewWithTag:kTagArticleTitleView];
    [requestDict setValue:[titleView text] forKey:@"articleTitle"];
    
    [requestDict setValue:[articleDict valueForKey:@"articleType"] forKey:@"articleType"];
    
    UIExpandingTextView* draftView = (UIExpandingTextView*)[articleView viewWithTag:kTagArticleDraftView];
    [requestDict setValue:[draftView text] forKey:@"articleDraft"];
    
    NSMutableArray* articleContentArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    //int articleCellNumber = [[articleDict valueForKey:@"articleCellNumber"] intValue];
    for (int i=0; i<8; i++) {
        UIExpandingTextView* contentView = (UIExpandingTextView*)[articleView viewWithTag:1200+i];
        
        NSDictionary* contentDict = [NSDictionary dictionaryWithObjectsAndKeys:[contentView text],@"articleContent", nil];
        [articleContentArray addObject:contentDict];
    }
    [requestDict setValue:[articleContentArray JSONString] forKey:@"articleContents"];
    [articleContentArray release];
    
    NSMutableArray* articleCommentArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    UIExpandingTextView* comment01View = (UIExpandingTextView*)[articleView viewWithTag:kTagArticleComment01View];
    NSDictionary* comment01Dict = [NSDictionary dictionaryWithObjectsAndKeys:[comment01View text],@"articleComment", nil];
    [articleCommentArray addObject:comment01Dict];
    
    UIExpandingTextView* comment02View = (UIExpandingTextView*)[articleView viewWithTag:kTagArticleComment02View];
    NSDictionary* comment02Dict = [NSDictionary dictionaryWithObjectsAndKeys:[comment02View text],@"articleComment", nil];
    [articleCommentArray addObject:comment02Dict];
    
    UIExpandingTextView* comment03View = (UIExpandingTextView*)[articleView viewWithTag:kTagArticleComment03View];
    NSDictionary* comment03Dict = [NSDictionary dictionaryWithObjectsAndKeys:[comment03View text],@"articleComment", nil];
    [articleCommentArray addObject:comment03Dict];
    
    [requestDict setValue:[articleCommentArray JSONString] forKey:@"articleComments"];
    [articleCommentArray release];
    
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

    NSArray* _articleContentArray = [articleDict valueForKey:@"articleContents"];
    
    UIScrollView* scrollView = [[UIScrollView alloc] init];
    [scrollView setFrame:CGRectMake(300, 50, 420, 700)];
    //[scrollView setContentSize:CGSizeMake(420, 110*(_count-1)+122)];
    
    UIImageView* article_Item_Title_View = [[UIImageView alloc] init];
    UIImage* article_Item_Title_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_02" ofType:@"png"]];
    [article_Item_Title_View setFrame:CGRectMake(24, -20, 406, 122)];
    [article_Item_Title_View setImage:article_Item_Title_Image];
    [scrollView addSubview:article_Item_Title_View];
    [article_Item_Title_View release];
    
    UIExpandingTextView* item_TitleView = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(99, 28, 246, 58)];
    [item_TitleView setFont:[UIFont systemFontOfSize:16]];
    [item_TitleView setTag:1200];
    if (self.type == 2 || self.type == 3) {
        [item_TitleView setEditable:NO];
    }
    if ([_articleContentArray count] > 0) {
        NSDictionary* articleContentDict = [_articleContentArray objectAtIndex:0];
        [item_TitleView setText:[articleContentDict valueForKey:@"articleContent"]];
    }
    [scrollView addSubview:item_TitleView];
    [item_TitleView release];
    
    UIImageView* article_Item_Settings_View = [[UIImageView alloc] init];
    UIImage* article_Item_Settings_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_02" ofType:@"png"]];
    [article_Item_Settings_View setFrame:CGRectMake(24, 72, 406, 122)];
    [article_Item_Settings_View setImage:article_Item_Settings_Image];
    [scrollView addSubview:article_Item_Settings_View];
    [article_Item_Settings_View release];
    
    UIExpandingTextView* item_SettingsView = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(99, 120, 246, 58)];
    [item_SettingsView setFont:[UIFont systemFontOfSize:16]];
    [item_SettingsView setTag:1201];
    if (self.type == 2 || self.type == 3) {
        [item_SettingsView setEditable:NO];
    }
    if ([_articleContentArray count] > 1) {
        NSDictionary* articleContentDict = [_articleContentArray objectAtIndex:1];
        [item_SettingsView setText:[articleContentDict valueForKey:@"articleContent"]];
    }
    [scrollView addSubview:item_SettingsView];
    [item_SettingsView release];
    
    UIImageView* article_Item_Characters_View = [[UIImageView alloc] init];
    UIImage* article_Item_Characters_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_02" ofType:@"png"]];
    [article_Item_Characters_View setFrame:CGRectMake(24, 164, 406, 122)];
    [article_Item_Characters_View setImage:article_Item_Characters_Image];
    [scrollView addSubview:article_Item_Characters_View];
    [article_Item_Characters_View release];
    
    UIExpandingTextView* item_CharactersView = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(99, 212, 246, 58)];
    [item_CharactersView setFont:[UIFont systemFontOfSize:16]];
    [item_CharactersView setTag:1202];
    if (self.type == 2 || self.type == 3) {
        [item_CharactersView setEditable:NO];
    }
    if ([_articleContentArray count] > 2) {
        NSDictionary* articleContentDict = [_articleContentArray objectAtIndex:2];
        [item_CharactersView setText:[articleContentDict valueForKey:@"articleContent"]];
    }
    [scrollView addSubview:item_CharactersView];
    [item_CharactersView release];
    
    UIImageView* article_Item_Problems_View = [[UIImageView alloc] init];
    UIImage* article_Item_Problems_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_02" ofType:@"png"]];
    [article_Item_Problems_View setFrame:CGRectMake(24, 256, 406, 122)];
    [article_Item_Problems_View setImage:article_Item_Problems_Image];
    [scrollView addSubview:article_Item_Problems_View];
    [article_Item_Problems_View release];
    
    UIExpandingTextView* item_ProblemsView = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(99, 304, 246, 58)];
    [item_ProblemsView setFont:[UIFont systemFontOfSize:16]];
    [item_ProblemsView setTag:1203];
    if (self.type == 2 || self.type == 3) {
        [item_ProblemsView setEditable:NO];
    }
    if ([_articleContentArray count] > 3) {
        NSDictionary* articleContentDict = [_articleContentArray objectAtIndex:3];
        [item_ProblemsView setText:[articleContentDict valueForKey:@"articleContent"]];
    }
    [scrollView addSubview:item_ProblemsView];
    [item_ProblemsView release];
    
    UIImageView* article_Item01_View = [[UIImageView alloc] init];
    UIImage* article_Item01_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_01" ofType:@"png"]];
    [article_Item01_View setFrame:CGRectMake(57, 358, 339, 117)];
    [article_Item01_View setImage:article_Item01_Image];
    [scrollView addSubview:article_Item01_View];
    [article_Item01_View release];
    
    UIExpandingTextView* item_01View = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(123, 400, 198, 46)];
    [item_01View setFont:[UIFont systemFontOfSize:16]];
    [item_01View setTag:1204];
    if (self.type == 2 || self.type == 3) {
        [item_01View setEditable:NO];
    }
    if ([_articleContentArray count] > 4) {
        NSDictionary* articleContentDict = [_articleContentArray objectAtIndex:4];
        [item_01View setText:[articleContentDict valueForKey:@"articleContent"]];
    }
    [scrollView addSubview:item_01View];
    [item_01View release];
    
    UIImageView* article_Item02_View = [[UIImageView alloc] init];
    UIImage* article_Item02_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_01" ofType:@"png"]];
    [article_Item02_View setFrame:CGRectMake(57, 438, 339, 117)];
    [article_Item02_View setImage:article_Item02_Image];
    [scrollView addSubview:article_Item02_View];
    [article_Item02_View release];
    
    UIExpandingTextView* item_02View = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(123, 480, 198, 46)];
    [item_02View setFont:[UIFont systemFontOfSize:16]];
    [item_02View setTag:1205];
    if (self.type == 2 || self.type == 3) {
        [item_02View setEditable:NO];
    }
    if ([_articleContentArray count] > 5) {
        NSDictionary* articleContentDict = [_articleContentArray objectAtIndex:5];
        [item_02View setText:[articleContentDict valueForKey:@"articleContent"]];
    }
    [scrollView addSubview:item_02View];
    [item_02View release];
    
    UIImageView* article_Item03_View = [[UIImageView alloc] init];
    UIImage* article_Item03_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_01" ofType:@"png"]];
    [article_Item03_View setFrame:CGRectMake(57, 518, 339, 117)];
    [article_Item03_View setImage:article_Item03_Image];
    [scrollView addSubview:article_Item03_View];
    [article_Item03_View release];
    
    UIExpandingTextView* item_03View = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(123, 560, 198, 46)];
    [item_03View setFont:[UIFont systemFontOfSize:16]];
    [item_03View setTag:1206];
    if (self.type == 2 || self.type == 3) {
        [item_ProblemsView setEditable:NO];
    }
    if ([_articleContentArray count] > 6) {
        NSDictionary* articleContentDict = [_articleContentArray objectAtIndex:6];
        [item_03View setText:[articleContentDict valueForKey:@"articleContent"]];
    }
    [scrollView addSubview:item_03View];
    [item_03View release];
    
    UIImageView* article_Item04_View = [[UIImageView alloc] init];
    UIImage* article_Item04_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_02" ofType:@"png"]];
    [article_Item04_View setFrame:CGRectMake(57, 598, 339, 102)];
    [article_Item04_View setImage:article_Item04_Image];
    [scrollView addSubview:article_Item04_View];
    [article_Item04_View release];
    
    UIExpandingTextView* item_04View = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(123, 640, 198, 46)];
    [item_04View setFont:[UIFont systemFontOfSize:16]];
    [item_04View setTag:1207];
    if (self.type == 2 || self.type == 3) {
        [item_04View setEditable:NO];
    }
    if ([_articleContentArray count] > 7) {
        NSDictionary* articleContentDict = [_articleContentArray objectAtIndex:7];
        [item_04View setText:[articleContentDict valueForKey:@"articleContent"]];
    }
    [scrollView addSubview:item_04View];
    [item_04View release];
    
    UIImageView* article_Item_Line_Left_View = [[UIImageView alloc] init];
    UIImage* article_Item_Line_Left_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_Line_Left" ofType:@"png"]];
    [article_Item_Line_Left_View setFrame:CGRectMake(0, 330, 29, 365)];
    [article_Item_Line_Left_View setImage:article_Item_Line_Left_Image];
    [scrollView addSubview:article_Item_Line_Left_View];
    [article_Item_Line_Left_View release];
    
    UIImageView* article_Item_Line_Right_View = [[UIImageView alloc] init];
    UIImage* article_Item_Line_Right_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_Line_Right" ofType:@"png"]];
    [article_Item_Line_Right_View setFrame:CGRectMake(380, 330, 29, 365)];
    [article_Item_Line_Right_View setImage:article_Item_Line_Right_Image];
    [scrollView addSubview:article_Item_Line_Right_View];
    [article_Item_Line_Right_View release];
    
    [articleView addSubview:scrollView];
    [scrollView release];
}

@end
