//
//  DYPieChartView.m
//  DYPieChartView
//
//  Created by Dwarven on 16/5/5.
//  Copyright © 2016 Dwarven Yang. All rights reserved.
//

#import "DYPieChartView.h"

@interface DYPieChartView () {
    NSMutableArray * _sectorLayers;
    NSArray * _cumulativeSectorValues;
}

@end

@implementation DYPieChartView

- (id)init {
    self = [super init];
    if (self) {
        [self setupForInitialization];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupForInitialization];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupForInitialization];
    }
    return self;
}

- (void)setupForInitialization {
    self.clockwise = YES;
    _sectorLayers = [NSMutableArray array];
    if (!self.backgroundColor) {
        self.backgroundColor = [UIColor whiteColor];
    }
}

- (void)populateSectorLayers {
    [self calculateCumulativeValues];
    
    while (_sectorLayers.count > _scaleValues.count) {
        [(CAShapeLayer*)[_sectorLayers lastObject] removeFromSuperlayer];
        [_sectorLayers removeLastObject];
    }
    
    CGFloat radius = self.bounds.size.width*0.5;
    UIBezierPath *sectorLayerPath = [UIBezierPath bezierPathWithArcCenter:(CGPoint){radius, radius} radius:radius/2 startAngle:_startAngle endAngle:_clockwise?_startAngle+M_PI*2:_startAngle-M_PI*2 clockwise:_clockwise];
    for (CAShapeLayer* s in _sectorLayers) {
        s.path = sectorLayerPath.CGPath;
        s.lineWidth = radius;
    }
    
    NSUInteger colorCount = _sectorColors.count;
    NSUInteger sectorLayerCount = _sectorLayers.count;
    while (sectorLayerCount < _scaleValues.count) {
        CAShapeLayer* sectorLayer = [CAShapeLayer layer];
        sectorLayer.path = sectorLayerPath.CGPath;
        sectorLayer.fillColor = [UIColor clearColor].CGColor;
        sectorLayer.lineWidth = radius;
        sectorLayer.strokeColor = (sectorLayerCount < colorCount)?((UIColor*)_sectorColors[sectorLayerCount]).CGColor:[UIColor clearColor].CGColor;
        if (sectorLayerCount != 0) {
            CAShapeLayer* previousLayer = _sectorLayers[sectorLayerCount-1];
            sectorLayer.strokeStart = previousLayer.strokeEnd;
            sectorLayer.strokeEnd = previousLayer.strokeEnd;
        } else {
            sectorLayer.strokeEnd = 0.0;
        }
        [self.layer insertSublayer:sectorLayer atIndex:0];
        [_sectorLayers addObject:sectorLayer];
        sectorLayerCount++;
    }
}

- (void)updateSectorStrokeValues {
    NSUInteger i = 0;
    for (CAShapeLayer* s in _sectorLayers) {
        s.strokeStart = [_cumulativeSectorValues[i] floatValue];
        i++;
        s.strokeEnd = [_cumulativeSectorValues[i] floatValue];
    }
}

- (void)animateToScaleValues:(NSArray *)scaleValues duration:(CGFloat)duration {
    _scaleValues = scaleValues;
    [self populateSectorLayers];
    
    CABasicAnimation* strokeAnim = [CABasicAnimation animation];
    strokeAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    strokeAnim.duration = duration;
    for (int i = 0; i < _sectorLayers.count; i++) {
        CAShapeLayer* s = _sectorLayers[i];
        if (i != 0) [s addAnimation:strokeAnim forKey:@"startStrokeAnim"];
        strokeAnim.keyPath = @"strokeEnd";
        strokeAnim.fromValue = @(s.strokeEnd);
        strokeAnim.toValue = @([_cumulativeSectorValues[i+1] floatValue]);
        [s addAnimation:strokeAnim forKey:@"endStrokeAnim"];
        strokeAnim.keyPath = @"strokeStart";
    }
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [self updateSectorStrokeValues];
    [CATransaction commit];
}

- (void)setSectorColors:(NSArray *)sectorColors {
    _sectorColors = sectorColors;
    for (int i = 0; i < _sectorLayers.count; i++) {
        ((CAShapeLayer*)_sectorLayers[i]).strokeColor = ((UIColor*)_sectorColors[i]).CGColor;
    }
}

- (void)setScaleValues:(NSArray *)scaleValues {
    _scaleValues = scaleValues;
    [self populateSectorLayers];
    [self updateSectorStrokeValues];
}

- (void)calculateCumulativeValues {
    NSMutableArray* cumulativeValues = [@[@(0.0)] mutableCopy];
    CGFloat cumulativeValue = 0;
    for (NSNumber* n in _scaleValues) {
        cumulativeValue += [n floatValue];
        [cumulativeValues addObject:[NSNumber numberWithFloat:cumulativeValue]];
    }
    _cumulativeSectorValues = [cumulativeValues copy];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self.layer setCornerRadius:self.bounds.size.width/2];
    [self.layer setMasksToBounds:YES];
}

@end
