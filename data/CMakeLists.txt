# install desktop file
install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/com.github.dbhowell.streak.desktop
        DESTINATION ${CMAKE_INSTALL_FULL_DATAROOTDIR}/applications/)

install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/icons/16/com.github.dbhowell.streak.svg
        DESTINATION ${CMAKE_INSTALL_FULL_DATAROOTDIR}/icons/hicolor/16x16/apps/)

install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/icons/24/com.github.dbhowell.streak.svg
        DESTINATION ${CMAKE_INSTALL_FULL_DATAROOTDIR}/icons/hicolor/24x24/apps/)

install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/icons/32/com.github.dbhowell.streak.svg
        DESTINATION ${CMAKE_INSTALL_FULL_DATAROOTDIR}/icons/hicolor/32x32/apps/)

install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/icons/48/com.github.dbhowell.streak.svg
        DESTINATION ${CMAKE_INSTALL_FULL_DATAROOTDIR}/icons/hicolor/48x48/apps/)

install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/icons/64/com.github.dbhowell.streak.svg
        DESTINATION ${CMAKE_INSTALL_FULL_DATAROOTDIR}/icons/hicolor/64x64/apps/)

install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/icons/128/com.github.dbhowell.streak.svg
        DESTINATION ${CMAKE_INSTALL_FULL_DATAROOTDIR}/icons/hicolor/128x128/apps/)

install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/icons/128/com.github.dbhowell.streak.svg
        DESTINATION ${CMAKE_INSTALL_FULL_DATAROOTDIR}/icons/hicolor/scalable/apps/)

# install the appdata
install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/com.github.dbhowell.streak.appdata.xml
        DESTINATION ${CMAKE_INSTALL_FULL_DATAROOTDIR}/metainfo/)
