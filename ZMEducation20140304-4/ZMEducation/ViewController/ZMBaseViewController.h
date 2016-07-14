//
//  ZMBaseViewController.h
//  ZMEducation
//
//  Created by Hunter Li on 13-5-7.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import "JSONKit.h"
#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "ZMAppDelegate.h"
#import "ZMConfig.h"
#import "ZMHttpEngine.h"

@interface ZMBaseViewController : UIViewController<ZMHttpEngineDelegate>

-(void)addLabel:(NSString*)text
          frame:(CGRect)frame
  textAlignment:(NSTextAlignment)textAlignment
            tag:(NSInteger)tag
           size:(CGFloat)size
      textColor:(UIColor*)color
       intoView:(UIView*)view;

-(void)addLabel:(NSString*)text
          frame:(CGRect)frame
           size:(CGFloat)size
       intoView:(UIView*)intoView;

-(UIImage *)imageWithColor:(UIColor *)color
                     frame:(CGRect)frame;

-(void)showIndicator;
-(void)hideIndicator;

-(void)showTip:(NSString *)tip;
-(void)httpEngine:(ZMHttpEngine *)httpEngine
       didSuccess:(NSDictionary *)responseDict;

@end
