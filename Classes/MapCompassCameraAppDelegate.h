#import <UIKit/UIKit.h>

@class MapCompassCameraViewController;

@interface MapCompassCameraAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MapCompassCameraViewController *viewController;
}

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong) IBOutlet MapCompassCameraViewController *viewController;

@end

