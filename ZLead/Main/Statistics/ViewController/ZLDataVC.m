//
//  ZLDataVC.m
//  ZLead
//
//  Created by 董建伟 on 2019/5/22.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLDataVC.h"
#import "ZLLoginVC.h"
@interface ZLDataVC ()<QBImagePickerControllerDelegate>

@end

@implementation ZLDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"退出登录" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view.
}
- (void)btnClick {
    QBImagePickerController *imagePickerController =[QBImagePickerController new];
    imagePickerController.delegate = self;
    imagePickerController.allowsMultipleSelection = YES;
    //imagePickerController.prompt = @"请选择图像!";//在界面上方显示文字“请选择图像!”
    imagePickerController.showsNumberOfSelectedAssets = YES;//在界面下方显示已经选择图像的数量
    imagePickerController.numberOfColumnsInPortrait = 4;//竖屏模式下一行显示4张图像
    imagePickerController.numberOfColumnsInLandscape = 7;//横屏模式下一行显示7张图像
    imagePickerController.maximumNumberOfSelection = 9;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
//    ZLLoginVC *vc = [[ZLLoginVC alloc] init];
//    [self presentViewController:vc animated:YES completion:nil];
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
