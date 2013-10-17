#import <UIKit/UIKit.h>
#import <ArcGIS/ArcGIS.h>

@interface MapCompassCameraViewController : UIViewController {
	AGSMapView *_mapView;
    UISegmentedControl *_autoPanModeControl;
    UILabel *_label;
    UIImageView *_northArrowImage;
}
@property (nonatomic, strong) IBOutlet UILabel *label;
@property (nonatomic, strong) IBOutlet UIImageView *northArrowImage;

@property (nonatomic, strong) IBOutlet UISegmentedControl *autoPanModeControl;
@property (nonatomic, strong) IBOutlet AGSMapView *mapView;
- (IBAction)autoPanModeChanged:(id)sender;

@end

