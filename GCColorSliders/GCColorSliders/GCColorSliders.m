//
//  GCColorSliders.m
//  GCColorSliders
//
//  Created by Emir on 31/08/2019.
//  Copyright © 2019 GeneCode. All rights reserved.
//

#import "GCColorSliders.h"

@implementation GCColorSliders

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)adjHSL:(UISlider *)slider {
    
    
    CGFloat h = 0;
    CGFloat s = 1;
    CGFloat l = 1;
    
    BOOL hueAdjusted = NO;
    for (UIView *subview in self.subviews) {
        if  ([subview isKindOfClass:[UISlider class]]) {
            UISlider *sli = (UISlider*)subview;
            
            if (sli.tag==1) {
                h = sli.value;
                // update the saturation slider image
                hueAdjusted = YES;
            }
            if (sli.tag==2) s = sli.value;
            if (sli.tag==3) l = sli.value;
        }
    }

    if (hueAdjusted) {
        for (UIView *subview in self.subviews) {
            if  ([subview isKindOfClass:[UISlider class]]) {
                UISlider *sli = (UISlider*)subview;
                if (sli.tag==2) {
                    UIImage *trackImg = [[self drawSatSliderImage:sli withHue:h withBright:l] stretchableImageWithLeftCapWidth:14.0 topCapHeight:0.0];
                    [sli setMaximumTrackImage:trackImg forState:UIControlStateNormal];
                    [sli setMinimumTrackImage:trackImg forState:UIControlStateNormal];
                }
                if (sli.tag==3) {
                    UIImage *trackImg = [[self drawBrightSliderImage:sli withHue:h withSat:s] stretchableImageWithLeftCapWidth:14.0 topCapHeight:0.0];
                    [sli setMaximumTrackImage:trackImg forState:UIControlStateNormal];
                    [sli setMinimumTrackImage:trackImg forState:UIControlStateNormal];
                }
            }
        }
    }
    
    
    if (_delegate) {
        UIColor *color = [UIColor colorWithHue:h saturation:s brightness:l alpha:1.0];
        [self.delegate GCColorSlidersColorSelected:color];
    }

}


