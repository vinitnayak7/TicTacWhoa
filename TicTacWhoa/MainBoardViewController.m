//
//  MainBoardViewController.m
//  TicTacWhoa
//
//  Created by Vinit Nayak on 2/28/15.
//  Copyright (c) 2015 Vinit Nayak. All rights reserved.
//

#import "MainBoardViewController.h"
#import "MutableGrid.h"
#import "Constants.h"

@interface MainBoardViewController ()

@end

@implementation MainBoardViewController {
    MutableGrid *grid;
    NSMutableArray *pickerList;
    BOOL newUser;
    NSString *userName;
    NSMapTable *pickerToString;
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
@synthesize trialsLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    pickerList = [[NSMutableArray alloc] initWithCapacity:9];
    pickerToString = [[NSMapTable alloc] init];

    [pickerList addObject:m1x1pickerView];
    [pickerList addObject:m1x2pickerView];
    [pickerList addObject:m1x3pickerView];
    [pickerList addObject:m2x1pickerView];
    [pickerList addObject:m2x2pickerView];
    [pickerList addObject:m2x3pickerView];
    [pickerList addObject:m3x1pickerView];
    [pickerList addObject:m3x2pickerView];
    [pickerList addObject:m3x3pickerView];
    
    [pickerToString setObject:@"m1x1pickerView" forKey:m1x1pickerView];
    [pickerToString setObject:@"m1x2pickerView" forKey:m1x1pickerView];
    [pickerToString setObject:@"m1x3pickerView" forKey:m1x1pickerView];
    [pickerToString setObject:@"m2x1pickerView" forKey:m1x1pickerView];
    [pickerToString setObject:@"m2x2pickerView" forKey:m1x1pickerView];
    [pickerToString setObject:@"m2x3pickerView" forKey:m1x1pickerView];
    [pickerToString setObject:@"m3x1pickerView" forKey:m1x1pickerView];
    [pickerToString setObject:@"m3x2pickerView" forKey:m1x1pickerView];
    [pickerToString setObject:@"m3x3pickerView" forKey:m1x1pickerView];
    
    
    grid = [[MutableGrid alloc] initWithPickers:pickerList];
    
    for (UIPickerView *picker in pickerList) {
        UITapGestureRecognizer* gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerTapped:)];
        [picker addGestureRecognizer:gestureRecognizer];
        gestureRecognizer.delegate = self;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

-(id)initWithUserName:(NSString *)usersName forNewUser:(BOOL)isNewUser {
    self = [super init];
    if (self) {
        newUser = isNewUser;
        userName = usersName;
    }
    return self;
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 4;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 150;
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
    UIImage *image = [UIImage imageNamed:@"pic1"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView setImage:image];
    [[pickerView.subviews objectAtIndex:1] setHidden:TRUE];
    [[pickerView.subviews objectAtIndex:2] setHidden:TRUE];

    if ([grid isSelectedForPicker:[pickerToString objectForKey:pickerView] forRow:row]) {
        CGFloat borderWidth = 6.0f;
        imageView.frame = CGRectInset(imageView.frame, borderWidth, borderWidth);
        imageView.layer.borderColor = [UIColor redColor].CGColor;
        imageView.layer.borderWidth = borderWidth;
    }
    return imageView;
}

-(void)pickerTapped:(UIGestureRecognizer *)recognizer {
    NSLog(@"FUCK");
    UIPickerView *pV = (UIPickerView*)[recognizer view];
    NSUInteger selectedRow = [pV selectedRowInComponent:0];

    UIView *imageView = [pV viewForRow:selectedRow forComponent:0];
    struct CGColor *selectionColor;
    CGFloat borderWidth = 6.0f;
    
    if (![grid isSelectedForPicker:[pickerToString objectForKey:pV] forRow:selectedRow]) {
        imageView.frame = CGRectInset(imageView.frame, borderWidth, borderWidth);
        selectionColor = [UIColor redColor].CGColor;
    } else {
        imageView.frame = CGRectInset(imageView.frame, -borderWidth, -borderWidth);
        selectionColor = [UIColor clearColor].CGColor;
    }
    imageView.layer.borderColor = selectionColor;
    imageView.layer.borderWidth = borderWidth;
    
    for (UIPickerView *picker in pickerList) {
        if (picker == pV) {
            [grid updateSelectionForPicker:[pickerToString objectForKey:picker] forRow:selectedRow];
        }
    }
}

- (IBAction)submitButtonAction:(id)sender {
    BOOL success;
    if (newUser) {
        success = [grid saveGrid:userName];
    } else {
        success = [grid validate:userName];
    }
    if (success) {
        [MainBoardViewController showAlert:@"YAYAYA"];
    } else {
        if ([grid getAttempts] > ATTEMPT_LIMIT) {
            [MainBoardViewController showAlert:@"ATTEMPTS!"];
        } else {
            [MainBoardViewController showAlert:@"NOT SUCCESSFUL"];
        }
    }
}

- (IBAction)cancelButtonAction:(id)sender {
}

+(void)showAlert:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Sorry"
                          message:message
                          delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return true;
}
@end
