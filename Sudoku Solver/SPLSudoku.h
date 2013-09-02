//
//  SPLSudoku.h
//  Sudoku Solver
//
//  Created by Skyler Patrick Lutz on 9/1/13.
//  Copyright (c) 2013 Skyler Patrick Lutz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SPLSudokuDelegate <NSObject>

@required
- (void)didSolve:(NSArray *)solution;
- (void)cannotBeSolved;
- (void)didClear;
@end


@interface SPLSudoku : NSObject

@property (strong, nonatomic) NSArray *board;
@property (assign, nonatomic) id<SPLSudokuDelegate> delegate;

- (void)solve;
- (void)clear;
@end
