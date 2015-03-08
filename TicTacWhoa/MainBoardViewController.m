//
//  MainBoardViewController.m
//  TicTacWhoa
//
//  Created by Vinit Nayak on 2/28/15.
//  Copyright (c) 2015 Vinit Nayak. All rights reserved.
//

#import "MainBoardViewController.h"

@interface MainBoardViewController ()

@end

@implementation MainBoardViewController
@synthesize m1x1pickerView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UITapGestureRecognizer* gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerTapped:)];
    [m1x1pickerView addGestureRecognizer:gestureRecognizer];
    gestureRecognizer.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
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
    
        UITapGestureRecognizer* gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
        [imageView addGestureRecognizer:gestureRecognizer];
        gestureRecognizer.delegate = self;
    return imageView;
}

-(void)pickerTapped:(UIGestureRecognizer *)recognizer {
    NSLog(@"FUCK");
    UIPickerView *pV = (UIPickerView*)[recognizer view];
    NSUInteger selectedRow = [pV selectedRowInComponent:0];
    NSMutableString * text = [NSMutableString string];
    [text appendFormat:@"Selected row %d in component for picker %@\n", selectedRow, [pV debugDescription]];
    
    UIView *imgView = [pV viewForRow:selectedRow forComponent:0];
    UIView *overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, imgView.frame.size.width, imgView.frame.size.height / 2)];
    [overlay setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
    overlay.contentMode = UIViewContentModeScaleAspectFit;
    [imgView addSubview:overlay];
    NSLog(@"%@", text);
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return true;
}

-(void)imageTapped:(UIGestureRecognizer *)recognizer {
         NSLog(@"FUCK22");
}
@end
