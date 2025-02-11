include(FetchContent)

fetchcontent_declare(
  Catch2
  GIT_REPOSITORY https://github.com/catchorg/Catch2.git
  GIT_TAG v2.13.9
)

fetchcontent_makeavailable(Catch2)
list(APPEND CMAKE_MODULE_PATH ${catch2_SOURCE_DIR}/contrib)
include(Catch)

set(catch2_INCLUDE_DIR ${catch2_SOURCE_DIR}/single_include/catch2)

include(CTest)
