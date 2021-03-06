//
//  UIWindow+LXLExtension.m
//  LXLExtension
//
//  Created by lixianliang on 2021/7/19.
//

#import "UIWindow+LXLExtension.h"

@implementation UIWindow (LXLExtension)
- (UIResponder *)firstResponder {
    return [self valueForKey:@"_firstResponder"];
}

- (UIViewController *)currentShowController {
    return [[self class] topViewController:self.rootViewController];
}

+ (UIViewController *)topViewController:(UIViewController *)rootViewController {
    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController;
        return [[self class] topViewController:[navigationController.viewControllers lastObject]];
    }
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabController = (UITabBarController *)rootViewController;
        return [[self class] topViewController:tabController.selectedViewController];
    }
    if (rootViewController.presentedViewController) {
        return [[self class] topViewController:rootViewController.presentedViewController];
    }
    return rootViewController;
}

- (UIViewController*)topViewController {
    UIViewController *topViewController = self.rootViewController;
    while (topViewController.presentedViewController) {
        topViewController = topViewController.presentedViewController;
    }
    return topViewController;
}

- (UIViewController *)currentShowBottomController {
    UIViewController *topViewController = self.rootViewController;
    while (topViewController) {
        if (topViewController.presentedViewController) {
            UIModalPresentationStyle p = topViewController.presentedViewController.modalPresentationStyle;
            if (p == UIModalPresentationFullScreen) {
                topViewController = topViewController.presentedViewController;
            } else {
                break;
            }
        } else {
            break;
        }
    }
    
    if ([topViewController isKindOfClass:[UITabBarController class]]) {
        topViewController = ((UITabBarController *)topViewController).selectedViewController;
    }
    
    if ([topViewController isKindOfClass:[UINavigationController class]]) {
        topViewController = ((UINavigationController *)topViewController).topViewController;
    }
    
    return topViewController;
}
@end
