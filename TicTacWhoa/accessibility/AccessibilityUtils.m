//
//  AccessibilityUtils.m
//  TicTacWhoa
//
//  Created by Vinit Nayak on 4/11/15.
//  Copyright (c) 2015 Vinit Nayak. All rights reserved.
//

#import "AccessibilityUtils.h"

static AVSpeechSynthesizer *speaker;
@implementation AccessibilityUtils

+(void)initialize {
    speaker = [[AVSpeechSynthesizer alloc] init];
}
-(instancetype)init {
    // Private constructor
    return nil;
}

+(void)speakIfInAccessibility:(NSString*) textToSpeak {
    if (!UIAccessibilityIsVoiceOverRunning()) {
        return;
    }

    [speaker stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];

    AVSpeechUtterance *utterance2 = [AVSpeechUtterance
                  speechUtteranceWithString:textToSpeak];
    [speaker speakUtterance:utterance2];
}

@end
