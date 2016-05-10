//
//  UIImage+Helper.m
//  WorldWeather
//
//  Created by Rupak Sarker on 5/10/16.
//  Copyright © 2016 Phunware. All rights reserved.
//

#import "UIImage+Helper.h"

@implementation UIImage (Helper)

+ (void)loadFromURLString:(NSString *)urlString callback:(void (^)(UIImage *))callback {
    NSURL *url = [NSURL URLWithString:urlString];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSData * imageData = [NSData dataWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:imageData];
            callback(image);
        });
    });
}

@end
