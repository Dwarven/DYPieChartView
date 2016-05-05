//
//  DYPieChartView.h
//  DYPieChartView
//
//  Created by Dwarven on 16/5/5.
//  Copyright © 2016 Dwarven Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYPieChartView : UIView

/**
*  An array of float values to define the values of each sector of the pie-chart.
*  e.g. @[@(0.4), @(0.35), @(0.25), @(0.0), @(0.0)]
*/
@property (nonatomic) NSArray* scaleValues;

/**
 *  An array of UIColors to define the colors of the sectors.
 */
@property (nonatomic) NSArray* sectorColors;

/**
 *  Specifies the starting angle of the arc (measured in radians).
 */
@property (nonatomic) CGFloat startAngle;

/**
 *  The direction in which to draw the arc.
 */
@property (nonatomic) BOOL clockwise;

/**
 *  Animates the scale values from their current values to a new set of values.
 */
- (void)animateToScaleValues:(NSArray*)scaleValues duration:(CGFloat)duration;

@end
