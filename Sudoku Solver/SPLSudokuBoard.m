//
//  SPLSudokuBoard.m
//  Sudoku Solver
//
//  Created by Skyler Patrick Lutz on 9/1/13.
//  Copyright (c) 2013 Skyler Patrick Lutz. All rights reserved.
//

#import "SPLSudokuBoard.h"
#import <QuartzCore/QuartzCore.h>

@interface SPLSudokuBoard () <UITextFieldDelegate>
@property (strong, nonatomic) NSMutableArray *fields;
@end

@implementation SPLSudokuBoard

static int LENGTH_OF_SUDOKU_BOARD = 9;

#pragma mark Overridden Init 
// invoked by interface builder
- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        self.fields = [[NSMutableArray alloc] init];
        
        CGFloat boardWidth = self.frame.size.width;
        CGFloat boardHeight = self.frame.size.height;
        
        CGFloat squareWidth = boardWidth / LENGTH_OF_SUDOKU_BOARD;
        CGFloat squareHeight = boardHeight / LENGTH_OF_SUDOKU_BOARD;
        
        for (int i=0; i < LENGTH_OF_SUDOKU_BOARD; i++) {
            
            NSMutableArray *row = [[NSMutableArray alloc] init];
            
            for (int j=0; j < LENGTH_OF_SUDOKU_BOARD; j++) {
                
                UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(j * squareWidth,
                                                                           i * squareHeight,
                                                                           squareWidth,
                                                                           squareHeight)];
                textField.layer.borderColor = [UIColor blackColor].CGColor;
                textField.layer.borderWidth = 1.0;
                textField.textAlignment = NSTextAlignmentCenter;
                textField.keyboardType = UIKeyboardTypeNumberPad;
                textField.delegate = self;
                [row addObject:textField];
                [self addSubview:textField];
                
            }
            [self.fields addObject:row];
        }
        
    }
    return self;
}
#pragma mark Instance Methods
- (NSArray *)squareValues {
    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    for (int i=0; i < LENGTH_OF_SUDOKU_BOARD; i++) {
        
        NSMutableArray *row = [[NSMutableArray alloc] init];
        
        for (int j=0; j < LENGTH_OF_SUDOKU_BOARD; j++) {
            
            UILabel *lbl = [[self.fields objectAtIndex:i] objectAtIndex:j];
            NSString *text = lbl.text;
            NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
            [f setNumberStyle:NSNumberFormatterDecimalStyle];
            NSNumber *number = [f numberFromString:text];
            
            if (!number) {
                number = @(0);
            }
            [row addObject:number];
            
        }
        [values addObject:row];
    }
    
    return values;
}

- (void)updateSquare:(NSInteger)row col:(NSInteger)col withNumber:(NSNumber *)number {
    
    UITextField *field = [[self.fields objectAtIndex:row] objectAtIndex:col];
    field.text = [number stringValue];
}

#pragma mark UITextField Delegate Methods
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.text = nil;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    if (newLength > 1) {
        return NO;
    }
    else {
        [self skip:textField];
        return YES;
    }
}
- (void)skip:(UITextField *)old {
    // transfer control to next text field.
    NSInteger r;
    NSInteger c;
    for (r = 0; r < [self.fields count]; r++)  {
        NSArray *row = [self.fields objectAtIndex:r];
        c = [row indexOfObject:old];
        if (c != NSNotFound) {
            break;
        }
    }
    NSInteger nr = ((c+1)/9 >0) ? r+1 : r;
    NSInteger nc = (c+1)%9;
    if (nr >= 9) {
        return;
    }
    UITextField *nextField = [[self.fields objectAtIndex:nr] objectAtIndex:nc];
    if (nextField) {
        // [nextField becomeFirstResponder]; doesn't work for some reason.
        [nextField performSelector:@selector(becomeFirstResponder) withObject:nextField afterDelay:0.1];
    }
}

@end
