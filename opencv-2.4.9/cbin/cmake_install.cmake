# Install script for directory: /Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9

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

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "dev")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv2" TYPE FILE FILES "/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/opencv2/opencv_modules.hpp")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "dev")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "dev")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/unix-install/opencv.pc")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "dev")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "dev")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/OpenCV" TYPE FILE FILES "/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/unix-install/OpenCVConfig.cmake")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "dev")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "dev")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/OpenCV" TYPE FILE FILES "/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/unix-install/OpenCVConfig-version.cmake")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "dev")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "dev")
  IF(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/OpenCV/OpenCVModules.cmake")
    FILE(DIFFERENT EXPORT_FILE_CHANGED FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/OpenCV/OpenCVModules.cmake"
         "/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/CMakeFiles/Export/share/OpenCV/OpenCVModules.cmake")
    IF(EXPORT_FILE_CHANGED)
      FILE(GLOB OLD_CONFIG_FILES "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/OpenCV/OpenCVModules-*.cmake")
      IF(OLD_CONFIG_FILES)
        MESSAGE(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/OpenCV/OpenCVModules.cmake\" will be replaced.  Removing files [${OLD_CONFIG_FILES}].")
        FILE(REMOVE ${OLD_CONFIG_FILES})
      ENDIF(OLD_CONFIG_FILES)
    ENDIF(EXPORT_FILE_CHANGED)
  ENDIF()
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/OpenCV" TYPE FILE FILES "/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/CMakeFiles/Export/share/OpenCV/OpenCVModules.cmake")
  IF("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/OpenCV" TYPE FILE FILES "/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/CMakeFiles/Export/share/OpenCV/OpenCVModules-release.cmake")
  ENDIF("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "dev")

IF(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/3rdparty/zlib/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/3rdparty/libtiff/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/3rdparty/libjpeg/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/3rdparty/libjasper/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/3rdparty/libpng/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/3rdparty/openexr/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/include/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/modules/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/doc/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/data/cmake_install.cmake")
  INCLUDE("/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/apps/cmake_install.cmake")

ENDIF(NOT CMAKE_INSTALL_LOCAL_ONLY)

IF(CMAKE_INSTALL_COMPONENT)
  SET(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
ELSE(CMAKE_INSTALL_COMPONENT)
  SET(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
ENDIF(CMAKE_INSTALL_COMPONENT)

FILE(WRITE "/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/${CMAKE_INSTALL_MANIFEST}" "")
FOREACH(file ${CMAKE_INSTALL_MANIFEST_FILES})
  FILE(APPEND "/Users/siddharthachandra/gits/refocusAppIOS/opencv-2.4.9/cbin/${CMAKE_INSTALL_MANIFEST}" "${file}\n")
ENDFOREACH(file)
