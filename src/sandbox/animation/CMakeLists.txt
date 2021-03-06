add_executable(animation
    main.cpp
    )
target_link_libraries(animation
    common
    ${ASSIMP_LIBRARIES}
    )

if(DEFINED ENV{EMSCRIPTEN} AND EMSCRIPTEN_ENABLED)
  set(EMSCRIPTEN_FLAGS
      "-s USE_SDL=2"
      "-s USE_SDL_IMAGE=2"
      "-s SDL2_IMAGE_FORMATS='[\"png\"]'"
      "-s USE_BULLET=1"
     )
  string (REPLACE ";" " " EMSCRIPTEN_FLAGS "${EMSCRIPTEN_FLAGS}")
  set(EMSCRIPTEN_LINK_FLAGS
      "--preload-file ${CMAKE_CURRENT_SOURCE_DIR}/assets@/assets"
      "--preload-file ${CMAKE_CURRENT_SOURCE_DIR}/../../common/assets/shaders@/assets/shaders"
     )
  string (REPLACE ";" " " EMSCRIPTEN_LINK_FLAGS "${EMSCRIPTEN_LINK_FLAGS}")
  set_target_properties(animation PROPERTIES
      SUFFIX ".html"
      COMPILE_FLAGS "${EMSCRIPTEN_FLAGS}"
      LINK_FLAGS "${EMSCRIPTEN_FLAGS} ${EMSCRIPTEN_LINK_FLAGS}"
      )
  install(TARGETS animation
      RUNTIME DESTINATION html
      )
  install(FILES
      "${CMAKE_CURRENT_BINARY_DIR}/animation.js"
      "${CMAKE_CURRENT_BINARY_DIR}/animation.data"
      DESTINATION html
      )
else()
target_link_libraries(animation
      ${BULLET_LIBRARIES}
      ${SDL2_LIBRARY}
      ${SDL2_IMAGE_LIBRARY}
      ${GLEW_LIBRARY}
      ${OPENGL_LIBRARIES}
      ${ASSIMP_LIBRARY}
    )

#Copy assets to the build folder. 
add_custom_command(TARGET animation PRE_BUILD
                   COMMAND ${CMAKE_COMMAND} -E copy_directory
                       ${CMAKE_SOURCE_DIR}/src/sandbox/animation/assets $<TARGET_FILE_DIR:animation>/assets)
endif()
