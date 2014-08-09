//
//  HelpViewController.m
//  ColorTeller
//
//  Created by Le Yu on 8/5/14.
//  Copyright (c) 2014 Le Yu. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()
@property (weak, nonatomic) IBOutlet UIView *imageView;

@end

@implementation HelpViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    UIImageView *imageSubView = [[UIImageView alloc] initWithFrame:self.imageView.bounds];
    imageSubView.image = [UIImage imageNamed:@"screenshot2"];
    [self.imageView addSubview:imageSubView];
    
    
}
- (IBAction)backGame:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}

@end
