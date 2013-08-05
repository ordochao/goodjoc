Application = require 'application'
ContentManager = require 'contentManager/content-manager'
LinkManager = require 'contentManager/link-manager'
InterfaceComponets = require 'contentManager/content-manager'

# Initialize the application on DOM ready event.
$ ->
  window.application = new Application
  window.contentManager = new ContentManager
  window.linkManager = new LinkManager
  window.contentManager.initialize()
  

