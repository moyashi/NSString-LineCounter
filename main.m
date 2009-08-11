#import "NSString+LineCounter.h"

int main(int argc, char *argv[])
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSString *str = [NSString stringWithUTF8String:"あ\nい\n\nう\nえ\nお\nか\n\n\n\n\n"];

	// 字詰めを指定した行数カウント
	NSLog(@"%d", [str lineCountWithLineLength:2]);

	// 字詰め指定のみなし総文字数（空行、指定字詰めに満たない行も指定字詰めを書いたものとみなす）
	NSLog(@"%d", [str characterCountWithLineLength:2
					  countMode:NSStringLineCounterConstructive]);

	// 改行を抜いた総文字数
	NSLog(@"%d", [str characterCountWithLineLength:2
					  countMode:NSStringLineCounterWithoutLineSeparator]);

	[pool release];

	return 0;
}
