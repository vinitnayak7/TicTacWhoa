//
//  AccessiblePickerView.m
//  TicTacWhoa
//
//  Created by Vinit Nayak on 4/11/15.
//  Copyright (c) 2015 Vinit Nayak. All rights reserved.
//

#import "AccessiblePickerView.h"
#import "AccessibilityUtils.h"

@implementation AccessiblePickerView {
    int selectedRow;
    NSArray *imageNameList;
}

//-(void) accessibilityElementDidBecomeFocused {
//        AVSpeechUtterance *utterance2;
//        utterance2 = [AVSpeechUtterance
//                      speechUtteranceWithString:@"Working all day"];
//        
//        AVSpeechSynthesizer *synth = [[AVSpeechSynthesizer alloc] init];
//            [synth speakUtterance:utterance2];
//}

-(BOOL) accessibilityScroll:(UIAccessibilityScrollDirection)direction {

    return YES;
}

-(BOOL) isAccessibilityElement {
    return YES;
}

-(void) accessibilityIncrement {
    if (selectedRow == [self numberOfRowsInComponent:0] - 1) {
        return;
    }
    selectedRow++;
    
    [AccessibilityUtils speakIfInAccessibility:[self->imageNameList objectAtIndex:selectedRow]];
    [super selectRow:selectedRow inComponent:0 animated:YES];
}

-(void) accessibilityDecrement {
    if (selectedRow < 1 ) {
        return;
    }
    selectedRow--;
    
    [AccessibilityUtils speakIfInAccessibility:[self->imageNameList objectAtIndex:selectedRow]];
    [super selectRow:selectedRow inComponent:0 animated:YES];
}

-(UIAccessibilityTraits)accessibilityTraits {
    UIAccessibilityTraits t = [super accessibilityTraits];
    return t | UIAccessibilityTraitAdjustable | UIAccessibilityTraitAllowsDirectInteraction;
}

-(void) setImagesForRows:(NSArray *)imageList {
    self->imageNameList = imageList;
}

@end
