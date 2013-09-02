//
//  SPLViewController.m
//  Sudoku Solver
//
//  Created by Skyler Patrick Lutz on 9/1/13.
//  Copyright (c) 2013 Skyler Patrick Lutz. All rights reserved.
//

#import "SPLViewController.h"
#import "SPLSudoku.h"
#import "SPLSudokuBoard.h"

@interface SPLViewController () <SPLSudokuDelegate>
@property (strong, nonatomic) SPLSudoku *sudoku;
@end

@implementation SPLViewController

static int LENGTH_OF_SUDOKU_BOARD = 9;

#pragma mark Overridden Getters
- (SPLSudoku *)sudoku {
    if (!_sudoku) {
        _sudoku = [[SPLSudoku alloc] init];
        _sudoku.delegate = self;
    }
    _sudoku.board = [self.boardView squareValues];
    return _sudoku;
}

#pragma mark Instance Methods
- (IBAction)solve:(id)sender {
    
    [self.sudoku solve];
}

- (IBAction)clear:(id)sender {

    [self.sudoku clear];
}


#pragma mark SPLSudoku Delegate methods
- (void)didSolve:(NSArray *)solution {
    
    NSArray *board = [self.boardView squareValues];
    self.boardView.isSolving = YES;
    for (int i=0; i < LENGTH_OF_SUDOKU_BOARD; i++) {
        
        for (int j=0; j < LENGTH_OF_SUDOKU_BOARD; j++) {
            
            NSNumber *num = [[solution objectAtIndex:i] objectAtIndex:j];
            if ([board[i][j] isEqualToNumber:num]) {
                continue;
            }
            [self.boardView updateSquare:i col:j withNumber:num];
        }
    }
    self.boardView.isSolving = NO;
}
- (void)cannotBeSolved {
    [[[UIAlertView alloc] initWithTitle:@"Cannot be solved"
                                message:nil
                               delegate:nil
                      cancelButtonTitle:@"ok"
                      otherButtonTitles:nil , nil] show];
}
- (void)didClear {
    for (int i=0; i < LENGTH_OF_SUDOKU_BOARD; i++) {
        
        for (int j=0; j < LENGTH_OF_SUDOKU_BOARD; j++) {
            
            [self.boardView updateSquare:i col:j withNumber:nil];
        }
    }
}
@end
