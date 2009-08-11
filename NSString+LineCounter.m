#import "NSString+LineCounter.h"

@implementation NSString (LineCounter)

- (NSString *) lineSeparator {
  NSEnumerator *enumerator =
	[[NSArray arrayWithObjects:@"\r\n", @"\r", @"\n", nil] objectEnumerator];
  id object;
  while ((object = [enumerator nextObject])) {
	if ([self rangeOfString:object
			   options:NSLiteralSearch
			   range:NSMakeRange(0, [self length])].location != NSNotFound) {
	  return object;
	}
  }
  return @"\n";
}

- (int) lineCountWithLineLength: (int) length
{
  int counter = 0;
  NSMutableArray *array =
	[[self componentsSeparatedByString: [self lineSeparator]] mutableCopy];

  // 末尾の空行を削除
  if ([array count] > 0) {
	for (int i = [array count] - 1; i > 0; i--) {
	  if ([[array objectAtIndex:i] isEqualToString:@""]) {
		[array removeObjectAtIndex:i];
	  }
	  else {
		break;
	  }
	}
	NSEnumerator *enumerator = [array objectEnumerator];
	id object;
	while ((object = [enumerator nextObject])) {
	  // 文章の途中に登場する空行をカウント
	  if ([object length] == 0) {
		counter++;
	  }
	  else {
		// 文字数で割った答えをまず++
		counter += [object length] / length;
		// 1行に満たない分があったらそれも++
		if ((int)[object length] % length > 0) {
		  counter++;
		}
	  }
	}
  }
  else {
	return 0;
  }
  return counter;
}

- (int) characterCountWithLineLength: (int) length countMode: (int) mode {
  NSMutableString *buf;
  switch (mode) {
  case NSStringLineCounterWithoutLineSeparator:
	buf = [self mutableCopy];
	[buf replaceOccurrencesOfString: [self lineSeparator]
		 withString: @""
		 options: NSLiteralSearch
		 range: NSMakeRange(0, [self length])];
	return [buf length];
	break;
  case NSStringLineCounterConstructive:
	return [self lineCountWithLineLength:length] * length;
	break;
  }  
  return 0;
}

@end
