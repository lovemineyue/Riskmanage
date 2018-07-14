//
//  CPTabBarController.m
//  Riskmanagement
//
//  Created by demon on 2018/7/13.
//  Copyright © 2018年 demon. All rights reserved.
//

#import "CPTabBarController.h"
#import "CPNavigationController.h"
#import "LoginViewController.h"
#import "RegistViewController.h"
@interface CPTabBarController ()

@end

@implementation CPTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupChildViewControllers];
    
    //选中的颜色
    self.tabBar.tintColor = [UIColor redColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//初始化tabbarControll
-(void)setupChildViewControllers
{
#warning begin
    // 1.首页
    LoginViewController *home = [[LoginViewController alloc] init];
    [self setupChildViewController:home title:@"首页" imageName:@"首页" selectedImageName:@"首页拷贝"];

    
    RegistViewController *message = [[RegistViewController alloc] init];
    [self setupChildViewController:message title:@"行业政策" imageName:@"tabbar_hy" selectedImageName:@"tabbar_hy_sel"];
}

-(void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    CPNavigationController *nav = [[CPNavigationController alloc]initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
}

@end
