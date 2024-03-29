//
//  GCColorSliders.h
//  GCColorSliders
//
//  Created by Emir on 31/08/2019.
//  Copyright © 2019 GeneCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

#define GCSLIDER_VERTICAL 1
#define GCSLIDER_HORIZONTAL 2

@protocol GCColorSlidersDelegate <NSObject>
@required
-(void)GCColorSlidersColorSelected:(UIColor*)selectedColor;
@end

@interface GCColorSliders : UIView

@property (nonatomic, assign) int sliderType;
@property (nonatomic, strong) UIColor *themeColor;
@property (nonatomic, strong) id delegate;

-(id)initWithFrame:(CGRect)frame andType:(int)type andTheme:(UIColor*)color;
-(void)adjHSL:(UISlider *)slider;
-(UIImage *)drawSatSliderImage:(UISlider*)slider withHue:(CGFloat)hue withBright:(CGFloat)bright;
-(UIImage *)drawBrightSliderImage:(UISlider*)slider withHue:(CGFloat)hue withSat:(CGFloat)sat;
-(UIImage *)drawHueSliderImage:(CGRect)fram;



@end

NS_ASSUME_NONNULL_END
