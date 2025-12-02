cmake_minimum_required( VERSION 4.0...4.2 )

add_executable( example main.cpp MarioCoin.hpp MarioCoin.cpp )

target_link_libraries( example
    PRIVATE Audio
)

target_compile_features( example PUBLIC cxx_std_20 )

set_target_properties( example 
    PROPERTIES
        DEBUGGER_WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
)
