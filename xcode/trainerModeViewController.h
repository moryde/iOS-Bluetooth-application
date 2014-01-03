//
//  domination.h
//  climbing_bluetooth
//
//  Created by Morten Ydefeldt on 08/12/13.
//  Copyright (c) 2013 Morten Ydefeldt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CorePlot/CorePlot-CocoaTouch.h>
#import "gameController.h"

@interface trainerModeViewController : UIViewController <gameControllerDelegate, CPTScatterPlotDataSource, CPTScatterPlotDelegate> {
    
    NSDate *startTime;
    NSMutableDictionary *buttons;
    NSMutableDictionary *labels;
    NSTimer *uiTimer;
    CGPoint startPoint;
    
}
@property (nonatomic) NSMutableDictionary *labels;
@property (nonatomic) CGPoint startPoint;

@property (weak, nonatomic) IBOutlet CPTGraphHostingView *graphHostingView;


- (IBAction)startTime:(id)sender;


@end
