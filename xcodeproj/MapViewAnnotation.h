//
//  MapViewAnnotation.h
//  TestmunkDemo
//
//  Created by Syed Kashif Zaidi on 10/22/13.
//  Copyright (c) 2013 Andrea Mazzini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface MapViewAnnotation : NSObject <MKAnnotation> {
    
	NSString *title;
	CLLocationCoordinate2D coordinate;
    
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithTitle:(NSString *)ttl andCoordinate:(CLLocationCoordinate2D)c2d;

@end
