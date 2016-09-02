//
//  ZMSwipeViewController.h
//  ZMEducation
//
//  Created by Hunter Li on 13-5-13.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import "FGalleryViewController.h"
#import "ReaderViewController.h"
#import "PageControl.h"
#import "SwipeView.h"
#import "ZMBaseOnlineViewController.h"
#import "AudioPlayer.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface ZMSwipeViewController : ZMBaseOnlineViewController<SwipeViewDataSource,SwipeViewDelegate,AVAudioPlayerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,FGalleryViewControllerDelegate,ReaderViewControllerDelegate>{
    PageControl* _pageControl;
    
    MPMoviePlayerViewController *playerViewController;
    UINavigationController *pdfNavigationController;
    AudioPlayer *_audioPlayer;
    
    AVAudioPlayer *_audioPlayer1;

    NSMutableArray* photosArray;
    
    int selectUnitId;
}

@property(nonatomic, retain) NSMutableArray* unitArray;
@property(nonatomic, retain) SwipeView* swipeView;
@property(nonatomic, retain) UIPopoverController* popoverController;

@end
