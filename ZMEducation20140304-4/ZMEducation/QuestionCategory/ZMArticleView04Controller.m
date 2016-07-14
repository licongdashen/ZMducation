//
//  ZMArticleView04Controller.m
//  ZMEducation
//
//  Created by Hunter Li on 13-5-25.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import "ZMArticleView04Controller.h"
#define kTagContentTableView 1200
#define kTagArticleContentView 1201
#import <QuartzCore/QuartzCore.h>

@implementation ZMArticleView04Controller

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
    int articleCellNumber = [[articleDict valueForKey:@"articleCellNumber"] intValue];

    CGFloat height = 80*articleCellNumber;
    if (height>690) {
        height = 690;
    }
    CGRect frame = CGRectMake(320, 80, 380, height);    
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:frame];
    UIColor* bgColor = [UIColor colorWithRed:0 green:136.0/255.0 blue:180.0/255.0 alpha:1];
    [scrollView.layer setBorderColor:[bgColor CGColor]];
    [scrollView.layer setBorderWidth:2];
    scrollView.layer.cornerRadius = 5;
    
    [scrollView setContentSize:CGSizeMake(360, 80*articleCellNumber)];
    for (int i=0; i<articleCellNumber; i++) {
        NSArray* _articleContentArray = [articleDict valueForKey:@"articleContents"];
        NSDictionary* articleContentDict = nil;
        if ([_articleContentArray count] > i) {
            articleContentDict = [_articleContentArray objectAtIndex:i];
        }
        
        UIExpandingTextView* itemView = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(10,10+80*i, 360, 70)];
        [itemView setFont:[UIFont systemFontOfSize:16]];
        [itemView setTag:1200+i];
        if (self.type == 2 || self.type == 3) {
            [itemView setEditable:NO];
        }
        [itemView setText:[articleContentDict valueForKey:@"articleContent"]];
        [scrollView addSubview:itemView];
        [itemView release];
        
        UIImage* separater_lineImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Button_separater_line" ofType:@"png"]];
        UIImageView* separater_lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 78+80*i, 380, 2)];
        [separater_lineView setImage:separater_lineImage];
        [scrollView addSubview:separater_lineView];
        [separater_lineView release];

    }
    [articleView addSubview:scrollView];
    [scrollView release];
    
    
//    UITableView* contentTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
//    [contentTableView setTag:kTagContentTableView];
//    contentTableView.delegate = self;
//    contentTableView.dataSource = self;
//    [contentTableView setBackgroundColor:[UIColor clearColor]];
//    [contentTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    UIColor* bgColor = [UIColor colorWithRed:0 green:136.0/255.0 blue:180.0/255.0 alpha:1];
//    [contentTableView setSeparatorColor:bgColor];
//    [contentTableView.layer setBorderColor:[bgColor CGColor]];
//    [contentTableView.layer setBorderWidth:2];
//    contentTableView.layer.cornerRadius = 5;
//    
//    [articleView addSubview:contentTableView];
//    [contentTableView release];
}

#pragma mark - Table view data source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int tag = tableView.tag;
    if (tag == kTagContentTableView) {
        int articleCellNumber = [[articleDict valueForKey:@"articleCellNumber"] intValue];
        return articleCellNumber;
    }else{
        return [super tableView:tableView numberOfRowsInSection:section];
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"AISRegularEntityCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }else{
        for (UIView *subView in [cell.contentView subviews]){
			[subView removeFromSuperview];
		}
    }
    
    int tag = tableView.tag;
    
    if (tag == kTagContentTableView) {
        NSArray* _articleContentArray = [articleDict valueForKey:@"articleContents"];
        NSDictionary* articleContentDict = nil;
        if ([_articleContentArray count] > indexPath.row) {
            articleContentDict = [_articleContentArray objectAtIndex:indexPath.row];
        }
        
        UIExpandingTextView* itemView = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(10,10, 360, 70)];
        [itemView setFont:[UIFont systemFontOfSize:16]];
        [itemView setTag:kTagArticleContentView];
        if (self.type == 2 || self.type == 3) {
            [itemView setEditable:NO];
        }
        [itemView setText:[articleContentDict valueForKey:@"articleContent"]];
        [cell.contentView addSubview:itemView];
        [itemView release];
        
        UIImage* separater_lineImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Button_separater_line" ofType:@"png"]];
        UIImageView* separater_lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 58, 380, 2)];
        [separater_lineView setImage:separater_lineImage];
        [cell.contentView addSubview:separater_lineView];
        [separater_lineView release];
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
    return cell;
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    int tag = tableView.tag;
    if (tag == kTagContentTableView) {
        if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row){
            if (!flag) {
                [tableView reloadData];
                flag = YES;
            }else{
                flag = NO;
            }
        }
    }
}

#pragma mark - Table view delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    int tag = tableView.tag;
    if (tag == kTagContentTableView) {
        return 60;
    }else{
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    
    return 0;
}

@end
