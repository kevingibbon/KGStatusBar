//
//  KGStatusBar.h
//
//  Created by Kevin Gibbon on 2/27/13.
//  Copyright 2013 Kevin Gibbon. All rights reserved.
//  @kevingibbon
//

#import <UIKit/UIKit.h>

@interface KGStatusBar : UIView

+ (void)showWithStatus:(NSString*)status showSpinner:(BOOL)shouldShowSpinner;
+ (void)showErrorWithStatus:(NSString*)status showSpinner:(BOOL)shouldShowSpinner;
+ (void)showSuccessWithStatus:(NSString*)status showSpinner:(BOOL)shouldShowSpinner;
+ (void)dismiss;

@end
