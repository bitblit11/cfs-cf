execute_process(COMMAND ${TEST_PROG}
                RESULT_VARIABLE HAD_ERROR)
if(HAD_ERROR)
    message(FATAL_ERROR "Test failed")
endif()

execute_process(COMMAND ${CMAKE_COMMAND} -E compare_files
    ${ACTUAL_OUTPUT} ${EXPECTED_OUTPUT}
    RESULT_VARIABLE DIFFERENT)
if(DIFFERENT)
    message(FATAL_ERROR "Test failed - files differ")
endif()


