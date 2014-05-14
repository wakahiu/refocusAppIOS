# Install script for directory: /Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/modules/java

# Set the install prefix
IF(NOT DEFINED CMAKE_INSTALL_PREFIX)
  SET(CMAKE_INSTALL_PREFIX "/usr/local")
ENDIF(NOT DEFINED CMAKE_INSTALL_PREFIX)
STRING(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
IF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  IF(BUILD_TYPE)
    STRING(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  ELSE(BUILD_TYPE)
    SET(CMAKE_INSTALL_CONFIG_NAME "Release")
  ENDIF(BUILD_TYPE)
  MESSAGE(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
ENDIF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)

# Set the component getting installed.
IF(NOT CMAKE_INSTALL_COMPONENT)
  IF(COMPONENT)
    MESSAGE(STATUS "Install component: \"${COMPONENT}\"")
    SET(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  ELSE(COMPONENT)
    SET(CMAKE_INSTALL_COMPONENT)
  ENDIF(COMPONENT)
ENDIF(NOT CMAKE_INSTALL_COMPONENT)

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "java")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/OpenCV/java" TYPE FILE FILES "/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/bin/opencv-249.jar")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "java")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "java")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/OpenCV/java" TYPE SHARED_LIBRARY FILES "/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/lib/libopencv_java249.dylib")
  IF(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/OpenCV/java/libopencv_java249.dylib" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/OpenCV/java/libopencv_java249.dylib")
    EXECUTE_PROCESS(COMMAND "/usr/bin/install_name_tool"
      -id "lib/libopencv_java249.dylib"
      -change "/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/lib/libopencv_calib3d.2.4.dylib" "lib/libopencv_calib3d.2.4.dylib"
      -change "/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/lib/libopencv_contrib.2.4.dylib" "lib/libopencv_contrib.2.4.dylib"
      -change "/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/lib/libopencv_core.2.4.dylib" "lib/libopencv_core.2.4.dylib"
      -change "/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/lib/libopencv_features2d.2.4.dylib" "lib/libopencv_features2d.2.4.dylib"
      -change "/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/lib/libopencv_flann.2.4.dylib" "lib/libopencv_flann.2.4.dylib"
      -change "/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/lib/libopencv_gpu.2.4.dylib" "lib/libopencv_gpu.2.4.dylib"
      -change "/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/lib/libopencv_highgui.2.4.dylib" "lib/libopencv_highgui.2.4.dylib"
      -change "/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/lib/libopencv_imgproc.2.4.dylib" "lib/libopencv_imgproc.2.4.dylib"
      -change "/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/lib/libopencv_legacy.2.4.dylib" "lib/libopencv_legacy.2.4.dylib"
      -change "/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/lib/libopencv_ml.2.4.dylib" "lib/libopencv_ml.2.4.dylib"
      -change "/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/lib/libopencv_nonfree.2.4.dylib" "lib/libopencv_nonfree.2.4.dylib"
      -change "/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/lib/libopencv_objdetect.2.4.dylib" "lib/libopencv_objdetect.2.4.dylib"
      -change "/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/lib/libopencv_ocl.2.4.dylib" "lib/libopencv_ocl.2.4.dylib"
      -change "/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/lib/libopencv_photo.2.4.dylib" "lib/libopencv_photo.2.4.dylib"
      -change "/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/lib/libopencv_video.2.4.dylib" "lib/libopencv_video.2.4.dylib"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/OpenCV/java/libopencv_java249.dylib")
    execute_process(COMMAND /usr/bin/install_name_tool
      -add_rpath "/usr/local/lib"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/OpenCV/java/libopencv_java249.dylib")
    IF(CMAKE_INSTALL_DO_STRIP)
      EXECUTE_PROCESS(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/OpenCV/java/libopencv_java249.dylib")
    ENDIF(CMAKE_INSTALL_DO_STRIP)
  ENDIF()
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "java")

IF(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/java/test/cmake_install.cmake")

ENDIF(NOT CMAKE_INSTALL_LOCAL_ONLY)

