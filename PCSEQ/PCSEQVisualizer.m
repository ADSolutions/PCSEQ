//
//  HNHHEQVisualizer.m
//  HNHH
//
//  Created by Dobango on 9/17/13.
//  Copyright (c) 2013 RC. All rights reserved.
//

#import "PCSEQVisualizer.h"
#import "UIImage+Color.h"

#define kWidth 12
#define kPadding 1

@implementation PCSEQVisualizer
{
    NSTimer *_timer;
    NSArray *_barArray;
}

- (id)initWithNumberOfBars:(NSInteger)numberOfBars
{
    self = [super init];
    if (self)
    {
        _numberOfBars = numberOfBars;
    }
    
    return self;
}

-(void)drawRect:(CGRect)rect
{
    self.frame = CGRectMake(0, 0, kPadding *_numberOfBars +(kWidth *_numberOfBars), self.frame.size.height);
    [super drawRect:rect];
}

-(void)setNeedsDisplay
{
    for (UIView *subView in self.subviews)
    {
        _barArray = nil;
        
        if ([subView isKindOfClass:[UIImageView class]])
        {
            [subView removeFromSuperview];
        }
    }
    
    NSMutableArray* tempBarArray = [[NSMutableArray alloc] initWithCapacity:_numberOfBars];
    
    for (int i = 0; i < _numberOfBars; i++)
    {
        UIImageView *bar = [[UIImageView alloc] initWithFrame:CGRectMake(i *kWidth+i *kPadding, 0, kWidth, 1)];
        bar.image = [UIImage imageWithColor:self.barColor];
        [self addSubview:bar];
        [tempBarArray addObject:bar];
    }
    
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_2 *2);
    self.transform = transform;
    
    _barArray = tempBarArray;
}

#pragma mark - Setters

-(void)setNumberOfBars:(NSInteger)numberOfBars
{
    _numberOfBars = numberOfBars;
    [self drawRect:self.frame];
    [self setNeedsDisplay];
}

#pragma mark - Commands

-(void)start
{
    if (_timer)
    {
        [_timer invalidate];
        _timer = nil;
    }
    
    self.hidden = NO;
    _timer = [NSTimer scheduledTimerWithTimeInterval:.35 target:self selector:@selector(ticker) userInfo:nil repeats:YES];
}

-(void)stop
{
    [_timer invalidate];
    _timer = nil;
}

-(void)ticker
{
    [UIView animateWithDuration:.35 animations:^{
        
        for (UIImageView *bar in _barArray)
        {
            float height = self.frame.size.height;
            
            CGRect rect = bar.frame;
            rect.size.height = arc4random() % (UInt16)height + 1;
            bar.frame = rect;
        }
    }];
}

@end