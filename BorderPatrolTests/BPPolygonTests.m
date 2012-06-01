//
//  BPPolygonTests.m
//  BorderPatrol
//
//  Created by Jim Puls on 5/30/12.
//  Copyright (c) 2012 Square, Inc. All rights reserved.
//

#import "BPPolygonTests.h"
#import "BPPolygon.h"

@implementation BPPolygonTests {
    BPPolygon *testPolygon;
}

- (void)setUp;
{
    CLLocationCoordinate2D coordinates[3] = {
        CLLocationCoordinate2DMake(-10, 0),
        CLLocationCoordinate2DMake(10, 0),
        CLLocationCoordinate2DMake(0, 10)
    };
    testPolygon = [BPPolygon polygonWithCoordinates:coordinates count:3];
}

- (void)testContainsCoordinateInPolygon;
{
    STAssertTrue([testPolygon containsCoordinate:CLLocationCoordinate2DMake(0.5, 0.5)], @"Should contain coordinate");
    STAssertTrue([testPolygon containsCoordinate:CLLocationCoordinate2DMake(0, 5)], @"Should contain coordinate");
    STAssertTrue([testPolygon containsCoordinate:CLLocationCoordinate2DMake(-1, 3)], @"Should contain coordinate");
}

- (void)testContainsCoordinateOnSlopes;
{
    STAssertTrue([testPolygon containsCoordinate:CLLocationCoordinate2DMake(5, 5)], @"Should contain coordinate");
    STAssertTrue([testPolygon containsCoordinate:CLLocationCoordinate2DMake(4.999999, 4.999999)], @"Should contain coordinate");
    STAssertFalse([testPolygon containsCoordinate:CLLocationCoordinate2DMake(5.000001, 5.000001)], @"Should not contain coordinate");
    STAssertTrue([testPolygon containsCoordinate:CLLocationCoordinate2DMake(0, 0)], @"Should contain coordinate");
    STAssertTrue([testPolygon containsCoordinate:CLLocationCoordinate2DMake(0.000001, 0.000001)], @"Should contain coordinate");
    STAssertFalse([testPolygon containsCoordinate:CLLocationCoordinate2DMake(-0.000001, -0.000001)], @"Should not contain coordinate");
}

- (void)testContainsCoordinateOnVertices;
{
    STAssertTrue([testPolygon containsCoordinate:CLLocationCoordinate2DMake(-10, 0)], @"Should contain coordinate");
    STAssertTrue([testPolygon containsCoordinate:CLLocationCoordinate2DMake(0, 10)], @"Should contain coordinate");
    STAssertTrue([testPolygon containsCoordinate:CLLocationCoordinate2DMake(10, 0)], @"Should contain coordinate");
}

- (void)testExcludesCoordinateOutsidePolygon;
{
    STAssertFalse([testPolygon containsCoordinate:CLLocationCoordinate2DMake(9, 5)], @"Should not contain coordinate");
    STAssertFalse([testPolygon containsCoordinate:CLLocationCoordinate2DMake(-5, 8)], @"Should not contain coordinate");
    STAssertFalse([testPolygon containsCoordinate:CLLocationCoordinate2DMake(-10, -1)], @"Should not contain coordinate");
    STAssertFalse([testPolygon containsCoordinate:CLLocationCoordinate2DMake(-20, -20)], @"Should not contain coordinate");
}

- (void)testCoordinatesOnFunkyShapes;
{
    CLLocationCoordinate2D coordinates[8] = {
        CLLocationCoordinate2DMake(0, -15),
        CLLocationCoordinate2DMake(10, -15),
        CLLocationCoordinate2DMake(10, -5),
        CLLocationCoordinate2DMake(20, -5),
        CLLocationCoordinate2DMake(20, 5),
        CLLocationCoordinate2DMake(10, 5),
        CLLocationCoordinate2DMake(10, 15),
        CLLocationCoordinate2DMake(0, 15)
    };
    BPPolygon *otherTestPolygon = [BPPolygon polygonWithCoordinates:coordinates count:8];
    
    STAssertTrue([otherTestPolygon containsCoordinate:CLLocationCoordinate2DMake(5, 5)], @"Should contain coordinate");
    STAssertFalse([otherTestPolygon containsCoordinate:CLLocationCoordinate2DMake(15, -10)], @"Should not contain coordinate");
    STAssertFalse([otherTestPolygon containsCoordinate:CLLocationCoordinate2DMake(5, -20)], @"Should not contain coordinate");
    STAssertFalse([otherTestPolygon containsCoordinate:CLLocationCoordinate2DMake(20, -15)], @"Should not contain coordinate");
}

@end
