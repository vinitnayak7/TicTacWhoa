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
    [selectionList removeAllObjects];
    [selectedViewsTable removeAllObjects];
}

-(BOOL)saveGrid:(NSString *)userName {
    // Store the data
    if ([selectionList count] == 0) {
        return NO;
    }
        
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *nonMutableArray = [NSArray arrayWithArray:selectionList];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:nonMutableArray];
    [defaults setObject:data forKey:userName];
    [defaults synchronize];
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
