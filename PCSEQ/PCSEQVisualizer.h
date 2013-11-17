//
//  HNHHEQVisualizer.h
//  HNHH
//
//  Created by Dobango on 9/17/13.
//  Copyright (c) 2013 RC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PCSEQVisualizer : UIView

@property (nonatomic, retain) UIColor *barColor;
@property (nonatomic) NSInteger numberOfBars;

- (id)initWithNumberOfBars:(NSInteger)numberOfBars;

//Starts NSTimer and begins the animation
-(void)start;

//Stops NSTimer by invalidating and stops the animation
-(void)stop;

@end