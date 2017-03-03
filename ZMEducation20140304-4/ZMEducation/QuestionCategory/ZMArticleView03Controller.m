//
//  ZMArticleView03Controller.m
//  ZMEducation
//
//  Created by Hunter Li on 13-5-25.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import "ZMArticleView03Controller.h"

@implementation ZMArticleView03Controller



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
    
    UIImageView* article_Item_View = [[UIImageView alloc] init];
    UIImage* article_Item_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_07" ofType:@"png"]];
    [article_Item_View setFrame:CGRectMake(270, 60, 641, 683)];
    [article_Item_View setImage:article_Item_Image];
    [articleView insertSubview:article_Item_View atIndex:0];
    [article_Item_View release];
    
    UIExpandingTextView* item_01View = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(510, 376, 158, 130)];
    [item_01View setFont:[UIFont systemFontOfSize:16]];
    [item_01View setTag:1200];
    [item_01View setTextAlignment:NSTextAlignmentCenter];
    if (self.type == 2 || self.type == 3) {
        [item_01View setEditable:NO];
    }
    if ([_articleContentArray count] > 0) {
        NSDictionary* articleContentDict = [_articleContentArray objectAtIndex:0];
        [item_01View setText:[articleContentDict valueForKey:@"articleContent"]];
    }
    [articleView addSubview:item_01View];
    [item_01View release];
    
    UIExpandingTextView* item_02View = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(540, 180, 98, 140)];
    [item_02View setFont:[UIFont systemFontOfSize:16]];
    [item_02View setTag:1201];
    [item_02View setTextAlignment:NSTextAlignmentCenter];
    if (self.type == 2 || self.type == 3) {
        [item_02View setEditable:NO];
    }
    if ([_articleContentArray count] > 1) {
        NSDictionary* articleContentDict = [_articleContentArray objectAtIndex:1];
        [item_02View setText:[articleContentDict valueForKey:@"articleContent"]];
    }
    [articleView addSubview:item_02View];
    [item_02View release];
    
    UIExpandingTextView* item_03View = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(330, 340, 140, 90)];
    [item_03View setFont:[UIFont systemFontOfSize:16]];
    [item_03View setTag:1202];
    [item_03View setTextAlignment:NSTextAlignmentCenter];
    if (self.type == 2 || self.type == 3) {
        [item_03View setEditable:NO];
    }
    if ([_articleContentArray count] > 2) {
        NSDictionary* articleContentDict = [_articleContentArray objectAtIndex:2];
        [item_03View setText:[articleContentDict valueForKey:@"articleContent"]];
    }
    [articleView addSubview:item_03View];
    [item_03View release];
    
    UIExpandingTextView* item_04View = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(450, 550, 100, 120)];
    [item_04View setFont:[UIFont systemFontOfSize:16]];
    [item_04View setTag:1203];
    [item_04View setTextAlignment:NSTextAlignmentCenter];
    if (self.type == 2 || self.type == 3) {
        [item_04View setEditable:NO];
    }
    if ([_articleContentArray count] > 3) {
        NSDictionary* articleContentDict = [_articleContentArray objectAtIndex:3];
        [item_04View setText:[articleContentDict valueForKey:@"articleContent"]];
    }
    [articleView addSubview:item_04View];
    [item_04View release];
    
    UIExpandingTextView* item_05View = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(620, 550, 100, 120)];
    [item_05View setFont:[UIFont systemFontOfSize:16]];
    [item_05View setTag:1204];
    [item_05View setTextAlignment:NSTextAlignmentCenter];
    if (self.type == 2 || self.type == 3) {
        [item_05View setEditable:NO];
    }
    if ([_articleContentArray count] > 4) {
        NSDictionary* articleContentDict = [_articleContentArray objectAtIndex:4];
        [item_05View setText:[articleContentDict valueForKey:@"articleContent"]];
    }
    [articleView addSubview:item_05View];
    [item_05View release];
    
    UIExpandingTextView* item_6View = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(710, 340, 140, 90)];
    [item_6View setFont:[UIFont systemFontOfSize:16]];
    [item_6View setTag:1205];
    [item_6View setTextAlignment:NSTextAlignmentCenter];
    if (self.type == 2 || self.type == 3) {
        [item_6View setEditable:NO];
    }
    if ([_articleContentArray count] > 5) {
        NSDictionary* articleContentDict = [_articleContentArray objectAtIndex:5];
        [item_6View setText:[articleContentDict valueForKey:@"articleContent"]];
    }
    [articleView addSubview:item_6View];
    [item_6View release];
}

-(void)addCommentView{
    UIImage* article_Comment_01_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Comment_bg_01" ofType:@"png"]];
    UIImageView* article_Comment_01_View = [[UIImageView alloc] initWithFrame:CGRectMake(725, 80, 274, 164)];
    [article_Comment_01_View setImage:article_Comment_01_Image];
    [articleView addSubview:article_Comment_01_View];
    [article_Comment_01_View release];
    

    
    NSArray* _articleCommentArray = [articleDict valueForKey:@"articleComment"];
    UIExpandingTextView* comment_01View = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(786, 90, 198, 138)];
    [comment_01View setTag:kTagArticleComment01View];
    [comment_01View setFont:[UIFont systemFontOfSize:16]];
    if (self.type == 2 || self.type == 3) {
        [comment_01View setEditable:NO];
    }
    if ([_articleCommentArray count]>0) {
        NSDictionary* comment01Dict = [_articleCommentArray objectAtIndex:0];
        [comment_01View setText:[comment01Dict valueForKey:@"articleComment"]];
    }
    [articleView addSubview:comment_01View];
    [comment_01View release];
    
    UIImage* article_Comment_02_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Comment_bg_02" ofType:@"png"]];
    UIImageView* article_Comment_02_View = [[UIImageView alloc] initWithFrame:CGRectMake(725, 490, 273, 170)];
    [article_Comment_02_View setImage:article_Comment_02_Image];
    [articleView addSubview:article_Comment_02_View];
    [article_Comment_02_View release];
    
    UIExpandingTextView* comment_02View = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(786, 500, 198, 138)];
    [comment_02View setTag:kTagArticleComment02View];
    [comment_02View setFont:[UIFont systemFontOfSize:16]];
    if (self.type == 2 || self.type == 3) {
        [comment_02View setEditable:NO];
    }
    if ([_articleCommentArray count]>1) {
        NSDictionary* comment02Dict = [_articleCommentArray objectAtIndex:1];
        [comment_02View setText:[comment02Dict valueForKey:@"articleComment"]];
    }
    [articleView addSubview:comment_02View];
    [comment_02View release];
}

@end
