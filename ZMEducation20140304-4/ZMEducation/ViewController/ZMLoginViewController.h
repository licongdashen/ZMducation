//
//  ZMLoginViewController.h
//  ZMEducation
//
//  Created by Hunter Li on 13-5-7.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import "ZMBaseViewController.h"
#import "UIExpandingTextView.h"

@interface ZMLoginViewController : ZMBaseViewController<UITextFieldDelegate,UIExpandingTextViewDelegate>{
    UITextField* pwTF;
    UITextField* nameTF;
}

@end
