#import "OverlayViewController.h"

@implementation OverlayViewController

@synthesize captureManager;

- (void)viewDidLoad {
  
	[self setCaptureManager:[[CaptureSessionManager alloc] init] ];
  
	[[self captureManager] addVideoInput];
  
	[[self captureManager] addVideoPreviewLayer];
	CGRect layerRect = [[[self view] layer] bounds];
	[[[self captureManager] previewLayer] setBounds:layerRect];
	[[[self captureManager] previewLayer] setPosition:CGPointMake(CGRectGetMidX(layerRect),
                                                                CGRectGetMidY(layerRect))];
	[[[self view] layer] addSublayer:[[self captureManager] previewLayer]];
  
  
	[[captureManager captureSession] startRunning];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

@end

