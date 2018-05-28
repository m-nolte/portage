cmake_minimum_required(VERSION 3.3)

project(libsparse C CXX)

find_package(ZLIB REQUIRED)

include_directories(${ZLIB_INCLUDE_DIRS})
include_directories(${CMAKE_SOURCE_DIR}/include)

add_library(sparse SHARED
  "backed_block.c"
  "output_file.c"
  "sparse.c"
  "sparse_crc32.c"
  "sparse_err.c"
  "sparse_read.cpp"
)
target_link_libraries(sparse ${ZLIB_LIBRARIES})

add_executable(simg2img
  "simg2img.c"
  "sparse_crc32.c"
)
target_link_libraries(simg2img ${ZLIB_LIBRARIES} sparse)

add_executable(img2simg
  "img2simg.c"
)
target_link_libraries(img2simg ${ZLIB_LIBRARIES} sparse)

add_executable(append2simg
  "append2simg.c"
)
target_link_libraries(append2simg ${ZLIB_LIBRARIES} sparse)

include(GNUInstallDirs)

install(FILES include/sparse/sparse.h DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/sparse)
install(TARGETS sparse DESTINATION ${CMAKE_INSTALL_LIBDIR})
install(TARGETS simg2img img2simg append2simg DESTINATION ${CMAKE_INSTALL_BINDIR})
