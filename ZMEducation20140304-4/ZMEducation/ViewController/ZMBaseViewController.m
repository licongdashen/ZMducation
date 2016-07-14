//
//  ZMBaseViewController.m
//  ZMEducation
//
//  Created by Hunter Li on 13-5-7.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import "ZMBaseViewController.h"

#define kTagIndicatorView 1122

@implementation ZMBaseViewController

-(void)addLabel:(NSString*)text
          frame:(CGRect)frame
  textAlignment:(NSTextAlignment)textAlignment
            tag:(NSInteger)tag
           size:(CGFloat)size
      textColor:(UIColor*)color
       intoView:(UIView*)view{
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:frame];
    [titleLabel setText:text];
    [titleLabel setTag:tag];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextAlignment:textAlignment];
    [titleLabel setMinimumScaleFactor:1.0];
    [titleLabel setFont:[UIFont fontWithName:@"MicrosoftYaHei" size:size]];
    [titleLabel setTextColor:color];
    [view addSubview:titleLabel];
    [titleLabel release];
}

-(void)addLabel:(NSString*)text
          frame:(CGRect)frame
           size:(CGFloat)size
       intoView:(UIView*)intoView{
    [self addLabel:text
             frame:frame
     textAlignment:NSTextAlignmentCenter
               tag:0
              size:size
         //textColor:[UIColor darkTextColor]
        textColor:[UIColor darkTextColor]
          intoView:intoView];
}

-(UIImage *)imageWithColor:(UIColor *)color
                     frame:(CGRect)frame{
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0);
    [color setFill];
    UIRectFill(frame);   // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

-(void)showIndicator{
    UIView* indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    [indicatorView setTag:kTagIndicatorView];
    
    UIImageView* indicatorBgView = [[UIImageView alloc] init];
    [indicatorBgView setFrame:CGRectMake(456.0f, 327.0f, 113.0f, 113.0f)];
    [indicatorBgView setImage:[UIImage imageWithContentsOfFile:
                               [[NSBundle mainBundle] pathForResource:@"network_connect_bg" ofType:@"png"]]];
    [indicatorView addSubview:indicatorBgView];
    
    UILabel* indicatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 75.0f, 113.0f, 30.0f)];
    [indicatorLabel setText:@"请等待..."];
    [indicatorLabel setBackgroundColor:[UIColor clearColor]];
    [indicatorLabel setTextAlignment:NSTextAlignmentCenter];
    [indicatorLabel setTextColor:[UIColor whiteColor]];
    [indicatorBgView addSubview:indicatorLabel];
    [indicatorLabel release];
    
	UIActivityIndicatorView* indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    
	[self.view addSubview:indicatorView];
	indicator.center = CGPointMake(56.5f,45);
	[indicatorBgView addSubview:indicator];
	[indicator startAnimating];
    
    [indicatorBgView release];
    [indicator release];
    [indicatorView release];
}

-(void)hideIndicator{
    for (UIView* subView in [self.view subviews]) {
        if (kTagIndicatorView == subView.tag) {
            [subView removeFromSuperview];
            break;
        }
    }

    //debug start
    
//    for (UIView * subView in [self.view subviews]) {
//        NSLog(@"frame:%@",NSStringFromCGRect(subView.frame));
//    }
//    
    //debug end
    
//    UIView* indicatorView = [self.view viewWithTag:kTagIndicatorView];
//    [indicatorView removeFromSuperview];
//    [UIView animateWithDuration:0.5f
//                     animations:^{
//                         indicatorView.alpha = 0;
//                     }
//                     completion:^(BOOL finished){
//                         if (finished) {
//                             [indicatorView removeFromSuperview];
//                         }
//                     }];

}

-(void)showTip:(NSString *)tip{
    UIImageView* flashTipView = [[UIImageView alloc] init];
    [flashTipView setFrame:CGRectMake(456.0f, 327.0f, 113.0f, 113.0f)];
    [flashTipView setImage:[UIImage imageWithContentsOfFile:
                            [[NSBundle mainBundle] pathForResource:@"network_connect_bg" ofType:@"png"]]];
    [self.view addSubview:flashTipView];
    
    UILabel* tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 93, 83)];
    [tipLabel setText:tip];
    [tipLabel setNumberOfLines:3];
    [tipLabel setFont:[UIFont systemFontOfSize:17.0f]];
    [tipLabel setTextAlignment:NSTextAlignmentCenter];
    [tipLabel setBackgroundColor:[UIColor clearColor]];
    [tipLabel setTextColor:[UIColor whiteColor]];
    [flashTipView addSubview:tipLabel];
    [tipLabel release];
    
    flashTipView.alpha = 0;
    [UIView animateWithDuration:0.5f
                     animations:^{ flashTipView.alpha = 1; }
                     completion:^(BOOL finished){
                         [NSTimer scheduledTimerWithTimeInterval:1.8f
                                                          target:self
                                                        selector:@selector(hideTip:)
                                                        userInfo:flashTipView
                                                         repeats:NO];
                     }];
    [flashTipView release];
}

-(void)hideTip:(NSTimer *)timer{
    UIImageView* flashTipView = (UIImageView *)[timer userInfo];
    [UIView animateWithDuration:0.5f
                     animations:^{ flashTipView.alpha = 0; }
                     completion:^(BOOL finished){}];
}

-(void)loadView{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    //[view setBackgroundColor:[UIColor purpleColor]];
    //[self setView:view];
    self.view = view;
    [view release];
}

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ZMHttpEngineDelegate
-(void)httpEngineDidBegin:(ZMHttpEngine *)httpEngine{
    [self showIndicator];
}

-(void)httpEngine:(ZMHttpEngine *)httpEngine didSuccess:(NSDictionary *)responseDict{
    [self hideIndicator];
}

-(void)httpEngine:(ZMHttpEngine *)httpEngine didFailed:(NSString *)failResult{
    [self hideIndicator];
    
    [self showTip:failResult];
}

@end
