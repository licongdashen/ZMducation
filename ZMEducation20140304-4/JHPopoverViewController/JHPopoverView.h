//
//  JHPopOverView.h
//  JHPopOverView
//
//  Created by Jon Hocking on 03/04/2012.
//  Copyright (c) 2012 Jon Hocking. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHPopoverView : UIView{

    UIBezierPath *mOuterPath;
    UIBezierPath *mInnerPath;
    
    CGFloat mXPeak;
    CGFloat mYPeak;
    CGFloat mPeakWidth;
    CGFloat mPeakHeight;
    CGFloat mCornerRadius;
    CGFloat mShadowRadius;
    
}

@property (strong, nonatomic) UIColor *outerStrokeColour;
@property (strong, nonatomic) UIColor *innerStrokeColour;
@property (strong, nonatomic) UIColor *fillColour;
@property (strong, nonatomic) UIColor *shadowColour;

// I recommend minor tweaks in the implementation of the view
// try to keep it to colour changes only

- (void)setContentView:(UIView*)contentView;
- (id)initWithFrame:(CGRect)frame andXPeak:(CGFloat)xPeak;
@end
