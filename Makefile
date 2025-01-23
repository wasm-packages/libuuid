CC=turbo cc
CFLAGS=-Isrc/include/ -D_WASI_EMULATED_SIGNAL -DHAVE_NANOSLEEP -DHAVE_REALLOCARRAY \
	-D_PATH_LOCALSTATEDIR=\"/tmp/libuuid\" -fPIC -I$(PWD)/src/include
LDFLAGS=-Wl,-shared -Wl,--no-entry -nostdlib -Wl,--export-all

OBJS= \
	src/libuuid/src/clear.o \
	src/libuuid/src/compare.o \
	src/libuuid/src/copy.o \
	src/libuuid/src/gen_uuid.o \
	src/libuuid/src/isnull.o \
	src/libuuid/src/pack.o \
	src/libuuid/src/parse.o \
	src/libuuid/src/predefined.o \
	src/libuuid/src/test_uuid.o \
	src/libuuid/src/unpack.o \
	src/libuuid/src/unparse.o \
	src/libuuid/src/uuid_time.o \
	src/lib/randutils.o \
	src/lib/md5.o \
	src/lib/sha1.c \

install/lib/libuuid.so: $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS) -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: clean
clean:
	find . -name "*.o" -delete
