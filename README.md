# DYPieChartView

[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/DYPieChartView.svg)](https://img.shields.io/cocoapods/v/DYPieChartView.svg)
[![Platform](https://img.shields.io/cocoapods/p/DYPieChartView.svg)](http://cocoadocs.org/docsets/DYPieChartView)
[![Twitter](https://img.shields.io/badge/twitter-@DwarvenYang-blue.svg)](http://twitter.com/DwarvenYang)
[![License](https://img.shields.io/github/license/Dwarven/DYPieChartView.svg)](https://img.shields.io/github/license/Dwarven/DYPieChartView.svg)

Animated Pie Chart using Custom CALayer.

#Preview
![Demo Gif](https://raw.githubusercontent.com/Dwarven/DYPieChartView/master/demo.gif)

# Podfile
To integrate DYPieChartView into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'DYPieChartView'
```

# How to use 

```obj-c
#import "DYPieChartView.h"

#define MakeColor(r, g, b) [UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:1.0f]

#pragma mark - init and setup DYPieChartView
_pieChartView = [[DYPieChartView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
//_pieChartView.backgroundColor = [UIColor lightGrayColor];
_pieChartView.startAngle = -M_PI/2;
_pieChartView.clockwise = NO;
_pieChartView.center = self.view.center;
_pieChartView.sectorColors = @[MakeColor(120, 110, 230),
                               MakeColor(110, 240, 190),
                               MakeColor(10, 220, 230),
                               MakeColor(240, 140, 10),
                               MakeColor(230, 10, 100)];
[self.view addSubview:_pieChartView];

#pragma mark - animations
//type 1: for duration
[_pieChartView animateToScaleValues:@[@(0.4), @(0.35), @(0.25), @(0.0), @(0.0)]
                           duration:2];
//type 2: quickly
[_pieChartView setScaleValues:@[@(0.4), @(0.35), @(0.25), @(0.0), @(0.0)];
```

