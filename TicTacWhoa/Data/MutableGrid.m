//
//  MutableGrid.m
//  TicTacWhoa
//
//  Created by Vinit Nayak on 3/8/15.
//  Copyright (c) 2015 Vinit Nayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MutableGrid.h"
#import "Selection.h"

@implementation MutableGrid {
    NSArray *pickerList;
    NSMutableArray *selectionList;
    int attempts;
    NSMapTable *selectedViewsTable;
}

- (id)initWithPickers:(NSArray *)pickers {
    self = [super init];
    if (self) {
        self->pickerList = pickers;
        selectionList = [[NSMutableArray alloc] init];
        selectedViewsTable = [[NSMapTable alloc] init];
    }
    NSInteger n = 9;
    NSNumber *nsn = [NSNumber numberWithInteger:9];
    NSMutableSet *nms = [[NSMutableSet alloc] init];
    [nms addObject:nsn];
    if ([nms containsObject:[NSNumber numberWithInteger:n]]) {
        NSLog(@"SHIITE");
    }
    return self;
}

-(void)resetDataState {
    for (UIPickerView *picker in pickerList) {
        [picker reloadAllComponents];
    }
    [selectionList removeAllObjects];
}

-(BOOL)saveGrid {
    // Store the data
    if ([selectionList count] == 0) {
        return NO;
    }
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:selectionList forKey:@"foo"];
    [defaults synchronize];
    return YES;
}

-(BOOL)validate {
    attempts++;
    return NO;
}

-(NSInteger)getAttempts {
    return attempts;
}

- (BOOL)isSelectedForPicker:(UIPickerView *)picker forRow:(NSInteger)row {
    NSMapTable *selectedMap = [selectedViewsTable objectForKey:picker];
    if (selectedMap == nil) {
        return NO;
    }
    
    return [selectedMap objectForKey:[NSNumber numberWithInteger:row]] != nil;
}

-(void)updateSelectionForPicker:(UIPickerView *)picker forRow:(NSInteger)row {
    NSMapTable *pickerSelectionMap = [selectedViewsTable objectForKey:picker];
    if (pickerSelectionMap == nil
        || ![pickerSelectionMap objectForKey:[NSNumber numberWithInteger:row]]) {
        
        // add selection
        Selection *s = [[Selection alloc] initWithPicker:picker forRow:row];
        [selectionList addObject:s];
        
        if (pickerSelectionMap == nil) {
            pickerSelectionMap = [[NSMapTable alloc] init];
            [selectedViewsTable setObject:pickerSelectionMap forKey:picker];
        }
        
        [pickerSelectionMap setObject:s forKey:[NSNumber numberWithInteger:row]];
    } else {
        
        // remove selection
        NSMutableArray *discardedItems = [NSMutableArray array];
        for (Selection *s in selectionList) {
            if (s.picker == picker && s.rowInPicker == row) {
                [discardedItems addObject:s];
                
                [pickerSelectionMap removeObjectForKey:[NSNumber numberWithInteger:row]];
                if ([pickerSelectionMap count] == 0) {
                    [selectedViewsTable removeObjectForKey:picker];
                }
            }
        }
        
        [selectionList removeObjectsInArray:discardedItems];
    }
}
@end
