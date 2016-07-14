//
//  AudioPlayer.h
//  Share
//
//  Created by Lin Zhang on 11-4-26.
//  Copyright 2011年 www.eoemobile.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AudioButton;
@class AudioStreamer;

@interface AudioPlayer : NSObject {
    AudioStreamer *streamer;
    AudioButton *button;   
    NSURL *url;
    NSTimer *timer;
}

@property (nonatomic, retain) AudioStreamer *streamer;
@property (nonatomic, retain) AudioButton *button;
@property (nonatomic, retain) NSURL *url;

- (void)initInfo;
- (void)play;
-(void)pause;
- (void)stop;
- (BOOL)isProcessing;
-(BOOL)isPlaying;
-(BOOL)isPaused;
-(BOOL)isFinishing;
-(BOOL)isWaiting;

@end
