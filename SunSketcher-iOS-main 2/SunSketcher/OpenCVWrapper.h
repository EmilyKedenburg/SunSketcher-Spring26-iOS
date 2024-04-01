//
//  OpenCVWrapper.h
//  Sunsketcher
//
//  Created by Ferguson, Tameka on 2/23/24.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
// #import <opencv2/opencv.hpp>
// #import <array>

NS_ASSUME_NONNULL_BEGIN

@interface OpenCVWrapper : NSObject

+ (NSString *)getOpenCVVersion;
+ (UIImage *)makeUIImageGrayScale:(UIImage *)image;
+ (UIImage *)croppingUIImage:(UIImage *)image withCoords:(NSArray<NSNumber *> *)boxCoords;
//+ (UIImage *)cropUIImage:(UIImage *)image;
+ (NSArray<NSNumber *> *)getEclipseBox:(UIImage *)img;

@end

NS_ASSUME_NONNULL_END

