if (SAMPLE_BUILD_CLANG_TIDY)
    if (${CMAKE_VERSION} VERSION_LESS "3.6")
        message(STATUS "clang-tidy is not enabled because cmake version is too old")
    else ()
        if (${CMAKE_VERSION} VERSION_LESS "3.8")
            message(WARNING "clang-tidy exit code ignored in this version of cmake")
        endif ()
        find_program(
            SAMPLE_MODULE_CLANG_TIDY_PROGRAM
            NAMES "clang-tidy"
            DOC "Path to clang-tidy executable")
        mark_as_advanced(SAMPLE_MODULE_CLANG_TIDY_PROGRAM)
        if (NOT SAMPLE_MODULE_CLANG_TIDY_PROGRAM)
            message(STATUS "clang-tidy not found.")
        else ()
            message(
                STATUS "Found clang-tidy: ${SAMPLE_MODULE_CLANG_TIDY_PROGRAM}")
        endif ()
    endif ()
endif ()

function (sample_add_clang_tidy target)
    if (SAMPLE_MODULE_CLANG_TIDY_PROGRAM AND SAMPLE_BUILD_CLANG_TIDY)
       # message(STATUS "add ${target} to clang-tidy")

        get_link_dependencies(${target} list)
        set(_srclist "")
        foreach(f IN LISTS list)
            get_target_property(_srcs ${f} SOURCES)
            get_target_property(_src_dir ${f} SOURCE_DIR)
            foreach(_src IN LISTS _srcs)
                list(APPEND _srclist "${_src_dir}/${_src}")
            endforeach()
        endforeach()

        #message("${_srclist}")
        #message(${SAMPLE_MODULE_CLANG_TIDY_PROGRAM} ${_srclist}  -header-filter=\.h$ -- | tee -a ./report/clang-report.log)

        #add_custom_target(${target}-clang-tidy
	    #COMMAND ${SAMPLE_MODULE_CLANG_TIDY_PROGRAM} ${_srclist} -- | tee -a ./report/clang-report.log
        #COMMENT "===== Checking ${target} with clang-tidy... ====="
        #VERBATIM )
        
        # This is for Ninja, Makefile Generators
        set_target_properties( ${target} PROPERTIES CXX_CLANG_TIDY "${SAMPLE_MODULE_CLANG_TIDY_PROGRAM}")
    endif ()
endfunction ()

function(get_link_dependencies _target _listvar)
    set(_worklist ${${_listvar}})
    if (TARGET ${_target})
        list(APPEND _worklist ${_target})
        get_property(_dependencies GLOBAL PROPERTY GlobalTargetDepends${_target})
        foreach(_dependency IN LISTS _dependencies)
            if (NOT _dependency IN_LIST _worklist)
                get_link_dependencies(${_dependency} _worklist)
            endif()
        endforeach()
        set(${_listvar} "${_worklist}" PARENT_SCOPE)
    endif()
endfunction()