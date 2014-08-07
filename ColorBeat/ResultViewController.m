//
//  ResultViewController.m
//  ColorTeller
//
//  Created by Le Yu on 8/5/14.
//  Copyright (c) 2014 Le Yu. All rights reserved.
//

#import "ResultViewController.h"
#import "ColorUtils.h"

@interface ResultViewController ()

@property (weak, nonatomic) IBOutlet UILabel *scoreRecordText;
@property (weak, nonatomic) IBOutlet UILabel *scoreText;

@end

@implementation ResultViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSInteger highestScore = [ColorUtils getHighestScore];
    if (highestScore < self.score) {
        highestScore = self.score;
        [ColorUtils saveHighestScore:self.score];
    }
    self.scoreRecordText.text = [NSString stringWithFormat:@"HISTORY RECORD: %d", (int)highestScore];
    self.scoreText.text = [NSString stringWithFormat:@"Score: %d", (int)self.score];
}
 
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)tryAgain:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}

@end
