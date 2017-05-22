//
//  ViewController.m
//  MotionEffectDemo
//
//  Created by Teo on 2017/5/22.
//

#import "ViewController.h"
#import "MotionLoadingView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:self.view.bounds];
    iv.image = [UIImage imageNamed:@"starry.jpg"];
    [self.view addSubview:iv];
    
    [MotionLoadingView showMotionLoadingViewTo:self.view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(125 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MotionLoadingView hidenForView:self.view];
    });
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
