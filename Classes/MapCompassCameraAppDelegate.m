#import "MapCompassCameraAppDelegate.h"
#import "MapCompassCameraViewController.h"

@implementation MapCompassCameraAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window setRootViewController:viewController];
    [window makeKeyAndVisible];
}




@end
