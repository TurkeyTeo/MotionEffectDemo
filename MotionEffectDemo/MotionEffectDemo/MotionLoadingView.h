//
//  MotionLoadingView.h
//  MotionEffectDemo
//
//  Created by Teo on 2017/5/22.
//

#import <UIKit/UIKit.h>

@interface MotionLoadingView : UIView



/**
 show MotionLoadingView

 @param view adds it to provided view and shows it
 */
+ (instancetype)showMotionLoadingViewTo:(UIView *)view;


/**
 hidden loadingView
 */
+ (void)hidenForView:(UIView *)view;

@end
