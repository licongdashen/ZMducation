//
//  ZMSwipeViewController.m
//  ZMEducation
//
//  Created by Hunter/Users/bb/Work/知明读写/ZMEducation0623/ZMEducation.xcodeproj Li on 13-5-13.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import <MobileCoreServices/MobileCoreServices.h>

#import "ZMSwipeViewController.h"
#import "AudioButton.h"

#import "ZMCheckItemViewController.h"
#import "ZMWriteGuideViewController.h"

#import "ZMArticleViewController.h"
#import "ZMArticleView01Controller.h"
#import "ZMArticleView02Controller.h"
#import "ZMArticleView03Controller.h"
#import "ZMArticleView04Controller.h"
#import "ZMArticleView05Controller.h"
#import "ZMArticleView06Controller.h"
#import "ZMArticleView07Controller.h"

//模板 add 20131003
#import "ZMMdlCmpVCtrl.h"
#import "ZMMdlExplainVCtrl.h"
#import "ZMMdlTopicVCtrl.h"
#import "ZMMdlSliderVCtrl.h"
#import "ZMMdlStoryVCtrl.h"
#import "ZMMdlTravelVCtrl.h"
#import "ZMMdlConceptionVCtrl.h"
#import "ZMMdlCommentVCtrl.h"

#import "UIImage+fixOrientation.h"

#define kTagCollectAddButton 5202
#define kTagShareToOtherButton 5203

@implementation ZMSwipeViewController
@synthesize popoverController;
@synthesize unitArray = _unitArray;
@synthesize swipeView = _swipeView;

-(IBAction)browsePhoto:(id)sender{
    [self screenLocked];
    
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    
    NSDictionary* unitDict = [_unitArray objectAtIndex:_swipeView.currentItemIndex];
    
    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDict setValue:@"M043" forKey:@"method"];
    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [requestDict setValue:[userDict valueForKey:@"currentModuleId"] forKey:@"moduleId"];
    [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
    [requestDict setValue:[unitDict valueForKey:@"unitId"] forKey:@"unitId"];
    
    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
    [httpEngine setDelegate:self];
    [httpEngine requestWithDict:requestDict];
    [httpEngine release];
    [requestDict release];
}

-(IBAction)takePicture:(id)sender{
    [self screenLocked];
    
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

- (void)playAudio:(AudioButton *)button{
    [self screenLocked];
    
    NSInteger index = button.tag;
    NSDictionary *unitDict = [_unitArray objectAtIndex:index];
    
    selectUnitId =  [[unitDict valueForKey:@"unitId"] intValue];
    
    
    if (((ZMAppDelegate *)[UIApplication sharedApplication].delegate).isdownfinsh == YES) {
        NSString * docPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString* unitURL = [[[_unitArray[index] valueForKey:@"unitURL"] componentsSeparatedByString:@"/"] lastObject];

        if (_audioPlayer1 == nil) {
            _audioPlayer1 = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:[docPath stringByAppendingPathComponent:unitURL]] error:nil];
        }
        if ([_audioPlayer1 isPlaying]) {
            [_audioPlayer1 pause];
            [button setBackgroundImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
            
        }else{
            [_audioPlayer1 prepareToPlay];
            [_audioPlayer1 play];
            [button setBackgroundImage:[UIImage imageNamed:@"stop.png"] forState:UIControlStateNormal];
            
        }
    }else {
        
        NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
        NSString* screenControl = [userDict valueForKey:@"screenControl"];
        NSString* role = [userDict valueForKey:@"role"];
        if ([@"02" isEqualToString:role] ||
            (([@"03" isEqualToString:role] || [@"04" isEqualToString:role]) && [@"01" isEqualToString:screenControl])) {
            
            NSString *urlStr = [NSString stringWithFormat:@"%@%@",kHttpRequestURL,[unitDict valueForKey:@"unitURL"]];
            if (_audioPlayer == nil) {
                _audioPlayer = [[AudioPlayer alloc] init];
            }
            
            if ([_audioPlayer.button isEqual:button]) {
                if ([_audioPlayer isPlaying]) {
                    [_audioPlayer pause];
                }else{
                    [_audioPlayer play];
                }
            } else {
                [_audioPlayer stop];
                
                _audioPlayer.button = button;
                
                NSFileManager* fileManager =[NSFileManager defaultManager];
                NSString* userDocPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)
                                       objectAtIndex:0];
                
                // 先创建文件 file ，再用 NSFileHandle 打开它
                NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
                NSString* courseId = [userDict valueForKey:@"currentCourseId"];
                NSString* classId = [userDict valueForKey:@"currentClassId"];
                NSString* gradeId = [userDict valueForKey:@"currentGradeId"];
                NSString* moduleId = [userDict valueForKey:@"currentModuleId"];
                NSString* unitId = [unitDict valueForKey:@"unitId"];
                NSString* unitURL = [unitDict valueForKey:@"unitURL"];
                
                NSString* file= [NSString stringWithFormat:@"%@_%@_%@_%@_%@.%@",gradeId,classId,courseId,moduleId,unitId,[[unitURL componentsSeparatedByString:@"."] lastObject]];
                NSString *filePath = [userDocPath stringByAppendingPathComponent:file];
                NSLog(@"path:%@",filePath);
                
                if([fileManager fileExistsAtPath:filePath]){
                    _audioPlayer.url = [NSURL URLWithString:filePath];
                }else{
                    _audioPlayer.url = [NSURL URLWithString:urlStr];
                }
                
                [_audioPlayer initInfo];
                [_audioPlayer play];
            }
            
            if ([@"02" isEqualToString:role] && [@"00" isEqualToString:screenControl]) {
                NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
                [requestDict setValue:@"M032" forKey:@"method"];
                [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
                [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
                [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
                [requestDict setValue:[userDict valueForKey:@"currentModuleId"] forKey:@"moduleId"];
                
                NSDictionary* unitDict = [_unitArray objectAtIndex:_swipeView.currentItemIndex];
                [requestDict setValue:[unitDict valueForKey:@"unitId"] forKey:@"unitId"];
                if ([_audioPlayer isPaused]) {
                    NSLog(@"isPaused");
                    [requestDict setValue:@"02" forKey:@"playControl"];
                }else if([_audioPlayer isProcessing]){
                    NSLog(@"isProcessing");
                    [requestDict setValue:@"01" forKey:@"playControl"];
                }else if([_audioPlayer isWaiting]){
                    NSLog(@"isWaiting");
                }else if([_audioPlayer isFinishing]){
                    NSLog(@"isFinishing");
                }else{
                    NSLog(@"isnot");
                }
                
                ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
                [httpEngine setDelegate:self];
                [httpEngine requestWithDict:requestDict];
                [httpEngine release];
                [requestDict release];
            }
        }

    }
    
}

-(IBAction)playVideoClick:(id)sender{
    [self screenLocked];
    
    UIButton* button = (UIButton*)sender;
    NSInteger index = button.tag;
    NSDictionary *unitDict = [_unitArray objectAtIndex:index];
    
    selectUnitId =  [[unitDict valueForKey:@"unitId"] intValue];
    
    if (((ZMAppDelegate *)[UIApplication sharedApplication].delegate).isdownfinsh == YES) {
        
        NSString * docPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString* unitURL = [[[_unitArray[index] valueForKey:@"unitURL"] componentsSeparatedByString:@"/"] lastObject];
        playerViewController = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:[docPath stringByAppendingPathComponent:unitURL]]];
        playerViewController.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
        
        [playerViewController.moviePlayer prepareToPlay];
        
        [self presentViewController:playerViewController animated:YES completion:nil];

    }else {
        
        NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
        NSString* screenControl = [userDict valueForKey:@"screenControl"];
        NSString* role = [userDict valueForKey:@"role"];
        
        if ([@"02" isEqualToString:role] ||
            (([@"03" isEqualToString:role] || [@"04" isEqualToString:role]) && [@"01" isEqualToString:screenControl])) {
            
            if ([@"02" isEqualToString:role] && [@"00" isEqualToString:screenControl]) {
                NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
                [requestDict setValue:@"M031" forKey:@"method"];
                [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
                [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
                [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
                [requestDict setValue:[userDict valueForKey:@"currentModuleId"] forKey:@"moduleId"];
                [requestDict setValue:[unitDict valueForKey:@"unitId"] forKey:@"unitId"];
                [requestDict setValue:@"00" forKey:@"playControl"];
                
                ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
                [httpEngine setDelegate:self];
                [httpEngine requestWithDict:requestDict];
                [httpEngine release];
                [requestDict release];
            }
            
            UIButton* playButton = (UIButton*)sender;
            int index = playButton.tag;
            
            NSDictionary* unitDict = [_unitArray objectAtIndex:index];
            NSString *urlStr = [NSString stringWithFormat:@"%@%@",kHttpRequestURL,[unitDict valueForKey:@"unitURL"]];
            
            NSFileManager* fileManager =[NSFileManager defaultManager];
            NSString* userDocPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)
                                   objectAtIndex:0];
            
            // 先创建文件 file ，再用 NSFileHandle 打开它
            NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
            NSString* courseId = [userDict valueForKey:@"currentCourseId"];
            NSString* classId = [userDict valueForKey:@"currentClassId"];
            NSString* gradeId = [userDict valueForKey:@"currentGradeId"];
            NSString* moduleId = [userDict valueForKey:@"currentModuleId"];
            NSString* unitId = [unitDict valueForKey:@"unitId"];
            NSString* unitURL = [unitDict valueForKey:@"unitURL"];
            
            NSString* file= [NSString stringWithFormat:@"%@_%@_%@_%@_%@.%@",gradeId,classId,courseId,moduleId,unitId,[[unitURL componentsSeparatedByString:@"."] lastObject]];
            NSString *filePath = [userDocPath stringByAppendingPathComponent:file];
            NSLog(@"path:%@",filePath);
            
            if([fileManager fileExistsAtPath:filePath]){
                playerViewController = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:filePath]];
            }else{
                playerViewController = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:urlStr]];
            }
            
            playerViewController.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
            
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(movieFinishedCallback:)
                                                         name:MPMoviePlayerPlaybackDidFinishNotification
                                                       object:[playerViewController moviePlayer]];
            
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(playbackStateChanged:)
                                                         name:MPMoviePlayerPlaybackStateDidChangeNotification
                                                       object:[playerViewController moviePlayer]];
            
            
            MPMoviePlayerController *player = [playerViewController moviePlayer];
            [player setShouldAutoplay:NO];
            
            [self presentViewController:playerViewController animated:YES completion:nil];
        }
    }
    
}

