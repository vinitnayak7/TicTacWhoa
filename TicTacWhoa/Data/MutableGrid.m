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
    NSMutableArray *pickerStringList;
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
        pickerStringList = [[NSMutableArray alloc] init];
        [pickerStringList addObject:@"m1x1pickerView"];
        [pickerStringList addObject:@"m1x2pickerView"];
        [pickerStringList addObject:@"m1x3pickerView"];
        [pickerStringList addObject:@"m2x1pickerView"];
        [pickerStringList addObject:@"m2x2pickerView"];
        [pickerStringList addObject:@"m2x3pickerView"];
        [pickerStringList addObject:@"m3x1pickerView"];
        [pickerStringList addObject:@"m3x2pickerView"];
        [pickerStringList addObject:@"m3x3pickerView"];
    }
    return self;
}

-(void)resetDataState {
    [selectionList removeAllObjects];
    [selectedViewsTable removeAllObjects];
}

-(BOOL)saveGrid:(NSString *)userName withMultiSelect:(BOOL)multiSelectEnabled {
    // Store the data
    if ([selectionList count] < 4) {
        return NO;
    }
    
    if (!multiSelectEnabled) {
        if (![self ensureNoMultiSelectedImages]) {
            return NO;
        }
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
-(BOOL) ensureNoMultiSelectedImages {
    
    NSMutableSet *pickerSet = [[NSMutableSet alloc] init];
    for(Selection *s in selectionList) {
        if ([pickerSet containsObject:s.picker]) {
            return NO;
        }
        [pickerSet addObject:s.picker];
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
    NSString *imageOrderKey = [NSString stringWithFormat:@"%@_image_input_order", userName];
    BOOL digitAnyOrder = [defaults boolForKey:pinOrderKey];
    BOOL imagesInAnyOrderEnabled = [defaults boolForKey:imageOrderKey];
    
    if (digitAnyOrder && imagesInAnyOrderEnabled) {
        return [self validateNoConstraintsWithSolution:solution];
    } else if (digitAnyOrder && !imagesInAnyOrderEnabled) {
        NSMutableArray *selectionPickers = [[NSMutableArray alloc] init];
        NSMutableArray *solutinPickers = [[NSMutableArray alloc] init];
        for (NSString *pVString in pickerStringList) {
            for (Selection *s1 in solution) {
                if ([s1.picker isEqualToString:pVString]) {
                    [solutinPickers addObject:s1];
                }
            }
            for (Selection *s1 in selectionList) {
                if ([s1.picker isEqualToString:pVString]) {
                    [selectionPickers addObject:s1];
                }
            }
            
            if (selectionPickers.count != solutinPickers.count) {
                return NO;
            } else {
                for (int i = 0; i < selectionPickers.count; i++) {
                    Selection *s1 = [selectionPickers objectAtIndex:i];
                    Selection *s2 = [solutinPickers objectAtIndex:i];
                    if (s1.rowInPicker != s2.rowInPicker) {
                        // Images are not in order!
                        return NO;
                    }
                }
            }
        }
        return [self validateNoConstraintsWithSolution:solution];
    } else if (!digitAnyOrder && imagesInAnyOrderEnabled) {
        for (int i = 0; i < [solution count]; i++) {
            Selection *s1 = [solution objectAtIndex:i];
            Selection *s2 = [selectionList objectAtIndex:i];
            if (![s1.picker isEqualToString:s2.picker]) {
                return NO;
            }
        }
        return [self validateNoConstraintsWithSolution:solution];
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

-(BOOL) validateNoConstraintsWithSolution:(NSArray*)solution {
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
