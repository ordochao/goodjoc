Application = require 'application'
ContentManager = require 'contentManager/content-manager'
LinkManager = require 'contentManager/link-manager'
InterfaceComponets = require 'contentManager/content-manager'

# Initialize the application on DOM ready event.
$ ->
  window.goodjoc = {models: {}, views: {}, controllers: {}, managers: {}}
  window.application = new Application
  window.goodjoc.managers.contentManager = new ContentManager
  window.goodjoc.managers.linkManager = new LinkManager
  window.goodjoc.managers.contentManager.initialize()
  