- (void)playbackStateChanged:(NSNotification*) aNotification {
    MPMoviePlayerController *player = [aNotification object];
    MPMoviePlaybackState playbackState = [player playbackState];

    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSString* screenControl = [userDict valueForKey:@"screenControl"];
    NSString* role = [userDict valueForKey:@"role"];

    switch (playbackState) {
        case MPMoviePlaybackStateStopped:
            NSLog(@"停止");
            
            if ([@"02" isEqualToString:role]) {
                if ([@"00" isEqualToString:screenControl]) {
                    for (int i = 0; i<[_unitArray count]; i++) {
                        NSDictionary* tempUnitDict = [_unitArray objectAtIndex:i];
                        int _unitId = [[tempUnitDict valueForKey:@"unitId"] intValue];
                        if (_unitId == selectUnitId) {
                            NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
                            [requestDict setValue:@"M031" forKey:@"method"];
                            [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
                            [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
                            [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
                            [requestDict setValue:[userDict valueForKey:@"currentModuleId"] forKey:@"moduleId"];
                            [requestDict setValue:[tempUnitDict valueForKey:@"unitId"] forKey:@"unitId"];
                            [requestDict setValue:@"03" forKey:@"playControl"];
                            
                            ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
                            [httpEngine setDelegate:self];
                            [httpEngine requestWithDict:requestDict];
                            [httpEngine release];
                            [requestDict release];
                        }
                    }
                }
            }
            break;
            
        case MPMoviePlaybackStatePlaying:
            NSLog(@"播放中");
            
            if ([@"02" isEqualToString:role]) {
                if ([@"00" isEqualToString:screenControl]) {
                    for (int i = 0; i<[_unitArray count]; i++) {
                        NSDictionary* tempUnitDict = [_unitArray objectAtIndex:i];
                        int _unitId = [[tempUnitDict valueForKey:@"unitId"] intValue];
                        if (_unitId == selectUnitId) {
                            NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
                            [requestDict setValue:@"M031" forKey:@"method"];
                            [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
                            [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
                            [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
                            [requestDict setValue:[userDict valueForKey:@"currentModuleId"] forKey:@"moduleId"];
                            [requestDict setValue:[tempUnitDict valueForKey:@"unitId"] forKey:@"unitId"];
                            [requestDict setValue:@"01" forKey:@"playControl"];
                            
                            ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
                            [httpEngine setDelegate:self];
                            [httpEngine requestWithDict:requestDict];
                            [httpEngine release];
                            [requestDict release];
                        }
                    }
                }
            }
            
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"暫停");
            
            if ([@"02" isEqualToString:role]) {
                if ([@"00" isEqualToString:screenControl]) {
                    for (int i = 0; i<[_unitArray count]; i++) {
                        NSDictionary* tempUnitDict = [_unitArray objectAtIndex:i];
                        int _unitId = [[tempUnitDict valueForKey:@"unitId"] intValue];
                        if (_unitId == selectUnitId) {
                            NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
                            [requestDict setValue:@"M031" forKey:@"method"];
                            [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
                            [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
                            [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
                            [requestDict setValue:[userDict valueForKey:@"currentModuleId"] forKey:@"moduleId"];
                            [requestDict setValue:[tempUnitDict valueForKey:@"unitId"] forKey:@"unitId"];
                            [requestDict setValue:@"02" forKey:@"playControl"];
                            
                            ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
                            [httpEngine setDelegate:self];
                            [httpEngine requestWithDict:requestDict];
                            [httpEngine release];
                            [requestDict release];
                        }
                    }
                }
            }

            break;
            
        case MPMoviePlaybackStateInterrupted:
            NSLog(@"播放被中斷");
            break;
            
        case MPMoviePlaybackStateSeekingForward:
            NSLog(@"往前快轉");
            break;
            
        case MPMoviePlaybackStateSeekingBackward:
            NSLog(@"往後快轉");
            break;
            
        default:
            NSLog(@"無法辨識的狀態");
            break;
    }
}


-(IBAction)answerClick:(id)sender{
    [self screenLocked];
    
    UIButton* answerButton = (UIButton*)sender;
    int index = answerButton.tag;
    
    NSDictionary* unitDict = [_unitArray objectAtIndex:index];

    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSMutableDictionary* articleUnitDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    [articleUnitDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
    [articleUnitDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
    [articleUnitDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
    [articleUnitDict setValue:[userDict valueForKey:@"currentModuleId"] forKey:@"moduleId"];
    [articleUnitDict setValue:[userDict valueForKey:@"userId"] forKey:@"authorId"];
    [articleUnitDict setValue:[unitDict valueForKey:@"unitId"] forKey:@"unitId"];
    
    
    NSString* articleType = [unitDict valueForKey:@"articleType"];//模板id
    //NSLog(@"articleType : %@",articleType);
    NSString* screenControl = [userDict valueForKey:@"screenControl"];
    NSString* role = [userDict valueForKey:@"role"];
    if ([@"02" isEqualToString:role] ||
        (([@"03" isEqualToString:role] || [@"04" isEqualToString:role])&& [@"01" isEqualToString:screenControl])) {
        if ([@"00" isEqualToString:screenControl]) {
            NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
            [requestDict setValue:@"M013" forKey:@"method"];
            [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
            [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
            [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
            [requestDict setValue:[userDict valueForKey:@"currentModuleId"] forKey:@"moduleId"];
            
            NSDictionary* unitDict = [_unitArray objectAtIndex:_swipeView.currentItemIndex];
            [requestDict setValue:[unitDict valueForKey:@"unitId"] forKey:@"unitId"];
            
            [requestDict setValue:@"01" forKey:@"control"];
            
            ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
            [httpEngine setDelegate:self];
            [httpEngine requestWithDict:requestDict];
            [httpEngine release];
            [requestDict release];
        }
        
        if ([@"01" isEqualToString:articleType]) {
            ZMArticleViewController* viewController = [[ZMArticleViewController alloc] init];
            [viewController setType:1];
            [viewController setUnitDict:articleUnitDict];
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }else if([@"02" isEqualToString:articleType]){
            ZMArticleView01Controller* viewController = [[ZMArticleView01Controller alloc] init];
            [viewController setType:1];
            [viewController setUnitDict:articleUnitDict];
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }else if([@"03" isEqualToString:articleType]){
            ZMArticleView02Controller* viewController = [[ZMArticleView02Controller alloc] init];
            [viewController setType:1];
            [viewController setUnitDict:articleUnitDict];
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }else if([@"04" isEqualToString:articleType]){
            ZMArticleView03Controller* viewController = [[ZMArticleView03Controller alloc] init];
            [viewController setType:1];
            [viewController setUnitDict:articleUnitDict];
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }else if([@"05" isEqualToString:articleType]){
            ZMArticleView04Controller* viewController = [[ZMArticleView04Controller alloc] init];
            [viewController setType:1];
            [viewController setUnitDict:articleUnitDict];
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }else if([@"06" isEqualToString:articleType]){
            ZMArticleView05Controller* viewController = [[ZMArticleView05Controller alloc] init];
            [viewController setType:1];
            [viewController setUnitDict:articleUnitDict];
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }else if([@"07" isEqualToString:articleType]){
            ZMArticleView06Controller* viewController = [[ZMArticleView06Controller alloc] init];
            [viewController setType:1];
            [viewController setUnitDict:articleUnitDict];
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }else if([@"08" isEqualToString:articleType]){
            ZMArticleView07Controller* viewController = [[ZMArticleView07Controller alloc] init];
            [viewController setType:1];
            [viewController setUnitDict:articleUnitDict];
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }else if([@"09" isEqualToString:articleType]){
            ZMWriteGuideViewController* viewController = [[ZMWriteGuideViewController alloc] init];
            [viewController setType:1];
            [viewController setUnitDict:articleUnitDict];
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }else if([@"00" isEqualToString:articleType]){
            [articleUnitDict setValue:articleType forKey:@"articleType"];
            ZMCheckItemViewController* viewController = [[ZMCheckItemViewController alloc] init];
            [viewController setType:1];
            [viewController setUnitDict:articleUnitDict];
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }else if([articleType intValue] == 11){//7个模板 11－17分别对应7个模板
            [articleUnitDict setValue:articleType forKey:@"articleType"];
            ZMMdlCmpVCtrl * viewController = [[ZMMdlCmpVCtrl alloc] init];
            [viewController setType:1];
            viewController.unitDict = articleUnitDict;
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }
        else if([articleType intValue] == 12){
            [articleUnitDict setValue:articleType forKey:@"articleType"];
            ZMMdlExplainVCtrl * viewController = [[ZMMdlExplainVCtrl alloc] init];
            [viewController setType:1];
            viewController.unitDict = articleUnitDict;
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }
        else if([articleType intValue]== 13){
            [articleUnitDict setValue:articleType forKey:@"articleType"];
            ZMMdlTopicVCtrl * viewController = [[ZMMdlTopicVCtrl alloc] init];
            [viewController setType:1];
            viewController.unitDict = articleUnitDict;
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }
        else if([articleType intValue] == 14){
            [articleUnitDict setValue:articleType forKey:@"articleType"];
            ZMMdlSliderVCtrl * viewController = [[ZMMdlSliderVCtrl alloc] init];
            [viewController setType:1];
            viewController.unitDict = articleUnitDict;
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }
        else if([articleType intValue] == 15){
            [articleUnitDict setValue:articleType forKey:@"articleType"];
            ZMMdlStoryVCtrl * viewController = [[ZMMdlStoryVCtrl alloc] init];
            [viewController setType:1];
            viewController.unitDict = articleUnitDict;
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }
        else if([articleType intValue] == 16){
            [articleUnitDict setValue:articleType forKey:@"articleType"];
            ZMMdlTravelVCtrl * viewController = [[ZMMdlTravelVCtrl alloc] init];
            [viewController setType:1];
            viewController.unitDict = articleUnitDict;
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }
        else if([articleType intValue] == 17){
            [articleUnitDict setValue:articleType forKey:@"articleType"];
            ZMMdlConceptionVCtrl * viewController = [[ZMMdlConceptionVCtrl alloc] init];
            [viewController setType:1];
            viewController.unitDict = articleUnitDict;
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }
        else if([articleType intValue] == 18){
            [articleUnitDict setValue:articleType forKey:@"articleType"];
            ZMMdlCommentVCtrl * viewController = [[ZMMdlCommentVCtrl alloc] init];
            [viewController setType:1];
            viewController.unitDict = articleUnitDict;
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
        }
        
    }
    
    [articleUnitDict release];
}

- (NSString *)videoCachePath
{
    
    NSString * docPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *diskPath = [docPath stringByAppendingPathComponent:@"ZM_temp"]; // 新建一个文件夹  保存视频
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:diskPath])
    {
        [fileManager createDirectoryAtPath:diskPath withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    return diskPath;
}

-(IBAction)readClick:(id)sender{
    [self screenLocked];
    
    UIButton* readButton = (UIButton*)sender;
    int index = readButton.tag;
    
    NSDictionary* unitDict = [_unitArray objectAtIndex:index];
    NSLog(@"unitDict:%@",unitDict);
    
    if (((ZMAppDelegate *)[UIApplication sharedApplication].delegate).isdownfinsh == YES) {
        NSString * docPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString* unitURL = [[[_unitArray[index] valueForKey:@"unitURL"] componentsSeparatedByString:@"/"] lastObject];
        
        ReaderDocument *document = [ReaderDocument withDocumentFilePath:[docPath stringByAppendingPathComponent:unitURL] password:nil];
        ReaderViewController* pdfController = [[ReaderViewController alloc] initWithReaderDocument:document];
        [pdfController setShowToolbar:YES];
        [pdfController setDelegate:self];
        pdfNavigationController = [[UINavigationController alloc] initWithRootViewController:pdfController];
        [pdfNavigationController setNavigationBarHidden:YES animated:YES];
        [self presentViewController:pdfNavigationController animated:YES completion:NULL];
        [pdfController release];

    }else {
        
        selectUnitId =  [[unitDict valueForKey:@"unitId"] intValue];
        NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
        NSString* screenControl = [userDict valueForKey:@"screenControl"];
        NSString* role = [userDict valueForKey:@"role"];
        if ([@"02" isEqualToString:role] ||
            (([@"03" isEqualToString:role] || [@"04" isEqualToString:role])&& [@"01" isEqualToString:screenControl])) {
            if ([@"00" isEqualToString:screenControl]) {
                NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
                [requestDict setValue:@"M013" forKey:@"method"];
                [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
                [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
                [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
                [requestDict setValue:[userDict valueForKey:@"currentModuleId"] forKey:@"moduleId"];
                
                NSDictionary* unitDict = [_unitArray objectAtIndex:_swipeView.currentItemIndex];
                [requestDict setValue:[unitDict valueForKey:@"unitId"] forKey:@"unitId"];
                
                [requestDict setValue:@"01" forKey:@"control"];
                
                ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
                [httpEngine setDelegate:self];
                [httpEngine requestWithDict:requestDict];
                [httpEngine release];
                [requestDict release];
            }
            
            /*NSString *urlStr = [NSString stringWithFormat:@"%@%@",kHttpRequestURL,[unitDict valueForKey:@"unitURL"]];
             
             NSURL *documentURL = [NSURL URLWithString:urlStr];
             PSPDFDocument *document = [PSPDFDocument documentWithURL:documentURL];
             //[[PSPDFCache sharedCache] clearCache];
             PSPDFViewController* pdfController = [[PSPDFViewController alloc] initWithDocument:document];
             [pdfController setDelegate:self];
             [pdfController setRightBarButtonItems:nil];
             //[pdfController setScrollingEnabled:NO];
             pdfNavigationController = [[UINavigationController alloc] initWithRootViewController:pdfController];
             [self presentViewController:pdfNavigationController animated:YES completion:NULL];
             [pdfController release];
             */
            
            NSFileManager* fileManager =[NSFileManager defaultManager];
            NSString* userDocPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)
                                   objectAtIndex:0];
            
            NSString* unitURL = [[[unitDict valueForKey:@"unitURL"] componentsSeparatedByString:@"/"] lastObject];
            
            NSString *filePath = [userDocPath stringByAppendingPathComponent:unitURL];
            NSLog(@"path:%@",filePath);
            
            if([fileManager fileExistsAtPath:filePath] ){
                [fileManager removeItemAtPath:filePath error:nil];
            }
            
            BOOL createFileSuccess = [fileManager createFileAtPath:filePath
                                                          contents:nil
                                                        attributes:nil];
            if (createFileSuccess){
                NSFileHandle* filehandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
                
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kHttpRequestURL,[unitDict valueForKey:@"unitURL"]]];
                ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
                
                [self showIndicator];
                [request setUserInfo:[NSDictionary dictionaryWithObject:unitURL forKey:@"TargetPath"]];
                [request setCompletionBlock :^( void ){
                    NSLog ( @"%@ complete !" ,unitURL);
                    assert (filehandle);
                    [self hideIndicator];
                    [filehandle closeFile ];
                    
                    ReaderDocument *document = [ReaderDocument withDocumentFilePath:filePath password:nil];
                    ReaderViewController* pdfController = [[ReaderViewController alloc] initWithReaderDocument:document];
                    [pdfController setShowToolbar:YES];
                    [pdfController setDelegate:self];
                    pdfNavigationController = [[UINavigationController alloc] initWithRootViewController:pdfController];
                    [pdfNavigationController setNavigationBarHidden:YES animated:YES];
                    [self presentViewController:pdfNavigationController animated:YES completion:NULL];
                    [pdfController release];
                }];
                
                [request setFailedBlock :^( void ){
                    NSLog ( @"%@ download failed !" ,unitURL);
                    [self hideIndicator];
                }];
                
                [request setDataReceivedBlock :^( NSData * data){
                    if (filehandle != nil ) {
                        [filehandle seekToEndOfFile ];
                        [filehandle writeData :data];
                    }
                }];
                
                [request startAsynchronous];
            }
        }

    }
   
}

- (void)movieFinishedCallback:(NSNotification*)aNotification {
    MPMoviePlayerController *player = [aNotification object];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:player];
    [player stop];
    
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSString* screenControl = [userDict valueForKey:@"screenControl"];
    NSString* role = [userDict valueForKey:@"role"];
    if ([@"02" isEqualToString:role]) {
        if ([@"00" isEqualToString:screenControl]) {
            for (int i = 0; i<[_unitArray count]; i++) {
                NSDictionary* tempUnitDict = [_unitArray objectAtIndex:i];
                int _unitId = [[tempUnitDict valueForKey:@"unitId"] intValue];
                if (_unitId == selectUnitId) {
                    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
                    [requestDict setValue:@"M031" forKey:@"method"];
                    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
                    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
                    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
                    [requestDict setValue:[userDict valueForKey:@"currentModuleId"] forKey:@"moduleId"];
                    [requestDict setValue:[tempUnitDict valueForKey:@"unitId"] forKey:@"unitId"];
                    [requestDict setValue:@"03" forKey:@"playControl"];
                    
                    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
                    [httpEngine setDelegate:self];
                    [httpEngine requestWithDict:requestDict];
                    [httpEngine release];
                    [requestDict release];
                }
            }
        }
    }
}

-(IBAction)downloadClick:(id)sender{
    //[self screenLocked];
    
    UIButton* readButton = (UIButton*)sender;
    int index = readButton.tag;
    
    NSDictionary* unitDict = [_unitArray objectAtIndex:index];
    if ([@"01" isEqualToString:[unitDict valueForKey:@"unitType"]] ||
        [@"02" isEqualToString:[unitDict valueForKey:@"unitType"]]) {
        
        NSFileManager* fileManager =[NSFileManager defaultManager];
        NSString* userDocPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)
                               objectAtIndex:0];
        
        // 先创建文件 file ，再用 NSFileHandle 打开它
        NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
        NSString* courseId = [userDict valueForKey:@"currentCourseId"];
        NSString* classId = [userDict valueForKey:@"currentClassId"];
        NSString* gradeId = [userDict valueForKey:@"currentGradeId"];
        NSString* moduleId = [userDict valueForKey:@"currentModuleId"];
        NSString* unitId = [unitDict valueForKey:@"unitId"];
        NSString* unitURL = [unitDict valueForKey:@"unitURL"];
        
        NSString* file= [NSString stringWithFormat:@"%@_%@_%@_%@_%@.%@",gradeId,classId,courseId,moduleId,unitId,[[unitURL componentsSeparatedByString:@"."] lastObject]];
        NSString *filePath = [userDocPath stringByAppendingPathComponent:file];
        NSLog(@"path:%@",filePath);
        
        if([fileManager fileExistsAtPath:filePath]){
            [fileManager removeItemAtPath:filePath error:nil];
        }
        
        BOOL createFileSuccess = [fileManager createFileAtPath:filePath
                                                      contents:nil
                                                    attributes:nil];
        
        if (createFileSuccess){
            NSFileHandle* filehandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
            
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kHttpRequestURL,[unitDict valueForKey:@"unitURL"]]];
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
            
            [self showIndicator];
            [request setUserInfo:[NSDictionary dictionaryWithObject:file forKey:@"TargetPath"]];
            [request setCompletionBlock :^( void ){
                NSLog ( @"%@ complete !" ,file);
                assert (filehandle);
                [self hideIndicator];
                [filehandle closeFile ];
            }];
            
            [request setFailedBlock :^( void ){
                NSLog ( @"%@ download failed !" ,file);
                [self hideIndicator];
            }];
            
            [request setDataReceivedBlock :^( NSData * data){
                if (filehandle != nil ) {
                    [filehandle seekToEndOfFile ];
                    [filehandle writeData :data];
                }
            }];
            
            [request startAsynchronous];
        }
    }
}

-(void)dealloc{
    [_swipeView setDataSource:nil];
    [_swipeView setDelegate:nil];
    [_swipeView release];
    
    [_pageControl release];
    
    [_unitArray release];
    [photosArray release];
    
    [_audioPlayer stop];
    [_audioPlayer release];
    
    [pdfNavigationController release];
    [playerViewController release];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"unitExplainNotification"
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"PDFExplainNotification"
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"playAudioDidChangeNotification"
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"playVideoDidChangeNotification"
                                                  object:nil];

    [super dealloc];
}

-(IBAction)backClick:(id)sender{
    [self screenLocked];
    
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSString* screenControl = [userDict valueForKey:@"screenControl"];
    NSString* role = [userDict valueForKey:@"role"];
    if ([@"02" isEqualToString:role]) {
        if ([@"00" isEqualToString:screenControl]) {
            NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
            [requestDict setValue:@"M012" forKey:@"method"];
            [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
            [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
            [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
            [requestDict setValue:[userDict valueForKey:@"currentModuleId"] forKey:@"moduleId"];
            [requestDict setValue:@"02" forKey:@"control"];
            
            ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
            [httpEngine setDelegate:self];
            [httpEngine requestWithDict:requestDict];
            [httpEngine release];
            [requestDict release];
        }else if ([@"01" isEqualToString:screenControl]){
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else if([@"03" isEqualToString:role] || [@"04" isEqualToString:role]){
        if ([@"01" isEqualToString:screenControl]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

-(void)loadView{
    [super loadView];
    
    
    UIImage* bearImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bear" ofType:@"png"]];
    UIImageView* bearView = [[UIImageView alloc] initWithFrame:CGRectMake(66, 195, 71, 81)];
    [bearView setImage:bearImage];
    [self.view addSubview:bearView];
    [bearView release];
}

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    photosArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self
                                              selector:@selector(unitExplain:)
                                                  name:@"unitExplainNotification"
                                                object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self
                                              selector:@selector(pdfExplain:)
                                                  name:@"PDFExplainNotification"
                                                object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self
                                              selector:@selector(playAudioDidChange:)
                                                  name:@"playAudioDidChangeNotification"
                                                object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self
                                              selector:@selector(playVideoDidChange:)
                                                  name:@"playVideoDidChangeNotification"
                                                object:nil];
    
    UIImageView* typeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(165, 230, 78, 39)];
    
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSString* currentModuleId = [userDict valueForKey:@"currentModuleId"];

    if ([@"00" isEqualToString:currentModuleId]) {
        UIImage* typeImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Icon_read" ofType:@"png"]];
        [typeImageView setImage:typeImage];
    }else if([@"01" isEqualToString:currentModuleId]){
        UIImage* typeImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Icon_Renwu" ofType:@"png"]];
        [typeImageView setImage:typeImage];
    }else if([@"02" isEqualToString:currentModuleId]){
        UIImage* typeImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Icon_Gousi" ofType:@"png"]];
        [typeImageView setImage:typeImage];
    }else if([@"03" isEqualToString:currentModuleId]){
        UIImage* typeImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Icon_Qicao" ofType:@"png"]];
        [typeImageView setImage:typeImage];
    }else if([@"04" isEqualToString:currentModuleId]){
        UIImage* typeImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Icon_xiugai" ofType:@"png"]];
        [typeImageView setImage:typeImage];
    }else if([@"05" isEqualToString:currentModuleId]){
        UIImage* typeImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Icon_jiaodui" ofType:@"png"]];
        [typeImageView setImage:typeImage];
    }
    
    [self.view addSubview:typeImageView];
    [typeImageView release];
    
    _swipeView = [[SwipeView alloc] initWithFrame:CGRectMake(0, 290, 1024, 400)];
    [_swipeView setDataSource:self];
    [_swipeView setDelegate:self];
    _swipeView.alignment = SwipeViewAlignmentCenter;
    _swipeView.pagingEnabled = YES;
    _swipeView.wrapEnabled = NO;
    _swipeView.itemsPerPage = 1;
    _swipeView.truncateFinalPage = YES;
    [self.view addSubview:_swipeView];

    NSString* screenControl = [userDict valueForKey:@"screenControl"];
    NSString* role = [userDict valueForKey:@"role"];
    if([@"03" isEqualToString:role] || [@"04" isEqualToString:role]){
        if ([@"00" isEqualToString:screenControl]) {
            [_swipeView setScrollEnabled:NO];
        }else if([@"01" isEqualToString:screenControl]){
            [_swipeView setScrollEnabled:YES];
        }
    }
    
    _pageControl = [[PageControl alloc] initWithFrame:CGRectMake(0, 700, 1024, 36)];
    _pageControl.image =  [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PageControl_Dot" ofType:@"png"]];
	_pageControl.selectedImage =  [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PageControl_Dot_Selected" ofType:@"png"]];;
	_pageControl.padding = 13.0f;
	_pageControl.orientation = PageControlOrientationLandscape;
	_pageControl.numberOfPages = _swipeView.numberOfPages;
    [self.view addSubview:_pageControl];
}

#pragma mark SwipeViewDataSource methods
- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView{
    return [_unitArray count];
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    if (view == nil){
        view = [[[UIView alloc] initWithFrame:[swipeView bounds]] autorelease];
    }else{
        for(UIView* subVivew in [view subviews]){
            [subVivew removeFromSuperview];
        }
    }
    
    NSDictionary* unitDict = [_unitArray objectAtIndex:index];
    UIImage* contentImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"lecture_Content_Bg" ofType:@"png"]];
    UIImageView* contentView = [[UIImageView alloc] initWithFrame:CGRectMake(109, 2, 527, 221)];
    [contentView setImage:contentImage];
    
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100.0f, 30.0f, 327.0f, 30.0f)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [titleLabel setText:[unitDict valueForKey:@"unitTitle"]];
    [titleLabel setFont:[UIFont systemFontOfSize:19]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [contentView addSubview:titleLabel];
    [titleLabel release];
    
    UILabel* contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(60.0f, 70.0f, 407.0f, 60.0f)];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.textColor = [UIColor whiteColor];
    NSString* unitBrief = [unitDict valueForKey:@"unitBrief"];
    if ([unitBrief isKindOfClass:[NSNull class]])
        [contentLabel setText:@""];
    else
        [contentLabel setText:unitBrief];
    [contentLabel setNumberOfLines:2];
    [contentLabel setFont:[UIFont systemFontOfSize:15]];
    [contentLabel setBackgroundColor:[UIColor clearColor]];
    [contentView addSubview:contentLabel];
    [contentLabel release];
    
    UIImage* typeIconImage = nil;
    NSString* unitType = [unitDict valueForKey:@"unitType"];
    
    if ([@"00" isEqualToString:unitType]) {
        typeIconImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Type_pdf" ofType:@"png"]];
    }else if([@"01" isEqualToString:unitType]){
        typeIconImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Type_video" ofType:@"png"]];
    }else if([@"02" isEqualToString:unitType]){
        typeIconImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Type_audio" ofType:@"png"]];
    }else if([@"03" isEqualToString:unitType]){
        typeIconImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Type_picture" ofType:@"png"]];
    }else if([@"04" isEqualToString:unitType]){
        typeIconImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Type_exam" ofType:@"png"]];
    }
    UIImageView* typeIconView = [[UIImageView alloc] initWithFrame:CGRectMake(440, 152, 33, 39)];
    [typeIconView setImage:typeIconImage];
    [contentView addSubview:typeIconView];
    [typeIconView release];
    
    [view addSubview:contentView];
    [contentView release];

    if([@"02" isEqualToString:unitType]){
//        UIButton* download_But = [UIButton buttonWithType:UIButtonTypeCustom];
//        [download_But setFrame:CGRectMake(215, 252, 171, 40)];
//        [download_But setTag:index];
//        [download_But setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Unit_Common_Button" ofType:@"png"]] forState:UIControlStateNormal];
//        [download_But setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Unit_Common_Button" ofType:@"png"]] forState:UIControlStateHighlighted];
//        [download_But setTitle:@"下载" forState:UIControlStateNormal];
//        [download_But addTarget:self
//                         action:@selector(downloadClick:)
//               forControlEvents:UIControlEventTouchUpInside];
//        [view addSubview:download_But];

        
        AudioButton* audioButton = [[AudioButton alloc] initWithFrame:CGRectMake(417, 252, 50, 50)];
        [audioButton setTag:index];
        [audioButton addTarget:self
                        action:@selector(playAudio:)
              forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:audioButton];
        [audioButton release];
    }else if([@"03" isEqualToString:unitType]){
        UIButton* browse_But = [UIButton buttonWithType:UIButtonTypeCustom];
        [browse_But setFrame:CGRectMake(317, 252, 171, 40)];
        [browse_But setTag:index];
        [browse_But setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Unit_Common_Button" ofType:@"png"]] forState:UIControlStateNormal];
        [browse_But setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Unit_Common_Button" ofType:@"png"]] forState:UIControlStateHighlighted];
        [browse_But setTitle:@"浏览" forState:UIControlStateNormal];
        [browse_But addTarget:self
                     action:@selector(browsePhoto:)
           forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:browse_But];
        
        UIButton* photo_But = [UIButton buttonWithType:UIButtonTypeCustom];
        [photo_But setFrame:CGRectMake(250, 247, 49, 50)];
        [photo_But setTag:index];
        [photo_But setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Camera_Button" ofType:@"png"]] forState:UIControlStateNormal];
        [photo_But setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Camera_Button" ofType:@"png"]] forState:UIControlStateHighlighted];
        [photo_But addTarget:self
                       action:@selector(takePicture:)
             forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:photo_But];
    }else if([@"00" isEqualToString:unitType]){
        UIButton* read_But = [UIButton buttonWithType:UIButtonTypeCustom];
        [read_But setFrame:CGRectMake(317, 252, 171, 40)];
        [read_But setTag:index];
        [read_But setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Unit_Common_Button" ofType:@"png"]] forState:UIControlStateNormal];
        [read_But setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Unit_Common_Button" ofType:@"png"]] forState:UIControlStateHighlighted];
        [read_But setTitle:@"阅读" forState:UIControlStateNormal];
        [read_But addTarget:self
                       action:@selector(readClick:)
             forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:read_But];
    }else if([@"01" isEqualToString:unitType]){
//        UIButton* download_But = [UIButton buttonWithType:UIButtonTypeCustom];
//        [download_But setFrame:CGRectMake(155, 252, 171, 40)];
//        [download_But setTag:index];
//        [download_But setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Unit_Common_Button" ofType:@"png"]] forState:UIControlStateNormal];
//        [download_But setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Unit_Common_Button" ofType:@"png"]] forState:UIControlStateHighlighted];
//        [download_But setTitle:@"下载" forState:UIControlStateNormal];
//        [download_But addTarget:self
//                         action:@selector(downloadClick:)
//               forControlEvents:UIControlEventTouchUpInside];
//        [view addSubview:download_But];
        
        UIButton* play_But = [UIButton buttonWithType:UIButtonTypeCustom];
        [play_But setFrame:CGRectMake(357, 252, 171, 40)];
        [play_But setTag:index];
        [play_But setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Unit_Common_Button" ofType:@"png"]] forState:UIControlStateNormal];
        [play_But setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Unit_Common_Button" ofType:@"png"]] forState:UIControlStateHighlighted];
        [play_But setTitle:@"播放" forState:UIControlStateNormal];
        [play_But addTarget:self
                     action:@selector(playVideoClick:)
           forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:play_But];
    }else if([@"04" isEqualToString:unitType]){
        UIButton* answerBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [answerBut setFrame:CGRectMake(317, 252, 171, 40)];
        [answerBut setTag:index];
        [answerBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Unit_Common_Button" ofType:@"png"]] forState:UIControlStateNormal];
        [answerBut setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Unit_Common_Button" ofType:@"png"]] forState:UIControlStateHighlighted];
        [answerBut setTitle:@"答题" forState:UIControlStateNormal];
        [answerBut addTarget:self
                     action:@selector(answerClick:)
           forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:answerBut];
    }
    
    return view;
}

#pragma mark screenControlDidChangeNotification methods
-(void)screenControlDidChange:(NSNotification *)notification{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSString* screenControl = [userDict valueForKey:@"screenControl"];
    NSString* role = [userDict valueForKey:@"role"];
    if([@"03" isEqualToString:role] || [@"04" isEqualToString:role]){
        if ([@"00" isEqualToString:screenControl]) {
            [_swipeView setScrollEnabled:NO];
        }else if([@"01" isEqualToString:screenControl]){
            [_swipeView setScrollEnabled:YES];
        }
    }
}

#pragma mark playVideoDidChangeNotification methods
-(void)playVideoDidChange:(NSNotification *)notification{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSString* screenControl = [userDict valueForKey:@"screenControl"];
    //int currentGradeId = [[userDict valueForKey:@"currentGradeId"] intValue];
    //int currentClassId = [[userDict valueForKey:@"currentClassId"] intValue];
    //NSString* currentModuleId = [userDict valueForKey:@"currentModuleId"];
    NSString* role = [userDict valueForKey:@"role"];
    if([@"03" isEqualToString:role] || [@"04" isEqualToString:role]){
        if ([@"00" isEqualToString:screenControl]) {
            NSDictionary* _unitDict = [notification userInfo];
            
            //int gradeId  = [[_unitDict valueForKey:@"gradeId"] intValue];
            //int classId  = [[_unitDict valueForKey:@"classId"] intValue];
            //NSString* moduleId  = [_unitDict valueForKey:@"moduleId"];
            int unitId = [[_unitDict valueForKey:@"unitId"] intValue];
            
            for (int i = 0; i<[_unitArray count]; i++) {
                NSDictionary* tempUnitDict = [_unitArray objectAtIndex:i];
                int _unitId = [[tempUnitDict valueForKey:@"unitId"] intValue];
                if (_unitId == unitId) {
                    NSString* playControl = [_unitDict valueForKey:@"playControl"];
                    NSLog(@"playControl:%@",playControl);
                    
                    if ([@"00" isEqualToString:playControl]) {
                        NSString *urlStr = [NSString stringWithFormat:@"%@%@",kHttpRequestURL,[tempUnitDict valueForKey:@"unitURL"]];
                        
                        NSFileManager* fileManager =[NSFileManager defaultManager];
                        NSString* userDocPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)
                                               objectAtIndex:0];
                        
                        // 先创建文件 file ，再用 NSFileHandle 打开它
                        NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
                        NSString* courseId = [userDict valueForKey:@"currentCourseId"];
                        NSString* classId = [userDict valueForKey:@"currentClassId"];
                        NSString* gradeId = [userDict valueForKey:@"currentGradeId"];
                        NSString* moduleId = [userDict valueForKey:@"currentModuleId"];
                        NSString* unitId = [tempUnitDict valueForKey:@"unitId"];
                        NSString* unitURL = [tempUnitDict valueForKey:@"unitURL"];
                        
                        NSString* file= [NSString stringWithFormat:@"%@_%@_%@_%@_%@.%@",gradeId,classId,courseId,moduleId,unitId,[[unitURL componentsSeparatedByString:@"."] lastObject]];
                        NSString *filePath = [userDocPath stringByAppendingPathComponent:file];
                        NSLog(@"path:%@",filePath);
                        
                        if([fileManager fileExistsAtPath:filePath]){
                            playerViewController = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:filePath]];
                        }else{
                            playerViewController = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:urlStr]];
                        }
                        playerViewController.moviePlayer.controlStyle = MPMovieControlStyleNone;
                        playerViewController.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
                        
                        [[NSNotificationCenter defaultCenter] addObserver:self
                                                                 selector:@selector(movieFinishedCallback:)
                                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                                   object:[playerViewController moviePlayer]];
                        
                        [[NSNotificationCenter defaultCenter] addObserver:self
                                                                 selector:@selector(playbackStateChanged:)
                                                                     name:MPMoviePlayerPlaybackStateDidChangeNotification
                                                                   object:[playerViewController moviePlayer]];
                        
                        
                        MPMoviePlayerController *player = [playerViewController moviePlayer];
                        [player setShouldAutoplay:NO];
                        
                        [self presentViewController:playerViewController animated:YES completion:nil];
                    }else if([@"01" isEqualToString:playControl]){
                        [playerViewController.moviePlayer play];
                    }else if([@"02" isEqualToString:playControl]){
                        [playerViewController.moviePlayer pause];
                    }else if([@"03" isEqualToString:playControl]){
                        [playerViewController dismissViewControllerAnimated:YES completion:NULL];
                    }
                }
            }
        }
    }
}

#pragma mark playAudioDidChangeNotification methods
-(void)playAudioDidChange:(NSNotification *)notification{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSString* screenControl = [userDict valueForKey:@"screenControl"];
    //int currentGradeId = [[userDict valueForKey:@"currentGradeId"] intValue];
    //int currentClassId = [[userDict valueForKey:@"currentClassId"] intValue];
    //NSString* currentModuleId = [userDict valueForKey:@"currentModuleId"];
    NSString* role = [userDict valueForKey:@"role"];
    if([@"03" isEqualToString:role] || [@"04" isEqualToString:role]){
        if ([@"00" isEqualToString:screenControl]) {
            NSDictionary* _unitDict = [notification userInfo];
            
            //int gradeId  = [[_unitDict valueForKey:@"gradeId"] intValue];
            //int classId  = [[_unitDict valueForKey:@"classId"] intValue];
            //NSString* moduleId  = [_unitDict valueForKey:@"moduleId"];
            int unitId = [[_unitDict valueForKey:@"unitId"] intValue];
            
            for (int i = 0; i<[_unitArray count]; i++) {
                NSDictionary* tempUnitDict = [_unitArray objectAtIndex:i];
                int _unitId = [[tempUnitDict valueForKey:@"unitId"] intValue];
                if (_unitId == unitId) {
                    NSString* playControl = [_unitDict valueForKey:@"playControl"];
                    NSLog(@"playControl:%@",playControl);
                    
                    NSDictionary *unitDict = [_unitArray objectAtIndex:i];
                    NSString *urlStr = [NSString stringWithFormat:@"%@%@",kHttpRequestURL,[unitDict valueForKey:@"unitURL"]];
                    if (_audioPlayer == nil) {
                        _audioPlayer = [[AudioPlayer alloc] init];
                    }
                    
                    UIView* itemView = [_swipeView itemViewAtIndex:i];
                    for (UIView* subView in [itemView subviews]) {
                        NSString * buttonName = @"AudioButton";
                        if ([NSStringFromClass([subView class]) isEqualToString:buttonName] ) {
                            if ([_audioPlayer.button isEqual:(AudioButton*)subView]) {
                                if ([@"02" isEqualToString:playControl]) {
                                    [_audioPlayer pause];
                                }else if([@"01" isEqualToString:playControl]){
                                    [_audioPlayer play];
                                }
                            } else {
                                [_audioPlayer stop];
                                
                                _audioPlayer.button = (AudioButton*)subView;
                                
                                NSFileManager* fileManager =[NSFileManager defaultManager];
                                NSString* userDocPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)
                                                       objectAtIndex:0];
                                
                                // 先创建文件 file ，再用 NSFileHandle 打开它
                                NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
                                NSString* courseId = [userDict valueForKey:@"currentCourseId"];
                                NSString* classId = [userDict valueForKey:@"currentClassId"];
                                NSString* gradeId = [userDict valueForKey:@"currentGradeId"];
                                NSString* moduleId = [userDict valueForKey:@"currentModuleId"];
                                NSString* unitId = [unitDict valueForKey:@"unitId"];
                                NSString* unitURL = [unitDict valueForKey:@"unitURL"];
                                
                                NSString* file= [NSString stringWithFormat:@"%@_%@_%@_%@_%@.%@",gradeId,classId,courseId,moduleId,unitId,[[unitURL componentsSeparatedByString:@"."] lastObject]];
                                NSString *filePath = [userDocPath stringByAppendingPathComponent:file];
                                NSLog(@"path:%@",filePath);
                                
                                if([fileManager fileExistsAtPath:filePath]){
                                    _audioPlayer.url = [NSURL URLWithString:filePath];
                                }else{
                                    _audioPlayer.url = [NSURL URLWithString:urlStr];
                                }
                                
                                [_audioPlayer initInfo];
                                [_audioPlayer play];
                            }
                            
                            break;
                        }
                    }
                                        
                    break;
                }
            }
        }
    }
}

#pragma mark pdfExplainNotification methods
-(void)pdfExplain:(NSNotification *)notification{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSString* screenControl = [userDict valueForKey:@"screenControl"];
    int currentGradeId = [[userDict valueForKey:@"currentGradeId"] intValue];
    int currentClassId = [[userDict valueForKey:@"currentClassId"] intValue];
    NSString* currentModuleId = [userDict valueForKey:@"currentModuleId"];
    NSString* role = [userDict valueForKey:@"role"];
    if([@"03" isEqualToString:role] || [@"04" isEqualToString:role]){
        if ([@"00" isEqualToString:screenControl]) {
            NSDictionary* _unitDict = [notification userInfo];
            
            int gradeId  = [[_unitDict valueForKey:@"gradeId"] intValue];
            int classId  = [[_unitDict valueForKey:@"classId"] intValue];
            NSString* moduleId  = [_unitDict valueForKey:@"moduleId"];
            //int unitId = [[_unitDict valueForKey:@"unitId"] intValue];
            //int currentPage  = [[_unitDict valueForKey:@"currentPage"] intValue];
            
            if ([currentModuleId isEqualToString:moduleId] &&
                currentGradeId == gradeId &&
                currentClassId == classId) {
                for (int i = 0; i<[_unitArray count]; i++) {

                }
            }
        }
    }
}

#pragma mark unitExplainNotification methods
-(void)unitExplain:(NSNotification *)notification{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSString* screenControl = [userDict valueForKey:@"screenControl"];
    int currentGradeId = [[userDict valueForKey:@"currentGradeId"] intValue];
    int currentClassId = [[userDict valueForKey:@"currentClassId"] intValue];
    NSString* currentModuleId = [userDict valueForKey:@"currentModuleId"];
    NSString* role = [userDict valueForKey:@"role"];
    if([@"03" isEqualToString:role] || [@"04" isEqualToString:role]){
        if ([@"00" isEqualToString:screenControl]) {
            NSDictionary* _unitDict = [notification userInfo];
            
            int gradeId  = [[_unitDict valueForKey:@"gradeId"] intValue];
            int classId  = [[_unitDict valueForKey:@"classId"] intValue];
            NSString* moduleId  = [_unitDict valueForKey:@"moduleId"];
            int unitId = [[_unitDict valueForKey:@"unitId"] intValue];
            NSString* control  = [_unitDict valueForKey:@"control"];
            
            if ([currentModuleId isEqualToString:moduleId] &&
                currentGradeId == gradeId &&
                currentClassId == classId) {
                for (int i = 0; i<[_unitArray count]; i++) {
                    NSDictionary* tempUnitDict = [_unitArray objectAtIndex:i];
                    int _unitId = [[tempUnitDict valueForKey:@"unitId"] intValue];
                    if (_unitId == unitId) {
                        if ([@"03" isEqualToString:control]) {
                            [_swipeView scrollToItemAtIndex:i duration:1.5f];
                        }else if ([@"01" isEqualToString:control]){
                            NSString* unitType = [tempUnitDict valueForKey:@"unitType"];
                            if ([@"00" isEqualToString:unitType]) {
                                /*NSString *urlStr = [NSString stringWithFormat:@"%@%@",kHttpRequestURL,[tempUnitDict valueForKey:@"unitURL"]];
                                
                                NSURL *documentURL = [NSURL URLWithString:urlStr];
                                PSPDFDocument *document = [PSPDFDocument documentWithURL:documentURL];
                                //[[PSPDFCache sharedCache] clearCache];
                                PSPDFViewController* pdfController = [[PSPDFViewController alloc] initWithDocument:document];
                                [pdfController setDelegate:self];
                                [pdfController setPageMode:PSPDFPageModeSingle];
                                //[pdfController setScrollingEnabled:NO];
                                [pdfController setRightBarButtonItems:nil];
                                [pdfController setLeftBarButtonItems:nil];
                                pdfNavigationController = [[UINavigationController alloc] initWithRootViewController:pdfController];
                                [self presentViewController:pdfNavigationController animated:YES completion:NULL];
                                [pdfController release];
                                 */
                                
                                NSFileManager* fileManager =[NSFileManager defaultManager];
                                NSString* userDocPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)
                                                       objectAtIndex:0];
                                
                                NSString* unitURL = [[[tempUnitDict valueForKey:@"unitURL"] componentsSeparatedByString:@"/"] lastObject];
                                
                                NSString *filePath = [userDocPath stringByAppendingPathComponent:unitURL];
                                NSLog(@"path:%@",filePath);
                                
                                if([fileManager fileExistsAtPath:filePath] ){
                                    [fileManager removeItemAtPath:filePath error:nil];
                                }
                                
                                BOOL createFileSuccess = [fileManager createFileAtPath:filePath
                                                                              contents:nil
                                                                            attributes:nil];
                                if (createFileSuccess){
                                    NSFileHandle* filehandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
                                    
                                    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kHttpRequestURL,[tempUnitDict valueForKey:@"unitURL"]]];
                                    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
                                    
                                    [self showIndicator];
                                    [request setUserInfo:[NSDictionary dictionaryWithObject:unitURL forKey:@"TargetPath"]];
                                    [request setCompletionBlock :^( void ){
                                        NSLog ( @"%@ complete !" ,unitURL);
                                        assert (filehandle);
                                        [self hideIndicator];
                                        [filehandle closeFile ];
                                        
                                        ReaderDocument *document = [ReaderDocument withDocumentFilePath:filePath password:nil];
                                        ReaderViewController* pdfController = [[ReaderViewController alloc] initWithReaderDocument:document];
                                        
                                        [pdfController setDelegate:self];
                                        pdfNavigationController = [[UINavigationController alloc] initWithRootViewController:pdfController];
                                        [pdfNavigationController setNavigationBarHidden:YES animated:YES];
                                        [self presentViewController:pdfNavigationController animated:YES completion:NULL];
                                        [pdfController release];
                                    }];
                                    
                                    [request setFailedBlock :^( void ){
                                        NSLog ( @"%@ download failed !" ,unitURL);
                                        [self hideIndicator];
                                    }];
                                    
                                    [request setDataReceivedBlock :^( NSData * data){
                                        if (filehandle != nil ) {
                                            [filehandle seekToEndOfFile ];
                                            [filehandle writeData :data];
                                        }
                                    }];
                                    
                                    [request startAsynchronous];
                                }
                            }else if ([@"01" isEqualToString:unitType]) {
                                
                            }else if ([@"02" isEqualToString:unitType]) {
                                
                            }else if ([@"03" isEqualToString:unitType]) {
                                
                            }else if ([@"04" isEqualToString:unitType]) {
                                NSMutableDictionary* articleUnitDict = [[NSMutableDictionary alloc] initWithCapacity:10];
                                [articleUnitDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
                                [articleUnitDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
                                [articleUnitDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
                                [articleUnitDict setValue:[userDict valueForKey:@"currentModuleId"] forKey:@"moduleId"];
                                [articleUnitDict setValue:[userDict valueForKey:@"userId"] forKey:@"authorId"];
                                [articleUnitDict setValue:[NSNumber numberWithInt:unitId] forKey:@"unitId"];
                                
                                NSString* articleType = [tempUnitDict valueForKey:@"articleType"];
                                if ([@"01" isEqualToString:articleType]) {
                                    ZMArticleViewController* viewController = [[ZMArticleViewController alloc] init];
                                    [viewController setType:1];
                                    [viewController setUnitDict:articleUnitDict];
                                    [self.navigationController pushViewController:viewController animated:YES];
                                    [viewController release];
                                }else if([@"02" isEqualToString:articleType]){
                                    ZMArticleView01Controller* viewController = [[ZMArticleView01Controller alloc] init];
                                    [viewController setType:1];
                                    [viewController setUnitDict:articleUnitDict];
                                    [self.navigationController pushViewController:viewController animated:YES];
                                    [viewController release];
                                }else if([@"03" isEqualToString:articleType]){
                                    ZMArticleView02Controller* viewController = [[ZMArticleView02Controller alloc] init];
                                    [viewController setType:1];
                                    [viewController setUnitDict:articleUnitDict];
                                    [self.navigationController pushViewController:viewController animated:YES];
                                    [viewController release];
                                }else if([@"04" isEqualToString:articleType]){
                                    ZMArticleView03Controller* viewController = [[ZMArticleView03Controller alloc] init];
                                    [viewController setType:1];
                                    [viewController setUnitDict:articleUnitDict];
                                    [self.navigationController pushViewController:viewController animated:YES];
                                    [viewController release];
                                }else if([@"05" isEqualToString:articleType]){
                                    ZMArticleView04Controller* viewController = [[ZMArticleView04Controller alloc] init];
                                    [viewController setType:1];
                                    [viewController setUnitDict:articleUnitDict];
                                    [self.navigationController pushViewController:viewController animated:YES];
                                    [viewController release];
                                }else if([@"06" isEqualToString:articleType]){
                                    ZMArticleView05Controller* viewController = [[ZMArticleView05Controller alloc] init];
                                    [viewController setType:1];
                                    [viewController setUnitDict:articleUnitDict];
                                    [self.navigationController pushViewController:viewController animated:YES];
                                    [viewController release];
                                }else if([@"07" isEqualToString:articleType]){
                                    ZMArticleView06Controller* viewController = [[ZMArticleView06Controller alloc] init];
                                    [viewController setType:1];
                                    [viewController setUnitDict:articleUnitDict];
                                    [self.navigationController pushViewController:viewController animated:YES];
                                    [viewController release];
                                }else if([@"08" isEqualToString:articleType]){
                                    ZMArticleView07Controller* viewController = [[ZMArticleView07Controller alloc] init];
                                    [viewController setType:1];
                                    [viewController setUnitDict:articleUnitDict];
                                    [self.navigationController pushViewController:viewController animated:YES];
                                    [viewController release];
                                }else if([@"09" isEqualToString:articleType]){
                                    ZMWriteGuideViewController* viewController = [[ZMWriteGuideViewController alloc] init];
                                    [viewController setType:1];
                                    [viewController setUnitDict:articleUnitDict];
                                    [self.navigationController pushViewController:viewController animated:YES];
                                    [viewController release];
                                }else if([@"00" isEqualToString:articleType]){
                                    ZMCheckItemViewController* viewController = [[ZMCheckItemViewController alloc] init];
                                    [viewController setType:1];
                                    [viewController setUnitDict:articleUnitDict];
                                    [self.navigationController pushViewController:viewController animated:YES];
                                    [viewController release];
                                }
                                
                                [articleUnitDict release];
                            }
                        }else if([@"02" isEqualToString:control]){
                            NSString* unitType = [tempUnitDict valueForKey:@"unitType"];
                            if ([@"00" isEqualToString:unitType]) {
                                [pdfNavigationController dismissViewControllerAnimated:YES completion:NULL];
                            }else if ([@"01" isEqualToString:unitType]) {
                                
                            }else if ([@"02" isEqualToString:unitType]) {
                                
                            }else if ([@"03" isEqualToString:unitType]) {
                                
                            }else if ([@"04" isEqualToString:unitType]) {
                                [self.navigationController popToViewController:self animated:YES];
                            }
                        }
                        
                        break;
                    }
                }
            }
            
            /*
            if (currentGradeId != gradeId || currentClassId != classId) {
                [self showTip:@"不在该班内"];
                return;
            }
            if ([currentModuleId isEqualToString:moduleId]) {
                for (int i = 0; i<[_unitArray count]; i++) {
                    NSDictionary* tempUnitDict = [_unitArray objectAtIndex:i];
                    int _unitId = [[tempUnitDict valueForKey:@"unitId"] intValue];
                    if (_unitId == unitId) {
                        [_swipeView scrollToItemAtIndex:i duration:1.5f];
                        break;
                    }
                }
            }else{
                selectUnitId = unitId;
                
                NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
                NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
                [requestDict setValue:@"M006" forKey:@"method"];
                [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
                [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
                [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
                [requestDict setValue:moduleId forKey:@"moduleId"];
                
                ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
                [httpEngine setDelegate:self];
                [httpEngine requestWithDict:requestDict];
                [httpEngine release];
                [requestDict release];
            }*/
        }
    }
}

#pragma mark SwipeViewDelegate methods
- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView{
    if (_audioPlayer) {
        [_audioPlayer stop];
    }
    _pageControl.currentPage = swipeView.currentPage;

    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSString* screenControl = [userDict valueForKey:@"screenControl"];
    NSString* role = [userDict valueForKey:@"role"];
    if ([@"02" isEqualToString:role]) {
        if ([@"00" isEqualToString:screenControl]) {
            NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
            [requestDict setValue:@"M013" forKey:@"method"];
            [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
            [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
            [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
            [requestDict setValue:[userDict valueForKey:@"currentModuleId"] forKey:@"moduleId"];
            
            NSDictionary* unitDict = [_unitArray objectAtIndex:_swipeView.currentItemIndex];
            [requestDict setValue:[unitDict valueForKey:@"unitId"] forKey:@"unitId"];

            [requestDict setValue:@"03" forKey:@"control"];
            
            ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
            [httpEngine setDelegate:self];
            [httpEngine requestWithDict:requestDict];
            [httpEngine release];
            [requestDict release];
        }
    }
}

#pragma mark ReaderViewControllerDelegate
-(void)didEndReaderViewController:(ReaderViewController*)viewController{

}

-(void)dismissReaderViewController:(ReaderViewController *)viewController{
    NSMutableDictionary* userDict = [(ZMAppDelegate*)[UIApplication sharedApplication].delegate userDict];
    NSString* screenControl = [userDict valueForKey:@"screenControl"];
    NSString* role = [userDict valueForKey:@"role"];
    if ([@"02" isEqualToString:role]) {
        if ([@"00" isEqualToString:screenControl]) {
            for (int i = 0; i<[_unitArray count]; i++) {
                NSDictionary* tempUnitDict = [_unitArray objectAtIndex:i];
                int _unitId = [[tempUnitDict valueForKey:@"unitId"] intValue];
                if (_unitId == selectUnitId) {
                    NSMutableDictionary* requestDict = [[NSMutableDictionary alloc] initWithCapacity:10];
                    [requestDict setValue:@"M013" forKey:@"method"];
                    [requestDict setValue:[userDict valueForKey:@"currentCourseId"] forKey:@"courseId"];
                    [requestDict setValue:[userDict valueForKey:@"currentClassId"] forKey:@"classId"];
                    [requestDict setValue:[userDict valueForKey:@"currentGradeId"] forKey:@"gradeId"];
                    [requestDict setValue:[userDict valueForKey:@"currentModuleId"] forKey:@"moduleId"];
                    [requestDict setValue:[tempUnitDict valueForKey:@"unitId"] forKey:@"unitId"];
                    [requestDict setValue:@"02" forKey:@"control"];
                    
                    ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
                    [httpEngine setDelegate:self];
                    [httpEngine requestWithDict:requestDict];
                    [httpEngine release];
                    [requestDict release];
                    
                    break;
                }
            }
        }
    }
    
    [viewController dismissViewControllerAnimated:YES completion:NULL];
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
            
            NSDictionary* unitDict = [_unitArray objectAtIndex:_swipeView.currentItemIndex];
            NSString* unitId = [unitDict valueForKey:@"unitId"];

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
            
            NSData* jpegImageData = UIImagePNGRepresentation(fixOrientation);
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

#pragma mark FGalleryViewControllerDelegate
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
        NSDictionary* _unitDict = [_unitArray objectAtIndex:_swipeView.currentPage];
        [requestDict setValue:[_unitDict valueForKey:@"unitId"] forKey:@"unitId"];
        [requestDict setValue:[userDict valueForKey:@"userId"] forKey:@"userId"];
        
        ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
        [httpEngine setDelegate:self];
        [httpEngine requestWithDict:requestDict];
        [httpEngine release];
        [requestDict release];
    }
}

-(void)collectButtonDidClick:(FGalleryViewController *)gallery{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定加入错题集吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alert setTag:kTagCollectAddButton];
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
        NSDictionary* _unitDict = [_unitArray objectAtIndex:_swipeView.currentPage];
        [requestDict setValue:[_unitDict valueForKey:@"unitId"] forKey:@"unitId"];
        
        ZMHttpEngine* httpEngine = [[ZMHttpEngine alloc] init];
        [httpEngine setDelegate:self];
        [httpEngine requestWithDict:requestDict];
        [httpEngine release];
        [requestDict release];
    }
}

-(void)shareButtonDidClick:(FGalleryViewController *)gallery{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定分享吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alert setTag:kTagShareToOtherButton];
    [alert show];
    [alert release];
}


#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        
    }else if(buttonIndex == 1){
        int tag = alertView.tag;
        if(tag == kTagCollectAddButton){
            [self addToCollect];
        }else if(tag == kTagShareToOtherButton){
            [self shareToOther];
        }
    }
}


#pragma mark ZMHttpEngineDelegate
-(void)httpEngine:(ZMHttpEngine *)httpEngine didSuccess:(NSDictionary *)responseDict{
    [super httpEngine:httpEngine didSuccess:responseDict];
    
    NSString* method = [responseDict valueForKey:@"method"];
    NSString* responseCode = [responseDict valueForKey:@"responseCode"];
    if ([@"M012" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if ([@"M006" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        [_unitArray removeAllObjects];
        
        NSArray* _unitsArray = [responseDict valueForKey:@"units"];
        for (int i=0; i<[_unitsArray count]; i++) {
            NSLog(@"unit:%@",[_unitsArray objectAtIndex:i]);
            [_unitArray addObject:[_unitsArray objectAtIndex:i]];
        }
        
        [_swipeView reloadData];
        
        for (int i = 0; i<[_unitArray count]; i++) {
            NSDictionary* tempUnitDict = [_unitArray objectAtIndex:i];
            int _unitId = [[tempUnitDict valueForKey:@"unitId"] intValue];
            if (_unitId == selectUnitId) {
                [_swipeView scrollToItemAtIndex:i duration:1.5f];
                break;
            }
        }
    }else if([@"M030" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        NSMutableDictionary * articleDict = [[NSMutableDictionary alloc] initWithCapacity:0];
        
        [articleDict setValue:[responseDict valueForKey:@"articleCellNumber"] forKey:@"articleCellNumber"];
        [articleDict setValue:[responseDict valueForKey:@"articleType"] forKey:@"articleType"];
        [articleDict setValue:[responseDict valueForKey:@"title"] forKey:@"title"];
        [articleDict setValue:[responseDict valueForKey:@"articleDraft"] forKey:@"articleDraft"];
        [articleDict setValue:[responseDict valueForKey:@"articleContents"] forKey:@"articleContents"];
        [articleDict setValue:[responseDict valueForKey:@"articleComment"] forKey:@"articleComment"];
        
//        [self addLabel:[responseDict valueForKey:@"unitTitle"]
//                 frame:CGRectMake(291, 22, 421, 30)
//                  size:18
//              intoView:articleView];
//        
//        [self addDraftView];
//        [self addContentView];
//        [self addCommentView];
    }else if ([@"M013" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        
    }else if ([@"M014" isEqualToString:method] && [@"00" isEqualToString:responseCode]) {
        
    }else if([@"M008" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        
    }else if([@"M025" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        
    }else if([@"M026" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        
    }else if([@"M031" isEqualToString:method] && [@"00" isEqualToString:responseCode]){

    }else if([@"M032" isEqualToString:method] && [@"00" isEqualToString:responseCode]){
        
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
    }else if(![@"00" isEqualToString:responseCode]){
        [self showTip:@"服务器异常"];
    }
}

@end
