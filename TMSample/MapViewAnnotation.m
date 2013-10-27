//
//  MapViewAnnotation.m
//  TestmunkDemo
//
//  Created by Syed Kashif Zaidi on 10/22/13.
//  Copyright (c) 2013 Andrea Mazzini. All rights reserved.
//

#import "MapViewAnnotation.h"

@implementation MapViewAnnotation

@synthesize title, coordinate;

- (id)initWithTitle:(NSString *)ttl andCoordinate:(CLLocationCoordinate2D)c2d
{
	self = [super init];
    if(self){
        title = ttl;
        coordinate = c2d;
            }
    return self;
}

@end
