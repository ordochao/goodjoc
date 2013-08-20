Controller = require 'controllers/base/controller'
CoverView = require 'views/cover-view'
ProjectsView = require 'views/projects-view'
AboutView = require 'views/about-view'
ContactView = require 'views/contact-view'

module.exports = class HomeController extends Controller
    
  index: ->
    @view = new CoverView region: 'main'
    imageBackground = d3.select "#background"
    imageBackground.transition().ease("linear").duration(500).style("opacity","0.6")
    #.each("end",() => @view = new CoverView region: 'main')

  projects: -> 
    console.log "homeController - projects: fetch Proyects"
    if window.goodjoc.models.projects.length == 0
      window.goodjoc.models.projects.on("sync",@loadProjectsView)
      window.goodjoc.models.projects.download()
    else 
      imageBackground = d3.select "#background"
      imageBackground.transition().duration(500).style("opacity","0.2")
      .each("end",() => 
        @view = new ProjectsView region: 'main'
        @view.placeProjects(@view.weights)
      )

  loadProjectsView: =>
    imageBackground = d3.select "#background"
    imageBackground.transition().duration(500).style("opacity","0.2")
    .each("end",() => 
      @view = new ProjectsView region: 'main'
      @view.placeProjects(@view.weights)
    )
    
  about: -> 
    console.log "About"
    imageBackground = d3.select "#background"
    imageBackground.transition().duration(500).style("opacity","0.4")
    .each("end",() => @view = new AboutView region: 'main')

  contact: -> 
      console.log "Contact"
      imageBackground = d3.select "#background"
      imageBackground.transition().duration(500).style("opacity","0.4")
      .each("end",() => @view = new ContactView region: 'main')