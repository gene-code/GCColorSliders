//
//  ViewController.m
//  GCColorSliders
//
//  Created by Emir on 31/08/2019.
//  Copyright © 2019 GeneCode. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    
    _runOnce = YES;
}


-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (_runOnce) {
        _runOnce = NO;
        self.gcSliders = [[GCColorSliders alloc] initWithFrame:self.sliderView.frame andType:GCSLIDER_VERTICAL];
        [self.view addSubview:self.gcSliders];
        [self.gcSliders setBackgroundColor:[UIColor darkGrayColor]];
        
        
        GCColorSliders *gcSliders2 = [[GCColorSliders alloc] initWithFrame:self.sliderView.frame andType:GCSLIDER_HORIZONTAL];
        [self.view addSubview:gcSliders2];
        [gcSliders2 setBackgroundColor:[UIColor darkGrayColor]];
        
        gcSliders2.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0 + 200);
    }
    
}

@end
