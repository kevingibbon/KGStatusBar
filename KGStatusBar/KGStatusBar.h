//
//  KGStatusBar.h
//
//  Created by Kevin Gibbon on 2/27/13.
//  Copyright 2013 Kevin Gibbon. All rights reserved.
//  @kevingibbon
//

#import <UIKit/UIKit.h>

@interface KGStatusBar : UIView

+ (void)setFont:(UIFont*)font;
+ (UIFont*)font;

+ (void)setUsingShadow:(BOOL)useShadow;
+ (BOOL)isUsingShadow;

+ (void)showWithStatus:(NSString*)status;
+ (void)showErrorWithStatus:(NSString*)status;
+ (void)showSuccessWithStatus:(NSString*)status;

+ (void)showWithStatus:(NSString *)status barColor:(UIColor*)barColor textColor:(UIColor*)textColor;

+ (void)dismiss;

@end
