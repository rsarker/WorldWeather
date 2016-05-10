//
//  UIImage+Helper.h
//  WorldWeather
//
//  Created by Rupak Sarker on 5/10/16.
//  Copyright © 2016 Phunware. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Helper)

+ (void) loadFromURLString: (NSString*) urlString callback:(void (^)(UIImage *image))callback;

@end
