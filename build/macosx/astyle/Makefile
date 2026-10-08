CXX ?= clang++
JAVA_HOME ?= $(shell brew --prefix openjdk@11)
ASTYLE_VERSION ?= 2.05.1

CXXFLAGS += -fPIC -std=c++11 -DASTYLE_JNI
CXXFLAGS += -I"$(JAVA_HOME)/include" -I"$(JAVA_HOME)/include/darwin"

ASTYLE_VERSION ?= 3.1.0

SOURCES = \
	src/astyle_main.cpp \
	src/ASBeautifier.cpp \
	src/ASFormatter.cpp \
	src/ASEnhancer.cpp \
	src/ASResource.cpp

all:
	$(CXX) -dynamiclib $(CXXFLAGS) $(SOURCES) -o libastylej.dylib
	mkdir -p ../libastylej-$(ASTYLE_VERSION)
	rm -rf ../libastylej-$(ASTYLE_VERSION)/libastylej.jnilib
	cp libastylej.dylib ../libastylej-$(ASTYLE_VERSION)/libastylej.jnilib
