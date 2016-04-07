//
//  DJWebKitController.m
//  BuDeJie
//
//  Created by Jack.Ma on 16/4/7.
//  Copyright © 2016年 Jack.Ma. All rights reserved.
//

#import "DJWebKitController.h"
#import <WebKit/WebKit.h>

@interface DJWebKitController ()
@property (weak, nonatomic) IBOutlet UIProgressView *webViewProgress;
@property (weak, nonatomic) WKWebView *webView;
@end

@implementation DJWebKitController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [self.view insertSubview:webView atIndex:0];
    
    NSURLRequest *requset = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [webView loadRequest:requset];
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    _webView = webView;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(WKWebView *)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    self.webViewProgress.progress = object.estimatedProgress;
    self.webViewProgress.hidden = object.estimatedProgress <= 0 || object.estimatedProgress >= 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.webView.frame = self.view.bounds;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}
@end
