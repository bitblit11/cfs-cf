# Set local variables
set(APPTARGET cf)

# Set source files
set(APP_SRC 
	${CMAKE_CURRENT_SOURCE_DIR}/../src/PRI/aaa.c
	${CMAKE_CURRENT_SOURCE_DIR}/../src/PRI/callbacks.c
	${CMAKE_CURRENT_SOURCE_DIR}/../src/PRI/cfdp_lib.c
	${CMAKE_CURRENT_SOURCE_DIR}/../src/PRI/default_filestore.c
	${CMAKE_CURRENT_SOURCE_DIR}/../src/PRI/default_indication.c
	${CMAKE_CURRENT_SOURCE_DIR}/../src/PRI/event.c
	${CMAKE_CURRENT_SOURCE_DIR}/../src/PRI/machine_list.c
	${CMAKE_CURRENT_SOURCE_DIR}/../src/PRI/message_class.c
	${CMAKE_CURRENT_SOURCE_DIR}/../src/PRI/mib.c
	${CMAKE_CURRENT_SOURCE_DIR}/../src/PRI/misc.c
	${CMAKE_CURRENT_SOURCE_DIR}/../src/PRI/nak_mem.c
	${CMAKE_CURRENT_SOURCE_DIR}/../src/PRI/nak.c
	${CMAKE_CURRENT_SOURCE_DIR}/../src/PRI/pdu_as_string.c
	${CMAKE_CURRENT_SOURCE_DIR}/../src/PRI/pdu.c
	${CMAKE_CURRENT_SOURCE_DIR}/../src/PRI/r1.c
	${CMAKE_CURRENT_SOURCE_DIR}/../src/PRI/r2.c
	${CMAKE_CURRENT_SOURCE_DIR}/../src/PRI/s1.c
	${CMAKE_CURRENT_SOURCE_DIR}/../src/PRI/s2.c
	${CMAKE_CURRENT_SOURCE_DIR}/../src/PRI/timer.c
	${CMAKE_CURRENT_SOURCE_DIR}/../src/PRI/utils.c
	${CMAKE_CURRENT_SOURCE_DIR}/../src/cf_app.c
	${CMAKE_CURRENT_SOURCE_DIR}/../src/cf_callbacks.c  
	${CMAKE_CURRENT_SOURCE_DIR}/../src/cf_cmds.c
	${CMAKE_CURRENT_SOURCE_DIR}/../src/cf_playback.c
	${CMAKE_CURRENT_SOURCE_DIR}/../src/cf_utils.c)
	
# Set include paths
set(APP_INC_DIRS 
	${CMAKE_CURRENT_SOURCE_DIR}/../src/PRI
	${CMAKE_CURRENT_SOURCE_DIR}/../src/PUB
	${CMAKE_CURRENT_SOURCE_DIR}/../src/)
include_directories(${APP_INC_DIRS})
include_directories(${CFE_INC_DIRS})
include_directories(${OSAL_INC_DIRS})
include_directories(${PSP_INC_DIRS})
	
# Build application
add_app(${APP_FILE} SHARED ${APP_SRC} ${APP_CUSTOM_SRC})

# Build tables
add_app(cf_cfgtable STATIC ${TABLE_DIR}/cf_cfgtable.c)
set_target_properties(cf_cfgtable PROPERTIES PREFIX "" SUFFIX ".tbl")

add_subdirectory(../unit_test unit_test)

# Generate documentation
find_package(Doxygen)
if(DOXYGEN_FOUND)
    configure_file(${CMAKE_CURRENT_SOURCE_DIR}/user_doxy.in ${CMAKE_CURRENT_BINARY_DIR}/user_doxy @ONLY)
    add_custom_target(cf-docs
        COMMENT "Generating API documentation with Doxygen" VERBATIM
    	COMMAND mkdir -p ${CMAKE_BINARY_DIR}/docs/users_guide/html/${APPTARGET}/
    	COMMAND mkdir -p ${CMAKE_BINARY_DIR}/docs/users_guide/latex/${APPTARGET}/
        COMMAND ${DOXYGEN_EXECUTABLE} ${CMAKE_CURRENT_BINARY_DIR}/user_doxy
        COMMAND make -C ${CMAKE_BINARY_DIR}/docs/users_guide/latex/${APPTARGET}
        COMMAND cp ${CMAKE_BINARY_DIR}/docs/users_guide/latex/${APPTARGET}/refman.pdf ${CMAKE_BINARY_DIR}/docs/users_guide/CF.pdf
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/
    )
endif(DOXYGEN_FOUND)
