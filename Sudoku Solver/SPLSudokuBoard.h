//
//  SPLSudokuBoard.h
//  Sudoku Solver
//
//  Created by Skyler Patrick Lutz on 9/1/13.
//  Copyright (c) 2013 Skyler Patrick Lutz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPLSudokuBoard : UIView

- (NSArray *)squareValues;
- (void)updateSquare:(NSInteger)row col:(NSInteger)col withNumber:(NSNumber *)number;
@property (assign, nonatomic) BOOL isSolving;
@end
