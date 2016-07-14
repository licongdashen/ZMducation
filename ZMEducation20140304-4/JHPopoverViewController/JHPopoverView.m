//
//  JHPopOverView.m
//  JHPopOverView
//
//  Created by Jon Hocking on 03/04/2012.
//  Copyright (c) 2012 Jon Hocking. All rights reserved.
//

#import "JHPopoverView.h"
#import <QuartzCore/QuartzCore.h>

@interface JHPopoverView ()

@property (strong, nonatomic) UIBezierPath *outerPath;
@property (strong, nonatomic) UIBezierPath *innerPath;
@property (strong, nonatomic) UIScrollView *scrollView;

@end

@implementation JHPopoverView

@synthesize outerPath = mOuterPath;
@synthesize innerPath = mInnerPath;
@synthesize scrollView = mScrollView;

@synthesize outerStrokeColour = mOuterStrokeColour;
@synthesize innerStrokeColour = mInnerStrokeColour;
@synthesize fillColour = mFillColour;
@synthesize shadowColour = mShadowColour;

- (id)initWithFrame:(CGRect)frame andXPeak:(CGFloat)xPeak
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        
        // set up some defaults just incase
        mYPeak = 0;
        mPeakWidth = 34;
        mPeakHeight = 8;
        mXPeak = xPeak;
        mCornerRadius = 4;
        mShadowRadius = 6;
        
        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(mShadowRadius + 1, mYPeak + mPeakHeight + mShadowRadius + 0.5, frame.size.width - (2*mShadowRadius + 1.5), frame.size.height - mYPeak - mPeakHeight - mShadowRadius - mShadowRadius - 1.5)];
        self.scrollView.layer.cornerRadius = mCornerRadius;
        self.scrollView.clipsToBounds = YES;
        self.scrollView.userInteractionEnabled = YES;
        
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, 2* self.scrollView.frame.size.height);
        [self addSubview:self.scrollView];
        
        // set up our initial colours
        self.outerStrokeColour = [UIColor colorWithRed:0.67 green:0.66 blue:0.66 alpha:1.0];
        self.innerStrokeColour = [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:0.9];
        self.fillColour = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
        self.shadowColour = [UIColor colorWithWhite:0 alpha:0.35];
//        // set up our initial colours
//        self.outerStrokeColour = [UIColor colorWithRed:0.67 green:0.66 blue:0.66 alpha:0.0];
//        self.innerStrokeColour = [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:0.0];
//        self.fillColour = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:0.0];
//        self.shadowColour = [UIColor colorWithWhite:0 alpha:0.0];

        
    }
    
    return self;
}

- (UIBezierPath*)bezierPathWithRect:(CGRect)rect xPeak:(CGFloat)xPeak yPeak: (CGFloat)yPeak peakWidth:(CGFloat)peakWidth andPeakHeight:(CGFloat)peakHeight{
    
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    
    CGFloat cornerRadius = mCornerRadius;
    CGFloat pointHeight = peakHeight;
    CGFloat pointWidth_2 = peakWidth/2;
    [aPath moveToPoint:CGPointMake(xPeak - pointWidth_2, yPeak + pointHeight)];
    [aPath addLineToPoint:CGPointMake(xPeak, yPeak)];
    
    [aPath addLineToPoint:CGPointMake(xPeak + pointWidth_2, yPeak + pointHeight)];
    [aPath addLineToPoint:CGPointMake(rect.size.width - cornerRadius, yPeak + pointHeight)];
    
    [aPath addArcWithCenter:CGPointMake(rect.size.width - cornerRadius, yPeak + pointHeight + cornerRadius) radius:cornerRadius startAngle:-M_PI_2 endAngle:0 clockwise:YES];
    
    
    [aPath addLineToPoint:CGPointMake(rect.size.width, rect.size.height -  yPeak - pointHeight - cornerRadius)];
    [aPath addArcWithCenter:CGPointMake(rect.size.width - cornerRadius, rect.size.height - cornerRadius) radius:cornerRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
    
    [aPath addLineToPoint:CGPointMake(cornerRadius, rect.size.height)];
    [aPath addArcWithCenter:CGPointMake(cornerRadius, rect.size.height - cornerRadius) radius:cornerRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    
    [aPath addLineToPoint:CGPointMake(0, yPeak + pointHeight + cornerRadius)];
    [aPath addArcWithCenter:CGPointMake(cornerRadius, yPeak + pointHeight + cornerRadius) radius:cornerRadius startAngle:M_PI endAngle:M_PI + M_PI_2 clockwise:YES];
    
    [aPath closePath];
    
    return aPath;
}

- (void)drawRect:(CGRect)rect{
    
    CGContextRef aRef = UIGraphicsGetCurrentContext();
    
    // initial inset so we get shadow all the way around
    rect = CGRectInset(self.bounds, 5, 5);
    CGContextTranslateCTM(aRef, rect.origin.x, rect.origin.y);
    rect.origin = CGPointZero;
    
    // create our first outer path and store for faster drawing
    if (nil == self.outerPath) {
        self.outerPath = [self bezierPathWithRect:rect xPeak:mXPeak yPeak:mYPeak peakWidth:mPeakWidth andPeakHeight:mPeakHeight];
    }

    // Set the render colors
    
    [self.outerStrokeColour setStroke]; // gray stroke
    [self.fillColour setFill];   // light grey inner fill
    
    self.outerPath.lineWidth = 1;
    
    // save state before drawing the shadow
    CGContextSaveGState(aRef);
    CGContextSetShadowWithColor(aRef, CGSizeMake(0, 0), mShadowRadius, self.shadowColour.CGColor);
    // Fill the path before stroking it so that the fill
    // color does not obscure the stroked line.
    [self.outerPath fill];
    [self.outerPath stroke];
    
    CGContextRestoreGState(aRef);
    
    // create inner stroke white with slight alpha
    [self.innerStrokeColour setStroke]; // white highlight inner stroke
    
    // move the rect in for inner path
    rect = CGRectInset(self.bounds, 6, 6);
    CGContextTranslateCTM(aRef, rect.origin.x - 5, rect.origin.y - 5);
    rect.origin = CGPointZero;
    // create inner path and store
    if (nil == self.innerPath) {
        self.innerPath = [self bezierPathWithRect:rect xPeak:mXPeak - 1 yPeak:mYPeak + 0.5 peakWidth:mPeakWidth - 1 andPeakHeight:mPeakHeight - 0.5];
    }
    self.innerPath.lineWidth = 1;
    
    [self.innerPath fill];
    [self.innerPath stroke];
}

- (void)setContentView:(UIView*)contentView{
    self.scrollView.contentSize = contentView.bounds.size;
    [self.scrollView addSubview:contentView];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"Error: Attempted to set unrecognized key: %@ on a JHPopoverViewController - not cool man, not cool", key);
}

@end
