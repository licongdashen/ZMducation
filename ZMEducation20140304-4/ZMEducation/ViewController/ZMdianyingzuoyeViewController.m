//
//  ZMdianyingzuoyeViewController.m
//  ZMEducation
//
//  Created by Queen on 16/7/25.
//  Copyright © 2016年 99Bill. All rights reserved.
//

#import "ZMdianyingzuoyeViewController.h"

@interface ZMdianyingzuoyeViewController ()
@property (nonatomic, strong) UITextView * TV_Bk1;
@property (nonatomic, strong) UITextView * TV_Bk2;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UIImageView *contentImagv;
@property (nonatomic, strong) UIButton *shoucangBtn;
@property (nonatomic, strong) UIView *shoucangview;

@end

@implementation ZMdianyingzuoyeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.shoucangview = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 210)];
    self.shoucangview.center = self.view.center;
    self.shoucangview.hidden = YES;
    [self.view addSubview:self.shoucangview];

    NSArray *arr = @[@"好词语",@"好句子",@"好段落",@"好开头",@"好结尾",@"好题目",@"好文章",];
    int y = 0;
    for (int i = 0; i < 7; i ++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, y, 60, 30)];
        btn.tag = i;
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.layer.borderColor = [UIColor blackColor].CGColor;
        btn.layer.borderWidth = 1;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        [self.shoucangview addSubview:btn];
        y += 30;
    }
}

-(void)action:(UIButton *)sender
{
    self.shoucangview.hidden = YES;
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M131" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:gousiDict[@"title"] forKey:@"collectTitile"];
    [requestDict setValue:gousiDict[@"articleDraft"] forKey:@"collectContent"];
    [requestDict setValue:[NSString stringWithFormat:@"%ld",(long)sender.tag + 1] forKey:@"typeId"];
    [requestDict setValue:@"1" forKey:@"sourceId"];
    [requestDict setValue:self.unitDict[@"authorId"] forKey:@"authorId"];
    [requestDict setValue:self.unitDict[@"recordId"] forKey:@"recordId"];
    [self showIndicator];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}

-(void)addCommentView
{
    NSLog(@"ffggggggg%@",gousiDict);

    NSLog(@"unitDict===%@",self.unitDict);
    
    UIImage* article_Category_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Category_bg" ofType:@"png"]];
    UIImageView* article_Category_View = [[UIImageView alloc] initWithFrame:CGRectMake(291, 15, 421, 43)];
    [article_Category_View setImage:article_Category_Image];
    [articleView addSubview:article_Category_View];
    [article_Category_View release];
    
    self.titleLb = [[UILabel alloc]initWithFrame:article_Category_View.bounds];
    self.titleLb.textAlignment = NSTextAlignmentCenter;
    [article_Category_View addSubview:self.titleLb];
    self.titleLb.text = gousiDict[@"unitTitle"];
    
    UIImageView *titleImagv = [[UIImageView alloc]initWithFrame:CGRectMake(100,article_Category_View.frame.origin.y + article_Category_View.frame.size.height + 20 , self.view.frame.size.width - 200, 60)];
    titleImagv.image = [UIImage imageNamed:@"Article_Item_11"];
    titleImagv.userInteractionEnabled = YES;
    [articleView addSubview:titleImagv];
    
    self.TV_Bk1 = [[UITextView alloc]initWithFrame:CGRectMake(120, 10 , titleImagv.frame.size.width - 120, 40)];
    self.TV_Bk1.font = [UIFont systemFontOfSize:18];
    self.TV_Bk1.backgroundColor = [UIColor clearColor];
    self.TV_Bk1.text = gousiDict[@"title"];
    self.TV_Bk1.editable = NO;
    [titleImagv addSubview:self.TV_Bk1];
    
    self.contentImagv = [[UIImageView alloc]initWithFrame:CGRectMake(100,titleImagv.frame.origin.y + titleImagv.frame.size.height + 20 , self.view.frame.size.width - 200, 500)];
    self.contentImagv.image = [UIImage imageNamed:@"Article_Item_12"];
    self.contentImagv.userInteractionEnabled = YES;
    self.contentImagv.tag = 300;
    [articleView addSubview:self.contentImagv];
    
    self.TV_Bk2 = [[UITextView alloc]initWithFrame:CGRectMake(60, 60 , self.contentImagv.frame.size.width - 120, self.contentImagv.frame.size.height - 120)];
    self.TV_Bk2.font = [UIFont systemFontOfSize:18];
    self.TV_Bk2.backgroundColor = [UIColor clearColor];
    self.TV_Bk2.text = gousiDict[@"articleDraft"];
    self.TV_Bk2.editable = NO;
    [self.contentImagv addSubview:self.TV_Bk2];

    
    self.shoucangBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 15, 50, 40)];
    [self.shoucangBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [self.shoucangBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.shoucangBtn.layer.borderColor = [UIColor blackColor].CGColor;
    self.shoucangBtn.layer.borderWidth = 1;
    [self.shoucangBtn addTarget:self action:@selector(shoucang) forControlEvents:UIControlEventTouchUpInside];
    [articleView addSubview:self.shoucangBtn];
    
    
    if ([((ZMAppDelegate*)[UIApplication sharedApplication].delegate).str isEqualToString:@"2"]) {
        UIButton * fabuBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 15, 50, 40)];
        [fabuBtn setTitle:@"发布" forState:UIControlStateNormal];
        [fabuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        fabuBtn.layer.borderColor = [UIColor blackColor].CGColor;
        [fabuBtn addTarget:self action:@selector(fabu) forControlEvents:UIControlEventTouchUpInside];
        fabuBtn.layer.borderWidth = 1;
        [articleView addSubview:fabuBtn];
        
    }
}

-(void)fabu
{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M135" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:gousiDict[@"title"] forKey:@"collectTitile"];
    [requestDict setValue:gousiDict[@"articleDraft"] forKey:@"collectContent"];
    [requestDict setValue:@"4" forKey:@"sourceId"];
    [requestDict setValue:((ZMAppDelegate*)[UIApplication sharedApplication].delegate).authorId forKey:@"authorId"];
    [requestDict setValue:((ZMAppDelegate*)[UIApplication sharedApplication].delegate).unitId forKey:@"recordId"];
    
    [self showIndicator];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
    
}
-(void)shoucang
{
    self.shoucangview.hidden = NO;
}

-(void)httpEngine:(ZMHttpEngine *)httpEngine didSuccess:(NSDictionary *)responseDict{
    [super httpEngine:httpEngine didSuccess:responseDict];
    
    NSString* method = [responseDict valueForKey:@"method"];
    NSString* responseCode = [responseDict valueForKey:@"responseCode"];
    if ([@"M131" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        [self hideIndicator];
        [self showTip:@"收藏成功"];
    }
    if ([@"M131" isEqualToString:method] && [@"96" isEqualToString:responseCode]) {
        [self hideIndicator];
        [self showTip:responseDict[@"responseMessage"]];
    }

    if ([@"M135" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        [self hideIndicator];
        [self showTip:@"发布成功"];
    }
    if ([@"M135" isEqualToString:method] && [@"96" isEqualToString:responseCode]) {
        [self hideIndicator];
        [self showTip:responseDict[@"responseMessage"]];
    }

}

-(void)addDraftView
{
    
}

-(void)addContentView
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
