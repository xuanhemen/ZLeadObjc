//
//  ZLTabBarViewController.m
//  ZLead
//
//  Created by 董建伟 on 2019/5/22.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLTabBarViewController.h"
#import "ZLNavigationController.h"
#import "ZLShopVC.h"
#import "ZLGoodsVC.h"
#import "ZLDataVC.h"
#import "ZLPersonalVC.h"
@interface ZLTabBarViewController ()

@end

@implementation ZLTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configTabBar];
    
}
/** 配置tabBar */
-(void)configTabBar{
    
    ZLShopVC *svc = [[ZLShopVC alloc] init]; //店铺
    ZLGoodsVC *gvc = [[ZLGoodsVC alloc] init]; //商品
    ZLDataVC *dvc = [[ZLDataVC alloc] init]; //数据
    ZLPersonalVC *pvc = [[ZLPersonalVC alloc] init]; //我的
    
    [self addChildController:svc title:@"店铺" image:image(@"首页") selectImage:image(@"tabbar_icon_home_active")];
    [self addChildController:gvc title:@"商品" image:image(@"管理办法") selectImage:image(@"tabbar_icon_lanmu_active")];
    [self addChildController:dvc title:@"数据" image:image(@"村务公开") selectImage:image(@"tabbar_icon_cunwu_active")];
    [self addChildController:pvc title:@"我的" image:image(@"我的") selectImage:image(@"tabbar_icon_my_active")];
}
/**
 添加子控制器

 @param controller 子控制器
 @param title itemTiele
 @param image 正常图片
 @param selectImg 选中图片
 */
-(void)addChildController:(UIViewController *)controller title:(NSString *)title image:(UIImage *)image selectImage:(UIImage *)selectImg{
    ZLNavigationController *nvc = [[ZLNavigationController alloc] initWithRootViewController:controller];
    nvc.tabBarItem.title = title;
    nvc.tabBarItem.image = image;
    nvc.tabBarItem.selectedImage = selectImg;
    [self addChildViewController:nvc];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
