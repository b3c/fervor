#-----------------------------------------------------------------------------
# Settings shared between the build tree and install tree.


#-----------------------------------------------------------------------------
# Settings specific to the build tree.

# The "use" file.
SET(fervor_USE_FILE ${fervor_BINARY_DIR}/Usefervor.cmake)

# Determine the include directories needed.
SET(fervor_INCLUDE_DIRS_CONFIG
  ${fervor_SOURCE_DIR}
)

# Library directory.
SET(fervor_LIBRARY_DIRS_CONFIG ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})

# Runtime library directory.
SET(fervor_RUNTIME_LIBRARY_DIRS_CONFIG ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})

# Build configuration information.
SET(fervor_CONFIGURATION_TYPES_CONFIG ${CMAKE_CONFIGURATION_TYPES})
SET(fervor_BUILD_TYPE_CONFIG ${CMAKE_BUILD_TYPE})

#-----------------------------------------------------------------------------
# Configure fervorConfig.cmake for the build tree.
CONFIGURE_FILE(${fervor_SOURCE_DIR}/fervorConfig.cmake.in
               ${fervor_BINARY_DIR}/fervorConfig.cmake @ONLY IMMEDIATE)

#-----------------------------------------------------------------------------
# Settings specific to the install tree.

# TODO

#-----------------------------------------------------------------------------
# Configure fervorConfig.cmake for the install tree.

# TODO
