//
//  ZMArticleView02Controller.m
//  ZMEducation
//
//  Created by Hunter Li on 13-5-25.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import "ZMArticleView02Controller.h"

@implementation ZMArticleView02Controller

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
    for (int i=0; i<9; i++) {
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
    [scrollView setFrame:CGRectMake(300, 60, 420, 690)];
    [scrollView setContentSize:CGSizeMake(420, 900)];
    
    UIImageView* article_Item_Left_01_View = [[UIImageView alloc] init];
    UIImage* article_Item_Left_01_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_05" ofType:@"png"]];
    [article_Item_Left_01_View setFrame:CGRectMake(0, 10, 179, 162)];
    [article_Item_Left_01_View setImage:article_Item_Left_01_Image];
    [scrollView addSubview:article_Item_Left_01_View];
    [article_Item_Left_01_View release];
    
    UIImageView* article_Item_Left_Arrow_01_View = [[UIImageView alloc] init];
    UIImage* article_Item_Left_Arrow_01_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_Arrow" ofType:@"png"]];
    [article_Item_Left_Arrow_01_View setFrame:CGRectMake(80, 166, 36, 43)];
    [article_Item_Left_Arrow_01_View setImage:article_Item_Left_Arrow_01_Image];
    [scrollView addSubview:article_Item_Left_Arrow_01_View];
    [article_Item_Left_Arrow_01_View release];
    
    UIExpandingTextView* item_Left_01View = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(14, 28, 143, 127)];
    [item_Left_01View setFont:[UIFont systemFontOfSize:16]];
    [item_Left_01View setTag:1200];
    if (self.type == 2 || self.type == 3) {
        [item_Left_01View setEditable:NO];
    }
    if ([_articleContentArray count] > 0) {
        NSDictionary* articleContentDict = [_articleContentArray objectAtIndex:0];
        [item_Left_01View setText:[articleContentDict valueForKey:@"articleContent"]];
    }
    [scrollView addSubview:item_Left_01View];
    [item_Left_01View release];
    
    
    
    UIImageView* article_Item_Right_01_View = [[UIImageView alloc] init];
    UIImage* article_Item_Right_01_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_06" ofType:@"png"]];
    [article_Item_Right_01_View setFrame:CGRectMake(219, 10, 182, 164)];
    [article_Item_Right_01_View setImage:article_Item_Right_01_Image];
    [scrollView addSubview:article_Item_Right_01_View];
    [article_Item_Right_01_View release];
    
    UIImageView* article_Item_Right_Arrow_01_View = [[UIImageView alloc] init];
    UIImage* article_Item_Right_Arrow_01_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_Arrow" ofType:@"png"]];
    [article_Item_Right_Arrow_01_View setFrame:CGRectMake(300, 166, 36, 43)];
    [article_Item_Right_Arrow_01_View setImage:article_Item_Right_Arrow_01_Image];
    [scrollView addSubview:article_Item_Right_Arrow_01_View];
    [article_Item_Right_Arrow_01_View release];
    
    UIExpandingTextView* item_Right_01View = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(233, 28, 144, 129)];
    [item_Right_01View setFont:[UIFont systemFontOfSize:16]];
    [item_Right_01View setTag:1201];
    if (self.type == 2 || self.type == 3) {
        [item_Right_01View setEditable:NO];
    }
    if ([_articleContentArray count] > 1) {
        NSDictionary* articleContentDict = [_articleContentArray objectAtIndex:1];
        [item_Right_01View setText:[articleContentDict valueForKey:@"articleContent"]];
    }
    [scrollView addSubview:item_Right_01View];
    [item_Right_01View release];
    
    UIImageView* article_Item_Left_02_View = [[UIImageView alloc] init];
    UIImage* article_Item_Left_02_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_05" ofType:@"png"]];
    [article_Item_Left_02_View setFrame:CGRectMake(0, 202, 179, 162)];
    [article_Item_Left_02_View setImage:article_Item_Left_02_Image];
    [scrollView addSubview:article_Item_Left_02_View];
    [article_Item_Left_02_View release];
    
    UIImageView* article_Item_Left_Arrow_02_View = [[UIImageView alloc] init];
    UIImage* article_Item_Left_Arrow_02_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_Arrow" ofType:@"png"]];
    [article_Item_Left_Arrow_02_View setFrame:CGRectMake(80, 358, 36, 43)];
    [article_Item_Left_Arrow_02_View setImage:article_Item_Left_Arrow_02_Image];
    [scrollView addSubview:article_Item_Left_Arrow_02_View];
    [article_Item_Left_Arrow_02_View release];
    
    UIExpandingTextView* item_Left_02View = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(14, 220, 143, 127)];
    [item_Left_02View setFont:[UIFont systemFontOfSize:16]];
    [item_Left_02View setTag:1202];
    if (self.type == 2 || self.type == 3) {
        [item_Left_02View setEditable:NO];
    }
    if ([_articleContentArray count] > 2) {
        NSDictionary* articleContentDict = [_articleContentArray objectAtIndex:2];
        [item_Left_02View setText:[articleContentDict valueForKey:@"articleContent"]];
    }
    [scrollView addSubview:item_Left_02View];
    [item_Left_02View release];
    
    UIImageView* article_Item_Right_02_View = [[UIImageView alloc] init];
    UIImage* article_Item_Right_02_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_06" ofType:@"png"]];
    [article_Item_Right_02_View setFrame:CGRectMake(219, 202, 182, 164)];
    [article_Item_Right_02_View setImage:article_Item_Right_02_Image];
    [scrollView addSubview:article_Item_Right_02_View];
    [article_Item_Right_02_View release];
    
    UIImageView* article_Item_Right_Arrow_02_View = [[UIImageView alloc] init];
    UIImage* article_Item_Right_Arrow_02_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_Arrow" ofType:@"png"]];
    [article_Item_Right_Arrow_02_View setFrame:CGRectMake(300, 358, 36, 43)];
    [article_Item_Right_Arrow_02_View setImage:article_Item_Right_Arrow_02_Image];
    [scrollView addSubview:article_Item_Right_Arrow_02_View];
    [article_Item_Right_Arrow_02_View release];
    
    UIExpandingTextView* item_Right_02View = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(233, 220, 144, 129)];
    [item_Right_02View setFont:[UIFont systemFontOfSize:16]];
    [item_Right_02View setTag:1203];
    if (self.type == 2 || self.type == 3) {
        [item_Right_02View setEditable:NO];
    }
    if ([_articleContentArray count] > 3) {
        NSDictionary* articleContentDict = [_articleContentArray objectAtIndex:3];
        [item_Right_02View setText:[articleContentDict valueForKey:@"articleContent"]];
    }
    [scrollView addSubview:item_Right_02View];
    [item_Right_02View release];
    
    UIImageView* article_Item_View = [[UIImageView alloc] init];
    UIImage* article_Item_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_03" ofType:@"png"]];
    [article_Item_View setFrame:CGRectMake(27, 397, 339, 105)];
    [article_Item_View setImage:article_Item_Image];
    [scrollView addSubview:article_Item_View];
    [article_Item_View release];
    
    UIImageView* article_Item_Left_Arrow_View = [[UIImageView alloc] init];
    UIImage* article_Item_Left_Arrow_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_Arrow" ofType:@"png"]];
    [article_Item_Left_Arrow_View setFrame:CGRectMake(80, 498, 36, 43)];
    [article_Item_Left_Arrow_View setImage:article_Item_Left_Arrow_Image];
    [scrollView addSubview:article_Item_Left_Arrow_View];
    [article_Item_Left_Arrow_View release];
    
    UIImageView* article_Item_Right_Arrow_View = [[UIImageView alloc] init];
    UIImage* article_Item_Right_Arrow_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_Arrow" ofType:@"png"]];
    [article_Item_Right_Arrow_View setFrame:CGRectMake(300, 498, 36, 43)];
    [article_Item_Right_Arrow_View setImage:article_Item_Right_Arrow_Image];
    [scrollView addSubview:article_Item_Right_Arrow_View];
    [article_Item_Right_Arrow_View release];
    
    UIExpandingTextView* itemView = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(66, 412, 266, 68)];
    [itemView setFont:[UIFont systemFontOfSize:16]];
    [itemView setTag:1204];
    if (self.type == 2 || self.type == 3) {
        [itemView setEditable:NO];
    }
    if ([_articleContentArray count] > 4) {
        NSDictionary* articleContentDict = [_articleContentArray objectAtIndex:4];
        [itemView setText:[articleContentDict valueForKey:@"articleContent"]];
    }
    [scrollView addSubview:itemView];
    [itemView release];
    
    UIImageView* article_Item_Left_03_View = [[UIImageView alloc] init];
    UIImage* article_Item_Left_03_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_05" ofType:@"png"]];
    [article_Item_Left_03_View setFrame:CGRectMake(0, 530, 179, 162)];
    [article_Item_Left_03_View setImage:article_Item_Left_03_Image];
    [scrollView addSubview:article_Item_Left_03_View];
    [article_Item_Left_03_View release];
    
    UIImageView* article_Item_Left_Arrow_03_View = [[UIImageView alloc] init];
    UIImage* article_Item_Left_Arrow_03_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_Arrow" ofType:@"png"]];
    [article_Item_Left_Arrow_03_View setFrame:CGRectMake(80, 686, 36, 43)];
    [article_Item_Left_Arrow_03_View setImage:article_Item_Left_Arrow_03_Image];
    [scrollView addSubview:article_Item_Left_Arrow_03_View];
    [article_Item_Left_Arrow_03_View release];
    
    UIExpandingTextView* item_Left_03View = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(14, 548, 143, 127)];
    [item_Left_03View setFont:[UIFont systemFontOfSize:16]];
    [item_Left_03View setTag:1205];
    if (self.type == 2 || self.type == 3) {
        [item_Left_03View setEditable:NO];
    }
    if ([_articleContentArray count] > 5) {
        NSDictionary* articleContentDict = [_articleContentArray objectAtIndex:5];
        [item_Left_03View setText:[articleContentDict valueForKey:@"articleContent"]];
    }
    [scrollView addSubview:item_Left_03View];
    [item_Left_03View release];
    
    UIImageView* article_Item_Right_03_View = [[UIImageView alloc] init];
    UIImage* article_Item_Right_03_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_06" ofType:@"png"]];
    [article_Item_Right_03_View setFrame:CGRectMake(219, 530, 182, 164)];
    [article_Item_Right_03_View setImage:article_Item_Right_03_Image];
    [scrollView addSubview:article_Item_Right_03_View];
    [article_Item_Right_03_View release];
    
    UIImageView* article_Item_Right_Arrow_03_View = [[UIImageView alloc] init];
    UIImage* article_Item_Right_Arrow_03_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_Arrow" ofType:@"png"]];
    [article_Item_Right_Arrow_03_View setFrame:CGRectMake(300, 686, 36, 43)];
    [article_Item_Right_Arrow_03_View setImage:article_Item_Right_Arrow_03_Image];
    [scrollView addSubview:article_Item_Right_Arrow_03_View];
    [article_Item_Right_Arrow_03_View release];
    
    UIExpandingTextView* item_Right_03View = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(233, 548, 144, 129)];
    [item_Right_03View setFont:[UIFont systemFontOfSize:16]];
    [item_Right_03View setTag:1206];
    if (self.type == 2 || self.type == 3) {
        [item_Right_03View setEditable:NO];
    }
    if ([_articleContentArray count] > 6) {
        NSDictionary* articleContentDict = [_articleContentArray objectAtIndex:6];
        [item_Right_03View setText:[articleContentDict valueForKey:@"articleContent"]];
    }
    [scrollView addSubview:item_Right_03View];
    [item_Right_03View release];
    
    UIImageView* article_Item_Left_04_View = [[UIImageView alloc] init];
    UIImage* article_Item_Left_04_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_05" ofType:@"png"]];
    [article_Item_Left_04_View setFrame:CGRectMake(0, 720, 179, 162)];
    [article_Item_Left_04_View setImage:article_Item_Left_04_Image];
    [scrollView addSubview:article_Item_Left_04_View];
    [article_Item_Left_04_View release];
    
    UIExpandingTextView* item_Left_04View = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(14, 738, 143, 127)];
    [item_Left_04View setFont:[UIFont systemFontOfSize:16]];
    [item_Left_04View setTag:1207];
    if (self.type == 2 || self.type == 3) {
        [item_Left_04View setEditable:NO];
    }
    if ([_articleContentArray count] > 7) {
        NSDictionary* articleContentDict = [_articleContentArray objectAtIndex:7];
        [item_Left_04View setText:[articleContentDict valueForKey:@"articleContent"]];
    }
    [scrollView addSubview:item_Left_04View];
    [item_Left_04View release];
    
    UIImageView* article_Item_Right_04_View = [[UIImageView alloc] init];
    UIImage* article_Item_Right_04_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_06" ofType:@"png"]];
    [article_Item_Right_04_View setFrame:CGRectMake(219, 720, 182, 164)];
    [article_Item_Right_04_View setImage:article_Item_Right_04_Image];
    [scrollView addSubview:article_Item_Right_04_View];
    [article_Item_Right_04_View release];
    
    UIExpandingTextView* item_Right_04View = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(233, 738, 144, 129)];
    [item_Right_04View setFont:[UIFont systemFontOfSize:16]];
    [item_Right_04View setTag:1208];
    if (self.type == 2 || self.type == 3) {
        [item_Right_04View setEditable:NO];
    }
    if ([_articleContentArray count] > 8) {
        NSDictionary* articleContentDict = [_articleContentArray objectAtIndex:8];
        [item_Right_04View setText:[articleContentDict valueForKey:@"articleContent"]];
    }
    [scrollView addSubview:item_Right_04View];
    [item_Right_04View release];
    
    [articleView addSubview:scrollView];
    [scrollView release];
}

@end
