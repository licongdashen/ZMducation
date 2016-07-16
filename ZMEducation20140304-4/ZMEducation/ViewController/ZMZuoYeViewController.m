//
//  ZMZuoYeViewController.m
//  ZMEducation
//
//  Created by Queen on 16/5/31.
//  Copyright © 2016年 99Bill. All rights reserved.
//

#import "ZMZuoYeViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "UIImage+fixOrientation.h"
#import "FGalleryViewController.h"
#define kTagCloseGousiBtn 20131123
#define DEF_OBJECT_TO_STIRNG(object) ((object && object != (id)[NSNull null])?([object isKindOfClass:[NSString class]]?object:[NSString stringWithFormat:@"%@",object]):@"")
@interface ZMZuoYeViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,FGalleryViewControllerDelegate,UIScrollViewDelegate>
{

    NSMutableArray *photosArray;
}
@property (nonatomic, strong) UILabel *titleLb;

@property (nonatomic, strong) UIScrollView *scro;

@property (nonatomic, strong) UIExpandingTextView * TV_Bk1;
@property (nonatomic, strong) UIExpandingTextView * TV_Bk2;
@property (nonatomic, strong) NSDictionary * onedic;
@property (nonatomic, strong) NSDictionary *twodic;
@property (nonatomic, strong) UIButton* submitBut;
@property (nonatomic, strong) UIImageView *contentImagv;
@end

@implementation ZMZuoYeViewController
-(void)dealloc
{
    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"vn" object:nil];
}