-(UIImage *)drawHueSliderImage:(CGRect)fram  {
    
    // Create a gradient from hue to hue
    UIImage *res = nil;
    CGSize btnSize = CGSizeMake(fram.size.width, fram.size.height);
    UIGraphicsBeginImageContext(CGSizeMake(100, 100));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    UIGraphicsBeginImageContextWithOptions(btnSize, YES, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [image drawInRect:CGRectMake(0, 0, btnSize.width, btnSize.height)];
    
    /* STANDARD HUE PALLETE
     <GradientStop Color="#FFFF0000" />
     <GradientStop Color="#FEFFFF00" Offset="0.167" />
     <GradientStop Color="#FE00FF00" Offset="0.333" />
     <GradientStop Color="#FE00FFFF" Offset="0.5" />
     <GradientStop Color="#FE0000FF" Offset="0.667" />
     <GradientStop Color="#FEFF00FF" Offset="0.833" />
     <GradientStop Color="#FFFF0000" Offset="1.0" />
     */
    
    CGGradientRef glossGradient;
    CGColorSpaceRef rgbColorspace;
    size_t num_locations = 7;
    CGFloat locations[7] = { 0.0, 0.167, 0.333, 0.5, 0.667, 0.833, 1.0 };
    CGFloat components [] = {
        1.0, 0.0, 0.0, 1.0,
        1.0, 1.0, 0.0, 1.0,
        0.0, 1.0, 0.0, 1.0,
        0.0, 1.0, 1.0, 1.0,
        0.0, 0.0, 1.0, 1.0,
        1.0, 0.0, 1.0, 1.0,
        1.0, 0.0, 0.0, 1.0
    };
    
    rgbColorspace = CGColorSpaceCreateDeviceRGB();
    glossGradient = CGGradientCreateWithColorComponents(rgbColorspace, components, locations, num_locations);
    CGRect currentBounds = fram;
    CGPoint startPt = CGPointMake(0, CGRectGetMidY(currentBounds));
    CGPoint endPt = CGPointMake(CGRectGetMaxX(currentBounds), CGRectGetMidY(currentBounds));
    CGContextDrawLinearGradient(context, glossGradient, startPt, endPt, 0);
    CGGradientRelease(glossGradient);
    CGColorSpaceRelease(rgbColorspace);
    res =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  res;
}

-(UIImage *)drawBrightSliderImage:(UISlider*)slider withHue:(CGFloat)hue withSat:(CGFloat)sat{
    
    // Create a gradient from white to red
    UIImage *res = nil;
    CGSize btnSize = CGSizeMake(slider.frame.size.width, slider.frame.size.height);
    
    if (self.sliderType == GCSLIDER_VERTICAL) btnSize = CGSizeMake(slider.frame.size.height, slider.frame.size.width);
    
    UIGraphicsBeginImageContext(CGSizeMake(100, 100));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContextWithOptions(btnSize, YES, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [image drawInRect:CGRectMake(0, 0, btnSize.width, btnSize.height)];
    
    UIColor *selectedBright = [UIColor colorWithHue:hue saturation:sat brightness:1.0 alpha:1.0];
    UIColor *lowBrightClr = [UIColor colorWithHue:hue saturation:sat brightness:0.0 alpha:1.0];

    CGFloat red, green, blue, alpha;
    if ( [selectedBright getRed: &red green: &green blue: &blue alpha: &alpha] ) {
        // color converted
    }
    
    CGFloat red2, green2, blue2, alpha2;
    if ( [lowBrightClr getRed: &red2 green: &green2 blue: &blue2 alpha: &alpha2] ) {
        // color converted
    }
    
    CGGradientRef glossGradient;
    CGColorSpaceRef rgbColorspace;
    size_t num_locations = 2;
    CGFloat locations[4] = { 0.0, 1.0 };
    CGFloat components [] = {
        red2, green2, blue2, 1.0,
        red, green, blue, 1.0
    };
    
    rgbColorspace = CGColorSpaceCreateDeviceRGB();
    glossGradient = CGGradientCreateWithColorComponents(rgbColorspace, components, locations, num_locations);
    CGRect currentBounds = slider.bounds;
    CGPoint startPt = CGPointMake(0, CGRectGetMidY(currentBounds));
    CGPoint endPt = CGPointMake(CGRectGetMaxX(currentBounds), CGRectGetMidY(currentBounds));
    CGContextDrawLinearGradient(context, glossGradient, startPt, endPt, 0);
    CGGradientRelease(glossGradient);
    CGColorSpaceRelease(rgbColorspace);
    res =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  res;
    
}

-(UIImage *)drawSatSliderImage:(UISlider*)slider withHue:(CGFloat)hue withBright:(CGFloat)bright{
    
    // Create a gradient from hue to gray
    UIImage *res = nil;
    CGSize btnSize = CGSizeMake(slider.frame.size.width, slider.frame.size.height);
    if (self.sliderType == GCSLIDER_VERTICAL) btnSize = CGSizeMake(slider.frame.size.height, slider.frame.size.width);
    
    UIGraphicsBeginImageContext(CGSizeMake(100, 100));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    UIGraphicsBeginImageContextWithOptions(btnSize, YES, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [image drawInRect:CGRectMake(0, 0, btnSize.width, btnSize.height)];
    
    UIColor *selectedHue = [UIColor colorWithHue:hue saturation:1.0 brightness:bright alpha:1.0];
    UIColor *lowSatClr = [UIColor colorWithHue:hue saturation:0.0 brightness:bright alpha:1.0];
    CGFloat red, green, blue, alpha;
    if ( [selectedHue getRed: &red green: &green blue: &blue alpha: &alpha] ) {
        // color converted
    }
    
    CGFloat red2, green2, blue2, alpha2;
    if ( [lowSatClr getRed: &red2 green: &green2 blue: &blue2 alpha: &alpha2] ) {
        // color converted
    }
    
    CGGradientRef glossGradient;
    CGColorSpaceRef rgbColorspace;
    size_t num_locations = 2;
    CGFloat locations[4] = { 0.0, 1.0 };
    CGFloat components [] = {
        red2, green2, blue2, 1.0,
        red, green, blue, 1.0
    };
    
    rgbColorspace = CGColorSpaceCreateDeviceRGB();
    glossGradient = CGGradientCreateWithColorComponents(rgbColorspace, components, locations, num_locations);
    CGRect currentBounds = slider.bounds;
    CGPoint startPt = CGPointMake(0, CGRectGetMidY(currentBounds));
    CGPoint endPt = CGPointMake(CGRectGetMaxX(currentBounds), CGRectGetMidY(currentBounds));
    CGContextDrawLinearGradient(context, glossGradient, startPt, endPt, 0);
    CGGradientRelease(glossGradient);
    CGColorSpaceRelease(rgbColorspace);
    res =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  res;
    
    
}


-(UIImage*)renderKnobImage {

    CGSize size = CGSizeMake(18, 28);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0); {
        CGContextRef gc = UIGraphicsGetCurrentContext();
        CGRect rectangle = CGRectMake(4, 0, 10, 28);
        CGContextSetRGBFillColor(gc, 0.2, 0.2, 0.2, 1.0);
        CGContextFillRect(gc,rectangle);
        
        CGRect rectangle2 = CGRectMake(7, 4, 4, 20);
        
        CGFloat r,g,b,a;
        [self.themeColor getRed:&r green:&g blue:&b alpha:&a];
        
        CGContextSetRGBFillColor(gc, r, g, b, 1.0);
        CGContextSetLineWidth(gc, 3);
        CGContextFillRect(gc,rectangle2);
        
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}



-(id)initWithFrame:(CGRect)frame andType:(int)type andTheme:(UIColor*)color {
    if ([super initWithFrame:frame]) {
        
        self.sliderType = type;
        self.themeColor = color;
        
        CGFloat h = 0;
        CGFloat s = 1;
        CGFloat l = 1;
        
        CGRect sliderFrame = CGRectZero;
        
         if (type == GCSLIDER_VERTICAL) {
             sliderFrame = CGRectMake(0, 0, self.frame.size.height*0.9, 30);
            
         } else {
              sliderFrame = CGRectMake(0, 0, 0.9*self.frame.size.width, 30);
             
         }

        // ads HSL sliders
        UISlider *hueSlider = [[UISlider alloc] initWithFrame:sliderFrame];
        hueSlider.minimumValue = 0;
        hueSlider.maximumValue = 1;
        hueSlider.tag = 1;
        hueSlider.value = h;
        UIImage *trackImg = [[self drawHueSliderImage:hueSlider.frame] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 1, 0, 1)];
        [hueSlider setMaximumTrackImage:trackImg forState:UIControlStateNormal];
        [hueSlider setMinimumTrackImage:trackImg forState:UIControlStateNormal];
        [hueSlider setThumbImage:[self renderKnobImage] forState:UIControlStateNormal];
        hueSlider.continuous = NO;
        [hueSlider addTarget:self action:@selector(adjHSL:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:hueSlider];

        
        // ads HSL sliders
        UISlider *satSlider = [[UISlider alloc] initWithFrame:sliderFrame];
        satSlider.minimumValue = 0;
        satSlider.maximumValue = 1;
        satSlider.value = s;
        satSlider.tag = 2;
        satSlider.continuous = NO;
        [satSlider setThumbImage:[self renderKnobImage] forState:UIControlStateNormal];
        [satSlider addTarget:self action:@selector(adjHSL:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:satSlider];

        
        
        // ads HSL sliders
        UISlider *lightSlider = [[UISlider alloc] initWithFrame:sliderFrame];
        lightSlider.minimumValue = 0;
        lightSlider.maximumValue = 1;
        lightSlider.value = l;
        lightSlider.tag = 3;
        lightSlider.continuous = NO;
        [lightSlider setThumbImage:[self renderKnobImage] forState:UIControlStateNormal];
        [lightSlider addTarget:self action:@selector(adjHSL:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:lightSlider];

        
        if (type == GCSLIDER_VERTICAL) {
            [hueSlider setTransform:CGAffineTransformMakeRotation(-M_PI_2)];
            [satSlider setTransform:CGAffineTransformMakeRotation(-M_PI_2)];
            [lightSlider setTransform:CGAffineTransformMakeRotation(-M_PI_2)];
            CGFloat xGap = self.frame.size.width/6.0;
            CGFloat yGap = self.frame.size.height/2.0;
            [hueSlider setCenter:CGPointMake(xGap, yGap)];
            [satSlider setCenter:CGPointMake(3*xGap, yGap)];
            [lightSlider setCenter:CGPointMake(5*xGap, yGap)];
        } else {
            CGFloat yGap = self.frame.size.height/6.0;
            CGFloat xGap = self.frame.size.width/2.0;
            [hueSlider setCenter:CGPointMake(xGap, yGap)];
            [satSlider setCenter:CGPointMake(xGap, 3*yGap)];
            [lightSlider setCenter:CGPointMake(xGap, 5*yGap)];
        }

        
        [self adjHSL:hueSlider];
        
    }
    return self;
    
}


@end
