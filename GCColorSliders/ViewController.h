//
//  ViewController.h
//  GCColorSliders
//
//  Created by Emir on 31/08/2019.
//  Copyright © 2019 GeneCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCColorSliders/GCColorSliders.h"

@interface ViewController : UIViewController <GCColorSlidersDelegate>


@property (nonatomic, weak) IBOutlet UIView *sliderView;
@property (nonatomic, assign) BOOL runOnce;

@end

