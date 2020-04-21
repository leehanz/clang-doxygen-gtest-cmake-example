if(SAMPLE_BUILD_DOXYGEN)
    # Find out the name of the subproject.
    get_filename_component(SAMPLE_MODULE_SUBPROJECT "${CMAKE_CURRENT_SOURCE_DIR}" NAME)

    # Each subproject adds dependencies to this target to have their docs generated.
    add_custom_target(doxygen-docs)

    if (${CMAKE_VERSION} VERSION_LESS "3.9")
        # Old versions of CMake have really poor support for Doxygen generation.
        message(STATUS "Doxygen generation only enabled for cmake 3.9 and higher")
    else ()
        find_package(Doxygen REQUIRED dot)
        if (Doxygen_FOUND)
            set(DOXYGEN_RECURSIVE YES)
            set(DOXYGEN_FILE_PATTERNS *.h *.cc *.cpp *.proto *.dox)
            set(DOXYGEN_EXAMPLE_RECURSIVE YES)
            set(DOXYGEN_EXCLUDE "third_party" "cmake-build-debug" "cmake-out")
            set(DOXYGEN_EXCLUDE_SYMLINKS YES)
            set(DOXYGEN_QUIET YES)
            set(DOXYGEN_WARN_AS_ERROR YES)
            set(DOXYGEN_INLINE_INHERITED_MEMB YES)
            set(DOXYGEN_JAVADOC_AUTOBRIEF YES)
            set(DOXYGEN_BUILTIN_STL_SUPPORT YES)
            set(DOXYGEN_IDL_PROPERTY_SUPPORT NO)
            set(DOXYGEN_EXTRACT_ALL YES)
            set(DOXYGEN_EXTRACT_STATIC YES)
            set(DOXYGEN_SORT_MEMBERS_CTORS_1ST YES)
            set(DOXYGEN_GENERATE_TODOLIST NO)
            set(DOXYGEN_GENERATE_BUGLIST NO)
            set(DOXYGEN_GENERATE_TESTLIST NO)
            
            #set(DOXYGEN_CLANG_ASSISTED_PARSING YES)
            #set(DOXYGEN_CLANG_OPTIONS "-std=c++11")
            set(DOXYGEN_SEARCH_INCLUDES YES)
            set(DOXYGEN_INCLUDE_PATH "${PROJECT_SOURCE_DIR}"
                                    "${PROJECT_BINARY_DIR}")
            set(DOXYGEN_EXCLUDE_PATTERNS "*/build/*")
            set(DOXYGEN_EXCLUDE_SYMBOLS "build")
            set(DOXYGEN_GENERATE_LATEX NO)
            set(DOXYGEN_GRAPHICAL_HIERARCHY NO)
            set(DOXYGEN_DIRECTORY_GRAPH NO)
            set(DOXYGEN_CLASS_GRAPH NO)
            set(DOXYGEN_COLLABORATION_GRAPH YES)
            set(DOXYGEN_INCLUDE_GRAPH YES)
            set(DOXYGEN_INCLUDED_BY_GRAPH NO)
            set(DOXYGEN_DOT_TRANSPARENT YES)
            set(DOXYGEN_MACRO_EXPANSION YES)
            set(DOXYGEN_EXPAND_ONLY_PREDEF YES)
            set(DOXYGEN_HTML_TIMESTAMP)
            set(DOXYGEN_STRIP_FROM_INC_PATH "${PROJECT_SOURCE_DIR}")
            set(DOXYGEN_SHOW_USED_FILES NO)
            set(DOXYGEN_REFERENCES_LINK_SOURCE NO)
            set(DOXYGEN_SOURCE_BROWSER YES)
            set(DOXYGEN_LAYOUT_FILE
                "${PROJECT_SOURCE_DIR}/config/DoxygenLayout.xml")

            doxygen_add_docs(
                ${SAMPLE_MODULE_SUBPROJECT}-docs ${CMAKE_CURRENT_SOURCE_DIR}
                WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} 
                COMMENT "Generate HTML documentation")
            add_dependencies(doxygen-docs ${SAMPLE_MODULE_SUBPROJECT}-docs)

        endif ()
    endif ()
endif ()