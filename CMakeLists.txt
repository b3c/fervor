
CMAKE_MINIMUM_REQUIRED(VERSION 2.8.2)

PROJECT(fervor)

OPTION(BUILD_TESTING "Enable testing" OFF)
OPTION(fervor_BUILD_EXAMPLES "Build examples" OFF)

set(BUILD_SHARED_LIBS ON CACHE BOOL "Build shared libraries (.dll/.so) instead of static ones (.lib/.a)")
OPTION(fervor_BUILD_EXAMPLES "Build examples" OFF)

set(FV_APP_NAME "\"fervor\"")
set(FV_APP_VERSION "\"1.0.0\"")


#-----------------------------------------------------------------------------
# Output directories.
#
SET(output_dir ${fervor_BINARY_DIR}/bin)
FOREACH(type LIBRARY RUNTIME ARCHIVE)
  IF(NOT DEFINED CMAKE_${type}_OUTPUT_DIRECTORY)
    SET(CMAKE_${type}_OUTPUT_DIRECTORY ${output_dir} CACHE INTERNAL "Single output directory for building all libraries.")
  ENDIF()
ENDFOREACH()

#-----------------------------------------------------------------------------
# Qt
#

SET(minimum_required_qt_version "4.7")

FIND_PACKAGE(Qt4)

# This option won't show up in the main CMake configure panel
MARK_AS_ADVANCED(QT_QMAKE_EXECUTABLE)
  
SET(QT_USE_QTNETWORK ON)
SET(QT_USE_QTGUI ON)
SET(QT_USE_QTWEBKIT ON)
INCLUDE(${QT_USE_FILE})

# Set variable QT_INSTALLED_LIBRARY_DIR that will contains
# Qt shared library
SET(QT_INSTALLED_LIBRARY_DIR ${QT_LIBRARY_DIR})
IF (WIN32)
  GET_FILENAME_COMPONENT(QT_INSTALLED_LIBRARY_DIR ${QT_QMAKE_EXECUTABLE} PATH)
ENDIF()


#-----------------------------------------------------------------------------
# Subdirectories
#

add_definitions( -DFV_APP_NAME=${FV_APP_NAME} )
add_definitions( -DFV_APP_VERSION=${FV_APP_VERSION} )

INCLUDE_DIRECTORIES(
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${CMAKE_CURRENT_BINARY_DIR}
  )


SET(PRJ_SRCS
  fvavailableupdate.cpp
  fvignoredversions.cpp
  fvplatform.cpp
  fvupdateconfirmdialog.cpp
  fvupdater.cpp
  fvupdatewindow.cpp
  fvversioncomparator.cpp
  fvversioncomparator.h
  )
  
SET(PRJ_MOC_SRCS
  fvavailableupdate.h
  fvignoredversions.h
  fvplatform.h
  fvupdateconfirmdialog.h
  fvupdater.h
  fvupdatewindow.h
  )
  
set(PRJ_UI_SRCS
  fvupdateconfirmdialog.ui
  fvupdatewindow.ui
  )

set(PRJ_QRC
  )

QT4_WRAP_CPP(PRJ_MOC_CPP ${PRJ_MOC_SRCS})
QT4_WRAP_UI(PRJ_UI_CXX ${PRJ_UI_SRCS})
QT4_ADD_RESOURCES(PRJ_QRC_SRCS ${PRJ_QRC})



# Create the library.
if(${BUILD_SHARED_LIBS})
  ADD_LIBRARY(${PROJECT_NAME} SHARED ${PRJ_SRCS} ${PRJ_MOC_CPP} ${PRJ_UI_CXX} ${PRJ_QRC})
else(${BUILD_SHARED_LIBS})
  ADD_LIBRARY(${PROJECT_NAME} STATIC ${PRJ_SRCS} ${PRJ_MOC_CPP} ${PRJ_UI_CXX} ${PRJ_QRC})
endif(${BUILD_SHARED_LIBS})  
  
#-----------------------------------------------------------------------------
#
# To fix compilation problem: relocation R_X86_64_32 against `a local symbol' can not be
# used when making a shared object; recompile with -fPIC
# See http://www.cmake.org/pipermail/cmake/2007-May/014350.html
#
IF( CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64" )
  SET_TARGET_PROPERTIES(${PROJECT_NAME} PROPERTIES COMPILE_FLAGS "-fPIC")
ENDIF( CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64" )

SET(${PROJECT_NAME}_LINK_LIBRARIES ${QT_LIBRARIES})
TARGET_LINK_LIBRARIES(
  fervor
  ${QT_LIBRARIES}
  )



IF(BUILD_TESTING)
#  ADD_SUBDIRECTORY(test)
ENDIF()

IF(fervor_BUILD_EXAMPLES)
#  ADD_SUBDIRECTORY(sample)
ENDIF()

#-----------------------------------------------------------------------------
# Generate fervor file
#
CONFIGURE_FILE(Usefervor.cmake.in
               ${fervor_BINARY_DIR}/Usefervor.cmake COPYONLY)

INCLUDE(GeneratefervorConfig.cmake)

