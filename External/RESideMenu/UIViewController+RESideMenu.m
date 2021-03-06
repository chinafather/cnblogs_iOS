//
// UIViewController+RESideMenu.m
// RESideMenu
//
// Copyright (c) 2013 Roman Efimov (https://github.com/romaonthego)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "UIViewController+RESideMenu.h"
#import "RESideMenu.h"

@implementation UIViewController (REFrostedViewController)

- (void)re_displayController:(UIViewController *)controller frame:(CGRect)frame
{
    [self addChildViewController:controller];
    controller.view.frame = frame;
    [self.view addSubview:controller.view];
    [controller didMoveToParentViewController:self];
}

- (void)re_hideController:(UIViewController *)controller
{
    [controller willMoveToParentViewController:nil];
    [controller.view removeFromSuperview];
    [controller removeFromParentViewController];
}

- (RESideMenu *)sideMenuViewController
{
    UIViewController *iter = self.parentViewController;
    while (iter) {
        if ([iter isKindOfClass:[RESideMenu class]]) {
            return (RESideMenu *)iter;
        } else if (iter.parentViewController && iter.parentViewController != iter) {
            iter = iter.parentViewController;
        } else {
            iter = nil;
        }
    }
    return nil;
}
-(void)slidePresentViewController:(UIViewController *)controller animated:(BOOL)flag
{
    //NSLog(@"%f--%f",controller.view.frame.size.width,controller.view.frame.size.height);
    [controller.view setCenter:CGPointMake(controller.view.frame.size.width*1.5, controller.view.frame.size.height*0.5)];
    [[self.view superview] addSubview:controller.view];
    //切换其他页面进来
    [UIView animateWithDuration:0.5 animations:^{
        [self.view setCenter:CGPointMake(-self.view.frame.size.width*0.5, self.view.frame.size.height*0.5)];
        [controller.view setCenter:CGPointMake(controller.view.frame.size.width*0.5, controller.view.frame.size.height*0.5)];
    }];
    /*
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.75];
    [animation setType: kCATransitionMoveIn];
    [animation setSubtype:kCATransitionFromLeft];//从上推入
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.view.layer addAnimation:animation forKey:kCATransitionFade];
    [controller.view.layer  addAnimation:animation forKey:kCATransitionFade];
    [self presentViewController:controller animated:NO completion:nil];
    */
    
}
@end
