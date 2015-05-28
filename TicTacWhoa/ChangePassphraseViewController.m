//
//  ChangePassphraseViewController.m
//  TicTacWhoa
//
//  Created by Vinit Nayak on 4/28/15.
//  Copyright (c) 2015 Vinit Nayak. All rights reserved.
//

#import "ChangePassphraseViewController.h"
#import "MutableGrid.h"
#import "AccessibilityUtils.h"
#import "NewUserViewController.h"
#import "AppDelegate.h"

@interface ChangePassphraseViewController ()

@end

@implementation ChangePassphraseViewController {
    MutableGrid *grid;
    NSMutableArray *pickerList;
    NSMutableArray *pickerImageList;
    NSMapTable *pickerStartingImageList;
    NSMapTable *pickerToString;
    BOOL multiSelectDisabled;
}
@synthesize m1x1pickerView;
@synthesize m1x2pickerView;
@synthesize m1x3pickerView;
@synthesize m2x1pickerView;
@synthesize m2x2pickerView;
@synthesize m2x3pickerView;
@synthesize m3x1pickerView;
@synthesize m3x2pickerView;
@synthesize m3x3pickerView;
@synthesize m4x1pickerView;
@synthesize optionsView;
@synthesize changePassphraseSwitch;
@synthesize inputOrderSwitch;
@synthesize multipleSelectionSwitch;
@synthesize toggleHintLabel;
@synthesize submitButton;
@synthesize inputOrderInDigitSwitch;
@synthesize headerLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    pickerList = [[NSMutableArray alloc] initWithCapacity:9];
    pickerToString = [[NSMapTable alloc] init];
    
    pickerImageList = [[NSMutableArray alloc] init];
    pickerStartingImageList = [[NSMapTable alloc] init];
    
    // NB: Do not change, this MUST be in the correct order
    [pickerList addObject:m1x1pickerView];
    [pickerList addObject:m1x2pickerView];
    [pickerList addObject:m1x3pickerView];
    [pickerList addObject:m2x1pickerView];
    [pickerList addObject:m2x2pickerView];
    [pickerList addObject:m2x3pickerView];
    [pickerList addObject:m3x1pickerView];
    [pickerList addObject:m3x2pickerView];
    [pickerList addObject:m3x3pickerView];
    [pickerList addObject:m4x1pickerView];
    
    [pickerToString setObject:@"m1x1pickerView" forKey:m1x1pickerView];
    [pickerToString setObject:@"m1x2pickerView" forKey:m1x2pickerView];
    [pickerToString setObject:@"m1x3pickerView" forKey:m1x3pickerView];
    [pickerToString setObject:@"m2x1pickerView" forKey:m2x1pickerView];
    [pickerToString setObject:@"m2x2pickerView" forKey:m2x2pickerView];
    [pickerToString setObject:@"m2x3pickerView" forKey:m2x3pickerView];
    [pickerToString setObject:@"m3x1pickerView" forKey:m3x1pickerView];
    [pickerToString setObject:@"m3x2pickerView" forKey:m3x2pickerView];
    [pickerToString setObject:@"m3x3pickerView" forKey:m3x3pickerView];
    [pickerToString setObject:@"m4x1pickerView" forKey:m4x1pickerView];
    
    [pickerStartingImageList setObject:@"one.png" forKey:m1x1pickerView];
    [pickerStartingImageList setObject:@"two.png" forKey:m1x2pickerView];
    [pickerStartingImageList setObject:@"three.png" forKey:m1x3pickerView];
    [pickerStartingImageList setObject:@"four.png" forKey:m2x1pickerView];
    [pickerStartingImageList setObject:@"five.png" forKey:m2x2pickerView];
    [pickerStartingImageList setObject:@"six.png" forKey:m2x3pickerView];
    [pickerStartingImageList setObject:@"seven.png" forKey:m3x1pickerView];
    [pickerStartingImageList setObject:@"eight.png" forKey:m3x2pickerView];
    [pickerStartingImageList setObject:@"nine.png" forKey:m3x3pickerView];
    [pickerStartingImageList setObject:@"zero.png" forKey:m4x1pickerView];
    
    for (UIPickerView *picker in pickerStartingImageList.keyEnumerator) {
        [pickerImageList addObject:[pickerStartingImageList objectForKey:picker]];
        [pickerImageList addObject:@"tree.png"];
        [pickerImageList addObject:@"car.png"];
        [pickerImageList addObject:@"cat.png"];
        [pickerImageList addObject:@"dog.png"];
        [pickerImageList addObject:@"house.png"];
        
        //        [picker setImagesForRows:[NSArray arrayWithArray:pickerImageList]];
        [pickerImageList removeAllObjects];
    }
    
    [pickerImageList addObject:@"tree.png"];
    [pickerImageList addObject:@"car.png"];
    [pickerImageList addObject:@"cat.png"];
    [pickerImageList addObject:@"dog.png"];
    [pickerImageList addObject:@"house.png"];
    
    grid = [[MutableGrid alloc] initWithPickers:pickerList];
    
    for (UIPickerView *picker in pickerList) {
        UITapGestureRecognizer* gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerTapped:)];
        [picker addGestureRecognizer:gestureRecognizer];
        gestureRecognizer.delegate = self;
    }
    
    [optionsView setHidden:YES];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *pinOrderKey = [NSString stringWithFormat:@"%@_input_order", appDelegate.userName];
    NSString *multipleSelectionKey =
    [NSString stringWithFormat:@"%@_multi_select", appDelegate.userName];
    NSString *imageOrderKey = [NSString stringWithFormat:@"%@_image_input_order", appDelegate.userName];

    [multipleSelectionSwitch setOn:[defaults boolForKey:multipleSelectionKey]];
    [inputOrderSwitch setOn:[defaults boolForKey:pinOrderKey]];
    [inputOrderInDigitSwitch setOn:[defaults boolForKey:imageOrderKey]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Copied from MainBoardViewController
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 6;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 130;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowWidthForComponent:(NSInteger)component
{
    return 200;
}

// The data to return for the row and component (column) that's being passed in
- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view
{
    UIImageView *imageView;
    if (view == nil) {
        imageView = [[UIImageView alloc] init];
    } else {
        imageView = (UIImageView *)view;
    }
    
    UIImage *image;
    NSString *accessibilityLabel;
    // We want the first image to be distinct and have the number displayed, the rest
    // are the same.
    if (row == 0) {
        image = [UIImage imageNamed:[pickerStartingImageList objectForKey:pickerView]];
        accessibilityLabel = [pickerStartingImageList objectForKey:pickerView];
    } else {
        image = [UIImage imageNamed:[pickerImageList objectAtIndex:row-1]];
        accessibilityLabel = [pickerImageList objectAtIndex:row-1];
    }
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView setImage:image];
    [[pickerView.subviews objectAtIndex:1] setHidden:TRUE];
    [[pickerView.subviews objectAtIndex:2] setHidden:TRUE];
    
    
    if ([grid isSelectedForPicker:[pickerToString objectForKey:pickerView] forRow:row]) {
        CGFloat borderWidth = 6.0f;
        imageView.frame = CGRectInset(imageView.frame, borderWidth, borderWidth);
        imageView.layer.borderColor = [UIColor redColor].CGColor;
        imageView.layer.borderWidth = borderWidth;
        accessibilityLabel = [NSString stringWithFormat:@"%@ %@", @"selected", [AccessibilityUtils removeFileSuffix:accessibilityLabel]];
    } else {
        accessibilityLabel = [NSString stringWithFormat:@"%@", [AccessibilityUtils removeFileSuffix:accessibilityLabel]];
    }
    [imageView setAccessibilityLabel:accessibilityLabel];
    return imageView;
}

