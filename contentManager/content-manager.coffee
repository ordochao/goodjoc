# The content manager object.
module.exports = class ContentManager
  # Set your application name here so the document title is set to
  # “Controller title – Site title” (see Chaplin.Layout#adjustTitle)

  contentURL: "https://docs.google.com/spreadsheet/pub?key=0AuHaNdrjJxjZdGR0RWZGNV9lOW92ZXJ4Nkt5MnRtd0E&single=true&gid=0&output=csv"

  #Languages
  castillianDictionary: {}
  catalanDictionary: {}
  englishDictionary: {}
  dictionaries: []
  currentDictionary: {}

  initialize: ->
    contentManager.dictionaries = [contentManager.castillianDictionary,contentManager.catalanDictionary,contentManager.englishDictionary]
    d3.csv(@contentURL, @loadData)
    

  loadData: (data) ->
    contentManager.parseCSVToFillDictionaries(data)
    contentManager.setCurrentDictionary(1)
    contentManager.updateHandlebars()
    window.application.initialize()

  parseCSVToFillDictionaries: (data) ->
    for entry in data
      @catalanDictionary[entry["key"]] = entry["català"]
      @castillianDictionary[entry["key"]] = entry["castellano"]
      @englishDictionary[entry["key"]] = entry["english"]

  setCurrentDictionary: (id) ->
    contentManager.currentDictionary = contentManager.dictionaries[id]

  updateHandlebars: () ->
    Handlebars.registerHelper('getContent', contentManager.getContent)


  getContent: (key) ->
    contentManager.currentDictionary[key]
