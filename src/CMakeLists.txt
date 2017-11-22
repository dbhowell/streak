include(ValaPrecompile)

vala_precompile(VALA_C
  Streak.vala
  MainWindow.vala

  Services/StripeAccount.vala

  Widgets/TransactionsTreeView.vala
  Widgets/EmptyAlert.vala
  Widgets/NotConfigureAlert.vala
  Widgets/HeaderBar.vala

  Models/StripeObject.vala
  Models/StripeError.vala
  Models/StripeList.vala
  Models/StripeTransaction.vala

  #${CMAKE_CURRENT_BINARY_DIR}/config.vala

PACKAGES
  ${VALA_DEPS}
OPTIONS
  ${GLOBAL_VALAC_OPTIONS}
  -g
  --thread
#  --vapidir=${CMAKE_SOURCE_DIR}/vapi
)

include (gresource)
# glib_compile_resources(GLIB_RESOURCES_ICONS SOURCE ../data/assets.gresource.xml)

add_executable(com.github.dbhowell.streak ${VALA_C} ${GLIB_RESOURCES_ICONS})

install(TARGETS com.github.dbhowell.streak RUNTIME DESTINATION ${CMAKE_INSTALL_FULL_BINDIR})
