//
//  ZMScreenControlViewController.m
//  ZMEducation
//
//  Created by Hunter Li on 13-6-4.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import "ZMScreenControlViewController.h"
#define kTagScreenControlButton 1200
#define kTagZcdControlButton 1300
#define kTagZykControlButton 1400
#define kTagShitiControlButton 1500
#define kTagtimuControlButton 1600

@implementation ZMScreenControlViewController

-(void)addUnitLabel:(NSString*)text
          frame:(CGRect)frame
       intoView:(UIView*)view{
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:frame];
    [titleLabel setText:text];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setMinimumScaleFactor:0.7];
    [titleLabel setFont:[UIFont fontWithName:@"MicrosoftYaHei" size:16]];
    [titleLabel setTextColor:[UIColor darkTextColor]];
    [view addSubview:titleLabel];
    [titleLabel release];
}

-(void)setBackgroundView{
    [self.view setBackgroundColor:[UIColor colorWithRed:217.0/255.0 green:217.0/255.0 blue:217.0/255.0 alpha:1.0]];
}

-(void)loadView{
    [super loadView];
    
    UIImage* article_Category_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Category_bg" ofType:@"png"]];
    UIImageView* article_Category_View = [[UIImageView alloc] initWithFrame:CGRectMake(291, 15, 421, 43)];
    [article_Category_View setImage:article_Category_Image];
    [self.view addSubview:article_Category_View];
    [article_Category_View release];
    
    [self addLabel:@"屏幕控制"
             frame:CGRectMake(291, 22, 421, 30)
              size:18
          intoView:self.view];
}

-(void)dealloc{
    [screenControlTableView setDataSource:nil];
    [screenControlTableView setDelegate:nil];
    [screenControlTableView release];
    [unitHide00Array release];
    [unitHide01Array release];
    [unitHide02Array release];
    [unitHide03Array release];
    [unitHide04Array release];
    [unitHide05Array release];
    
    [super dealloc];
}

-(void)getUnitHide{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M034" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}

-(void)getZcdStatus{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M066" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}

-(IBAction)screenConrolClick:(id)sender{
    UIButton* controlBut = (UIButton*)sender;
    [controlBut setSelected:!controlBut.selected];
    
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M011" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    if (controlBut.selected) {
        [requestDict setValue:@"00" forKey:@"screenControl"];
        [userDict setValue:@"00" forKey:@"screenControl"];
    }else{
        [requestDict setValue:@"01" forKey:@"screenControl"];
        [userDict setValue:@"01" forKey:@"screenControl"];
    }
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}

-(IBAction)zcdConrolClick:(id)sender{
    UIButton* controlBut = (UIButton*)sender;
    [controlBut setSelected:!controlBut.selected];
    
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M064" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:@"dictionary" forKey:@"type"];
    if (controlBut.selected) {
        [requestDict setValue:@"00" forKey:@"status"];
        //[userDict setValue:@"00" forKey:@"dictionaryStatus"];
    }else{
        [requestDict setValue:@"01" forKey:@"status"];
        //[userDict setValue:@"01" forKey:@"dictionaryStatus"];
    }
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}

-(IBAction)zykConrolClick:(id)sender{
    UIButton* controlBut = (UIButton*)sender;
    [controlBut setSelected:!controlBut.selected];
    
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M064" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:@"library" forKey:@"type"];
    if (controlBut.selected) {
        [requestDict setValue:@"00" forKey:@"status"];
        //[userDict setValue:@"00" forKey:@"dictionaryStatus"];
    }else{
        [requestDict setValue:@"01" forKey:@"status"];
        //[userDict setValue:@"01" forKey:@"dictionaryStatus"];
    }
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}

-(IBAction)shitiConrolClick:(id)sender{
    UIButton* controlBut = (UIButton*)sender;
    [controlBut setSelected:!controlBut.selected];
    
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M064" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:@"examination" forKey:@"type"];
    if (controlBut.selected) {
        [requestDict setValue:@"00" forKey:@"status"];
        //[userDict setValue:@"00" forKey:@"dictionaryStatus"];
    }else{
        [requestDict setValue:@"01" forKey:@"status"];
        //[userDict setValue:@"01" forKey:@"dictionaryStatus"];
    }
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}

-(void)timuConrolClick:(id)sender
{
    UIButton* controlBut = (UIButton*)sender;
    [controlBut setSelected:!controlBut.selected];
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M064" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:@"examQuestions" forKey:@"type"];
    if (controlBut.selected) {
        [requestDict setValue:@"00" forKey:@"status"];
        //[userDict setValue:@"00" forKey:@"dictionaryStatus"];
    }else{
        [requestDict setValue:@"01" forKey:@"status"];
        //[userDict setValue:@"01" forKey:@"dictionaryStatus"];
    }
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];

}

