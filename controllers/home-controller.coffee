Controller = require 'controllers/base/controller'
CoverView = require 'views/cover-view'
ProjectsView = require 'views/projects-view'
AboutView = require 'views/about-view'
ContactView = require 'views/contact-view'
Projects = require 'models/projects'

module.exports = class HomeController extends Controller
  index: ->
    @view = new CoverView region: 'main'

  cat: ->
    console.log "cat"

  cast: ->
    console.log "cast"
  
  en: ->
    console.log "en"  

  projects: -> 
    console.log "Proyectos"
    projects= new Projects    
    projects.download()
    console.log projects
    #@view = new ProjectsView region: 'main'
    

  about: -> 
      console.log "About"
      @view = new AboutView region: 'main'

  contact: -> 
      console.log "Contact"
      @view = new ContactView region: 'main'