//
//  LoginViewController.m
//  TicTacWhoa
//
//  Created by Vinit Nayak on 2/27/15.
//  Copyright (c) 2015 Vinit Nayak. All rights reserved.
//

#import "LoginViewController.h"
#import "NewUserViewController.h"
#import "Constants.h"
#import "AccessibilityUtils.h"
#import "MutableGrid.h"
#import "AppDelegate.h"

@interface LoginViewController ()

@end

@implementation LoginViewController {
    MutableGrid *grid;
    NSMutableArray *pickerList;
    NSMutableArray *pickerImageList;
    NSMutableArray *pickerSpeechList;
    NSMapTable *pickerStartingImageList;
    NSMapTable *pickerToString;
    NSString *userName;
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
@synthesize userNameTextField;
@synthesize createUserViewController;
@synthesize menuViewController;
@synthesize loginButton;
@synthesize clearButton;
@synthesize createUserButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // UNCOMMENT TO ERASE ALL NSUserDefaults
//    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    ////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////

    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    
    //UI changes
    loginButton.layer.cornerRadius = 10;
    loginButton.clipsToBounds = YES;
    loginButton.layer.borderWidth = 3.0;
    loginButton.layer.borderColor =[[UIColor colorWithRed:0.0f/255.0f green:204.0f/255.0f blue:0.0f/255.0f alpha:1.0f] CGColor];
    
    clearButton.layer.cornerRadius = 10;
    clearButton.clipsToBounds = YES;
    clearButton.layer.borderWidth = 3.0;
    clearButton.layer.borderColor =[[UIColor colorWithRed:255.0f/255.0f green:128.0f/255.0f blue:0.0f/255.0f alpha:1.0f] CGColor];
    
    createUserButton.layer.cornerRadius = 10;
    createUserButton.clipsToBounds = YES;
    createUserButton.layer.borderWidth = 3.0;
    createUserButton.layer.borderColor =[[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:0.0f/255.0f alpha:1.0f] CGColor];
    
    
    pickerList = [[NSMutableArray alloc] initWithCapacity:9];
    pickerToString = [[NSMapTable alloc] init];
    
    pickerImageList = [[NSMutableArray alloc] init];
    pickerSpeechList = [[NSMutableArray alloc] init];
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
    
    //////////// THIS DOES ABSOLUTELY NOTHING ///////////////////////////
    //////////// THIS DOES ABSOLUTELY NOTHING ///////////////////////////
    //////////// THIS DOES ABSOLUTELY NOTHING ///////////////////////////
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
    //////////// THIS DOES ABSOLUTELY NOTHING ///////////////////////////
    //////////// THIS DOES ABSOLUTELY NOTHING ///////////////////////////
    //////////// THIS DOES ABSOLUTELY NOTHING ///////////////////////////
    
//    [pickerImageList addObject:@"tree.png"];
//    [pickerImageList addObject:@"car.png"];
//    [pickerImageList addObject:@"cat.png"];
//    [pickerImageList addObject:@"dog.png"];
//    [pickerImageList addObject:@"house.png"];
    
    [pickerImageList addObject:@"HH Sheikh Rashid Bin Saeed Al-Maktoum.jpg"];
    [pickerSpeechList addObject:@"سمو الشيخ راشد بن سعيد آل مكتومْ"];
    
    [pickerImageList addObject:@"hh Sheikh Zayed Bin Sultan Al-Nahyan.png"];
    [pickerSpeechList addObject:@"سمو الشيخ زايد بن سلطان آل نهيان"];

    [pickerImageList addObject:@"HH Sheikh Mohamed Bin Rashid Al-Maktoum.jpg"];
    [pickerSpeechList addObject:@"سمو الشيخ مُِحمد بن راشد آل مكتومْ"];
    
    [pickerImageList addObject:@"HH Sheikh Khalifa Bin Zayed Al-Nahyan.jpg"];
    [pickerSpeechList addObject:@"سمو الشيخ خَليفَ بن زايد آل نهيان"];
    
    [pickerImageList addObject:@"HH Sheikh Mohamed bin Zayed Al-Nahyan.jpg"];
    [pickerSpeechList addObject:@"سمو الشيخ مُِحمد بن زايد آل نهيان"];
    
    [pickerImageList addObject:@"HH Shiekh Sultan bin Muhammad Al-Qasimi.jpg"];
    [pickerSpeechList addObject:@"سمو الشيخ سلطان بن مُِحمد آل قاسمي"];
    
    [pickerImageList addObject:@"HH sheikh Nahyan bin Mubarak Al-Nahyan.jpg"];
    [pickerSpeechList addObject:@"سمو الشيخ نهيان بن مبارك آل نهيان"];
    
    [pickerImageList addObject:@"HH sheikh Hamdan Bin mubarak Al-Nahyan.jpg"];
    [pickerSpeechList addObject:@"سمو الشيخ حمدان بن مبارك آل نهيان"];
    
    grid = [[MutableGrid alloc] initWithPickers:pickerList];
    
    [userNameTextField setText:self->userName];
    
    [self updateAccessibilityImageTap];
    ///////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id)initWithUsername:(NSString*)name {
    self = [super init];
    if (self) {
        self->userName = name;
    }
    return self;
}

