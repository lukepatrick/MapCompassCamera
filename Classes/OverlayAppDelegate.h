#import <UIKit/UIKit.h>

@class OverlayViewController;

@interface OverlayAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet OverlayViewController *viewController;

@end