-(void)setUnitHide:(NSString*)unitId
          moduleId:(NSString*)moduleId
           control:(NSString*)control{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M033" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:moduleId forKey:@"moduleId"];
    [requestDict setValue:unitId forKey:@"unitId"];
    [requestDict setValue:control forKey:@"control"];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];

}

-(IBAction)conrol00Click:(id)sender{
    UIButton* controlBut = (UIButton*)sender;
    [controlBut setSelected:!controlBut.selected];
    int index = controlBut.tag;
    
    NSDictionary* unitHideDict = [unitHide00Array objectAtIndex:index];
    if (controlBut.selected) {
        [self setUnitHide:[unitHideDict valueForKey:@"unitId"]
                 moduleId:@"00"
                  control:@"01"];
    }else{
        [self setUnitHide:[unitHideDict valueForKey:@"unitId"]
                 moduleId:@"00"
                  control:@"02"];
    }
}

-(IBAction)conrol01Click:(id)sender{
    UIButton* controlBut = (UIButton*)sender;
    [controlBut setSelected:!controlBut.selected];
    int index = controlBut.tag;
    
    NSDictionary* unitHideDict = [unitHide01Array objectAtIndex:index];
    if (controlBut.selected) {
        [self setUnitHide:[unitHideDict valueForKey:@"unitId"]
                 moduleId:@"01"
                  control:@"01"];
    }else{
        [self setUnitHide:[unitHideDict valueForKey:@"unitId"]
                 moduleId:@"01"
                  control:@"02"];
    }
}

-(IBAction)conrol02Click:(id)sender{
    UIButton* controlBut = (UIButton*)sender;
    [controlBut setSelected:!controlBut.selected];
    int index = controlBut.tag;
    
    NSDictionary* unitHideDict = [unitHide02Array objectAtIndex:index];
    if (controlBut.selected) {
        [self setUnitHide:[unitHideDict valueForKey:@"unitId"]
                 moduleId:@"02"
                  control:@"01"];
    }else{
        [self setUnitHide:[unitHideDict valueForKey:@"unitId"]
                 moduleId:@"02"
                  control:@"02"];
    }
}

-(IBAction)conrol03Click:(id)sender{
    UIButton* controlBut = (UIButton*)sender;
    [controlBut setSelected:!controlBut.selected];
    int index = controlBut.tag;
    
    NSDictionary* unitHideDict = [unitHide03Array objectAtIndex:index];
    if (controlBut.selected) {
        [self setUnitHide:[unitHideDict valueForKey:@"unitId"]
                 moduleId:@"03"
                  control:@"01"];
    }else{
        [self setUnitHide:[unitHideDict valueForKey:@"unitId"]
                 moduleId:@"03"
                  control:@"02"];
    }
}

-(IBAction)conrol04Click:(id)sender{
    UIButton* controlBut = (UIButton*)sender;
    [controlBut setSelected:!controlBut.selected];
    int index = controlBut.tag;
    
    NSDictionary* unitHideDict = [unitHide04Array objectAtIndex:index];
    if (controlBut.selected) {
        [self setUnitHide:[unitHideDict valueForKey:@"unitId"]
                 moduleId:@"04"
                  control:@"01"];
    }else{
        [self setUnitHide:[unitHideDict valueForKey:@"unitId"]
                 moduleId:@"04"
                  control:@"02"];
    }
}

-(IBAction)conrol05Click:(id)sender{
    UIButton* controlBut = (UIButton*)sender;
    [controlBut setSelected:!controlBut.selected];
     int index = controlBut.tag;
    
    NSDictionary* unitHideDict = [unitHide05Array objectAtIndex:index];
    if (controlBut.selected) {
        [self setUnitHide:[unitHideDict valueForKey:@"unitId"]
                 moduleId:@"05"
                  control:@"01"];
    }else{
        [self setUnitHide:[unitHideDict valueForKey:@"unitId"]
                 moduleId:@"05"
                  control:@"02"];
    }
}

