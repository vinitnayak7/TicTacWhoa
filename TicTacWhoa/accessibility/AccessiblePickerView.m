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
    NSString *originalAccessiblityLabel;
}

-(void)accessibilityElementDidLoseFocus {
    [self setAccessibilityLabel:[self getFutureAccessibilityLabel]];
}

-(BOOL) isAccessibilityElement {
    return YES;
}

-(void) accessibilityIncrement {
    if (selectedRow == [self numberOfRowsInComponent:0] - 1) {
        return;
    }
    selectedRow++;
    
    [AccessibilityUtils speakIfInAccessibility:[self removeFileSuffix:[self->imageNameList objectAtIndex:selectedRow]]];
    [super selectRow:selectedRow inComponent:0 animated:YES];
    [self setAccessibilityLabel:[self getFutureAccessibilityLabel]];
}

-(void) accessibilityDecrement {
    if (selectedRow < 1 ) {
        return;
    }
    selectedRow--;
    
    [AccessibilityUtils speakIfInAccessibility:[self removeFileSuffix:[self->imageNameList objectAtIndex:selectedRow]]];
    [super selectRow:selectedRow inComponent:0 animated:YES];
    [self setAccessibilityLabel:[self getFutureAccessibilityLabel]];
}

-(UIAccessibilityTraits)accessibilityTraits {
    UIAccessibilityTraits t = [super accessibilityTraits];
    return t | UIAccessibilityTraitAdjustable | UIAccessibilityTraitAllowsDirectInteraction;
}

-(void) setImagesForRows:(NSArray *)imageList {
    self->imageNameList = imageList;
}

-(NSString*)removeFileSuffix:(NSString*)fileSpeech {
    NSString* noFileExtension = [fileSpeech substringToIndex:[fileSpeech length]-4];
    return [NSString stringWithFormat:@"%@ image", noFileExtension];
}

// Sets label for when we return to this picker view
-(NSString*)getFutureAccessibilityLabel {
    if (!originalAccessiblityLabel) {
        // Keep everything except for tapp 3 times instructions
        originalAccessiblityLabel = [self accessibilityLabel];
        originalAccessiblityLabel = [originalAccessiblityLabel substringToIndex:[originalAccessiblityLabel rangeOfString:@"tap"].location];
    }
    NSString *newLabel = [self removeFileSuffix:[self->imageNameList objectAtIndex:selectedRow]];
    return [NSString stringWithFormat:@"%@ %@", originalAccessiblityLabel, newLabel];
}

- (NSString *)pickerView:(UIPickerView *)pickerView
accessibilityLabelForComponent:(NSInteger)component {
    BOOL y = [pickerView isAccessibilityElement];
    return @"foo";
}
@end
