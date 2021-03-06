# Install script for directory: /Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/modules

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

IF(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/androidcamera/.androidcamera/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/calib3d/.calib3d/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/contrib/.contrib/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/core/.core/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/dynamicuda/.dynamicuda/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/features2d/.features2d/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/flann/.flann/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/gpu/.gpu/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/highgui/.highgui/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/imgproc/.imgproc/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/java/.java/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/legacy/.legacy/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/ml/.ml/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/nonfree/.nonfree/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/objdetect/.objdetect/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/ocl/.ocl/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/photo/.photo/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/python/.python/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/stitching/.stitching/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/superres/.superres/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/ts/.ts/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/video/.video/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/videostab/.videostab/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/viz/.viz/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/world/.world/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/core/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/flann/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/imgproc/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/highgui/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/features2d/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/calib3d/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/ml/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/video/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/legacy/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/objdetect/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/photo/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/gpu/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/ocl/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/nonfree/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/contrib/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/java/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/python/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/stitching/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/superres/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/ts/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/videostab/cmake_install.cmake")

ENDIF(NOT CMAKE_INSTALL_LOCAL_ONLY)

