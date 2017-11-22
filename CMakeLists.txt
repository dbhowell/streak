project(com.github.dbhowell.streak)
cmake_minimum_required(VERSION 2.6)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

include (GNUInstallDirs)

set (PKGDATADIR "${CMAKE_INSTALL_FULL_DATAROOTDIR}/${CMAKE_PROJECT_NAME}")
set (GETTEXT_PACKAGE ${CMAKE_PROJECT_NAME})
set (RELEASE_NAME "Streak")
set (VERSION "0.1")
set (VERSION_INFO "Release")
set (CMAKE_C_FLAGS "-ggdb")

add_definitions (-DGETTEXT_PACKAGE=\"${GETTEXT_PACKAGE}\")
# disable C compiler warnings
add_definitions(-w)

set (PKG_DEPS
    gtk+-3.0
    libnotify
    granite
    libsoup-2.4
    json-glib-1.0
)

set (VALA_DEPS
    gtk+-3.0
    libnotify
    granite
    libsoup-2.4
    json-glib-1.0
    linux
)


find_package(PkgConfig)
pkg_check_modules (DEPS REQUIRED ${PKG_DEPS})

add_definitions(${DEPS_CFLAGS})
link_libraries(${DEPS_LIBRARIES})
link_directories(${DEPS_LIBRARY_DIRS})

find_package(Vala REQUIRED)
include(ValaVersion)
ensure_vala_version("0.26.0" MINIMUM)

add_subdirectory (po)
add_subdirectory (schemas)
add_subdirectory (data)
add_subdirectory (src)