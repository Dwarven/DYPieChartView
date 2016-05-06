//
//  ViewController.m
//  PieChart
//
//  Created by Dwarven on 16/5/5.
//  Copyright © 2016年 Dwarven. All rights reserved.
//

#import "ViewController.h"
#import "DYPieChartView.h"

#define MakeColor(r, g, b) [UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:1.0f]

@interface ViewController () {
    DYPieChartView * _pieChartView;
    NSInteger _index;
    NSArray * _array;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _array = @[@[@(0.4), @(0.35), @(0.25), @(0.0), @(0.0)],
               @[@(0.1), @(0.2), @(0.3), @(0.25), @(0.15)],
               @[@(0.3), @(0.35), @(0.25), @(0.0), @(0.0)],
               @[@(0.0), @(0.0), @(0.0), @(0.0), @(0.0)]];
    
    CGFloat size = 300;
    
    _pieChartView = [[DYPieChartView alloc] initWithFrame:CGRectMake(0, 0, size, size)];
//    _pieChartView.backgroundColor = [UIColor lightGrayColor];
    _pieChartView.startAngle = -M_PI/2;
    _pieChartView.clockwise = NO;
    _pieChartView.center = self.view.center;
    _pieChartView.sectorColors = @[MakeColor(120, 110, 230),
                                  MakeColor(110, 240, 190),
                                  MakeColor(10, 220, 230),
                                  MakeColor(240, 140, 10),
                                  MakeColor(230, 10, 100)
                                  ];
    
    
    [self.view addSubview:_pieChartView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    switch (_index) {
        case 0:
        case 1:
        case 2:
            [_pieChartView animateToScaleValues:_array[_index] duration:2];
            _index++;
            break;
            
        default:
            [_pieChartView setScaleValues:_array[_index]];
            _index = 0;
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