- (void)viewDidLoad{
    [super viewDidLoad];

    unitHide00Array = [[NSMutableArray alloc] initWithCapacity:0];
    unitHide01Array = [[NSMutableArray alloc] initWithCapacity:0];
    unitHide02Array = [[NSMutableArray alloc] initWithCapacity:0];
    unitHide03Array = [[NSMutableArray alloc] initWithCapacity:0];
    unitHide04Array = [[NSMutableArray alloc] initWithCapacity:0];
    unitHide05Array = [[NSMutableArray alloc] initWithCapacity:0];
    
    CGRect frame = CGRectMake(27, 100, 970, 600);
    screenControlTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    screenControlTableView.delegate = self;
    screenControlTableView.dataSource = self;
    [screenControlTableView setBackgroundColor:[UIColor clearColor]];
    [screenControlTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    UIView* headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 970, 100)];
    
    [self addLabel:@"是否锁屏"
             frame:CGRectMake(10, 10, 100, 30)
              size:16
          intoView:headView];
    
    UIButton* controlBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [controlBut setTag:kTagScreenControlButton];
    [controlBut setFrame:CGRectMake(107, 13, 25, 25)];
    [controlBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Btn" ofType:@"png"]] forState:UIControlStateNormal];
    [controlBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
    [controlBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Select_Btn" ofType:@"png"]] forState:UIControlStateSelected];
    [controlBut addTarget:self
                   action:@selector(screenConrolClick:)
         forControlEvents:UIControlEventTouchUpInside];
    
    {
        [self addLabel:@"字词典(隐藏)"
                 frame:CGRectMake(188, 10, 120, 30)
                  size:16
              intoView:headView];
        
        UIButton* controlBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [controlBut setTag:kTagZcdControlButton];
        [controlBut setFrame:CGRectMake(300, 13, 25, 25)];
        [controlBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Btn" ofType:@"png"]] forState:UIControlStateNormal];
        [controlBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
        [controlBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Select_Btn" ofType:@"png"]] forState:UIControlStateSelected];
        [controlBut addTarget:self
                       action:@selector(zcdConrolClick:)
             forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:controlBut];
    }
    
    {
        [self addLabel:@"资源库(隐藏)"
                 frame:CGRectMake(350, 10, 120, 30)
                  size:16
              intoView:headView];
        
        UIButton* controlBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [controlBut setTag:kTagZykControlButton];
        [controlBut setFrame:CGRectMake(462, 13, 25, 25)];
        [controlBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Btn" ofType:@"png"]] forState:UIControlStateNormal];
        [controlBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
        [controlBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Select_Btn" ofType:@"png"]] forState:UIControlStateSelected];
        [controlBut addTarget:self
                       action:@selector(zykConrolClick:)
             forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:controlBut];
    }
    
    {
        [self addLabel:@"试题浏览(隐藏)"
                 frame:CGRectMake(520, 10, 120, 30)
                  size:16
              intoView:headView];
        
        UIButton* controlBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [controlBut setTag:kTagShitiControlButton];
        [controlBut setFrame:CGRectMake(635, 13, 25, 25)];
        [controlBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Btn" ofType:@"png"]] forState:UIControlStateNormal];
        [controlBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
        [controlBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Select_Btn" ofType:@"png"]] forState:UIControlStateSelected];
        [controlBut addTarget:self
                       action:@selector(shitiConrolClick:)
             forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:controlBut];
    }
    
    {
        [self addLabel:@"试题题目(隐藏)"
                 frame:CGRectMake(690, 10, 120, 30)
                  size:16
              intoView:headView];
        
        UIButton* controlBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [controlBut setTag:kTagtimuControlButton];
        [controlBut setFrame:CGRectMake(635 + 170, 13, 25, 25)];
        [controlBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Btn" ofType:@"png"]] forState:UIControlStateNormal];
        [controlBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
        [controlBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Select_Btn" ofType:@"png"]] forState:UIControlStateSelected];
        [controlBut addTarget:self
                       action:@selector(timuConrolClick:)
             forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:controlBut];
    }

    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSLog(@"userDict:%@",userDict);
    NSString* screenControl = [userDict valueForKey:@"screenControl"];
    if ([@"01" isEqualToString:screenControl]) {
        [controlBut setSelected:NO];
    }else if([@"00" isEqualToString:screenControl]){
        [controlBut setSelected:YES];
    }
    [headView addSubview:controlBut];
    
    UIImage* separater_line00Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Button_separater_line" ofType:@"png"]];
    UIImageView* separater_line00View = [[UIImageView alloc] initWithFrame:CGRectMake(0, 48, 970, 2)];
    [separater_line00View setImage:separater_line00Image];
    [headView addSubview:separater_line00View];
    [separater_line00View release];
    
    [self addLabel:@"阅读(隐藏)"
             frame:CGRectMake(0, 50, 160, 30)
              size:16
          intoView:headView];
    [self addLabel:@"指导(隐藏)"
             frame:CGRectMake(160, 50, 160, 30)
              size:16
          intoView:headView];
    [self addLabel:@"构思(隐藏)"
             frame:CGRectMake(320, 50, 160, 30)
              size:16
          intoView:headView];
    [self addLabel:@"起草(隐藏)"
             frame:CGRectMake(480, 50, 160, 30)
              size:16
          intoView:headView];
    [self addLabel:@"修改(隐藏)"
             frame:CGRectMake(640, 50, 160, 30)
              size:16
          intoView:headView];
    [self addLabel:@"校对(隐藏)"
             frame:CGRectMake(800, 50, 160, 30)
              size:16
          intoView:headView];
    UIImage* separater_line01Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Button_separater_line" ofType:@"png"]];
    UIImageView* separater_line01View = [[UIImageView alloc] initWithFrame:CGRectMake(0, 98, 970, 2)];
    [separater_line01View setImage:separater_line01Image];
    [headView addSubview:separater_line01View];
    [separater_line01View release];
    [screenControlTableView setTableHeaderView:headView];
    [headView release];

    [self.view addSubview:screenControlTableView];
    
    [self getUnitHide];
    [self getZcdStatus];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int count = [unitHide00Array count];
    
    if ([unitHide01Array count] > count) {
        count = [unitHide01Array count];
    }
    
    if ([unitHide02Array count] > count) {
        count = [unitHide02Array count];
    }

    if ([unitHide03Array count] > count) {
        count = [unitHide03Array count];
    }

    if ([unitHide04Array count] > count) {
        count = [unitHide04Array count];
    }

    if ([unitHide05Array count] > count) {
        count = [unitHide05Array count];
    }

    return count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }else{
        for (UIView *subView in [cell.contentView subviews]){
			[subView removeFromSuperview];
		}
    }
    cell.backgroundColor = [UIColor clearColor];
    if ([unitHide00Array count] > indexPath.row) {
        NSDictionary* unitHide00Dict = [unitHide00Array objectAtIndex:indexPath.row];
  
        [self addUnitLabel:[unitHide00Dict valueForKey:@"unit"]
                 frame:CGRectMake(0, 10, 140, 30)
              intoView:cell.contentView];

        UIButton* controlBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [controlBut setTag:indexPath.row];
        [controlBut setFrame:CGRectMake(137, 13, 25, 25)];
        [controlBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Btn" ofType:@"png"]] forState:UIControlStateNormal];
        [controlBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
        [controlBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Select_Btn" ofType:@"png"]] forState:UIControlStateSelected];
        [controlBut addTarget:self
                     action:@selector(conrol00Click:)
           forControlEvents:UIControlEventTouchUpInside];
        NSString* control = [unitHide00Dict valueForKey:@"control"];
        if ([@"02" isEqualToString:control]) {
            [controlBut setSelected:NO];
        }else if([@"01" isEqualToString:control]){
            [controlBut setSelected:YES];
        }
        [cell.contentView addSubview:controlBut];
    }
    
    if ([unitHide01Array count] > indexPath.row) {
        NSDictionary* unitHide01Dict = [unitHide01Array objectAtIndex:indexPath.row];
        
        [self addUnitLabel:[unitHide01Dict valueForKey:@"unit"]
                 frame:CGRectMake(160, 10, 140, 30)
              intoView:cell.contentView];
        
        UIButton* controlBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [controlBut setTag:indexPath.row];
        [controlBut setFrame:CGRectMake(297, 13, 25, 25)];
        [controlBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Btn" ofType:@"png"]] forState:UIControlStateNormal];
        [controlBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
        [controlBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Select_Btn" ofType:@"png"]] forState:UIControlStateSelected];
        [controlBut addTarget:self
                       action:@selector(conrol01Click:)
             forControlEvents:UIControlEventTouchUpInside];
        NSString* control = [unitHide01Dict valueForKey:@"control"];
        if ([@"02" isEqualToString:control]) {
            [controlBut setSelected:NO];
        }else if([@"01" isEqualToString:control]){
            [controlBut setSelected:YES];
        }
        [cell.contentView addSubview:controlBut];
    }

    
    if ([unitHide02Array count] > indexPath.row) {
        NSDictionary* unitHide02Dict = [unitHide02Array objectAtIndex:indexPath.row];
        
        [self addUnitLabel:[unitHide02Dict valueForKey:@"unit"]
                 frame:CGRectMake(320, 10, 140, 30)
              intoView:cell.contentView];
        
        UIButton* controlBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [controlBut setTag:indexPath.row];
        [controlBut setFrame:CGRectMake(457, 13, 25, 25)];
        [controlBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Btn" ofType:@"png"]] forState:UIControlStateNormal];
        [controlBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
        [controlBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Select_Btn" ofType:@"png"]] forState:UIControlStateSelected];
        [controlBut addTarget:self
                       action:@selector(conrol02Click:)
             forControlEvents:UIControlEventTouchUpInside];
        NSString* control = [unitHide02Dict valueForKey:@"control"];
        if ([@"02" isEqualToString:control]) {
            [controlBut setSelected:NO];
        }else if([@"01" isEqualToString:control]){
            [controlBut setSelected:YES];
        }
        [cell.contentView addSubview:controlBut];
    }

    if ([unitHide03Array count] > indexPath.row) {
        NSDictionary* unitHide03Dict = [unitHide03Array objectAtIndex:indexPath.row];
        
        [self addUnitLabel:[unitHide03Dict valueForKey:@"unit"]
                 frame:CGRectMake(480, 10, 140, 30)
              intoView:cell.contentView];
        
        UIButton* controlBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [controlBut setTag:indexPath.row];
        [controlBut setFrame:CGRectMake(617, 13, 25, 25)];
        [controlBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Btn" ofType:@"png"]] forState:UIControlStateNormal];
        [controlBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
        [controlBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Select_Btn" ofType:@"png"]] forState:UIControlStateSelected];
        [controlBut addTarget:self
                       action:@selector(conrol03Click:)
             forControlEvents:UIControlEventTouchUpInside];
        NSString* control = [unitHide03Dict valueForKey:@"control"];
        if ([@"02" isEqualToString:control]) {
            [controlBut setSelected:NO];
        }else if([@"01" isEqualToString:control]){
            [controlBut setSelected:YES];
        }
        [cell.contentView addSubview:controlBut];
    }

    if ([unitHide04Array count] > indexPath.row) {
        NSDictionary* unitHide04Dict = [unitHide04Array objectAtIndex:indexPath.row];

        [self addUnitLabel:[unitHide04Dict valueForKey:@"unit"]
                 frame:CGRectMake(640, 10, 140, 30)
              intoView:cell.contentView];
        
        UIButton* controlBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [controlBut setTag:indexPath.row];
        [controlBut setFrame:CGRectMake(777, 13, 25, 25)];
        [controlBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Btn" ofType:@"png"]] forState:UIControlStateNormal];
        [controlBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
        [controlBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Select_Btn" ofType:@"png"]] forState:UIControlStateSelected];
        [controlBut addTarget:self
                       action:@selector(conrol04Click:)
             forControlEvents:UIControlEventTouchUpInside];
        NSString* control = [unitHide04Dict valueForKey:@"control"];
        if ([@"02" isEqualToString:control]) {
            [controlBut setSelected:NO];
        }else if([@"01" isEqualToString:control]){
            [controlBut setSelected:YES];
        }
        [cell.contentView addSubview:controlBut];
    }

    if ([unitHide05Array count] > indexPath.row) {
        NSDictionary* unitHide05Dict = [unitHide05Array objectAtIndex:indexPath.row];

        [self addUnitLabel:[unitHide05Dict valueForKey:@"unit"]
                 frame:CGRectMake(800, 10, 140, 30)
              intoView:cell.contentView];
        
        UIButton* controlBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [controlBut setTag:indexPath.row];
        [controlBut setFrame:CGRectMake(937, 13, 25, 25)];
        [controlBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Btn" ofType:@"png"]] forState:UIControlStateNormal];
        [controlBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
        [controlBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Select_Btn" ofType:@"png"]] forState:UIControlStateSelected];
        [controlBut addTarget:self
                       action:@selector(conrol05Click:)
             forControlEvents:UIControlEventTouchUpInside];
        NSString* control = [unitHide05Dict valueForKey:@"control"];
        if ([@"02" isEqualToString:control]) {
            [controlBut setSelected:NO];
        }else if([@"01" isEqualToString:control]){
            [controlBut setSelected:YES];
        }
        [cell.contentView addSubview:controlBut];
    }
    
    UIImage* separater_lineImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Work_Browse_Button_separater_line" ofType:@"png"]];
    UIImageView* separater_lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 48, 970, 2)];
    [separater_lineView setImage:separater_lineImage];
    [cell.contentView addSubview:separater_lineView];
    [separater_lineView release];
    
    return cell;
}

#pragma mark - Table view delegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark ZMHttpEngineDelegate
-(void)httpEngine:(ZMHttpEngine *)httpEngine didSuccess:(NSDictionary *)responseDict{
    [super httpEngine:httpEngine didSuccess:responseDict];
    
    NSString* method = [responseDict valueForKey:@"method"];
    NSString* responseCode = [responseDict valueForKey:@"responseCode"];
    if ([@"M034" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        [unitHide00Array removeAllObjects];
        [unitHide01Array removeAllObjects];
        [unitHide02Array removeAllObjects];
        [unitHide03Array removeAllObjects];
        [unitHide04Array removeAllObjects];
        [unitHide05Array removeAllObjects];
        
        NSArray* _unitHideArray = [responseDict valueForKey:@"unitHideList"];
        for (int i=0; i<[_unitHideArray count]; i++) {
            NSLog(@"unitHide:%@",[_unitHideArray objectAtIndex:i]);
            NSDictionary* unitHideDict = [_unitHideArray objectAtIndex:i];
            NSString* moduleId = [unitHideDict valueForKey:@"moduleId"];
            if ([@"00" isEqualToString:moduleId]) {
                [unitHide00Array addObject:unitHideDict];
            }else if ([@"01" isEqualToString:moduleId]) {
                [unitHide01Array addObject:unitHideDict];
            }else if ([@"02" isEqualToString:moduleId]) {
                [unitHide02Array addObject:unitHideDict];
            }else if ([@"03" isEqualToString:moduleId]) {
                [unitHide03Array addObject:unitHideDict];
            }else if ([@"04" isEqualToString:moduleId]) {
                [unitHide04Array addObject:unitHideDict];
            }else if ([@"05" isEqualToString:moduleId]) {
                [unitHide05Array addObject:unitHideDict];
            }
        }

        [screenControlTableView reloadData];
    }else if ([@"M011" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        //成功
    }else if ([@"M033" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        //成功
    }else if ([@"M064" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        //成功
    }
    else if ([@"M066" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        
        NSString * libstatusStr = [responseDict valueForKey:@"library"];
        NSString * dicstatusStr = [responseDict valueForKey:@"dictionary"];
        NSString * exastatusStr = [responseDict valueForKey:@"examination"];
        NSString * examQuestionsStr = [responseDict valueForKey:@"examQuestions"];
        if([@"00" isEqualToString:libstatusStr]){
            UIButton* shareBtn = (UIButton*)[self.view viewWithTag:kTagZykControlButton];
            [shareBtn setSelected:YES];
        }
        if([@"00" isEqualToString:dicstatusStr]){
            UIButton* shareBtn = (UIButton*)[self.view viewWithTag:kTagZcdControlButton];
            [shareBtn setSelected:YES];
        }
        if([@"00" isEqualToString:exastatusStr]){
            UIButton* shareBtn = (UIButton*)[self.view viewWithTag:kTagShitiControlButton];
            [shareBtn setSelected:YES];
        }
        if([@"00" isEqualToString:examQuestionsStr]){
            UIButton* shareBtn = (UIButton*)[self.view viewWithTag:kTagtimuControlButton];
            [shareBtn setSelected:YES];
        }
    }else if(![@"00" isEqualToString:responseCode]){
        [self showTip:@"服务器异常"];
    }
}

@end
