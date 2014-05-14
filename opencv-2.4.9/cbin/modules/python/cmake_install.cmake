# Install script for directory: /Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/modules/python

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

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "python")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python2.7/site-packages" TYPE SHARED_LIBRARY FILES "/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/lib/cv2.so")
  IF(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/python2.7/site-packages/cv2.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/python2.7/site-packages/cv2.so")
    EXECUTE_PROCESS(COMMAND "/usr/bin/install_name_tool"
      -id "cv2.so"
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
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/python2.7/site-packages/cv2.so")
    execute_process(COMMAND /usr/bin/install_name_tool
      -add_rpath "/usr/local/lib"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/python2.7/site-packages/cv2.so")
    IF(CMAKE_INSTALL_DO_STRIP)
      EXECUTE_PROCESS(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/python2.7/site-packages/cv2.so")
    ENDIF(CMAKE_INSTALL_DO_STRIP)
  ENDIF()
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "python")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "python")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python2.7/site-packages" TYPE FILE FILES "/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/modules/python/src2/cv.py")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "python")

