#import "ScreenCapturer.h"

@interface ScreenCapturer ()

@property (nonatomic, assign) CGDirectDisplayID displayID;
@property (nonatomic, strong) SCStream *stream;

// handlers
@property (nonatomic, copy, nonnull) void (^frameHandler)(CMSampleBufferRef sampleBuffer);
@property (nonatomic, copy, nonnull) void (^errorHandler)(NSError *error);

@end


@implementation ScreenCapturer

- (instancetype)initWithDisplay:(CGDirectDisplayID)displayID
                   frameHandler:(void (^)(CMSampleBufferRef))frameHandler
                   errorHandler:(void (^)(NSError *))errorHandler {
    if (self = [super init]) {
        _displayID = displayID;
        _frameHandler = [frameHandler copy];
        _errorHandler = [errorHandler copy];
    }
    return self;
}

- (void)startCapture {
    [SCShareableContent getShareableContentWithCompletionHandler:^(SCShareableContent *content, NSError *error) {
        if (error) {
            self.errorHandler(error);
            return;
        }

        SCDisplay *display = content.displays[[content.displays indexOfObjectPassingTest:^BOOL(SCDisplay *_Nonnull d, NSUInteger idx, BOOL *_Nonnull stop) {
                    return d.displayID == self.displayID;
                }]];

        if (!display) {
            NSError *noDisplayError = [NSError errorWithDomain:@"ScreenCapturerErrorDomain"
                                                          code:1
                                                      userInfo:@{NSLocalizedDescriptionKey : @"Display not available for capture"}];
            self.errorHandler(noDisplayError);
            return;
        }

        SCStreamConfiguration *config = [[SCStreamConfiguration alloc] init];
        // can later be adjusted for server-side scaling
        config.width = display.width;
        config.height = display.height;
        // set max frame rate to 60 FPS
        config.minimumFrameInterval = CMTimeMake(1, 60);
        config.pixelFormat = kCVPixelFormatType_32BGRA;

        SCContentFilter *filter = [[SCContentFilter alloc] initWithDisplay:(display) excludingWindows:(@[])];
        self.stream = [[SCStream alloc] initWithFilter:filter configuration:config delegate:self];

        NSError *addOutputError = nil;
        [self.stream addStreamOutput:self
                                type:SCStreamOutputTypeScreen
                  sampleHandlerQueue:dispatch_queue_create("libvncserver.examples.mac", NULL)
                               error:&addOutputError];
        if (addOutputError) {
            self.errorHandler(addOutputError);
            return;
        }

        [self.stream startCaptureWithCompletionHandler:^(NSError * _Nullable startError) {
            if (startError) {
                self.errorHandler(startError);
            }
        }];
    }];
}

- (void)stopCapture {
    [self.stream stopCaptureWithCompletionHandler:^(NSError * _Nullable stopError) {
        if (stopError) {
            self.errorHandler(stopError);
        }
        self.stream = nil;
    }];
}


/*
  SCStreamDelegate methods
*/

- (void) stream:(SCStream *) stream didStopWithError:(NSError *) error {
    self.errorHandler(error);
}


/*
  SCStreamOutput methods
*/

- (void)stream:(SCStream *)stream didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer ofType:(SCStreamOutputType)type {
    if (type == SCStreamOutputTypeScreen) {
        self.frameHandler(sampleBuffer);
    }
}

@end
