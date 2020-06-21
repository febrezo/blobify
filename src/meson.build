blobify_sources = [
  'Main.vala',
  'core/URIGenerator.vala',
  'gui/HeaderBar.vala',
  'gui/ResultsView.vala',
  'gui/SettingsMenu.vala',
  'gui/TextDialog.vala',
  'gui/URIDialog.vala',

  'gui/WelcomeView.vala',
  'gui/Window.vala',
]

blobify_deps = [
  dependency('gio-2.0', version: '>= 2.50'),
  dependency('gtk+-3.0', version: '>= 3.22'),
  dependency('granite'),
  dependency('libsoup-2.4'),
]

gnome = import('gnome')

executable('blobify', blobify_sources,
  vala_args: '--target-glib=2.50',  dependencies: blobify_deps,
  install: true,
)
