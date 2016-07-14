//
//  JHPopoverViewController.h
//  JHPopOverView
//
//  Created by Jon Hocking on 12/04/2012.
//  Copyright (c) 2012 Jon Hocking. All rights reserved.
//

/*
 
This class works in a very similar way to the UIPopoverController class
 
You should use this class instead of accessing the popover view directly

 
key points:
 
 - can only present from the top so far
   (hopefully this will be changed in future releases)
 
 - works best with fixed content but will automatically scroll if the 
   viewcontroller's view is larger than the content size
 
 - automatically dismisses the popover on rotation of device
 
 - would like to add a nice way to customise the colours through 
   the controller interface
 
*/

// colour path defines

#define JHPopoverViewInnerStrokeColorKey    @"innerStrokeColour"
#define JHPopoverViewOuterStrokeColorKey    @"outerStrokeColour"
#define JHPopoverViewFillColorKey           @"fillColour"
#define JHPopoverViewShadowColorKey         @"shadowColour"


#import <UIKit/UIKit.h>

@interface JHPopoverViewController : NSObject <UIGestureRecognizerDelegate>

- (id)initWithViewController:(UIViewController*)viewController andContentSize:(CGSize)size;

- (void)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated;
- (void)dismissPopoverAnimated:(BOOL)animated;


// customising colours

- (void)setColor:(UIColor*)color forKey:(NSString*)key;
- (void)setColorsDictionary:(NSDictionary*)colorsDictionary;

@end
