template = require 'views/templates/projects'
View = require 'views/base/view'

module.exports = class ProjectsView extends View
  autoRender: yes
  className: 'mainContent projects'
  template: template
  collection: goodjoc.models.projects
  oldWeights: []
  weights: []
  defaultWeights: [3,2,1]
  projectItems: []
  currentStep: 0
  transitionSettings:{
      duration: 500
      stepAmplitude: 10
  } 

  events:
    "click a": "manageProjectClick"

  initialize: () =>
    @weights = @defaultWeights
    @oldWeights = @defaultWeights

  
  manageProjectClick: (e) =>
    e.preventDefault()
    url = e.currentTarget.getAttribute("href")
    console.log url
    if url.indexOf("http://") == -1
      projectIndex = url.replace("#projects/selectedProject/","")
      newWeights = @defaultWeights.slice()
      newWeights[projectIndex] = 8
      @update(newWeights)
    else
      goodjoc.managers.linkManager.openExternalLink(url)


  update: (newWeights = null) =>
    if !newWeights?
      newWeights = @defaultWeights
    @oldWeights = @weights  
    @weights = newWeights
    @placeProjects(@oldWeights)
    console.log "projects-view: update "+@transitionSettings.stepAmplitude
    d3.timer(@notifyTimer,@transitionSettings.stepAmplitude)

  notifyTimer: (e) =>
    @currentStep=@currentStep+1
    console.log "projects-view: new iteration i="+@currentStep
    if @currentStep*@transitionSettings.stepAmplitude < @transitionSettings.duration
      console.log "not the last iteration"
      interpolatedWeights = []
      for i in [0..@weights.length-1] 
        console.log "preparing dynamicScale"
        dynamicScale = d3.scale.pow().domain([1,@transitionSettings.duration]).range([@oldWeights[i],@weights[i]])
        console.log "projects-view: new vaule is = ",dynamicScale,@currentStep,[0,@transitionSettings.duration],[@oldWeights[i],@weights[i]]
        interpolatedWeights.push(dynamicScale(@currentStep*@transitionSettings.stepAmplitude))
      console.log "projects-view: updatedValues", interpolatedWeights
      @placeProjects(interpolatedWeights)
      d3.timer(@notifyTimer,@transitionSettings.stepAmplitude)
    else
      console.log "projects-view: lastValues"
      @placeProjects(@weights)
      @currentStep = 0
    return true


  placeProjects: (weights) =>
    console.log weights
    browserWidth    = window.ordochao.globalAccess.getBrowserWidth()
    browserHeight   = window.ordochao.globalAccess.getBrowserHeight()
    rectangles      = window.ordochao.areas.packingRectangles(weights)
    gapFactorX = 1
    gapFactorY = gapFactorX * browserWidth/browserHeight
    $(".projectItem").each((i,d) =>
      d3.select(d)
      .style("left"   ,(rectangles[i][0]+gapFactorX)+"%")
      .style("top"    ,(rectangles[i][1]+gapFactorY)+"%")
      .style("width"  ,(rectangles[i][2]-2*gapFactorX)+"%")
      .style("height" ,(rectangles[i][3]-2*gapFactorY)+"%")
    )