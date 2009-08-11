CC=gcc
LD=$(CC)
CFLAGS= -fconstant-cfstrings \
-std=gnu99 \
-Wall \
-O2 \
-I/var/include \
-I..

LDFLAGS= -lobjc \
-bind_at_load \
-multiply_defined suppress \
-F/System/Library/PrivateFrameworks \
-framework CoreFoundation \
-framework Foundation

VERSION=1.0

all: linecount

linecount: main.o NSString+LineCounter.o
	$(LD) $(LDFLAGS) -o $@ $^
	if [ -x /usr/bin/ldid ]; then /usr/bin/ldid -S linecount; fi

%.o: %.m
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

%.o: %.c
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

clean:
	rm -f *.o linecount
