//
//  DJADController.m
//  BuDeJie
//
//  Created by Jack.Ma on 16/4/5.
//  Copyright © 2016年 Jack.Ma. All rights reserved.
//


#import "DJADController.h"
#import "DJTabBarController.h"
#import <AFNetworking/AFNetworking.h>
#import "DJADItem.h"
#import <MJExtension/MJExtension.h>
#import <SDWebImage/UIImageView+WebCache.h>



@interface DJADController ()
@property (weak, nonatomic) IBOutlet UIImageView *launchImage;
@property (weak, nonatomic) IBOutlet UIView *adView;
@property (weak, nonatomic) IBOutlet UIButton *jumpButton;
@property (weak, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) NSTimer *timer;
@property (strong, nonatomic) DJADItem *item;
@end

@implementation DJADController

- (UIImageView *)imageView {
    if (_imageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.adView addSubview:imageView];
        _imageView = imageView;
        imageView.userInteractionEnabled = YES;
        //添加广告页手势,用以跳转
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(adImageTapped)];
        [imageView addGestureRecognizer:gesture];
    }
    return _imageView;
}

- (void)adImageTapped {
    UIApplication *application = [UIApplication sharedApplication];
    if ([application canOpenURL:[NSURL URLWithString:self.item.ori_curl ]]) {
        [application openURL:[NSURL URLWithString:self.item.ori_curl ]];
    }
    [self jumpToTabBarController:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //设置启动后进行AD时的启动图片
    [self setUpLaunchImage];
    //下载广告数据
    [self loadADImage];
    //跳过按钮的到计时
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(adTimerOut) userInfo:nil repeats:YES];
}
- (void)adTimerOut {
    static NSInteger time = 3;
    NSString *string = [NSString stringWithFormat:@"跳过 %zd",time--];
    [self.jumpButton setTitle:string forState:UIControlStateNormal];
    if (time < 0) {
        [self.timer invalidate];
        UIApplication *application = [UIApplication sharedApplication];
        application.keyWindow.rootViewController = [[DJTabBarController alloc] init];
    }
}
- (IBAction)jumpToTabBarController:(id)sender {
    [self.timer invalidate];
    UIApplication *application = [UIApplication sharedApplication];
    application.keyWindow.rootViewController = [[DJTabBarController alloc] init];
}

#define Code2Value @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

- (void)loadADImage {
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",nil];
    NSDictionary *parameter = @{@"code2" : Code2Value
                                };
    
    [sessionManager GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *ad = [responseObject[@"ad"] firstObject];
        DJADItem *item = [DJADItem mj_objectWithKeyValues:ad];
        _item = item;
        //下载广告图片
        if (item.w <= 0) {
            return ;
        }
        CGFloat w = ScreenW;
        CGFloat h = ScreenW / item.w * item.h;
        self.imageView.frame = CGRectMake(0, 0, w, h);
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.w_picurl] ];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


- (void)setUpLaunchImage {
    UIImage *image = nil;

    switch ((NSInteger)ScreenH) {
        case iPhone6P:
            image = [UIImage imageNamed:@"LaunchImage-800-736h"];
            break;
        case iPhone6:
            image = [UIImage imageNamed:@"LaunchImage-800-667h"];
            break;
        case iPhone5:
            image = [UIImage imageNamed:@"LaunchImage-700-568h"];
            break;
        case iPhone4:
            image = [UIImage imageNamed:@"LaunchImage-700@2x"];
            break;
        default:
            break;
    }
    
    self.launchImage.image = image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
