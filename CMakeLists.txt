cmake_minimum_required(VERSION 3.5)

set(PROJECT_NAME catch2_benchmark_example)

project(
  ${PROJECT_NAME}
  LANGUAGES CXX
  VERSION 0.0.1
)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(catch2)

file(GLOB TEST_SOURCES ${CMAKE_SOURCE_DIR}/tests/*.cc)

add_executable(${PROJECT_NAME} ${TEST_SOURCES})
target_compile_definitions(${PROJECT_NAME} PRIVATE CATCH_CONFIG_ENABLE_BENCHMARKING)
target_include_directories(${PROJECT_NAME} PRIVATE ${catch2_INCLUDE_DIR})
target_link_libraries(${PROJECT_NAME} Catch2::Catch2)

catch_discover_tests(${PROJECT_NAME})

add_custom_target(
  clang-format
  clang-format -i ${TEST_SOURCES}
  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
  COMMENT "Checking clang-format for ${target}"
  VERBATIM
)

file(GLOB CMAKE_FORMAT_TARGETS ${CMAKE_SOURCE_DIR}/CMakeLists.txt ${CMAKE_SOURCE_DIR}/cmake/*.cmake)
add_custom_target(
  cmake-format
  cmake-format -i ${CMAKE_FORMAT_TARGETS}
  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
  COMMENT "formatting CMakeLists.txt files"
  VERBATIM
)

add_custom_target(
  format
  DEPENDS clang-format cmake-format
  COMMENT "formatting all files"
)

add_custom_target(
  benchmark
  ${CMAKE_BINARY_DIR}/${PROJECT_NAME}
  DEPENDS ${CMAKE_BINARY_DIR}/${PROJECT_NAME}
  COMMENT "run benchmarks"
)
