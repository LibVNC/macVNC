#import <ScreenCaptureKit/ScreenCaptureKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreMedia/CoreMedia.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScreenCapturer : NSObject <SCStreamDelegate, SCStreamOutput>

- (instancetype)initWithDisplay:(CGDirectDisplayID)displayID
                   frameHandler:(nonnull void (^)(CMSampleBufferRef sampleBuffer))frameHandler
                   errorHandler:(nonnull void (^)(NSError *error))errorHandler;

- (void)startCapture;
- (void)stopCapture;

@end

NS_ASSUME_NONNULL_END
