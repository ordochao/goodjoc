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
  currentIndex: 0

  initialize: ->
    goodjoc.managers.contentManager.dictionaries = [goodjoc.managers.contentManager.catalanDictionary,goodjoc.managers.contentManager.castillianDictionary,goodjoc.managers.contentManager.englishDictionary]
    d3.csv(@contentURL, @loadData)
    

  loadData: (data) ->
    goodjoc.managers.contentManager.parseCSVToFillDictionaries(data)
    goodjoc.managers.contentManager.updateHandlebars()
    goodjoc.managers.contentManager.detectDefaultLanguage()
    window.application.initialize()

  detectDefaultLanguage: () ->
    language = null
    language = goodjoc.managers.contentManager.getCookieLanguage()
    if !language || language == undefined
      language = window.navigator.userLanguage || window.navigator.language;
    if !language || language == undefined
      language = cat
    goodjoc.managers.contentManager.setCurrentDictionary(language)

  getCookieLanguage: () ->
    cookies = window.document.cookie.split(;)
    language = "cat"
    for cookie in cookies
      if cookie.indexOf("language=") != -1
        language = cookie.replace("language=","")
    return language

  parseCSVToFillDictionaries: (data) ->
    for entry in data
      @catalanDictionary[entry["key"]] = entry["català"]
      @castillianDictionary[entry["key"]] = entry["castellano"]
      @englishDictionary[entry["key"]] = entry["english"]

  setCurrentDictionary: (language) ->
    goodjoc.managers.contentManager.currentIndex = 0
    if (language.indexOf "en") != -1
      goodjoc.managers.contentManager.currentIndex = 2
    if (language.indexOf "cat") != -1
      goodjoc.managers.contentManager.currentIndex = 0
    if (language.indexOf "es")  != -1
      goodjoc.managers.contentManager.currentIndex = 1
    goodjoc.managers.contentManager.currentDictionary = goodjoc.managers.contentManager.dictionaries[goodjoc.managers.contentManager.currentIndex]
  
  reload: () ->
    location.reload();

  updateHandlebars: () ->
    Handlebars.registerHelper('getContent', goodjoc.managers.contentManager.getContent)
    Handlebars.registerHelper('log', goodjoc.managers.contentManager.log)

  log: (msg)->
    console.log "HELPER LOG: ", msg

  getContent: (key) ->
    goodjoc.managers.contentManager.currentDictionary[key]
