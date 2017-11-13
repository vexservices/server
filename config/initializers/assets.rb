# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

Rails.application.config.assets.precompile += %w(
  datepicker/pt-br.js
  datepicker/en.js
  datepicker/es.js
  delta/patterns/pattern-1.png
  pixel/pixel-admin/blank.png
  pixel/themes/adminflare/body-bg.png
  pixel/themes/adminflare/ie-navbar-bg.png
  pixel/themes/adminflare/menu-bg.png
  lightbox/close.png
  lightbox/loading.gif
  lightbox/prev.png
  lightbox/next.png
  jstree/32px.png
  jstree/40px.png
  jstree/throbber.gif
)