- (IBAction)submitExistingUser:(id)sender {
    NSString *inputUserName = userNameTextField.text;
    if (inputUserName == nil || [inputUserName  isEqual: @""]) {
        [LoginViewController showAlert:@"Enter userName" withDelegate:self withTitle:@"Sorry" withCancelButton:@"OK" withOtherButtonTitle:nil];
        return;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(![defaults objectForKey:inputUserName]) {
        [LoginViewController showAlert:@"User does not exist" withDelegate:self withTitle:@"Sorry" withCancelButton:@"Retry with different username" withOtherButtonTitle:@"Create new user"];
        [self resetGridAction:nil];
        return;
    }
    
    BOOL success = [grid validate:userNameTextField.text];
    if (success) {
        menuViewController = [[MenuViewController alloc] initWithUserName:userNameTextField.text];
        [self.navigationController pushViewController:menuViewController animated:YES];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate setUserName:inputUserName];
        [userNameTextField setText:@""];
        [self resetGridAction:nil];
    } else {
        if ([grid getAttempts] > ATTEMPT_LIMIT) {
            [NewUserViewController showAlert:@"Sorry, you've reached the maximum number of attempts" withDelegate:nil withTitle:@"Sorry" withOtherButtonTitle:nil];
        } else {
            [NewUserViewController showAlert:@"Incorrect passphrase, please try again!" withDelegate:nil
                                   withTitle:@"Sorry" withOtherButtonTitle:nil];
            // TODO
            //            [attemptsLabel setText:[NSString stringWithFormat:@"Attempts: %d", [grid getAttempts]]];
        }
        [self resetGridAction:nil];
    }
}

- (IBAction)submitNewUser:(id)sender {
    createUserViewController = [[NewUserViewController alloc] initWithNibName:@"NewUserViewController" bundle:nil];
    [self.navigationController pushViewController:createUserViewController animated:YES];
    [userNameTextField setText:@""];
    [self resetGridAction:nil];
}

- (IBAction)resetGridAction:(id)sender {
    [grid resetDataState];
    for (UIPickerView *picker in pickerList) {
        [picker reloadAllComponents];
        [picker selectRow:0 inComponent:0 animated:YES];
    }
    // TODO
    //    [grid increaseAttempts];
    //    [attemptsLabel setText:[NSString stringWithFormat:@"Attempts: %d", [grid getAttempts]]];
}

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
    // Number of images + 1 for the digit image
    return [pickerImageList count] + 1;
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
        accessibilityLabel = [AccessibilityUtils removeFileSuffix:[pickerStartingImageList objectForKey:pickerView]];
    } else {
        image = [UIImage imageNamed:[pickerImageList objectAtIndex:row-1]];
        accessibilityLabel = [pickerSpeechList objectAtIndex:row-1];
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
        accessibilityLabel = [NSString stringWithFormat:@"%@ %@", accessibilityLabel, @"selected"];
    } else {
        // Don't need to change accessibility label for sheiks
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
        utterance = [AccessibilityUtils removeFileSuffix:[pickerStartingImageList objectForKey:pV]];
    } else {
        utterance = [pickerSpeechList objectAtIndex:selectedRow - 1];
    }
    
    if (![grid isSelectedForPicker:[pickerToString objectForKey:pV] forRow:selectedRow]) {
        imageView.frame = CGRectInset(imageView.frame, borderWidth, borderWidth);
        selectionColor = [UIColor redColor].CGColor;
//        utterance = [NSString stringWithFormat:@"%@ selected", [AccessibilityUtils removeFileSuffix:imageTitle]];
        utterance = [NSString stringWithFormat:@"%@ %@", utterance, @"selected"];
    } else {
        imageView.frame = CGRectInset(imageView.frame, -borderWidth, -borderWidth);
        selectionColor = [UIColor clearColor].CGColor;
//        utterance = [NSString stringWithFormat:@"%@ un selected", [AccessibilityUtils removeFileSuffix:imageTitle]];
        utterance = [NSString stringWithFormat:@"%@ %@", utterance, @"un selected"];
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
    if (buttonIndex == [alertView cancelButtonIndex]) {
        [userNameTextField becomeFirstResponder];
    } else {
        [self submitNewUser:nil];
    }
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return true;
}

-(NSString*)removeFileSuffix:(NSString*)fileSpeech {
    NSString* noFileExtension = [fileSpeech substringToIndex:[fileSpeech length]-4];
    return [NSString stringWithFormat:@"%@ image", noFileExtension];
}

@end
