//
//  SPLViewController.h
//  Sudoku Solver
//
//  Created by Skyler Patrick Lutz on 9/1/13.
//  Copyright (c) 2013 Skyler Patrick Lutz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SPLSudokuBoard;

@interface SPLViewController : UIViewController

@property (strong, nonatomic) IBOutlet SPLSudokuBoard *boardView;
- (IBAction)solve:(id)sender;
- (IBAction)clear:(id)sender;
@end
