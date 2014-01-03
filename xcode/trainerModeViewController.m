//
//  domination.m
//  climbing_bluetooth
//
//  Created by Morten Ydefeldt on 08/12/13.
//  Copyright (c) 2013 Morten Ydefeldt. All rights reserved.
//

#import "trainerModeViewController.h"

@interface trainerModeViewController ()

@end

@implementation trainerModeViewController
@synthesize labels, startPoint;

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
    
    gameController* localGameController = [gameController getInstance];
    [localGameController setDelegate:self];
	buttons = [localGameController getPlayableButtons];
    labels = [[NSMutableDictionary alloc]init];
    
	// Do any additional setup after loading the view.
    
    CGRect parentRect = self.view.bounds;
    parentRect = _graphHostingView.frame;

    _graphHostingView.allowPinchScaling = YES;
    
    CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:_graphHostingView.bounds];
    _graphHostingView.hostedGraph = graph;
    graph.title = @"TITLELELEL";
    
    CPTScatterPlot *ScatterPlot = [[CPTScatterPlot alloc]init];
    
    
    ScatterPlot.dataSource = self;
    ScatterPlot.delegate = self;
    
    //plot line style
    CPTMutableLineStyle *lineStyle = [[CPTMutableLineStyle alloc]init];
    lineStyle.lineColor = [CPTColor redColor];
    
    //plot symbol style
    CPTPlotSymbol *graphSymbolStyle = [CPTPlotSymbol ellipsePlotSymbol];
    
    //add styles to plot
    ScatterPlot.plotSymbol = graphSymbolStyle;
    ScatterPlot.dataLineStyle = lineStyle;

    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
    plotSpace.allowsUserInteraction = YES;
    
    [graph addPlot:ScatterPlot toPlotSpace:plotSpace];
    


    
}

- (NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot {

    NSLog(@"NumberOfRecord");
    return 5;
    
}

- (NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)idx {
    switch (fieldEnum) {
        case 0:
            return [NSNumber numberWithInt:idx*2];
            break;
        case 1:
            return [NSNumber numberWithInt:idx];
            break;
        default:
            NSLog(@"Error no data");
            return nil;
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startTime:(id)sender {
    
    
}

-(void)buttonPressed:(button *)button {
    
    
}

-(void)newButtonAttatched:(button *)button buttons:(NSDictionary *)avalibleButtons{
    
}

-(void)connectionStatusChanged:(BOOL)isConnected{
}

@end