//
//  RTViewController.m
//  RhythmTest
//
//  Created by Mike Montalbo on 3/24/13.
//  Copyright (c) 2013 Joe Montalbo. All rights reserved.
//

#import "RTViewController.h"

const NSInteger kRTDefaultBPM = 120;
const NSInteger kRTDefaultBlinkFadeTime = 1;

@interface RTViewController ()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIView *blinkView;
@property (strong, nonatomic) NSDate *lastFireDate;
@end

@implementation RTViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.blinkView.backgroundColor = [UIColor greenColor];
}

- (void)timerFired:(NSTimer*)theTimer {
  NSLog(@"Timer fired");
  [self makeBlink];
  
  self.lastFireDate = [NSDate date];
}

- (IBAction)userTapped:(id)sender {
  if (!self.lastFireDate) {
    return;
  }
  
  NSTimeInterval diff = [[NSDate date]
                         timeIntervalSinceDate:self.lastFireDate];
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %f",diff];
}

- (IBAction)startTapped:(id)sender {
  NSLog(@"Start tapped");
  
  [self.bpmTimer invalidate];
  self.bpmTimer = [NSTimer scheduledTimerWithTimeInterval:60./kRTDefaultBPM
                                                   target:self
                                                 selector:@selector(timerFired:)
                                                 userInfo:nil
                                                  repeats:YES];
}

- (void)makeBlink {
  if ([[self.blinkView backgroundColor] isEqual:[UIColor greenColor]]) {
    self.blinkView.backgroundColor = [UIColor redColor];
  } else {
    self.blinkView.backgroundColor = [UIColor greenColor];
  }
}
@end
