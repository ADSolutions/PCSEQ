//
//  HNHHEQVisualizer.m
//  HNHH
//
//  Created by Dobango on 9/17/13.
//  Copyright (c) 2013 RC. All rights reserved.
//

#import "PCSEQVisualizer.h"
#import "UIImage+Color.h"

#define kPadding 1
#define kDefaultNumberOfBars 5

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
    if (_numberOfBars <= 0)
    {
        _numberOfBars = kDefaultNumberOfBars;
    }
    
    _barsWidth = rect.size.width/(_numberOfBars +(_numberOfBars*kPadding));
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
        CGRect frame = [self convertRect:self.frame fromView:self.superview];
        
        UIImageView *bar = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.origin.x/2) + (i *_barsWidth + (i *kPadding)), CGRectGetMinY(frame), _barsWidth, 1)];
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

-(void)setBarColor:(UIColor *)barColor
{
    _barColor = barColor;
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
            CGRect rect = bar.frame;
            rect.size.height = (arc4random() % (uint)self.frame.size.height) + 1;
            bar.frame = rect;
        }
    }];
}

@end