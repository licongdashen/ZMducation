//
//  ZMCheckItemViewController.m
//  ZMEducation
//
//  Created by Hunter Li on 13-6-4.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import "ZMCheckItemViewController.h"
#define kTagContentTableView 2190

@implementation ZMCheckItemViewController
//@synthesize unitDict = _unitDict;

-(IBAction)checkedButtonClick:(id)sender{
    UIButton* checkedBtn = (UIButton*)sender;
    int index = [checkedBtn tag];
    
    [checkedBtn setSelected:!checkedBtn.selected];
    
    NSMutableDictionary* itemDict = [checkItemArray objectAtIndex:index];
    if (checkedBtn.selected) {
        [itemDict setValue:@"01" forKey:@"checked"];
    }else{
        [itemDict setValue:@"00" forKey:@"checked"];
    }
}

-(void)dealloc{
    UITableView* checkItemTableView = (UITableView*)[self.view viewWithTag:kTagContentTableView];
    [checkItemTableView setDataSource:nil];
    [checkItemTableView setDelegate:nil];
    [checkItemArray release];
    
    //[_unitDict release];
    
    [super dealloc];
}

-(void)getArticleInfo{
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M019" forKey:@"method"];
    [requestDict setValue:[self.unitDict valueForKey:@"courseId"] forKey:@"courseId"];
    [requestDict setValue:[self.unitDict valueForKey:@"classId"] forKey:@"classId"];
    [requestDict setValue:[self.unitDict valueForKey:@"gradeId"] forKey:@"gradeId"];
    [requestDict setValue:[self.unitDict valueForKey:@"moduleId"] forKey:@"moduleId"];
    [requestDict setValue:[self.unitDict valueForKey:@"authorId"] forKey:@"userId"];
    [requestDict setValue:[self.unitDict valueForKey:@"unitId"] forKey:@"unitId"];
    [requestDict setValue:[self.unitDict valueForKey:@"recordId"] forKey:@"recordId"];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}

//-(void)loadView{
//    [super loadView];
//    
//    UIImage* article_Title_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_15" ofType:@"png"]];
//    UIImageView* article_Title_View = [[UIImageView alloc] initWithFrame:CGRectMake(55, 85, 909, 560)];
//    [article_Title_View setImage:article_Title_Image];
//    [self.view addSubview:article_Title_View];
//    [article_Title_View release];
//    
//    
//}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    UIImage* article_Title_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Item_15" ofType:@"png"]];
    UIImageView* article_Title_View = [[UIImageView alloc] initWithFrame:CGRectMake(55, 85, 909, 560)];
    [article_Title_View setImage:article_Title_Image];
    [articleView addSubview:article_Title_View];
    [article_Title_View release];

    checkItemArray = [[NSMutableArray alloc] initWithCapacity:0];
    CGRect frame = CGRectMake(65, 100, 889, 520);
    UITableView* checkItemTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    
    [checkItemTableView setTag:kTagContentTableView];
    checkItemTableView.delegate = self;
    checkItemTableView.dataSource = self;
    [checkItemTableView setBackgroundColor:[UIColor clearColor]];
    [checkItemTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [articleView addSubview:checkItemTableView];
    [checkItemTableView release];

}

