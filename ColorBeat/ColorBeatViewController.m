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

@property (weak, nonatomic) IBOutlet RoundedCornerView *quizColorView;
@property (weak, nonatomic) IBOutlet UILabel *quizTextView;

@property (weak, nonatomic) IBOutlet UIView *buttonsView;


@property (weak, nonatomic) NSTimer *timer;

@property (nonatomic) NSInteger count;

@end

@implementation ColorBeatViewController

#define TIMER_COUNT 10.0

#pragma mark Controller

//- (void)clickColor:(UIButton *)sender {
//    [self checkAnswer:sender.backgroundColor];
//    [self changePuzzle];
//}

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

- (void)checkAnswer:(UIColor *)buttonBackgroundColor
{
    
    NSArray *colorNames = [ColorUtils validColorNames];
    NSArray *colors = [ColorUtils validColors];
    
    NSUInteger indexOfTextNameInArray = [colorNames indexOfObject:self.quizTextView.text];
    NSUInteger indexOfButtonColorInArray = [colors indexOfObject:buttonBackgroundColor];
    
    if (indexOfTextNameInArray == indexOfButtonColorInArray)
    {
        self.count += 10;
    }
    else
    {
        self.count -= 5;
    }
}

- (void)updateTimer:(id)sender
{
    NSString *timeString = self.timerTextView.text;
    NSInteger timeInt = [timeString intValue];
    timeInt--;
    if (timeInt == 0) {
        [self performSegueWithIdentifier:@"Result" sender:self];
        timeInt = TIMER_COUNT;
    }
    self.timerTextView.text = [NSString stringWithFormat:@"%d", (int)timeInt];
    
}

- (void)addQuizButtons
{
    
    for (UIView *subView in self.buttonsView.subviews)
    {
        [subView removeFromSuperview];
    }
    
    CGRect frame = self.buttonsView.bounds;
    // NSLog(@"=======> Frame  %f %f %f %f", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    
    NSArray *colors = [ColorUtils validColors];
    NSUInteger count = [colors count];

    CGFloat height = frame.size.height;
    CGFloat gap = 8;
    CGFloat width = (frame.size.width - (count-1) * gap) / count;
    
    for (int i = 0; i < count; i++ ) {
        CGRect buttonFrame = CGRectMake(frame.origin.x + i * gap + i * width
                                        , frame.origin.y, width, height);
        
        // NSLog(@"=======> SubFrame  %f %f %f %f", buttonFrame.origin.x, buttonFrame.origin.y, buttonFrame.size.width, buttonFrame.size.height);
        

        RoundedCornerView *buttonView = [[RoundedCornerView alloc] initWithFrame:buttonFrame];
        buttonView.backgroundColor = colors[i];
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

    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Remove the timer when in other View Controller
    [self.timer invalidate];

    if ([segue.identifier isEqualToString:@"Result"]) {
        if ([segue.destinationViewController isKindOfClass:[ResultViewController class]]) {
            ResultViewController *vc = (ResultViewController *)segue.destinationViewController;
            vc.score = self.count;
        }
    }

}


@end