-(void)bbb
{
    self.submitBut.hidden = YES;
    
    
    for (UIView *view in [self.scro subviews]) {
        if (view.tag == 100) {
            view.hidden = YES;
        }
        if (view.tag == 200) {
            view.hidden = YES;
        }
        if (view.tag == 300) {
            view.userInteractionEnabled = NO;
        }
    }


}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bbb) name:@"vn" object:nil];
    photosArray = [[NSMutableArray alloc] initWithCapacity:0];

    NSLog(@"hhhhhhhhh%@",self.unitArray);
    
    self.view.backgroundColor = [UIColor whiteColor];


    //Article_Item_11
    //Article_Category_bg
    //Camera_Button
    
    
    
    self.scro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.scro.contentSize = CGSizeMake(self.view.frame.size.width*[self.unitArray count], self.view.frame.size.height);
    self.scro.pagingEnabled = YES;
    self.scro.delegate = self;
    [self.view addSubview:self.scro];
    
    _pageControl = [[PageControl alloc] initWithFrame:CGRectMake(0, 700, 1024, 36)];
    _pageControl.image =  [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PageControl_Dot" ofType:@"png"]];
    _pageControl.selectedImage =  [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PageControl_Dot_Selected" ofType:@"png"]];;
    _pageControl.padding = 13.0f;
    _pageControl.orientation = PageControlOrientationLandscape;
    _pageControl.numberOfPages = [self.unitArray count];
    [self.view addSubview:_pageControl];

    int y = 0;
    int i = 0;
    
    for (NSDictionary *dic in self.unitArray) {
        if ([dic[@"articleType"] intValue] == 98) {
            
            UIImage* article_Category_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Category_bg" ofType:@"png"]];
            UIImageView* article_Category_View = [[UIImageView alloc] initWithFrame:CGRectMake(291 + y, 15, 421, 43)];
            [article_Category_View setImage:article_Category_Image];
            [self.scro addSubview:article_Category_View];
            [article_Category_View release];
            
            self.titleLb = [[UILabel alloc]initWithFrame:article_Category_View.bounds];
            self.titleLb.textAlignment = NSTextAlignmentCenter;
            [article_Category_View addSubview:self.titleLb];
            self.titleLb.text = DEF_OBJECT_TO_STIRNG(dic[@"designTitle"]);

            UIImageView *titleImagv = [[UIImageView alloc]initWithFrame:CGRectMake(100 + y,article_Category_View.frame.origin.y + article_Category_View.frame.size.height + 20 , self.view.frame.size.width - 200, 60)];
            titleImagv.image = [UIImage imageNamed:@"Article_Item_11"];
            titleImagv.userInteractionEnabled = YES;
            [self.scro addSubview:titleImagv];
            
            self.TV_Bk1 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(120 + y, 10 , titleImagv.frame.size.width - 120, 40)];
            self.TV_Bk1.font = [UIFont systemFontOfSize:18];
            self.TV_Bk1.backgroundColor = [UIColor clearColor];
            self.TV_Bk1.tag = 999 + i;
            [titleImagv addSubview:self.TV_Bk1];

            self.contentImagv = [[UIImageView alloc]initWithFrame:CGRectMake(100 + y,titleImagv.frame.origin.y + titleImagv.frame.size.height + 20 , self.view.frame.size.width - 200, 500)];
            self.contentImagv.image = [UIImage imageNamed:@"Article_Item_12"];
            self.contentImagv.userInteractionEnabled = YES;
            self.contentImagv.tag = 300;
            [self.scro addSubview:self.contentImagv];
            
            self.TV_Bk2 = [[UIExpandingTextView alloc]initWithFrame:CGRectMake(60, 60 , self.contentImagv.frame.size.width - 120, self.contentImagv.frame.size.height - 120)];
            self.TV_Bk2.font = [UIFont systemFontOfSize:18];
            self.TV_Bk2.backgroundColor = [UIColor clearColor];
            self.TV_Bk2.tag = 9999 + i;
            [self.contentImagv addSubview:self.TV_Bk2];
            
            
            if ([((ZMAppDelegate*)[UIApplication sharedApplication].delegate).str isEqualToString:@"04"]) {
                UIButton* shareBut = [UIButton buttonWithType:UIButtonTypeCustom];
                [shareBut setFrame:CGRectMake(801 + y, 707, 25, 25)];
                [shareBut setSelected:NO];
                [shareBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Btn" ofType:@"png"]] forState:UIControlStateNormal];
                [shareBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
                [shareBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Share_Select_Btn" ofType:@"png"]] forState:UIControlStateSelected];
                [shareBut addTarget:self
                             action:@selector(shareClick:)
                   forControlEvents:UIControlEventTouchUpInside];
                shareBut.tag = 100;
                [self.scro addSubview:shareBut];
                
                UILabel* shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(830 + y, 710, 80, 20)];
                [shareLabel setText:@"是否共享"];
                [shareLabel setBackgroundColor:[UIColor clearColor]];
                [shareLabel setTextColor:[UIColor colorWithRed:0 green:110.0/255.0 blue:167.0/255.0 alpha:1.0]];
                shareLabel.tag = 200;
                [self.scro addSubview:shareLabel];
                
            }

            NSMutableDictionary * userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
            
            NSMutableDictionary * requestDict = [[NSMutableDictionary alloc]init];
            
            [requestDict setValue:@"M030" forKey:@"method"];
            
            [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
            [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
            [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
            [requestDict setValue:[userDict valueForKey:@"currentModuleId"] forKey:@"moduleId"];
            [requestDict setValue:[dic valueForKey:@"designId"] forKey:@"unitId"];
            [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"authorId"];
            
            ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
            [httpEngine setDelegate:self];
            [httpEngine requestWithDict:requestDict];
            [httpEngine release];
            [requestDict release];

        }
        
        if ([dic[@"articleType"] intValue] == 99) {
            
            UIImage* article_Category_Image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Article_Category_bg" ofType:@"png"]];
            UIImageView* article_Category_View = [[UIImageView alloc] initWithFrame:CGRectMake(y + 291, 15, 421, 43)];
            [article_Category_View setImage:article_Category_Image];
            [self.scro addSubview:article_Category_View];
            [article_Category_View release];
            
            self.titleLb = [[UILabel alloc]initWithFrame:article_Category_View.bounds];
            self.titleLb.textAlignment = NSTextAlignmentCenter;
            [article_Category_View addSubview:self.titleLb];
            self.titleLb.text = DEF_OBJECT_TO_STIRNG(dic[@"designTitle"]);

            UIButton* browse_But = [UIButton buttonWithType:UIButtonTypeCustom];
            [browse_But setFrame:CGRectMake(y + 317 + 100, 252, 171, 40)];
            [browse_But setTag:999999 + i];
            [browse_But setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Unit_Common_Button" ofType:@"png"]] forState:UIControlStateNormal];
            [browse_But setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Unit_Common_Button" ofType:@"png"]] forState:UIControlStateHighlighted];
            [browse_But setTitle:@"浏览" forState:UIControlStateNormal];
            [browse_But addTarget:self
                           action:@selector(browsePhoto:)
                 forControlEvents:UIControlEventTouchUpInside];
            [self.scro addSubview:browse_But];
            
            UIButton* photo_But = [UIButton buttonWithType:UIButtonTypeCustom];
            [photo_But setFrame:CGRectMake(y + 250 + 100, 247, 49, 50)];
            [photo_But setTag:99999 + i];
            [photo_But setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Camera_Button" ofType:@"png"]] forState:UIControlStateNormal];
            [photo_But setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Camera_Button" ofType:@"png"]] forState:UIControlStateHighlighted];
            [photo_But addTarget:self
                          action:@selector(takePicture:)
                forControlEvents:UIControlEventTouchUpInside];
            [self.scro addSubview:photo_But];

        }
        
        y += self.view.frame.size.width;
        i += 1;
    }
    
    self.submitBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.submitBut setFrame:CGRectMake(894, 670, 105, 89)];
    [self.submitBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Submit_Btn" ofType:@"png"]] forState:UIControlStateNormal];
    [self.submitBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Submit_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
    [self.submitBut addTarget:self
                  action:@selector(submitWorkClick)
        forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.submitBut];
    
    UIButton* closeBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBut setFrame:CGRectMake(948, 20, 49, 49)];
    [closeBut setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Close_Btn" ofType:@"png"]] forState:UIControlStateNormal];
    [closeBut setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Close_Btn" ofType:@"png"]] forState:UIControlStateHighlighted];
    [closeBut addTarget:self
                 action:@selector(closeClick)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBut];
    
    
    self.panBtn = [[UIButton alloc]initWithFrame:CGRectMake(948, 500, 50, 50)];
    self.panBtn.backgroundColor = [UIColor grayColor];
    self.panBtn.layer.cornerRadius = 8;
    self.panBtn.layer.masksToBounds = YES;
    self.panBtn.alpha = 0.9;
    [self.panBtn addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.panBtn];
    
    self.gousiBtn = [[UIButton alloc]init];
    self.gousiBtn.backgroundColor = [UIColor grayColor];
    [self.gousiBtn setTitle:@"构思图标" forState:UIControlStateNormal];
    [self.gousiBtn addTarget:self action:@selector(gousi) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.gousiBtn];
    self.gousiBtn.hidden = YES;
    
    self.zuoyeBtn = [[UIButton alloc]init];
    self.zuoyeBtn.backgroundColor = [UIColor grayColor];
    [self.zuoyeBtn setTitle:@"作业" forState:UIControlStateNormal];
    [self.zuoyeBtn addTarget:self action:@selector(zuoye) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.zuoyeBtn];
    self.zuoyeBtn.hidden = YES;
    
    self.luntanBtn = [[UIButton alloc]init];
    self.luntanBtn.backgroundColor = [UIColor grayColor];
    [self.luntanBtn setTitle:@"论坛" forState:UIControlStateNormal];
    [self.luntanBtn addTarget:self action:@selector(luntan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.luntanBtn];
    self.luntanBtn.hidden = YES;
    
    self.shijuanBtn = [[UIButton alloc]init];
    self.shijuanBtn.backgroundColor = [UIColor grayColor];
    [self.shijuanBtn setTitle:@"试卷" forState:UIControlStateNormal];
    [self.shijuanBtn addTarget:self action:@selector(shijuan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.shijuanBtn];
    self.shijuanBtn.hidden = YES;
    
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestures:)];
    self.panGestureRecognizer.minimumNumberOfTouches = 1;
    self.panGestureRecognizer.maximumNumberOfTouches = 1;
    [self.panBtn addGestureRecognizer:self.panGestureRecognizer];
    
    UITapGestureRecognizer *TAP = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:TAP];
}

-(void)browsePhoto:(UIButton *)sender{
    
    NSLog(@"vn=%ld",sender.tag - 999999);
    
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    
    
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M043" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"currentModuleId"] forKey:@"moduleId"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:[self.unitArray[sender.tag - 999999] valueForKey:@"designId"] forKey:@"unitId"];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}

-(void)takePicture:(UIButton *)sender{
    
    self.twodic = self.unitArray[sender.tag - 99999];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSArray *media = [UIImagePickerController
                          availableMediaTypesForSourceType: UIImagePickerControllerSourceTypeCamera];
        
        if ([media containsObject:(NSString*)kUTTypeImage] == YES) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            //picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
            [picker setMediaTypes:[NSArray arrayWithObject:(NSString *)kUTTypeImage]];
            
            picker.delegate = self;
            [self presentViewController:picker animated:YES completion:NULL];
            [picker release];
        }else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"当前设备不支持拍照"
                                                           delegate:nil
                                                  cancelButtonTitle:@"知道了"
                                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unavailable!"
                                                        message:@"This device does not have a camera."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}
-(void)submitWorkClick
{
    NSLog(@"shishi==%ld",_pageControl.currentPage);
    
    UIExpandingTextView *view1 = (UIExpandingTextView *)[self.view viewWithTag:999 + _pageControl.currentPage];
    UIExpandingTextView *view2 = (UIExpandingTextView *)[self.view viewWithTag:9999 + _pageControl.currentPage];

    NSMutableDictionary * userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    
    NSMutableDictionary * requestDict = [[NSMutableDictionary alloc]init];
    
    [requestDict setValue:@"M015" forKey:@"method"];
    
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"currentModuleId"] forKey:@"moduleId"];
    [requestDict setValue:[self.unitArray[_pageControl.currentPage] valueForKey:@"designId"] forKey:@"unitId"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:@"98" forKey:@"articleType"];
    [requestDict setValue:view1.text forKey:@"articleTitle"];
    [requestDict setValue:view2.text forKey:@"articleDraft"];
    NSMutableArray *articleCommentArray = [[NSMutableArray alloc]init];
    NSDictionary* comment01Dict = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"articleComment", nil];
    [articleCommentArray addObject:comment01Dict];
    NSDictionary* comment02Dict = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"articleComment", nil];
    [articleCommentArray addObject:comment02Dict];
    NSDictionary* comment03Dict = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"articleComment", nil];
    [articleCommentArray addObject:comment03Dict];
    [requestDict setValue:[articleCommentArray JSONString] forKey:@"articleComments"];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];

}

-(IBAction)shareClick:(id)sender{
    UIButton* shareBtn = (UIButton*)sender;
    
    [shareBtn setSelected:!shareBtn.selected];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat width = self.scro.frame.size.width;
    NSUInteger currentPage = floor((self.scro.contentOffset.x - width / 2) / width) + 1;
    _pageControl.currentPage = currentPage;
}

-(void)tap
{
    self.gousiBtn.hidden = NO;
    self.zuoyeBtn.hidden = NO;
    self.luntanBtn.hidden = NO;
    self.shijuanBtn.hidden = NO;
    
    self.gousiBtn.frame = CGRectMake(self.panBtn.frame.origin.x, self.panBtn.frame.origin.y - 100, self.panBtn.frame.size.width + 50, self.panBtn.frame.size.height);
    self.zuoyeBtn.frame = CGRectMake(self.panBtn.frame.origin.x, self.panBtn.frame.origin.y + 100, self.panBtn.frame.size.width + 50, self.panBtn.frame.size.height);
    self.luntanBtn.frame = CGRectMake(self.panBtn.frame.origin.x - 100, self.panBtn.frame.origin.y, self.panBtn.frame.size.width + 50, self.panBtn.frame.size.height);
    self.shijuanBtn.frame = CGRectMake(self.panBtn.frame.origin.x + 100, self.panBtn.frame.origin.y, self.panBtn.frame.size.width + 50, self.panBtn.frame.size.height);
    
    self.panBtn.hidden = YES;
    
}

-(void)gousi
{
    self.gousiBtn.hidden = YES;
    self.zuoyeBtn.hidden = YES;
    self.luntanBtn.hidden = YES;
    self.shijuanBtn.hidden = YES;
    
    self.panBtn.hidden = NO;
    
    [[ZMAppDelegate App].userDict setValue:@"02" forKey:@"currentModuleId"];
    NSMutableDictionary * userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary * requestDict = [[NSMutableDictionary alloc]init];
    
    [requestDict setValue:@"M044" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];

}

-(void)zuoye
{
    self.gousiBtn.hidden = YES;
    self.zuoyeBtn.hidden = YES;
    self.luntanBtn.hidden = YES;
    self.shijuanBtn.hidden = YES;
    
    self.panBtn.hidden = NO;

    
}

-(void)luntan
{
    self.gousiBtn.hidden = YES;
    self.zuoyeBtn.hidden = YES;
    self.luntanBtn.hidden = YES;
    self.shijuanBtn.hidden = YES;
    
    self.panBtn.hidden = NO;
    
    NSMutableDictionary * userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    
    NSString * courseID = [userDict valueForKey:@"currentCourseId"];
    
    NSMutableDictionary * requestDict = [[NSMutableDictionary alloc]init];
    [requestDict setValue:@"M051" forKey:@"method"];
    [requestDict setValue:courseID forKey:@"courseId"];
    
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
    
}

-(void)shijuan
{
    self.gousiBtn.hidden = YES;
    self.zuoyeBtn.hidden = YES;
    self.luntanBtn.hidden = YES;
    self.shijuanBtn.hidden = YES;
    
    self.panBtn.hidden = NO;
    
    NSMutableDictionary * userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary * requestDict = [[NSMutableDictionary alloc]init];
    
    [requestDict setValue:@"M061" forKey:@"method"];
    
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
    
}

-(void)tap:(UITapGestureRecognizer *)sender
{
    self.gousiBtn.hidden = YES;
    self.zuoyeBtn.hidden = YES;
    self.luntanBtn.hidden = YES;
    self.shijuanBtn.hidden = YES;
    
    self.panBtn.hidden = NO;
    
}

-(void)handlePanGestures:(UIPanGestureRecognizer *)paramSender{
    if (paramSender.state != UIGestureRecognizerStateEnded && paramSender.state != UIGestureRecognizerStateFailed) {
        CGPoint location = [paramSender locationInView:paramSender.view.superview];
        paramSender.view.center = location;
    }
}

-(void)httpEngine:(ZMHttpEngine *)httpEngine didSuccess:(NSDictionary *)responseDict{
    [super httpEngine:httpEngine didSuccess:responseDict];
    
    NSString* method = [responseDict valueForKey:@"method"];
    NSString* responseCode = [responseDict valueForKey:@"responseCode"];
    
     if ([@"M044" isEqualToString:method] && [@"00" isEqualToString:responseCode])
    { //获取构思列表
        
        //NSMutableArray * dataSource = [[NSMutableArray alloc]initWithArray:[responseDict valueForKey:@"units"]];
        NSArray* dataSource = [responseDict valueForKey:@"units"];
        NSMutableArray * dataSourceArr = [[NSMutableArray alloc]init];
        if ([dataSource count] > 0) {
            
            for (NSDictionary * item in dataSource) {
                NSDictionary * _item = [[NSDictionary alloc]initWithObjectsAndKeys:
                                        [item valueForKey:@"designTitle"],@"unitTitle",
                                        [item valueForKey:@"designBrief"],@"unitBrief",
                                        [item valueForKey:@"articleType"],@"articleType",
                                        [item valueForKey:@"designId"],@"unitId",
                                        @"04",@"unitType",
                                        nil];
                [dataSourceArr addObject:_item];
            }
            
            ZMGousiSwipeViewController * vc = [[ZMGousiSwipeViewController alloc] init];
            //                [vc setDelegate:self];
            [vc setUnitArray:dataSourceArr];
            [self presentViewController:vc animated:YES completion:NULL];
            [vc release];
        }else{
            
            [self showTip:@"没有内容！"];
            
        }
        
    }else if ([@"M061" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        //NSArray* dataSource = [responseDict valueForKey:@"units"];
        NSMutableArray * dataSource = [[NSMutableArray alloc]initWithArray:[responseDict valueForKey:@"units"]];
        if ([dataSource count] > 0) {
            
            ZMShitiSwipeViewController * vc = [[ZMShitiSwipeViewController alloc] init];
            //                [vc setDelegate:self];
            [vc setUnitArray:dataSource];
            [self presentViewController:vc animated:YES completion:NULL];
            
        }else{
            
            [self showTip:@"没有内容！"];
            
        }
        
    }else if ([@"M030" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
    
        self.TV_Bk1.text = responseDict[@"title"];
        self.TV_Bk2.text = responseDict[@"articleDraft"];
    
    }else if ([@"M015" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        [self showTip:@"提交成功！"];

        UIButton* shareBtn = (UIButton*)[self.view viewWithTag:999];
        if (shareBtn.selected) {
            NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
            
            NSMutableDictionary * userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
            [requestDict setValue:@"M026" forKey:@"method"];

            [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
            [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
            [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
            [requestDict setValue:[userDict valueForKey:@"currentModuleId"] forKey:@"moduleId"];
            [requestDict setValue:[self.unitArray[_pageControl.currentPage] valueForKey:@"designId"] forKey:@"unitId"];
            [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];

            ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
            [httpEngine setDelegate:self];
            [httpEngine requestWithDict:requestDict];
            [httpEngine release];
            [requestDict release];
        }
    }else if([@"M043" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        [photosArray removeAllObjects];
        
        NSArray* _fileArray = [responseDict valueForKey:@"files"];
        for (int i=0; i<[_fileArray count]; i++) {
            NSLog(@"_fileArray:%@",[_fileArray objectAtIndex:i]);
            [photosArray addObject:[_fileArray objectAtIndex:i]];
        }
        
        if ([photosArray count] > 0) {
            FGalleryViewController* networkGallery = [[FGalleryViewController alloc] initWithPhotoSource:self];
            
            NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
            
            NSString* role = [userDict valueForKey:@"role"];
            if([@"03" isEqualToString:role] || [@"04" isEqualToString:role]){
                [networkGallery setFlag:YES];
            }
            
            UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:networkGallery];
            
            [self presentViewController:navigationController animated:YES completion:NULL];
            [networkGallery release];
            [navigationController release];
        }else{
            [self showTip:@"请先把你的答案拍照上传"];
        }

        
    }else if([@"M026" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
    
        [self showTip:@"提交成功！"];
    }else if ([@"M051" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:[responseDict valueForKey:@"forumTitles"]];
        if ([arr count] > 0) {
            ZMMdlBbsVCtrl * bbsViewCtrl = [[ZMMdlBbsVCtrl alloc]init];
            [self presentViewController:bbsViewCtrl animated:YES completion:NULL];
        }else{
            
            [self showTip:@"没有内容！"];
            
        }
        
    }
}
    
- (int)numberOfPhotosForPhotoGallery:(FGalleryViewController *)gallery{
    return [photosArray count];
}

- (FGalleryPhotoSourceType)photoGallery:(FGalleryViewController *)gallery sourceTypeForPhotoAtIndex:(NSUInteger)index{
    return FGalleryPhotoSourceTypeNetwork;
}

- (NSString*)photoGallery:(FGalleryViewController *)gallery captionForPhotoAtIndex:(NSUInteger)index{
    NSDictionary* photosDict = [photosArray objectAtIndex:index];
    return [photosDict valueForKey:@"fileName"];
}

- (NSString*)photoGallery:(FGalleryViewController *)gallery urlForPhotoSize:(FGalleryPhotoSize)size atIndex:(NSUInteger)index {
    NSDictionary* photosDict = [photosArray objectAtIndex:index];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",kHttpRequestURL,[photosDict valueForKey:@"fileUrl"]];
    return urlStr;
}

-(void)collectButtonDidClick:(FGalleryViewController *)gallery{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定加入错题集吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alert setTag:888];
    [alert show];
    [alert release];
}

-(void)shareButtonDidClick:(FGalleryViewController *)gallery{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定分享吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alert setTag:999];
    [alert show];
    [alert release];
}

-(void)shareToOther{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    
    NSString* role = [userDict valueForKey:@"role"];
    if([@"03" isEqualToString:role] || [@"04" isEqualToString:role]){
        NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
        [requestDict setValue:@"M026" forKey:@"method"];
        [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
        [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
        [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
        [requestDict setValue:[userDict valueForKey:@"currentModuleId"] forKey:@"moduleId"];
        [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
        [requestDict setValue:[self.twodic valueForKey:@"designId"] forKey:@"unitId"];
        
        ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
        [httpEngine setDelegate:self];
        [httpEngine requestWithDict:requestDict];
        [httpEngine release];
        [requestDict release];
    }
}

-(void)addToCollect{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    
    NSString* role = [userDict valueForKey:@"role"];
    if([@"03" isEqualToString:role] || [@"04" isEqualToString:role]){
        NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
        [requestDict setValue:@"M025" forKey:@"method"];
        [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
        [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
        [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
        [requestDict setValue:[userDict valueForKey:@"currentModuleId"] forKey:@"moduleId"];
        [requestDict setValue:[self.twodic valueForKey:@"designId"] forKey:@"unitId"];
        [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
        
        ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
        [httpEngine setDelegate:self];
        [httpEngine requestWithDict:requestDict];
        [httpEngine release];
        [requestDict release];
    }
}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        
    }else if(buttonIndex == 1){
        int tag = alertView.tag;
        if (tag == kTagCloseGousiBtn) {
            [self.navigationController popViewControllerAnimated:YES];
            [self dismissModalViewControllerAnimated:YES];
            
            
        }
        if (tag == 999) {
            
            [self shareToOther];

        }
        
        if (tag == 888) {
            [self addToCollect];

        }
    }
}

-(void)closeClick
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定关闭？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alert setTag:kTagCloseGousiBtn];
    [alert show];
    [alert release];

}

#pragma mark UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSLog(@"Media Info: %@", info);
    NSString *mediaType = [info valueForKey:UIImagePickerControllerMediaType];
    
    if([mediaType isEqualToString:(NSString*)kUTTypeImage]) {
        UIImage *photoTaken = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        UIImage* fixOrientation = [photoTaken fixOrientation];
        //Save Photo to library only if it wasnt already saved i.e. its just been taken
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
            
            NSString* courseId = [userDict valueForKey:@"currentCourseId"];
            NSString* classId = [userDict valueForKey:@"currentClassId"];
            NSString* gradeId = [userDict valueForKey:@"currentGradeId"];
            NSString* moduleId = [userDict valueForKey:@"currentModuleId"];
            NSString* userId = [userDict valueForKey:@"userId"];
            
            NSString* unitId = [self.twodic valueForKey:@"designId"];
            
            NSString* filename = [NSString stringWithFormat:@"%@_%@_%@_%@_%@_%@.png",gradeId,classId,courseId,moduleId,unitId,userId];
            
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/rs/invoke",kHttpRequestURL]];
            ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:url];
            [request setTimeOutSeconds:60];
            [request addRequestHeader:@"Content-Type" value:@"multipart/form-data"];
            [request setPostValue:@"M008" forKey:@"method"];
            [request setPostValue:courseId forKey:@"courseId"];
            [request setPostValue:classId forKey:@"classId"];
            [request setPostValue:gradeId forKey:@"gradeId"];
            [request setPostValue:moduleId forKey:@"moduleId"];
            [request setPostValue:unitId forKey:@"unitId"];
            [request setPostValue:userId forKey:@"userId"];
            [request setPostValue:filename forKey:@"filename"];
            [request setPostValue:@"00" forKey:@"filetype"];
            
            NSData *jpegImageData = UIImageJPEGRepresentation(fixOrientation, 0.8);
            [request setData:jpegImageData
                withFileName:filename
              andContentType:@"image/jpeg"
                      forKey:@"file"];
            
            [self showIndicator];
            [request setCompletionBlock:^{
                [self hideIndicator];
                NSLog(@"\n response \n%@",request.responseString);
            }];
            
            [request setFailedBlock:^{
                [self hideIndicator];
                NSLog(@"\n\n%@", request.error);
                
                [self showTip:@"上次图片失败，请重试"];
            }];
            
            [request startAsynchronous];
        }
    }
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"拍照失败，请重拍"
                                                       delegate:nil
                                              cancelButtonTitle:@"知道了"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
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
