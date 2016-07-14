//
//  ZMArticleView07Controller.m
//  ZMEducation
//
//  Created by Hunter Li on 13-5-25.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import "ZMArticleView07Controller.h"

@implementation ZMArticleView07Controller

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

-(void)addDraftView{
    UIImage* article_Title_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_11" ofType:@"png"]];
    UIImageView* article_Title_View = [[UIImageView alloc] initWithFrame:CGRectMake(60, 70, 531, 115)];
    [article_Title_View setImage:article_Title_Image];
    [articleView addSubview:article_Title_View];
    [article_Title_View release];
    
    UIExpandingTextView* titleView = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(145, 90, 413, 70)];
    [titleView setTag:kTagArticleTitleView];
    if (self.type == 2 || self.type == 3) {
        [titleView setEditable:NO];
    }
    [titleView setText:[articleDict valueForKey:@"title"]];
    [titleView setFont:[UIFont boldSystemFontOfSize:16]];
    [articleView addSubview:titleView];
    [titleView release];
    
    UIImage* article_Content_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_12" ofType:@"png"]];
    UIImageView* article_Content_View = [[UIImageView alloc] initWithFrame:CGRectMake(60, 190, 543, 565)];
    [article_Content_View setImage:article_Content_Image];
    [articleView addSubview:article_Content_View];
    [article_Content_View release];
    
    UIExpandingTextView* contentView = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(105, 230, 460, 484)];
    [contentView setFont:[UIFont systemFontOfSize:16]];
    [contentView setTag:kTagArticleDraftView];
    if (self.type == 2 || self.type == 3) {
        [contentView setEditable:NO];
    }
    
    //20140121
    if ([articleDict valueForKey:@"articleDraft"] == nil) {
        [contentView setText:[articleDict valueForKey:@"field1"]];
    }else{
        [contentView setText:[articleDict valueForKey:@"articleDraft"]];
    }
    [articleView addSubview:contentView];
    [contentView release];
}

-(void)addContentView{}

@end
