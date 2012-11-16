#import <UIKit/UIKit.h>

@interface AppController : UIViewController

@end



@implementation AppController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight;
}
#ifdef __IPHONE_6_0
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}
#endif

@end



@interface HTML5AppDelegate : UIResponder <UIApplicationDelegate, UIWebViewDelegate>

@end



@implementation HTML5AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIWebView *webview = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	webview.delegate = self;
    
	//`html` folder in xcode should be blue
    NSString *path = [[NSBundle mainBundle] pathForResource:@"html/index" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseUrl = [NSURL fileURLWithPath:[path stringByDeletingLastPathComponent] isDirectory:YES];
    
	[webview loadHTMLString:html baseURL:baseUrl];
	
	//prevent zooming
    webview.scalesPageToFit = NO;
	//prevent bouncing
    webview.scrollView.bounces = NO;
    
	//set to landscape mode
    CGAffineTransform rotation = CGAffineTransformMakeRotation(M_PI_2);
    webview.transform = rotation;
    webview.bounds = CGRectMake(0,0,1024,768);
    
    UIViewController *controller = [[AppController alloc] init];
    self.window.rootViewController = controller;
    controller.view = webview;
	
    [window makeKeyAndVisible];
    return YES;
}

//if you want links to open in safari
- (BOOL)webView:(UIWebView *)view shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)type
{
    if (type == UIWebViewNavigationTypeLinkClicked) {
        [[UIApplication sharedApplication] openURL:[request URL]];
        return NO;
    }
    return YES;
}

@end



int main(int argc, char *argv[])
{
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