-(void)pickerTapped:(UIGestureRecognizer *)recognizer {
    NSLog(@"FUCK");
    UIPickerView *pV = (UIPickerView*)[recognizer view];
    
    // TODO, put all images in one array for each UIPickerView so we don't have to worry about offests
    NSUInteger selectedRow = [pV selectedRowInComponent:0];
    
    UIView *imageView = [pV viewForRow:selectedRow forComponent:0];
    struct CGColor *selectionColor;
    CGFloat borderWidth = 6.0f;
    
    NSString *utterance;
    NSString *imageTitle;
    
    if (selectedRow == 0) {
        imageTitle = [pickerStartingImageList objectForKey:pV];
    } else {
        imageTitle = [pickerImageList objectAtIndex:selectedRow - 1];
    }
    
    if (![grid isSelectedForPicker:[pickerToString objectForKey:pV] forRow:selectedRow]) {
        imageView.frame = CGRectInset(imageView.frame, borderWidth, borderWidth);
        selectionColor = [UIColor redColor].CGColor;
        utterance = [NSString stringWithFormat:@"%@ selected", [AccessibilityUtils removeFileSuffix:imageTitle]];
    } else {
        imageView.frame = CGRectInset(imageView.frame, -borderWidth, -borderWidth);
        selectionColor = [UIColor clearColor].CGColor;
        utterance = [NSString stringWithFormat:@"%@ un selected", [AccessibilityUtils removeFileSuffix:imageTitle]];
    }
    imageView.layer.borderColor = selectionColor;
    imageView.layer.borderWidth = borderWidth;
    [imageView setAccessibilityLabel:utterance];
    
    for (UIPickerView *picker in pickerList) {
        if (picker == pV) {
            [grid updateSelectionForPicker:[pickerToString objectForKey:picker] forRow:selectedRow];
        }
    }
}

