#import "OverlayAppDelegate.h"
#import "OverlayViewController.h"

@implementation OverlayAppDelegate


@synthesize window;

@synthesize viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  [[self window] setRootViewController:[self viewController]];
  [[self window] makeKeyAndVisible];
  return YES;
}

@end
