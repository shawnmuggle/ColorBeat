//
//  ColorTellerViewController.m
//  ColorTeller
//
//  Created by Le Yu on 8/5/14.
//  Copyright (c) 2014 Le Yu. All rights reserved.
//

#import "ColorBeatViewController.h"
#import "ResultViewController.h"
#import "ColorUtils.h"

@interface ColorBeatViewController ()
@property (weak, nonatomic) IBOutlet UIView *colorView;
@property (weak, nonatomic) IBOutlet UILabel *colorTextView;
@property (weak, nonatomic) IBOutlet UILabel *scoreTextView;
@property (weak, nonatomic) IBOutlet UILabel *timerText;

@property (weak, nonatomic) NSTimer *timer;

@property (nonatomic) NSInteger count;

@end

@implementation ColorBeatViewController

#define TIMER_COUNT 30

#pragma mark Controller
- (void)setCount:(NSInteger)count
{
    _count = count;
    self.scoreTextView.text = [NSString stringWithFormat:@"SCORE: %d", (int)self.count];
}

- (IBAction)clickColor:(UIButton *)sender {
    [self checkAnswer:sender.backgroundColor];
    [self changePuzzle];
}

- (IBAction)restart:(UIButton *)sender {
    self.count = 0;
    [self changePuzzle];
    self.timerText.text = [NSString stringWithFormat:@"%d", TIMER_COUNT];
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
    self.colorView.backgroundColor = colors[colorIndex1];
    self.colorTextView.textColor = colors[colorIndex2];
    self.colorTextView.text = [ColorUtils randomColorText];
}

- (void)checkAnswer:(UIColor *)buttonBackgroundColor
{
    
    NSArray *colorNames = [ColorUtils validColorNames];
    NSArray *colors = [ColorUtils validColors];
    
    NSUInteger indexOfTextNameInArray = [colorNames indexOfObject:self.colorTextView.text];
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
    NSString *timeString = self.timerText.text;
    NSInteger timeInt = [timeString intValue];
    timeInt--;
    if (timeInt == 0) {
        [self performSegueWithIdentifier:@"Result" sender:self];
        timeInt = TIMER_COUNT;
    }
    self.timerText.text = [NSString stringWithFormat:@"%d", (int)timeInt];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self changePuzzle];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self changePuzzle];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
            // self.count = 0;
        }
    }

}


@end
