//
//  KGStatusBar.m
//
//  Created by Kevin Gibbon on 2/27/13.
//  Copyright 2013 Kevin Gibbon. All rights reserved.
//  @kevingibbon
//

#import "KGStatusBar.h"

#define TOP_BAR_DISAPPEARING_ANIMATION_DURATION 0.15
#define STATUS_BAR_APPEARING_ANIMATION_DURATION 0.15


@interface KGStatusBar ()
@property (nonatomic, strong, readonly) UIWindow *overlayWindow;
@property (nonatomic, strong, readonly) UIView *topBar;
@property (nonatomic, strong) UILabel *stringLabel;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, assign, getter = shouldShowActivityIndicatorView) BOOL showActivityIndicatorView;
@end

@implementation KGStatusBar

@synthesize topBar, overlayWindow, stringLabel, activityIndicatorView, showActivityIndicatorView;

+ (KGStatusBar*)sharedView {
    static dispatch_once_t once;
    static KGStatusBar *sharedView;
    dispatch_once(&once, ^ { sharedView = [[KGStatusBar alloc] initWithFrame:[[UIScreen mainScreen] bounds]]; });
    return sharedView;
}

+ (void)showSuccessWithStatus:(NSString*)status showSpinner:(BOOL)shouldShowSpinner{
    [KGStatusBar showWithStatus:status showSpinner:shouldShowSpinner];
    [KGStatusBar performSelector:@selector(dismiss) withObject:self afterDelay:2.0 ];
}

+ (void)showWithStatus:(NSString*)status showSpinner:(BOOL)shouldShowSpinner{
    [[KGStatusBar sharedView] showWithStatus:status barColor:[UIColor blackColor] textColor:[UIColor colorWithRed:191.0/255.0 green:191.0/255.0 blue:191.0/255.0 alpha:1.0] showSpinner:shouldShowSpinner];
}

+ (void)showErrorWithStatus:(NSString*)status showSpinner:(BOOL)shouldShowSpinner{
    [[KGStatusBar sharedView] showWithStatus:status barColor:[UIColor colorWithRed:97.0/255.0 green:4.0/255.0 blue:4.0/255.0 alpha:1.0] textColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0] showSpinner:shouldShowSpinner];
    [KGStatusBar performSelector:@selector(dismiss) withObject:self afterDelay:2.0 ];
}

+ (void)dismiss {
    [[KGStatusBar sharedView] dismiss];
}

- (id)initWithFrame:(CGRect)frame {
	
    if ((self = [super initWithFrame:frame])) {
		self.userInteractionEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
		self.alpha = 0;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

- (void)showWithStatus:(NSString *)status barColor:(UIColor*)barColor textColor:(UIColor*)textColor showSpinner:(BOOL)shouldShowSpinner{
    if(!self.superview)
        [self.overlayWindow addSubview:self];
    [self.overlayWindow setHidden:NO];
    [self.topBar setHidden:NO];
    
    self.topBar.backgroundColor = barColor;
    
    self.showActivityIndicatorView = shouldShowSpinner;
    
    NSString *labelText = status;
    
    self.stringLabel.alpha = 0.0;
    self.stringLabel.hidden = NO;
    self.stringLabel.text = labelText;
    self.stringLabel.textColor = textColor;
    [self.stringLabel sizeToFit];
    self.stringLabel.center = CGPointMake(self.bounds.size.width/2+7, self.stringLabel.center.y);
    
    if (self.showActivityIndicatorView) {
    self.activityIndicatorView.center = CGPointMake(self.stringLabel.center.x - self.stringLabel.frame.size.width/2 - 14, self.stringLabel.center.y+1);
    self.activityIndicatorView.alpha = 0.0;
    [self.activityIndicatorView setHidden:NO];
    [self.activityIndicatorView startAnimating];
    }
    
    
    [UIView animateWithDuration:0.4 animations:^{
        self.stringLabel.alpha = 1.0;
        if (self.shouldShowActivityIndicatorView) {
        self.activityIndicatorView.alpha = 1.0;
        }
    }];
    [self setNeedsDisplay];
}

- (void) dismiss
{

    [UIView animateWithDuration:TOP_BAR_DISAPPEARING_ANIMATION_DURATION animations:^{
        self.stringLabel.alpha = 0.0;
        
        if (self.activityIndicatorView)
            self.activityIndicatorView.alpha = 0.0;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:STATUS_BAR_APPEARING_ANIMATION_DURATION animations:^{

            self.overlayWindow.alpha = 0.0;
        } completion:^(BOOL finished) {
            [topBar removeFromSuperview];
            topBar = nil;
            
            if (activityIndicatorView) {
                [activityIndicatorView removeFromSuperview];
                activityIndicatorView = nil;
            }
            
            
            [overlayWindow removeFromSuperview];
            overlayWindow = nil;
        }];
    }];
}

- (UIWindow *)overlayWindow {
    if(!overlayWindow) {
        overlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        overlayWindow.backgroundColor = [UIColor clearColor];
        overlayWindow.userInteractionEnabled = NO;
        overlayWindow.windowLevel = UIWindowLevelStatusBar;
    }
    return overlayWindow;
}

- (UIView *)topBar {
    if(!topBar) {
        topBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, overlayWindow.frame.size.width, 20.0)];
        [overlayWindow addSubview:topBar];
    }
    return topBar;
}

- (UIActivityIndicatorView *)activityIndicatorView {
    if(!activityIndicatorView) {
        activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        activityIndicatorView.transform = CGAffineTransformMakeScale(0.67, 0.67);
        [overlayWindow addSubview:activityIndicatorView];
    }
    return activityIndicatorView;
}

- (UILabel *)stringLabel {
    if (stringLabel == nil) {
        stringLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		stringLabel.textColor = [UIColor colorWithRed:191.0/255.0 green:191.0/255.0 blue:191.0/255.0 alpha:1.0];
		stringLabel.backgroundColor = [UIColor clearColor];
		stringLabel.adjustsFontSizeToFitWidth = YES;
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
        stringLabel.textAlignment = UITextAlignmentCenter;
#else
        stringLabel.textAlignment = NSTextAlignmentCenter;
#endif
		stringLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
		stringLabel.font = [UIFont boldSystemFontOfSize:14.0];
		stringLabel.shadowColor = [UIColor blackColor];
		stringLabel.shadowOffset = CGSizeMake(0, -1);
        stringLabel.numberOfLines = 1;
    }
    
    if(!stringLabel.superview)
        [self.topBar addSubview:stringLabel];
    
    return stringLabel;
}

@end
