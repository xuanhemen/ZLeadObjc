//
//  ZLAddImgTextVC.m
//  ZLead
//
//  Created by 董建伟 on 2019/6/13.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLAddImgTextVC.h"
#import "ZLImgTextView.h"
#import "TZImagePickerController.h"
@interface ZLAddImgTextVC ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate>

@property (nonatomic, strong) UITableView *tableView; //

@property (nonatomic, strong) UIView *headView; //

@property (nonatomic, strong) NSMutableArray *imgArr; // 图片数组

@property (nonatomic, strong) NSMutableDictionary *textDic; // 文字描述参数

@property (nonatomic, strong) UIButton *addBtn; // 继续添加
@end

static NSInteger contentY = 0; //inputView的y的位置
static NSInteger tag = 0;
@implementation ZLAddImgTextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"图文简介";
    [self initView]; //初始化视图
    
    // Do any additional setup after loading the view.
}
- (void)initView {
    
    [self addListView];
    [self addFootView]; //继续添加视图
    [self addBottomView]; //底部保存视图
    [self addImgTextView];
    
}
- (void)addImgTextView {
    
    self.addBtn.enabled = NO; //继续添加按钮设为不可点击
    
    ZLImgTextView *inputView = [[ZLImgTextView alloc] init];
    inputView.tag = tag;
    tag ++;
    kWeakSelf(weakSelf)
    [[inputView.imgBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakSelf popSheetView:inputView];
        
    }];
    [[inputView.desView.textView.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return value;
    }] subscribeNext:^(id  _Nullable x) {
        NSInteger tag = inputView.tag;
        NSString *key = [NSString stringWithFormat:@"text_0%ld",tag];
        [weakSelf.textDic setObject:x forKey:key]; //收集参数
    }];
    self.headView.frame = CGRectMake(0, 0, kScreenWidth, dis(230)+contentY);
    inputView.frame = CGRectMake(0, contentY, kScreenWidth, dis(230));
    contentY += dis(230);
    [self.headView addSubview:inputView];
    _tableView.tableHeaderView = self.headView ;
}
- (void)popSheetView:(ZLImgTextView *)view {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"请选择添加方式" preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //相机拍照
         [self goPhotoLibrary:@"camera" imgTextView:view];  //跳到相册
    }];
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self goPhotoLibrary:@"library" imgTextView:view];  //跳到相册
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    [alertController addAction:archiveAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
/** 跳转到相册 */
- (void)goPhotoLibrary:(NSString *)type imgTextView:(ZLImgTextView *)view {
    kWeakSelf(weakSelf)
    
    TZImagePickerController *vc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    // 你可以通过block或者代理，来得到用户选择的照片.
    [vc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        UIImage *image = [photos objectAtIndex:0];
        NSInteger tag = view.tag;
        [view.imgBtn setImage:image forState:UIControlStateNormal];
        if (view.isEmpty) {
            weakSelf.addBtn.enabled = YES;
            [weakSelf.imgArr addObject:image];
        }else{
            [weakSelf.imgArr replaceObjectAtIndex:tag withObject:image];
        }
        view.isEmpty = NO;  //控制继续添加按钮是否可点击
        
    }];
    
    [self presentViewController:vc animated:YES completion:nil];
   
}
- (void)addFootView {
    
    UIView * footView = [[UIView alloc] init];
    footView.backgroundColor = [UIColor whiteColor];
    footView.frame = CGRectMake(0, 0, kScreenWidth, dis(60));
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn setTitle:@"继续添加 +" forState:UIControlStateNormal];
    [_addBtn setTitleColor:normalColor forState:UIControlStateNormal];
    [_addBtn setTitleColor:lightColor forState:UIControlStateDisabled];
    _addBtn.enabled = NO;
    _addBtn.titleLabel.font = kFont16;
    kWeakSelf(weakSelf)
    [[_addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakSelf addImgTextView];
    }];
    [footView addSubview:_addBtn];
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(footView);
        make.left.equalTo(footView).offset(dis(20));
    }];
    
    _tableView.tableFooterView = footView;
    
}
- (UIView *)headView {
    if (!_headView) {
        _headView = [[UIView alloc] init];
        _headView.frame = CGRectMake(0, 0, kScreenWidth, dis(230));
    }
    return _headView;
}
- (void)addListView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height-kTabBarHeight) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}
- (void)addBottomView {
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, kTabBarHeight));
    }];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveBtn.backgroundColor = [UIColor zl_mainColor];
    saveBtn.layer.masksToBounds = YES;
    saveBtn.layer.cornerRadius = 4;
    [bottomView addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView).offset(dis(10));
        make.centerX.equalTo(bottomView);
        make.size.mas_equalTo(kSize(kScreenWidth-60, 44));
    }];
    kWeakSelf(weakSelf)
    [[saveBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        weakSelf.passImgtext(weakSelf.imgArr, weakSelf.textDic);
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    return cell;
}
- (NSMutableArray *)imgArr {
    if (!_imgArr) {
        _imgArr = [NSMutableArray array];
    }
    return _imgArr;
}
- (NSMutableDictionary *)textDic {
    if (!_textDic) {
        _textDic = [NSMutableDictionary dictionary];
    }
    return _textDic;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:[UIColor blackColor]}];
}
- (void)didMoveToParentViewController:(UIViewController *)parent {
    if (!parent) {
        contentY = 0;
    }
}
- (void)dealloc {
    NSLog(@"走了吗安云");
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