-(void)updateAccessibilityImageTap {
    for (UIPickerView *picker in pickerList) {
        UITapGestureRecognizer* gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerTapped:)];
        [picker addGestureRecognizer:gestureRecognizer];
        gestureRecognizer.delegate = self;
    }
}

+(void)showAlert:(NSString *)message
    withDelegate:(id)delegate
       withTitle:(NSString *)title
withCancelButton:(NSString *)cancelButtonmessage
withOtherButtonTitle:(NSString*)otherButtonTitle {
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:title
                          message:message
                          delegate:delegate
                          cancelButtonTitle:cancelButtonmessage
                          otherButtonTitles:otherButtonTitle, nil];
    [alert show];
}

/**
 TODO: Figure out a better way to do this
 Currently pickerView isn't actually a UIPickerView, it's a UIAccessibilityPickerComponent,
 which we have no way to map from to our digit UIPickerViews, so we check their frame to see
 which one it comes close to.
 
 NB: This is heavily reliant on using ordered NSMutableArrays and inserting the pickers in the
 correct order into the array, 1-9, row by row (horizontal then vertical)
 */
- (NSString *)pickerView:(UIPickerView *)pickerView
accessibilityLabelForComponent:(NSInteger)component {
    CGRect accessibilityPckerFrame = [pickerView accessibilityFrame];
    
    // If one of them is disabled they all should be disabled
    if (m1x1pickerView.userInteractionEnabled == NO) {
        return @"Please select change passphrase above to make changes to set a new passphrase";
    }
    
    for (UIPickerView *pV in pickerList) {
        CGRect pickerFrame = [pV accessibilityFrame];
        if (pickerFrame.origin.x == accessibilityPckerFrame.origin.x) {
            if (pickerFrame.origin.y > accessibilityPckerFrame.origin.y) {
                return [pV accessibilityLabel];
            }
        }
    }
    return NULL;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return true;
}

-(NSString*)removeFileSuffix:(NSString*)fileSpeech {
    NSString* noFileExtension = [fileSpeech substringToIndex:[fileSpeech length]-4];
    return [NSString stringWithFormat:@"%@ image", noFileExtension];
}



- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)submitAction:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    BOOL success = NO;
    NSString *failureMessage = nil;
    NSString *successMessage = nil;
    if ([optionsView isHidden]) {
        success = [grid validate:appDelegate.userName];
        if (success) {
            [self initializeChangeView];
            return;
        } else {
            [NewUserViewController showAlert:@"Incorrect passphrase, please try again!" withDelegate:nil
                                   withTitle:@"Sorry" withOtherButtonTitle:nil];
            [self resetGrid];
        }
    } else if ([changePassphraseSwitch isOn]) {
        // We know user has verified correctly
        success = [grid saveGrid:appDelegate.userName withMultiSelect:[multipleSelectionSwitch isOn]];
        if (!success) {
//            [NewUserViewController showAlert:@"Incorrect passphrase, please try again!" withDelegate:nil
//                                   withTitle:@"Sorry" withOtherButtonTitle:nil];
            failureMessage = @"Incorrect passphrase, please try again! Your changes are not saved.";
            [self resetGrid];
        } else {
//            [NewUserViewController showAlert:@"Your passphrase was saved!" withDelegate:self
//                                   withTitle:@"Saved" withOtherButtonTitle:nil];
            successMessage = @"Your passphrase was saved!";
            [changePassphraseSwitch setOn:NO];
            [self changePassphraseAction:nil];
        }

    }
    
    if ([optionsView isHidden]) {
        return;
    }
    // We know user has verified correctly and they don't want to change passphrase
    // Just save the two other switches into NSUserDefaults
    
    // if User disabled multi-select their previous password could have had multiple
    // selected image from the same digit, which means now they'll never be able to log in
    // Force them to make a new passphrase
    if (multiSelectDisabled && ![changePassphraseSwitch isOn] && !success) {
        if (failureMessage == nil) {
            failureMessage = @"If you disabled selecting multiple images within the same digit, you must make a new password for security reasons! Your changes are not saved.";
        }
        [NewUserViewController showAlert:failureMessage withDelegate:nil
                               withTitle:@"Sorry" withOtherButtonTitle:nil];
        return;
    } else if (failureMessage != nil) {
        [NewUserViewController showAlert:failureMessage withDelegate:nil
                               withTitle:@"Sorry" withOtherButtonTitle:nil];
        return;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *pinOrderKey = [NSString stringWithFormat:@"%@_input_order", appDelegate.userName];
    NSString *imageOrderKey = [NSString stringWithFormat:@"%@_image_input_order", appDelegate.userName];
    NSString *multipleSelectionKey =
    [NSString stringWithFormat:@"%@_multi_select", appDelegate.userName];
    
    [defaults setBool:inputOrderSwitch.isOn forKey:pinOrderKey];
    [defaults setBool:multipleSelectionSwitch.isOn forKey:multipleSelectionKey];
    [defaults setBool:inputOrderInDigitSwitch.isOn forKey:imageOrderKey];
    [defaults synchronize];
    
    if (successMessage == nil) {
        successMessage = @"Your changes were saved!";
    }
    [NewUserViewController showAlert:successMessage withDelegate:self
                           withTitle:@"Saved" withOtherButtonTitle:nil];
    [self resetGrid];
    
}

-(void) initializeChangeView {
    [optionsView setHidden:NO];
    [submitButton setTitle:@"Save" forState:UIControlStateNormal];
    [headerLabel setText:@"Passphrase Settings"];
    [headerLabel setAccessibilityLabel:@"Change passphrase or passphrase options below"];
    // Reset Grid
    [self resetGrid];
    [self toggleInteractionState];
}

-(void) resetGrid {
    [grid resetDataState];
    for (UIPickerView *picker in pickerList) {
        [picker reloadAllComponents];
        [picker selectRow:0 inComponent:0 animated:YES];
    }
}

-(void) toggleInteractionState {
    for (UIPickerView *picker in pickerList) {
        picker.userInteractionEnabled = !picker.userInteractionEnabled;
    }
}
- (IBAction)changePassphraseAction:(id)sender {
    [toggleHintLabel setHidden:!toggleHintLabel.isHidden];
    [self toggleInteractionState];
    
}

- (IBAction)multiSelectSwitchAction:(id)sender {
    multiSelectDisabled = ![multipleSelectionSwitch isOn];
    if (![multipleSelectionSwitch isOn]) {
        [inputOrderInDigitSwitch setOn:NO];
        [inputOrderInDigitSwitch setUserInteractionEnabled:NO];
    } else {
        [inputOrderInDigitSwitch setUserInteractionEnabled:YES];
    }
}

@end
