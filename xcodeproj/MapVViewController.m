//
//  MapVViewController.m
//  TestmunkDemo
//
//  Created by Syed Kashif Zaidi on 10/22/13.
//  Copyright (c) 2013 Andrea Mazzini. All rights reserved.
//

#import "MapVViewController.h"
#import "MapViewAnnotation.h"

@interface MapVViewController ()

@end

@implementation MapVViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	CLLocationCoordinate2D location;
	location.latitude = (double) 37.33168400;
	location.longitude = (double) -122.03175800;
    
	// Add the annotation to our map view
	MapViewAnnotation *newAnnotation = [[MapViewAnnotation alloc] initWithTitle:@"1 Infinite Loop" andCoordinate:location];
	[self.mapView addAnnotation:newAnnotation];
    
    MKCoordinateSpan span =
    { .longitudeDelta = 0,
        .latitudeDelta  = 0 };
    
    // Create a new MKMapRegion with the new span, using the center we want.
    MKCoordinateRegion region = { .center = location, .span = span };
    [self.mapView setRegion:region animated:YES];

}

// When a map annotation point is added, zoom to it (1500 range)
- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views
{
	MKAnnotationView *annotationView = [views objectAtIndex:0];
	id <MKAnnotation> mp = [annotationView annotation];
	MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([mp coordinate], 1500, 1500);
	[mv setRegion:region animated:YES];
	[mv selectAnnotation:mp animated:YES];
}

// Received memory warning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// If the view unloads, release the map view
- (void)viewDidUnload {
	[super viewDidUnload];
}

@end
