# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.8

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = "/Applications/CMake 2.8-12.app/Contents/bin/cmake"

# The command to remove a file.
RM = "/Applications/CMake 2.8-12.app/Contents/bin/cmake" -E remove -f

# Escaping for special characters.
EQUALS = =

# The program to use to edit the cache.
CMAKE_EDIT_COMMAND = "/Applications/CMake 2.8-12.app/Contents/bin/ccmake"

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin

# Utility rule file for opencv_test_java_properties.

# Include the progress variables for this target.
include modules/java/test/CMakeFiles/opencv_test_java_properties.dir/progress.make

modules/java/test/CMakeFiles/opencv_test_java_properties:
	cd /Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/java/test && "/Applications/CMake 2.8-12.app/Contents/bin/cmake" -E echo "opencv.lib.path = /Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/lib" > /Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/java/test/.build/ant-Release.properties

opencv_test_java_properties: modules/java/test/CMakeFiles/opencv_test_java_properties
opencv_test_java_properties: modules/java/test/CMakeFiles/opencv_test_java_properties.dir/build.make
.PHONY : opencv_test_java_properties

# Rule to build all files generated by this target.
modules/java/test/CMakeFiles/opencv_test_java_properties.dir/build: opencv_test_java_properties
.PHONY : modules/java/test/CMakeFiles/opencv_test_java_properties.dir/build

modules/java/test/CMakeFiles/opencv_test_java_properties.dir/clean:
	cd /Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/java/test && $(CMAKE_COMMAND) -P CMakeFiles/opencv_test_java_properties.dir/cmake_clean.cmake
.PHONY : modules/java/test/CMakeFiles/opencv_test_java_properties.dir/clean

modules/java/test/CMakeFiles/opencv_test_java_properties.dir/depend:
	cd /Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9 /Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/modules/java/test /Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin /Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/java/test /Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/java/test/CMakeFiles/opencv_test_java_properties.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : modules/java/test/CMakeFiles/opencv_test_java_properties.dir/depend