-(void)submitWork{
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M039" forKey:@"method"];
    [requestDict setValue:[self.unitDict valueForKey:@"courseId"] forKey:@"courseId"];
    [requestDict setValue:[self.unitDict valueForKey:@"classId"] forKey:@"classId"];
    [requestDict setValue:[self.unitDict valueForKey:@"gradeId"] forKey:@"gradeId"];
    [requestDict setValue:[self.unitDict valueForKey:@"moduleId"] forKey:@"moduleId"];
    [requestDict setValue:[self.unitDict valueForKey:@"authorId"] forKey:@"userId"];
    [requestDict setValue:[self.unitDict valueForKey:@"unitId"] forKey:@"unitId"];

    NSMutableArray* _checkedItemArray = [[NSMutableArray alloc] initWithCapacity:0];
    for(NSDictionary* dict in checkItemArray){
        NSDictionary* _checkedItemDict = [NSDictionary dictionaryWithObjectsAndKeys:[dict valueForKey:@"itemId"],@"itemId",[dict valueForKey:@"checked"],@"checked", nil];
        [_checkedItemArray addObject:_checkedItemDict];
    }
    [requestDict setValue:[_checkedItemArray JSONString] forKey:@"items"];
    [_checkedItemArray release];
    
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

#pragma mark - Table view data source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int tag = tableView.tag;
    if (tag == kTagContentTableView) {
        return [checkItemArray count];
    }else{
        return [super tableView:tableView numberOfRowsInSection:section];
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"AISRegularEntityCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.backgroundColor = [UIColor clearColor];
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
        NSDictionary* itemDict = [checkItemArray objectAtIndex:indexPath.row];
        
        UIButton* checkedBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [checkedBut setTag:indexPath.row];
        [checkedBut setFrame:CGRectMake(47, 13, 25, 25)];
        [checkedBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Btn" ofType:@"png"]] forState:UIControlStateNormal];
        [checkedBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
        [checkedBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Select_Btn" ofType:@"png"]] forState:UIControlStateSelected];
        [checkedBut addTarget:self
                       action:@selector(checkedButtonClick:)
             forControlEvents:UIControlEventTouchUpInside];
        NSString* checked = [itemDict valueForKey:@"checked"];
        if ([@"00" isEqualToString:checked]) {
            [checkedBut setSelected:NO];
        }else if([@"01" isEqualToString:checked]){
            [checkedBut setSelected:YES];
        }
        [cell.contentView addSubview:checkedBut];
        
        [self addLabel:[itemDict valueForKey:@"item"]
                 frame:CGRectMake(100, 10, 600, 30)
         textAlignment:NSTextAlignmentLeft
                   tag:0
                  size:18
             textColor:[UIColor darkTextColor]
              intoView:cell.contentView];
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
    return cell;
}

#pragma mark - Table view delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    int tag = tableView.tag;
    if (tag == kTagContentTableView) {
        return 50;
    }else{
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    
    return 0;
}

-(void)tableView:(UITableView*)tableView  willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}

#pragma mark ZMHttpEngineDelegate
-(void)httpEngine:(ZMHttpEngine *)httpEngine didSuccess:(NSDictionary *)responseDict{
    NSString* method = [responseDict valueForKey:@"method"];
    NSString* responseCode = [responseDict valueForKey:@"responseCode"];
    if ([@"M019" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        [self addLabel:[responseDict valueForKey:@"unitTitle"]
                 frame:CGRectMake(291, 22, 421, 30)
                  size:18
              intoView:articleView];
        
        [checkItemArray removeAllObjects];
        
        NSArray* _itemArray = [responseDict valueForKey:@"items"];
        for (int i=0; i<[_itemArray count]; i++) {
            NSLog(@"item:%@",[_itemArray objectAtIndex:i]);
            NSMutableDictionary* itemDict = [NSMutableDictionary dictionaryWithDictionary:[_itemArray objectAtIndex:i]];
            [checkItemArray addObject:itemDict];
        }
        
        UITableView* checkItemTableView = (UITableView*)[self.view viewWithTag:kTagContentTableView];
        [checkItemTableView reloadData];
        
        [self hideIndicator];
    }else if([@"M039" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        UIButton* shareBtn = (UIButton*)[self.view viewWithTag:kTagShareButton];
        if (shareBtn.selected) {
            NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
            [requestDict setValue:@"M026" forKey:@"method"];
            [requestDict setValue:[self.unitDict valueForKey:@"courseId"] forKey:@"courseId"];
            [requestDict setValue:[self.unitDict valueForKey:@"classId"] forKey:@"classId"];
            [requestDict setValue:[self.unitDict valueForKey:@"gradeId"] forKey:@"gradeId"];
            [requestDict setValue:[self.unitDict valueForKey:@"moduleId"] forKey:@"moduleId"];
            [requestDict setValue:[self.unitDict valueForKey:@"authorId"] forKey:@"userId"];
            [requestDict setValue:[self.unitDict valueForKey:@"unitId"] forKey:@"unitId"];
            
            ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
            [httpEngine setDelegate:self];
            [httpEngine requestWithDict:requestDict];
            [httpEngine release];
            [requestDict release];
        }
        
        [self hideIndicator];
    }else{
        [super httpEngine:httpEngine didSuccess:responseDict];
    }
}

@end
