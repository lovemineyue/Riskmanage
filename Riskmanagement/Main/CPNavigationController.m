//
//  CPNavigationController.m
//  Riskmanagement
//
//  Created by demon on 2018/7/13.
//  Copyright © 2018年 demon. All rights reserved.
//

#import "CPNavigationController.h"

@interface CPNavigationController ()

@end

@implementation CPNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

@end
