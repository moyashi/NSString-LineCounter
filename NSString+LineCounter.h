#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>

enum countMode {
  NSStringLineCounterWithoutLineSeparator,
  NSStringLineCounterConstructive
};

@interface NSString (LineCounter)
- (NSString *) lineSeparator;
- (int) lineCountWithLineLength: (int) length;
- (int) characterCountWithLineLength: (int) length countMode: (int) mode;
@end
