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
#import "Constants.h"
#import "AppDelegate.h"

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
    return self;
}

-(void)resetDataState {
    [selectionList removeAllObjects];
    [selectedViewsTable removeAllObjects];
}

-(BOOL)saveGrid:(NSString *)userName {
    // Store the data
    if ([selectionList count] != 4 || ![self checkMultiSelectConstraint]) {
        return NO;
    }
        
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *nonMutableArray = [NSArray arrayWithArray:selectionList];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:nonMutableArray];
    [defaults setObject:data forKey:userName];
    [defaults synchronize];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate setUserName:userName];
    return YES;
}

// Checks selections against constraints set by user
// i.e. multiple selection in a digit, order of inputs
-(BOOL) checkMultiSelectConstraint {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *pinOrderKey = [NSString stringWithFormat:@"%@_input_order", appDelegate.userName];
    NSString *multipleSelectionKey =
    [NSString stringWithFormat:@"%@_multi_select", appDelegate.userName];
    
    NSMutableSet *pickerSet = [[NSMutableSet alloc] init];
    if (![defaults boolForKey:multipleSelectionKey]) {
        for(Selection *s in selectionList) {
            if ([pickerSet containsObject:s.picker]) {
                return NO;
            }
            [pickerSet addObject:s.picker];
        }
    }
    return YES;
}

-(BOOL)validate:(NSString *)userName {
    if (attempts > ATTEMPT_LIMIT) {
        return NO;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:userName];
    NSArray *solution = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    if ([selectionList count] == 0
        || [selectionList count] != [solution count]) {
        attempts++;
        return NO;
    }
    
    NSString *pinOrderKey = [NSString stringWithFormat:@"%@_input_order", userName];
    
    if ([defaults boolForKey:pinOrderKey]) {
        for(Selection *s1 in selectionList) {
            BOOL found = NO;
            for(Selection *s2 in solution) {
                if ([s1.picker isEqualToString:s2.picker]
                    && s1.rowInPicker == s2.rowInPicker) {
                    found = YES;
                    break;
                }
            }
            if (!found) {
                return NO;
            }
        }
        return YES;
    } else {
        for (int i = 0; i < [solution count]; i++) {
            Selection *s1 = [solution objectAtIndex:i];
            Selection *s2 = [selectionList objectAtIndex:i];
            if (![s1.picker isEqualToString:s2.picker]
                || s1.rowInPicker != s2.rowInPicker) {
                attempts++;
                return NO;
            }
        }
        return YES;
    }
}

-(int)getAttempts {
    return attempts;
}

-(void)increaseAttempts {
    attempts++;
}

- (BOOL)isSelectedForPicker:(NSString *)picker forRow:(NSInteger)row {
    NSMapTable *selectedMap = [selectedViewsTable objectForKey:picker];
    if (selectedMap == nil) {
        return NO;
    }
    
    return [selectedMap objectForKey:[NSNumber numberWithInteger:row]] != nil;
}

-(void)updateSelectionForPicker:(NSString *)picker forRow:(NSInteger)row {
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
