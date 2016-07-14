//
//  ZMArticleView01Controller.m
//  ZMEducation
//
//  Created by Hunter Li on 13-5-24.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import "ZMArticleView01Controller.h"

@implementation ZMArticleView01Controller

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
    int articleCellNumber = [[articleDict valueForKey:@"articleCellNumber"] intValue];
    for (int i=0; i<articleCellNumber; i++) {
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
    int _count = 0;
    
    int articleCellNumber = [[articleDict valueForKey:@"articleCellNumber"] intValue];
    if (articleCellNumber>1) {
        if((articleCellNumber-1)%2 == 0){
            _count = (articleCellNumber-1)/2;
        }else{
            _count = (articleCellNumber-1)/2+1;
        }
        
        NSArray* _articleContentArray = [articleDict valueForKey:@"articleContents"];

        UIScrollView* scrollView = [[UIScrollView alloc] init];
        [scrollView setFrame:CGRectMake(300, 60, 420, 690)];
        [scrollView setContentSize:CGSizeMake(420, 100+195*_count)];
        
        UIImageView* article_Item_View = [[UIImageView alloc] init];
        UIImage* article_Item_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_03" ofType:@"png"]];
        [article_Item_View setFrame:CGRectMake(27, 0, 339, 105)];
        [article_Item_View setImage:article_Item_Image];
        [scrollView addSubview:article_Item_View];
        [article_Item_View release];
        
        UIExpandingTextView* itemView = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(66, 18, 266, 68)];
        [itemView setFont:[UIFont systemFontOfSize:16]];
        [itemView setTag:1200];
        if (self.type == 2 || self.type == 3) {
            [itemView setEditable:NO];
        }
        
        if ([_articleContentArray count] > 0 && articleCellNumber > 0) {
            NSDictionary* articleContentDict = [_articleContentArray objectAtIndex:0];
            [itemView setText:[articleContentDict valueForKey:@"articleContent"]];
        }
        
        [scrollView addSubview:itemView];
        [itemView release];
        
        //备注
//        {
//            
//            
//            NSArray* _articleContentArray = [articleDict valueForKey:@"articleComments"];
//            
//            if ([_articleContentArray count ] > 0) {
//                
//                for (int i = 0; i<[_articleContentArray count]; i++) {
//                    if (i == 0) {
//                        UIExpandingTextView* comment01View = (UIExpandingTextView*)[articleView viewWithTag:kTagArticleComment01View];
//                        comment01View.text = [_articleContentArray[0] valueForKey:@"articleComment"];
//                    }else if (i == 1){
//                        UIExpandingTextView* comment02View = (UIExpandingTextView*)[articleView viewWithTag:kTagArticleComment02View];
//                        comment02View.text = [_articleContentArray[1] valueForKey:@"articleComment"];
//                    }else if (i == 2){
//                        UIExpandingTextView* comment03View = (UIExpandingTextView*)[articleView viewWithTag:kTagArticleComment03View];
//                        comment03View.text = [_articleContentArray[2] valueForKey:@"articleComment"];
//                    }
//                }
//                
//                
//            }
        
            
            
       // }
        
        for (int i=0; i<_count; i++) {
            if (articleCellNumber>2*i+1) {
                UIImageView* article_Item_Left_View = [[UIImageView alloc] init];
                UIImage* article_Item_Left_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_04" ofType:@"png"]];
                [article_Item_Left_View setFrame:CGRectMake(7, 100+195*i, 192, 200)];
                [article_Item_Left_View setImage:article_Item_Left_Image];
                [scrollView addSubview:article_Item_Left_View];
                [article_Item_Left_View release];
                
                UIExpandingTextView* item_LeftView = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(32, 195*i+168, 142, 104)];
                [item_LeftView setTag:(1201+2*i)];
                [item_LeftView setFont:[UIFont systemFontOfSize:16]];
                if (self.type == 2 || self.type == 3) {
                    [item_LeftView setEditable:NO];
                }
                if ([_articleContentArray count] > 2*i+1) {
                    NSDictionary* articleContentDict = [_articleContentArray objectAtIndex:2*i+1];
                    [item_LeftView setText:[articleContentDict valueForKey:@"articleContent"]];
                }
                [scrollView addSubview:item_LeftView];
                [item_LeftView release];
            }

            if (articleCellNumber > 2*i+2) {
                UIImageView* article_Item_Right_View = [[UIImageView alloc] init];
                UIImage* article_Item_Right_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_04" ofType:@"png"]];
                [article_Item_Right_View setFrame:CGRectMake(207, 100+195*i, 192, 200)];
                [article_Item_Right_View setImage:article_Item_Right_Image];
                [scrollView addSubview:article_Item_Right_View];
                [article_Item_Right_View release];
                
                UIExpandingTextView* item_RightView = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(232, 195*i+168, 142, 104)];
                [item_RightView setTag:(1201+2*i+1)];
                if (self.type == 2 || self.type == 3) {
                    [item_RightView setEditable:NO];
                }
                if ([_articleContentArray count] > 2*i+2) {
                    NSDictionary* articleContentDict = [_articleContentArray objectAtIndex:2*i+2];
                    [item_RightView setText:[articleContentDict valueForKey:@"articleContent"]];
                }
                [item_RightView setFont:[UIFont systemFontOfSize:16]];
                [scrollView addSubview:item_RightView];
                [item_RightView release];
            }
        }
        
        [articleView addSubview:scrollView];
        [scrollView release];
    }
}

@end
