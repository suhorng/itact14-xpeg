-include Makefile.common

#CXXFLAGS = -std=c++11 -MMD -g -DDEBUG_LEVEL=5 -DDEBUG_CNT=4 -Wall -Wshadow -Wextra -Wconversion -pedantic -Iinclude
CXXFLAGS = -std=c++11 -MMD -O2 -DDISPLAY -DDEBUG_LEVEL=0 -DDEBUG_CNT=1000 -Wall -Wshadow -Wextra -pedantic -Iinclude
CXX = g++
LIBS = -lfreeglut -lopengl32 -lglew32

OBJS = \
	bin/bmp \
	bin/input_stream \
	bin/glshow \
	bin/mpeg

TARGET = mpeg$(exe)

.PHONY: all
all: $(TARGET)

.PHONY: clean
clean:
	-$(RM) $(TARGET) $(call fixpath,bin/*)

.PHONY: test
test: $(TARGET)
	mpeg 2>log.txt

# Compile the target file (e.g. hw3_1.exe)
$(TARGET): %$(exe): bin/%.o $(OBJS:=.o)
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LIBS)

# Compile library files, e.g. `instruction`, `tokenizer`
bin/%.o: src/%.cpp
	$(call if_not_exist,bin,mkdir bin)
	$(CXX) $(CXXFLAGS) -c -o $@ $<

# Include compiler-generated dependency files
-include $(OBJS:=.d)
