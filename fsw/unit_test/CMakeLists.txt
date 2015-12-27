include(CTest)
find_program( MEMORYCHECK_COMMAND valgrind )
find_package(Threads)
set( MEMORYCHECK_COMMAND_OPTIONS "--trace-children=yes --leak-check=full" )

# Set include directories
include_directories(
	../mission_inc
	../platform_inc
	${CMAKE_CURRENT_SOURCE_DIR}
	${CMAKE_CURRENT_SOURCE_DIR}/ut-assert/inc
	${CFE_INC_DIRS}
	${OSAL_INC_DIRS}
	${APP_INC_DIRS})

add_definitions(-DCFE_LINUX)

set(CMAKE_C_FLAGS ${CMAKE_C_FLAGS} "-g -O0 -Wformat=0 -Wno-pointer-to-int-cast -Wno-int-to-pointer-cast -fprofile-arcs -ftest-coverage")

# Add the executables
add_executable(CF-UT 
		${CMAKE_CURRENT_SOURCE_DIR}/cf_cfgtable.c
		${CMAKE_CURRENT_SOURCE_DIR}/cf_testcase.c
		${CMAKE_CURRENT_SOURCE_DIR}/cf_testrunner.c
		${CMAKE_CURRENT_SOURCE_DIR}/ut-assert/src/ut_cfe_es_hooks.c
		${CMAKE_CURRENT_SOURCE_DIR}/ut-assert/src/ut_cfe_es_stubs.c
		${CMAKE_CURRENT_SOURCE_DIR}/ut-assert/src/ut_cfe_evs_hooks.c
		${CMAKE_CURRENT_SOURCE_DIR}/ut-assert/src/ut_cfe_evs_stubs.c
		${CMAKE_CURRENT_SOURCE_DIR}/ut-assert/src/ut_cfe_fs_stubs.c
		${CMAKE_CURRENT_SOURCE_DIR}/ut-assert/src/ut_cfe_psp_memutils_stubs.c
		${CMAKE_CURRENT_SOURCE_DIR}/ut-assert/src/ut_cfe_sb_hooks.c
		${CMAKE_CURRENT_SOURCE_DIR}/ut-assert/src/ut_cfe_sb_stubs.c
		${CMAKE_CURRENT_SOURCE_DIR}/ut-assert/src/ut_cfe_tbl_hooks.c
		${CMAKE_CURRENT_SOURCE_DIR}/ut-assert/src/ut_cfe_tbl_stubs.c
		${CMAKE_CURRENT_SOURCE_DIR}/ut-assert/src/ut_cfe_time_stubs.c
		${CMAKE_CURRENT_SOURCE_DIR}/ut-assert/src/ut_osapi_stubs.c
		${CMAKE_CURRENT_SOURCE_DIR}/ut-assert/src/ut_osfileapi_stubs.c
		${CMAKE_CURRENT_SOURCE_DIR}/ut-assert/src/utassert.c
		${CMAKE_CURRENT_SOURCE_DIR}/ut-assert/src/utlist.c
		${CMAKE_CURRENT_SOURCE_DIR}/ut-assert/src/uttest.c
		${CMAKE_CURRENT_SOURCE_DIR}/ut-assert/src/uttools.c
		${APP_SRC}
		${APP_CUSTOM_SRC})
target_link_libraries(CF-UT -fprofile-arcs gcov ${CMAKE_THREAD_LIBS_INIT})

# We need to both run the test and compare the as-run with the expected output
# with a diff command. 
add_test(NAME cf-ut COMMAND ./CF-UT)


