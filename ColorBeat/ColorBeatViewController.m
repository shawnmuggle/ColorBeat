//
//  ColorTellerViewController.m
//  ColorTeller
//
//  Created by Le Yu on 8/5/14.
//  Copyright (c) 2014 Le Yu. All rights reserved.
//

#import "ColorBeatViewController.h"
#import "ResultViewController.h"
#import "RoundedCornerView.h"
#import "ColorUtils.h"

@interface ColorBeatViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timerTextView;
@property (weak, nonatomic) IBOutlet UILabel *scoreView;

@property (weak, nonatomic) IBOutlet RoundedCornerView *quizColorView;
@property (weak, nonatomic) IBOutlet UILabel *quizTextView;

@property (weak, nonatomic) IBOutlet UIView *buttonsView;


@property (weak, nonatomic) NSTimer *timer;

@property (nonatomic) NSInteger count;
@property (nonatomic) CGFloat timerFloat;

@end

@implementation ColorBeatViewController

#define TIMER_COUNT 10.0

#pragma mark Controller

- (void)setCount:(NSInteger)count
{
    _count = count;
    self.scoreView.text = [NSString stringWithFormat:@"%d", (int)count];
    
}

- (void)setTimerFloat:(CGFloat)timerFloat
{
    _timerFloat = timerFloat;
    self.timerTextView.text = [NSString stringWithFormat:@"%.01f", timerFloat];
}

- (void)changePuzzle
{
    // Get Two Random Color
    NSArray *colors = [ColorUtils validColors];
    NSUInteger colorCount = [colors count];
    NSUInteger colorIndex1 = [ColorUtils randomIndex:colorCount];
    NSUInteger colorIndex2 = [ColorUtils randomIndex:colorCount-1];
    if (colorIndex2 == colorIndex1) {
        colorIndex2++;
    }

    UIColor *colorx = colors[colorIndex1];
    NSLog(@"Color: %@", colorx);
    self.quizColorView.backgroundColor = colors[colorIndex1];
    self.quizTextView.textColor = colors[colorIndex2];
    self.quizTextView.text = [ColorUtils randomColorText];
}

- (void)checkAnswer:(NSUInteger)indexOfButtonIndex
{
    
    NSArray *colorNames = [ColorUtils validColorNames];
    NSUInteger indexOfTextNameInArray = [colorNames indexOfObject:self.quizTextView.text];
    
    if (indexOfTextNameInArray == indexOfButtonIndex)
    {
        self.count += 1;
    }
    else
    {
    }
}

- (void)updateTimer:(id)sender
{
    self.timerFloat -= 0.1;
    if (self.timerFloat <= 0) {
        [self performSegueWithIdentifier:@"Result" sender:self];
        self.timerFloat = TIMER_COUNT;
    }
}

- (void)buttonTapped:(UITapGestureRecognizer *)gr {
    RoundedCornerView *buttonView = (RoundedCornerView *)gr.view;
    NSUInteger buttonIndex = [self.buttonsView.subviews indexOfObject:buttonView];
    [self checkAnswer:buttonIndex];
    [self changePuzzle];
    
}

- (void)addQuizButtons
{
    
    for (UIView *subView in self.buttonsView.subviews)
    {
        [subView removeFromSuperview];
    }
    
    CGRect frame = self.buttonsView.bounds;
    
    NSArray *colors = [ColorUtils validColors];
    NSUInteger count = [colors count];

    CGFloat height = frame.size.height;
    CGFloat gap = 8;
    CGFloat width = (frame.size.width - (count-1) * gap) / count;
    
    for (int i = 0; i < count; i++ ) {
        CGRect buttonFrame = CGRectMake(frame.origin.x + i * gap + i * width
                                        , frame.origin.y, width, height);

        RoundedCornerView *buttonView = [[RoundedCornerView alloc] initWithFrame:buttonFrame];
        [buttonView commonInit];
        buttonView.backgroundColor = colors[i];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonTapped:)];
        [buttonView addGestureRecognizer:tapGR];
        
        [self.buttonsView addSubview:buttonView];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self changePuzzle];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self addQuizButtons];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self changePuzzle];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self addQuizButtons];

    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Remove the timer when in other View Controller
    [self.timer invalidate];

    if ([segue.identifier isEqualToString:@"Result"]) {
        if ([segue.destinationViewController isKindOfClass:[ResultViewController class]]) {
            ResultViewController *vc = (ResultViewController *)segue.destinationViewController;
            vc.score = self.count;
            self.count = 0;
        }
    }

}


@end
