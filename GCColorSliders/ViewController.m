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
        GCColorSliders *gcSliders1 = [[GCColorSliders alloc] initWithFrame:self.sliderView.frame
                                                                   andType:GCSLIDER_VERTICAL
                                                                   andTheme:[UIColor orangeColor]];
        [self.view addSubview:gcSliders1];
        gcSliders1.delegate = self;
        [gcSliders1 setBackgroundColor:[UIColor darkGrayColor]];

        GCColorSliders *gcSliders2 = [[GCColorSliders alloc] initWithFrame:self.sliderView.frame
                                                                   andType:GCSLIDER_HORIZONTAL
                                                                    andTheme:[UIColor cyanColor]];
        [self.view addSubview:gcSliders2];
        gcSliders2.delegate = self;
        [gcSliders2 setBackgroundColor:[UIColor darkGrayColor]];
        
        gcSliders2.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0 + 150);
    }
    
}

-(void)GCColorSlidersColorSelected:(UIColor *)selectedColor {
    
    self.view.backgroundColor = selectedColor;
}



@end
