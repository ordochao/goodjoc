Controller = require 'controllers/base/controller'
CoverView = require 'views/cover-view'
ProjectsView = require 'views/projects-view'
AboutView = require 'views/about-view'
ContactView = require 'views/contact-view'

module.exports = class HomeController extends Controller
  index: ->
    console.log "init"
    @view = new CoverView region: 'main'
    
  projects: -> 
    console.log "Proyectos"
    @view = new ProjectsView region: 'main'
    

  about: -> 
      console.log "About"
      @view = new AboutView region: 'main'

  contact: -> 
      console.log "Contact"
      @view = new ContactView region: 'main'