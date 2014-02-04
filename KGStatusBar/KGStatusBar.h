//
//  KGStatusBar.h
//
//  Created by Kevin Gibbon on 2/27/13.
//  Copyright 2013 Kevin Gibbon. All rights reserved.
//  @kevingibbon
//

#import <UIKit/UIKit.h>

@interface KGStatusBar : UIView

+ (void)showWithStatus:(NSString*)status animated:(BOOL)animated;
+ (void)showErrorWithStatus:(NSString*)status animated:(BOOL)animated;
+ (void)showSuccessWithStatus:(NSString*)status animated:(BOOL)animated;
+ (void)dismiss:(BOOL)animated;

@end
