//
//  ZMHomeViewController.m
//  ZMEducation
//
//  Created by Hunter Li on 13-5-7.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import "ZMSwipeViewController.h"
#import "ZMHomeViewController.h"

@implementation ZMHomeViewController
@synthesize moduleArray = _moduleArray;

-(IBAction)backClick:(id)sender{
    [self screenLocked];
    
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSString* screenControl = [userDict valueForKey:@"screenControl"];
    NSString* role = [userDict valueForKey:@"role"];
    if ([@"02" isEqualToString:role] ||
        (([@"03" isEqualToString:role] || [@"04" isEqualToString:role])&& [@"01" isEqualToString:screenControl])) {
        if ([@"00" isEqualToString:screenControl]) {
            NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
            [requestDict setValue:@"M012" forKey:@"method"];
            [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
            [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
            [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
            [requestDict setValue:[userDict valueForKey:@"currentModuleId"] forKey:@"moduleId"];
            [requestDict setValue:@"03" forKey:@"control"];
            
            ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
            [httpEngine setDelegate:self];
            [httpEngine requestWithDict:requestDict];
            [httpEngine release];
            [requestDict release];
        }
        NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
        
        NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
        [requestDict setValue:@"M002" forKey:@"method"];
        [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
        
        ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
        [httpEngine setDelegate:self];
        [httpEngine requestWithDict:requestDict];
        [httpEngine release];
        [requestDict release];
    }
}

-(void)addLabel:(NSString*)text
          frame:(CGRect)frame{
    [self addLabel:text
             frame:frame
     textAlignment:NSTextAlignmentCenter
               tag:0
              size:18.0f
         textColor:[UIColor whiteColor]
          intoView:self.view];
}

//获取模板列表
-(void)getModuleListAtIndex:(int)index{
    NSDictionary* moduleDict = [_moduleArray objectAtIndex:index];
    
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M006" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[moduleDict valueForKey:@"moduleId"] forKey:@"moduleId"];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}

-(IBAction)moduleButClick:(id)sender{
    [self screenLocked];
    
    UIButton* moduleButton = (UIButton*)sender;
    int index = moduleButton.tag;
    
    NSDictionary* moduleDict = [_moduleArray objectAtIndex:index];
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    [userDict setValue:[moduleDict valueForKey:@"moduleId"] forKey:@"currentModuleId"];
    [userDict setObject:@"1" forKey:@"articleMode"];
    //NSLog(@"userDict:%@",userDict);
    NSString* screenControl = [userDict valueForKey:@"screenControl"];
    NSString* role = [userDict valueForKey:@"role"];
    if ([@"02" isEqualToString:role]) {
        if ([@"00" isEqualToString:screenControl]) {
            NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
            [requestDict setValue:@"M012" forKey:@"method"];
            [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
            [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
            [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
            [requestDict setValue:[userDict valueForKey:@"currentModuleId"] forKey:@"moduleId"];
            [requestDict setValue:@"01" forKey:@"control"];
            
            ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
            [httpEngine setDelegate:self];
            [httpEngine requestWithDict:requestDict];
            [httpEngine release];
            [requestDict release];
        }
        
        [self getModuleListAtIndex:index];
    }else if([@"03" isEqualToString:role] || [@"04" isEqualToString:role]){
        if ([@"01" isEqualToString:screenControl]) {
            [self getModuleListAtIndex:index];
        }
    }
}

-(void)dealloc{
    [moduleView setDataSource:nil];
    [moduleView release];
    [_moduleArray release];
    
    [super dealloc];
}

-(void)loadView{
    [super loadView];
    
    moduleView = [[GMGridView alloc] initWithFrame:CGRectMake(60,167,904,550)];
    moduleView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    moduleView.backgroundColor = [UIColor clearColor];
    moduleView.style = GMGridViewStylePush;
    moduleView.itemSpacing = 30;
    moduleView.minEdgeInsets = UIEdgeInsetsMake(10, 0, 10, 0);
    moduleView.dataSource = self;
    
    [self.view addSubview:moduleView];
}

#pragma mark GMGridViewDataSource
- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView{
    return [_moduleArray count];
}

- (CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation{
    return CGSizeMake(230, 250);
}

- (GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index{
    CGSize size = [self GMGridView:gridView sizeForItemsInInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    
    GMGridViewCell *cell = [gridView dequeueReusableCell];
    if (!cell){
        cell = [[[GMGridViewCell alloc] init] autorelease];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        view.backgroundColor = [UIColor clearColor];
        
        cell.contentView = view;
        [view release];
    }else{
        for(UIView* subView in [cell.contentView subviews]){
            [subView removeFromSuperview];
        }
    }
    
    NSDictionary* moduleDict = [_moduleArray objectAtIndex:index];
    UIButton* moduleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [moduleButton setTag:index];
    [moduleButton setFrame:CGRectMake(4, 0.0f, 222, 222)];
    [moduleButton setImage:[UIImage imageWithContentsOfFile:
                             [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"Menu%d",index+1] ofType:@"png"]]
                   forState:UIControlStateNormal];
    [moduleButton setImage:[UIImage imageWithContentsOfFile:
                             [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"Menu%d",index+1] ofType:@"png"]]
                   forState:UIControlStateHighlighted];
    [moduleButton addTarget:self action:@selector(moduleButClick:)
            forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:moduleButton];
    
    //[[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 220, 230, 30.0f)];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setText:[moduleDict valueForKey:@"module"]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setMinimumScaleFactor:1.0];
    [titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:20]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [cell.contentView addSubview:titleLabel];
    [titleLabel release];
    
    return cell;
}


- (BOOL)GMGridView:(GMGridView *)gridView canDeleteItemAtIndex:(NSInteger)index{
    return NO; //index % 2 == 0;
}

#pragma mark ZMHttpEngineDelegate
-(void)httpEngine:(ZMHttpEngine *)httpEngine didSuccess:(NSDictionary *)responseDict{
    [super httpEngine:httpEngine didSuccess:responseDict];
    
    NSString* method = [responseDict valueForKey:@"method"];
    NSString* responseCode = [responseDict valueForKey:@"responseCode"];
    if ([@"M006" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        NSMutableArray* dataSource = [[NSMutableArray alloc] initWithCapacity:0];
        
        NSArray* _unitArray = [responseDict valueForKey:@"units"];
        for (int i=0; i<[_unitArray count]; i++) {
            [dataSource addObject:[_unitArray objectAtIndex:i]];
        }
        if ([dataSource count] > 0) {
            ZMSwipeViewController* swipeView = [[ZMSwipeViewController alloc] init];
            [swipeView setUnitArray:dataSource];
            [self.navigationController pushViewController:swipeView animated:YES];
            [swipeView release];
            [dataSource release];
        }else{
            [self showTip:@"暂无内容"];
        }
        
    }else if ([@"M012" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        NSString* control = [responseDict valueForKey:@"control"];
        if ([@"01" isEqualToString:control]) {
            NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
            int index = [[userDict valueForKey:@"currentModuleId"] intValue];
            [self getModuleListAtIndex:index];
        }
    }else if ([@"M002" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else if(![@"00" isEqualToString:responseCode]){
        [self showTip:@"服务器异常"];
    }
}

@end
