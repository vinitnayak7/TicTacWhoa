//
//  AccessibilityUtils.m
//  TicTacWhoa
//
//  Created by Vinit Nayak on 4/11/15.
//  Copyright (c) 2015 Vinit Nayak. All rights reserved.
//

#import "AccessibilityUtils.h"
#import <AVFoundation/AVFoundation.h>

@implementation AccessibilityUtils

-(instancetype)init {
    // Private constructor
    return nil;
}

+(void)speakIfInAccessibility:(NSString*) textToSpeak {
    if (!UIAccessibilityIsVoiceOverRunning()) {
        return;
    }
    
    AVSpeechUtterance *utterance2 = [AVSpeechUtterance
                  speechUtteranceWithString:textToSpeak];
    AVSpeechSynthesizer *synth = [[AVSpeechSynthesizer alloc] init];
    [synth speakUtterance:utterance2];
}

@end
