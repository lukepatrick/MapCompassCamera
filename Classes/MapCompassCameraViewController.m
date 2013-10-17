#import "MapCompassCameraViewController.h"

@implementation MapCompassCameraViewController

@synthesize label = _label;
@synthesize northArrowImage = _northArrowImage;
@synthesize autoPanModeControl = _autoPanModeControl;
@synthesize mapView=_mapView;

#pragma mark - UIViewController methods

- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSURL *mapUrl = [NSURL URLWithString:@"http://services.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer"];
	AGSTiledMapServiceLayer *tiledLyr = [AGSTiledMapServiceLayer tiledMapServiceLayerWithURL:mapUrl];
    //you don't want a basemap, then you couldn't see through to the camera
    //[self.mapView addMapLayer:tiledLyr withName:@"Tiled Layer"];
    
    NSURL *netmapUrl = [NSURL URLWithString:@""]; // your map resource, typically points or lines
	AGSDynamicMapServiceLayer *netLyr = [AGSDynamicMapServiceLayer dynamicMapServiceLayerWithURL:netmapUrl];
    [netLyr setImageFormat:AGSImageFormatPNG32];
    
	[self.mapView addMapLayer:netLyr withName:@"Network Layer"];
    UIColor *background = [UIColor clearColor];
    [self.mapView setBackgroundColor: background];
    [self.mapView setGridLineColor:background];
    [self.mapView setGridSize:0];
	
    //Listen to KVO notifications for map gps's autoPanMode property
    [self.mapView.locationDisplay addObserver:self
                       forKeyPath:@"autoPanMode"
                          options:(NSKeyValueObservingOptionNew)
                          context:NULL];
    
    //Listen to KVO notifications for map rotationAngle property
    [self.mapView addObserver:self
                   forKeyPath:@"rotationAngle"
                      options:(NSKeyValueObservingOptionNew)
                      context:NULL];


}


- (void)observeValueForKeyPath:(NSString *)keyPath
					  ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {

    //if autoPanMode changed
    if ([keyPath isEqual:@"autoPanMode"]){

        //Update the label to reflect which autoPanMode is active
        NSString* mode;
        switch (self.mapView.locationDisplay.autoPanMode) {
            case AGSLocationDisplayAutoPanModeOff:
                mode = @"Off";
                self.label.textColor = [UIColor redColor];
                break;
            case AGSLocationDisplayAutoPanModeDefault:
                mode = @"Default";
                self.label.textColor = [UIColor blueColor];
                break;
            case AGSLocationDisplayAutoPanModeNavigation:
                mode = @"Navigation";
                self.label.textColor = [UIColor blueColor];
                break;
            case AGSLocationDisplayAutoPanModeCompassNavigation:
                mode = @"Compass Navigation";
                self.label.textColor = [UIColor blueColor];
                break;
                
            default:
                break;
        }
        self.label.text = [NSString stringWithFormat:@"AutoPan Mode: %@",mode];

        //Un-select the segments when autoPanMode changes to OFF
        //Also, restore north-up map rotation
        if(self.mapView.locationDisplay.autoPanMode == AGSLocationDisplayAutoPanModeOff){
            [self.autoPanModeControl setSelectedSegmentIndex:-1];
        }
        
        //Also, restore north-up map rotation if Auto pan goes OFF or back to Default
        if(self.mapView.locationDisplay.autoPanMode == AGSLocationDisplayAutoPanModeOff || self.mapView.locationDisplay.autoPanMode == AGSLocationDisplayAutoPanModeDefault){
            [self.mapView setRotationAngle:0 animated:YES];
        }
    
    
    } 
    //if rotationAngle changed
    else if([keyPath isEqual:@"rotationAngle"]){
        CGAffineTransform transform = CGAffineTransformMakeRotation(-(self.mapView.rotationAngle*3.14)/180);
        [self.northArrowImage setTransform:transform]; 
    } 
    
    //if mapscale changed
    else if([keyPath isEqual:@"mapScale"]){
        if(self.mapView.mapScale < 5000) {
            [self.mapView zoomToScale:50000 withCenterPoint:nil animated:YES];
            [self.mapView removeObserver:self forKeyPath:@"mapScale"];
        }
    }

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    //Pass the interface orientation on to the map's gps so that
    //it can re-position the gps symbol appropriately in 
    //compass navigation mode
    self.mapView.locationDisplay.interfaceOrientation = interfaceOrientation;
    return YES;
}


- (void)viewDidUnload {
    //Stop the GPS, undo the map rotation (if any)
    if(self.mapView.locationDisplay.dataSourceStarted){
        [self.mapView.locationDisplay stopDataSource];
        self.mapView.rotationAngle = 0;
        [self.autoPanModeControl setSelectedSegmentIndex:-1];
    }
    self.mapView = nil;
    self.autoPanModeControl = nil;
    self.label = nil;
    self.northArrowImage = nil;
}



#pragma mark - Action methods


- (IBAction)autoPanModeChanged:(id)sender {
    //Start the map's gps if it isn't enabled already
    if(!self.mapView.locationDisplay.dataSourceStarted)
        [self.mapView.locationDisplay startDataSource];
    
    //Listen to KVO notifications for map scale property
    [self.mapView addObserver:self
                   forKeyPath:@"mapScale"
                      options:(NSKeyValueObservingOptionNew)
                      context:NULL];
    
    
    //Set the appropriate AutoPan mode
    switch (self.autoPanModeControl.selectedSegmentIndex) {
        case 0:
            self.mapView.locationDisplay.autoPanMode = AGSLocationDisplayAutoPanModeDefault;
            //Set a wander extent equal to 75% of the map's envelope
            //The map will re-center on the location symbol only when
            //the symbol moves out of the wander extent
			self.mapView.locationDisplay.wanderExtentFactor = 0.75;
            break;
        case 1:
            self.mapView.locationDisplay.autoPanMode = AGSLocationDisplayAutoPanModeNavigation;
            //Position the location symbol near the bottom of the map
            //A value of 1 positions it at the top edge, and 0 at bottom edge
			self.mapView.locationDisplay.navigationPointHeightFactor = 0.15;
            break;
        case 2:
            self.mapView.locationDisplay.autoPanMode = AGSLocationDisplayAutoPanModeCompassNavigation;
            //Position the location symbol in the center of the map
			self.mapView.locationDisplay.navigationPointHeightFactor = 0.5;
            break;
            
        default:
            break;
    }
}




@end
