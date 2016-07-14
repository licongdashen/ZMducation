//
//  ZMArticleView05Controller.m
//  ZMEducation
//
//  Created by Hunter Li on 13-5-25.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import "ZMArticleView05Controller.h"

@implementation ZMArticleView05Controller

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
    for (int i=0; i<6; i++) {
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
    NSArray* _articleContentArray = [articleDict valueForKey:@"articleContents"];
    
    UIImageView* article_Item_View = [[UIImageView alloc] init];
    UIImage* article_Item_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_03" ofType:@"png"]];
    [article_Item_View setFrame:CGRectMake(327, 60, 339, 105)];
    [article_Item_View setImage:article_Item_Image];
    [articleView addSubview:article_Item_View];
    [article_Item_View release];
    
    UIExpandingTextView* itemView = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(366, 78, 266, 68)];
    [itemView setFont:[UIFont systemFontOfSize:16]];
    [itemView setTag:1200];
    if (self.type == 2 || self.type == 3) {
        [itemView setEditable:NO];
    }
    if ([_articleContentArray count] > 0) {
        NSDictionary* articleContentDict = [_articleContentArray objectAtIndex:0];
        [itemView setText:[articleContentDict valueForKey:@"articleContent"]];
    }
    [articleView addSubview:itemView];
    [itemView release];
    
    UIImageView* article_Item_Left_Arrow_View = [[UIImageView alloc] init];
    UIImage* article_Item_Left_Arrow_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_Arrow" ofType:@"png"]];
    [article_Item_Left_Arrow_View setFrame:CGRectMake(375, 170, 36, 43)];
    [article_Item_Left_Arrow_View setImage:article_Item_Left_Arrow_Image];
    [articleView addSubview:article_Item_Left_Arrow_View];
    [article_Item_Left_Arrow_View release];
    
    UIImageView* article_Item_Right_Arrow_View = [[UIImageView alloc] init];
    UIImage* article_Item_Right_Arrow_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_Arrow" ofType:@"png"]];
    [article_Item_Right_Arrow_View setFrame:CGRectMake(580, 170, 36, 43)];
    [article_Item_Right_Arrow_View setImage:article_Item_Right_Arrow_Image];
    [articleView addSubview:article_Item_Right_Arrow_View];
    [article_Item_Right_Arrow_View release];
    
    UIImageView* article_Item_Left__View = [[UIImageView alloc] init];
    UIImage* article_Item_Left_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_09" ofType:@"png"]];
    [article_Item_Left__View setFrame:CGRectMake(300, 220, 196, 254)];
    [article_Item_Left__View setImage:article_Item_Left_Image];
    [articleView addSubview:article_Item_Left__View];
    [article_Item_Left__View release];
    
    UIImageView* article_Item_Right_View = [[UIImageView alloc] init];
    UIImage* article_Item_Right_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_09" ofType:@"png"]];
    [article_Item_Right_View setFrame:CGRectMake(507, 220, 196, 254)];
    [article_Item_Right_View setImage:article_Item_Right_Image];
    [articleView addSubview:article_Item_Right_View];
    [article_Item_Right_View release];
    
    UIExpandingTextView* item_Left_01_View = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(350, 260, 100, 56)];
    [item_Left_01_View setFont:[UIFont systemFontOfSize:16]];
    [item_Left_01_View setTextAlignment:NSTextAlignmentCenter];
    [item_Left_01_View setTag:1201];
    if (self.type == 2 || self.type == 3) {
        [item_Left_01_View setEditable:NO];
    }
    if ([_articleContentArray count] > 1) {
        NSDictionary* articleContentDict = [_articleContentArray objectAtIndex:1];
        [item_Left_01_View setText:[articleContentDict valueForKey:@"articleContent"]];
    }
    [articleView addSubview:item_Left_01_View];
    [item_Left_01_View release];
    
    UIExpandingTextView* item_Right_01_View = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(560, 260, 100, 56)];
    [item_Right_01_View setFont:[UIFont systemFontOfSize:16]];
    [item_Right_01_View setTextAlignment:NSTextAlignmentCenter];
    [item_Right_01_View setTag:1202];
    if (self.type == 2 || self.type == 3) {
        [item_Right_01_View setEditable:NO];
    }
    if ([_articleContentArray count] > 2) {
        NSDictionary* articleContentDict = [_articleContentArray objectAtIndex:2];
        [item_Right_01_View setText:[articleContentDict valueForKey:@"articleContent"]];
    }
    [articleView addSubview:item_Right_01_View];
    [item_Right_01_View release];
    
    UIExpandingTextView* item_Left_02_View = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(330, 330, 140, 126)];
    [item_Left_02_View setFont:[UIFont systemFontOfSize:16]];
    [item_Left_02_View setTextAlignment:NSTextAlignmentCenter];
    [item_Left_02_View setTag:1203];
    if (self.type == 2 || self.type == 3) {
        [item_Left_02_View setEditable:NO];
    }
    if ([_articleContentArray count] > 3) {
        NSDictionary* articleContentDict = [_articleContentArray objectAtIndex:3];
        [item_Left_02_View setText:[articleContentDict valueForKey:@"articleContent"]];
    }
    [articleView addSubview:item_Left_02_View];
    [item_Left_02_View release];
    
    UIExpandingTextView* item_Right_02_View = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(540, 330, 140, 126)];
    [item_Right_02_View setFont:[UIFont systemFontOfSize:16]];
    [item_Right_02_View setTextAlignment:NSTextAlignmentCenter];
    [item_Right_02_View setTag:1204];
    if (self.type == 2 || self.type == 3) {
        [item_Right_02_View setEditable:NO];
    }
    if ([_articleContentArray count] > 4) {
        NSDictionary* articleContentDict = [_articleContentArray objectAtIndex:4];
        [item_Right_02_View setText:[articleContentDict valueForKey:@"articleContent"]];
    }
    [articleView addSubview:item_Right_02_View];
    [item_Right_02_View release];
    
    UIImageView* article_Item_Left_Arrow_01_View = [[UIImageView alloc] init];
    UIImage* article_Item_Left_Arrow_01_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_Arrow" ofType:@"png"]];
    [article_Item_Left_Arrow_01_View setFrame:CGRectMake(375, 480, 36, 43)];
    [article_Item_Left_Arrow_01_View setImage:article_Item_Left_Arrow_01_Image];
    [articleView addSubview:article_Item_Left_Arrow_01_View];
    [article_Item_Left_Arrow_01_View release];
    
    UIImageView* article_Item_Right_Arrow_02_View = [[UIImageView alloc] init];
    UIImage* article_Item_Right_Arrow_02_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_Arrow" ofType:@"png"]];
    [article_Item_Right_Arrow_02_View setFrame:CGRectMake(580, 480, 36, 43)];
    [article_Item_Right_Arrow_02_View setImage:article_Item_Right_Arrow_02_Image];
    [articleView addSubview:article_Item_Right_Arrow_02_View];
    [article_Item_Right_Arrow_02_View release];
    
    UIImageView* article_Item_Circle_View = [[UIImageView alloc] init];
    UIImage* article_Item_Circle_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_10" ofType:@"png"]];
    [article_Item_Circle_View setFrame:CGRectMake(370, 540, 294, 190)];
    [article_Item_Circle_View setImage:article_Item_Circle_Image];
    [articleView addSubview:article_Item_Circle_View];
    [article_Item_Circle_View release];
    
    UIExpandingTextView* item_Circle_View = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(420, 580, 194, 106)];
    [item_Circle_View setFont:[UIFont systemFontOfSize:16]];
    [item_Circle_View setTextAlignment:NSTextAlignmentCenter];
    [item_Circle_View setTag:1205];
    if (self.type == 2 || self.type == 3) {
        [item_Circle_View setEditable:NO];
    }
    if ([_articleContentArray count] > 5) {
        NSDictionary* articleContentDict = [_articleContentArray objectAtIndex:5];
        [item_Circle_View setText:[articleContentDict valueForKey:@"articleContent"]];
    }
    [articleView addSubview:item_Circle_View];
    [item_Circle_View release];
}

@end
