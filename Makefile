COMPILER = gcc
BUFFER_SRC = buffer.c
BUFFER_O = buffer.o
FILESYSTEM_SRC = isfs.c
FILESYSTEM_O = isfs.o
FILESYSTEM_BINARY = isfs
# LINK_FLAGS = -lpthread `pkg-config fuse --cflags --libs`
LINK_FLAGS = `pkg-config fuse --cflags --libs`
COMPILE_FLAGS = -std=c99 -Wall

isfs: $(FILESYSTEM_O) $(BUFFER_O)
	$(COMPILER) $(BUFFER_O) $(FILESYSTEM_O) -o $(FILESYSTEM_BINARY) $(LINK_FLAGS)

$(FILESYSTEM_O): $(FILESYSTEM_SRC)
	$(COMPILER) -c $(COMPILE_FLAGS) -D_FILE_OFFSET_BITS=64 $(FILESYSTEM_SRC) -o $(FILESYSTEM_O)

$(BUFFER_O): $(BUFFER_SRC)
	$(COMPILER) -c $(COMPILE_FLAGS) $(BUFFER_SRC)

debug-isfs: $(BUFFER_SRC) $(FILESYSTEM_SRC)
	$(COMPILER) $(COMPILE_FLAGS) -DDEBUG_ISFS -g -D_FILE_OFFSET_BITS=64 $(FILESYSTEM_SRC) $(BUFFER_SRC) -o isfs-debug $(LINK_FLAGS)

debug-buffer: $(BUFFER_SRC)
	$(COMPILER) $(COMPILE_FLAGS) -DDEBUG_BUFFER -g $(BUFFER_SRC) -o buffer-debug

clean:
	rm -f $(FILESYSTEM_BINARY) $(BUFFER_O) $(FILESYSTEM_O) buffer-debug isfs-debug
