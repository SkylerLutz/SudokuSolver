//
//  SPLSudoku.m
//  Sudoku Solver
//
//  Created by Skyler Patrick Lutz on 9/1/13.
//  Copyright (c) 2013 Skyler Patrick Lutz. All rights reserved.
//

#import "SPLSudoku.h"

@implementation SPLSudoku
static int LENGTH_OF_SUDOKU_BOARD = 9;

#pragma mark Overridden Init
- (id)init {
    
    if (self = [super init]) {
        
        self.board = [[NSMutableArray alloc] init]; //not mutable publicly, only privately
    }
    return self;
}

#pragma mark Instance Methods
- (void)solve {

    if ([self isValidPuzzle]) {
        if ([self solve:0]) {
            [self.delegate didSolve:self.board];
            return;
        }
    }
    [self.delegate cannotBeSolved];
}
- (void)clear {
    
    for (int i=0; i < LENGTH_OF_SUDOKU_BOARD; i++) {
        
        for (int j=0; j < LENGTH_OF_SUDOKU_BOARD; j++) {
            
            [[self.board objectAtIndex:i] replaceObjectAtIndex:j withObject:@(0)];
        }
    }
    [self.delegate didClear];
}
#pragma mark Private helping Methods
- (BOOL)solve:(int)cell {
    
    if(cell == LENGTH_OF_SUDOKU_BOARD*LENGTH_OF_SUDOKU_BOARD){
        return true;
    }
    int row = cell / LENGTH_OF_SUDOKU_BOARD;
    int col = cell % LENGTH_OF_SUDOKU_BOARD;
    
    
    if([self.board[col][row] isEqual:@(0)]){ // if the space has not been filled in
        for(int i=1; i < LENGTH_OF_SUDOKU_BOARD+1; i++) {
            [[self.board objectAtIndex:col] replaceObjectAtIndex:row withObject:@(i)];
            if([self isValid:cell]) {
                
                if([self solve:cell+1]) {
                    return true;
                }
            }
            self.board[col][row] = @(0);
        }
    }
    else { // the space is permanately filled in
        if([self solve:cell+1]) {
            return true;
        }
    }
    return false;
}

-(BOOL)isValid:(int)cell {
    
    int row = cell / LENGTH_OF_SUDOKU_BOARD;
    int col = cell % LENGTH_OF_SUDOKU_BOARD;
    
    int cOrigin = (col/3)*3;
    int rOrigin = (row/3)*3;
    
    for(int i=0; i < 3; i++) {
        for(int j=0; j < 3; j++) {
            
            int r = rOrigin + i;
            int c = cOrigin + j;
            if(r == row && c == col) {
                continue;
            }
            if([self.board[c][r] isEqual:self.board[col][row]]) {
                return NO;
            }
        }
    }
    
    for(int i=1; i < LENGTH_OF_SUDOKU_BOARD; i++) {
        if(col+i >= 0 && col+i < LENGTH_OF_SUDOKU_BOARD){
            if([self.board[col+i][row] isEqual: self.board[col][row]]) {
                return NO;
            }
        }
        if(col-i >= 0 && col-i < LENGTH_OF_SUDOKU_BOARD){
            if([self.board[col-i][row] isEqual: self.board[col][row]]) {
                return NO;
            }
        }
    }
    for(int i=1; i < LENGTH_OF_SUDOKU_BOARD; i++) {
        if(row+i >= 0 && row+i < LENGTH_OF_SUDOKU_BOARD){
            if([self.board[col][row+i] isEqual: self.board[col][row]]) {
                return NO;
            }
        }
        if(row-i >= 0 && row-i < LENGTH_OF_SUDOKU_BOARD){
            if([self.board[col][row-i] isEqual: self.board[col][row]]) {
                return NO;
            }
        }
    }
    return YES;
}
- (BOOL)isValidPuzzle {
    for(int i=0; i < 81; i++) {
        
        int row = i / LENGTH_OF_SUDOKU_BOARD;
        int col = i % LENGTH_OF_SUDOKU_BOARD;
        if (![self.board[col][row] isKindOfClass:[NSNumber class]]) {
            return NO;
        }
        if([self.board[col][row] isEqual:@(0)]){
            continue;
        }
        if(![self isValid:i]) {
            return NO;
        }
    }
    return YES;
}
@end
